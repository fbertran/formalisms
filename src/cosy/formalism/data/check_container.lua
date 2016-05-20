return function (Layer, check_container)

  local function is_prefix (lhs, rhs)
    lhs = Layer.hidden [lhs]
    rhs = Layer.hidden [rhs]
    if lhs.layer ~= rhs.layer then
      return false
    end
    for i = 1, math.min (#lhs.keys, #rhs.keys) do
      if lhs.keys [i] ~= rhs.keys [i] then
        return false
      end
    end
    return true
  end

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
        -- for dependency in Layer.Proxy.dependencies (element) do
        --   if is_prefix (dependency, value) then
            return
          -- end
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
