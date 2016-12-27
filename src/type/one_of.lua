return function (Layer, one_of)

  local type_   = Layer.require "type"
  local check   = Layer.require "type.check"
  local checks  = Layer.key.checks
  local meta    = Layer.key.meta
  local refines = Layer.key.refines


  local prefix = "type.one_of"

  one_of [refines] = {
    type_,
  }
  one_of [meta] = {
    [type] = function (types, proxy)
      for key, t in Layer.pairs (types) do
        local result = Layer.coroutine.wrap (function ()
          check (proxy, t, {
            proxy  = proxy,
            key    = key,
            prefix = prefix .. ".type",
          })
        end) ()
        if result == nil then
          return true
        end
      end
      return false
    end,
  }

  one_of [checks] = {}

  one_of [checks] [prefix .. ".types"] = function (proxy)
    for key, t in Layer.pairs (proxy) do
      if  type (t) ~= "boolean"
      and type (t) ~= "number"
      and type (t) ~= "string"
      and not (getmetatable (t) == Layer.Proxy and type_ <= t) then
        Layer.coroutine.yield (prefix .. ".type.illegal", {
          proxy = proxy,
          key   = key,
          type  = t,
        })
      end
    end
  end

end
