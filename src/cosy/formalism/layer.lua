local Coromake = require "coroutine.make"
local Layer    = require "layeredata"

local oldnew = Layer.new

Layer.new = function (t)
  local layer = oldnew (t)
  return layer, Layer.reference (layer)
end

--[[Layer.require = function (name)
  print ("Require : "..name)
  local package = name:gsub ("/", ".")
 print (Layer.loaded [package])
  if Layer.loaded [package] then
    return Layer.loaded [package]
  else
    local layer = Layer.new {
      name = name,
    }
    local reference = Layer.reference (layer)
    layer = require (package) (Layer, layer, reference) or layer
    return layer, reference
  end
end]]--

Layer.messages = function (proxy)
  local coroutine = Coromake ()
  local messages  = Layer.key.messages
  local seen = {}
  local function iterate (x)
    seen [x] = true
    if getmetatable (x) == Layer.Proxy then
      if x [messages] then
        coroutine.yield (x)
      end
      for _, v in pairs (x) do
        if not seen [v] then
          iterate (v)
        end
      end

    end
  end
  return coroutine.wrap (function ()
    iterate (proxy)
  end)
end

return Layer
