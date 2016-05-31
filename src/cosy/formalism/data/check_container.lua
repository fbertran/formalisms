return function (Layer, check_container)

  check_container.apply = function (value, container, where)
    if getmetatable (value) ~= Layer.Proxy then
      Layer.coroutine.yield (where.prefix .. ".not-proxy", {
        proxy    = where.proxy,
        key      = where.key,
        expected = container,
        used     = type (value),
      })
    else
      for _, element in Layer.pairs (container) do
        if element <= value or value <= element then
          return
        end
      end
      Layer.coroutine.yield (where.prefix .. ".not-contained", {
        proxy    = where.proxy,
        key      = where.key,
        expected = container,
        used     = value,
      })
    end
  end

end
