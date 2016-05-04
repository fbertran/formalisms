return function (Layer, check_container)

  check_container.apply = function (value, container, where)
	--print (value)
	--print (container)
   if getmetatable (value) ~= Layer.Proxy then
      Layer.coroutine.yield (where.prefix .. ".not-proxy", {
        proxy    = where.proxy,
        key      = where.key,
        expected = container,
        used     = type (value),
      })

    elseif not Layer.Proxy.is_prefix (container, value) then
			--print ("not contained")
      Layer.coroutine.yield (where.prefix .. ".not-contained", {
        proxy    = where.proxy,
        key      = where.key,
        expected = container,
        used     = value,
      })
    end
		--print ("ok")
  end

end
