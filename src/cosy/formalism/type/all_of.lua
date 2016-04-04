return function (Layer, all_of)

  local type_   = Layer.require "cosy/formalism/type"
  local check   = Layer.require "cosy/formalism/type.check"
  local checks  = Layer.key.checks
  local meta    = Layer.key.meta
  local refines = Layer.key.refines


  local prefix = "cosy/formalism/type.all_of"

  all_of [refines] = {
    type_,
  }
  all_of [meta] = {
    [type] = function (types, proxy)
      for key, t in pairs (types) do
        local result = Layer.coroutine.wrap (function ()
          check (proxy, t, {
            proxy  = proxy,
            key    = key,
            prefix = prefix .. ".type",
          })
        end) ()
        if result then
          return false
        end
      end
      return true
    end,
  }

  all_of [checks] = {}

  all_of [checks] [prefix .. ".types"] = function (proxy)
    for key, t in pairs (proxy) do
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
