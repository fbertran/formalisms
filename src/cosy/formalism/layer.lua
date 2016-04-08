local Coromake = require "coroutine.make"
local Layer    = require "layeredata"

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
