local Coromake = require "coroutine.make"
local Layer    = require "layeredata"

local oldnew = Layer.new

Layer.new = function (t)
  assert (t.name)
  local layer = oldnew (t)
  if not layer [Layer.key.labels] then
    layer [Layer.key.labels] = {}
  end
  layer [Layer.key.labels] [t.name] = true
  local reference = Layer.reference (t.name)
  return layer, reference
end

Layer.require = function (name)
  local package = name:gsub ("/", ".")
  if Layer.loaded [package] then
    return Layer.loaded [package]
  else
    local layer = Layer.new {
      name = name,
    }
    local reference = Layer.reference (name)
    layer = require (package) (Layer, layer, reference) or layer
    return layer, reference
  end
end

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
