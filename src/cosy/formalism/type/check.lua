return function (Layer, check)

  local type_ = Layer.require "cosy/formalism/type"
  local meta  = Layer.key.meta

  check.apply = function (value, oftype, where)
    if value == nil then
      Layer.coroutine.yield (where.prefix .. ".missing", {
        proxy    = where.proxy,
        key      = where.key,
        expected = getmetatable (oftype) == Layer.Proxy
               and oftype
                or type (oftype),
      })
    elseif type (oftype) == "string" then
      if type (value) ~= oftype then
        Layer.coroutine.yield (where.prefix .. ".illegal", {
          proxy    = where.proxy,
          key      = where.key,
          expected = type (oftype),
          used     = type (value),
        })
      end
    elseif getmetatable (oftype) == Layer.Proxy then
      if type_ <= oftype then
        if not oftype [meta] [type_] (value, oftype) then
          Layer.coroutine.yield (where.prefix .. ".illegal", {
            proxy    = where.proxy,
            key      = where.key,
            expected = oftype,
            used     = type (value),
          })
        end
      elseif getmetatable (value) ~= Layer.Proxy then
        Layer.coroutine.yield (where.prefix .. ".illegal", {
          proxy    = where.proxy,
          key      = where.key,
          expected = oftype,
          used     = type (value),
        })

      elseif not (oftype <= value) then
        Layer.coroutine.yield (where.prefix .. ".illegal", {
          proxy    = where.proxy,
          key      = where.key,
          expected = oftype,
          used     = value,
        })
      end
   --   print("ok")
    else
      assert (false)
    end
  end

end
