local Layer = require "layeredata"

return function (value, container, where)
  if getmetatable (value) ~= Layer.Proxy then
    Layer.coroutine.yield (where.prefix .. ".not-proxy", {
      proxy    = where.proxy,
      key      = where.key,
      expected = container,
      used     = type (value),
    })
  elseif not Layer.Proxy.is_prefix (container, value) then
    Layer.coroutine.yield (where.prefix .. ".not-contained", {
      proxy    = where.proxy,
      key      = where.key,
      expected = container,
      used     = value,
    })
  end
end
