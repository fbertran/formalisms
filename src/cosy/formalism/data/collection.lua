-- Collection
-- ==========
--
-- A collection is a set, map or sequence of elements where keys or values
-- always have the same type.
--
-- To create a new collection type, refine this formalism and add the fields
-- descriptions in its `[meta][collection]` table.
--
-- `[meta][collection]` can define a `key_type` field, with either the string
-- representation of the Lua type name (for instance "boolean", "number",
-- "string"), or a reference to the expected parent type.
--
-- `[meta][collection]` can define a `value_type` field, with either the string
-- representation of the Lua type name (for instance "boolean", "number",
-- "string"), or a reference to the expected parent type.

return function (Layer, collection,ref)

  local checks   = Layer.key.checks
  local defaults = Layer.key.defaults
  local meta     = Layer.key.meta

  local check_type      = Layer.require "cosy/formalism/type.check"          .apply
  local check_container = Layer.require "cosy/formalism/data.check_container".apply

  local prefix = "cosy/formalism/data.collection"

  collection [meta] = {
    [collection] = {
      key_type        = false,
      value_type      = false,
      key_container   = false,
      value_container = false,
      minimum         = false,
      maximum         = false,
    },
  }
  collection [defaults] = {
   ref [meta] [collection].value_type,
  }

  collection [checks] = {}

  collection [checks] [prefix .. ".size"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end
    if  not proxy [meta][collection].minimum
    and not proxy [meta][collection].maximum then
      return
    end
    local size = 0
    for _ in pairs (collection) do
      size = size+1
    end
    if  (size < (proxy [meta][collection].minimum or  math.huge))
    or  (size > (proxy [meta][collection].maximum or -math.huge)) then

      Layer.coroutine.yield (prefix .. ".size.illegal", {
        proxy   = proxy,
        minimum = proxy [meta][collection].minimum,
        maximum = proxy [meta][collection].maximum,
        size    = size,
      })
    end
  end

  collection [checks] [prefix .. ".key_type"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end
    if not proxy [meta][collection].key_type then
      return
    end
    if type (proxy [meta][collection].key_type) == "string" then
      for key, _ in pairs (proxy) do
        check_type (key, proxy [meta][collection].key_type, {
          proxy  = proxy,
          key    = key,
          prefix = prefix .. ".key_type",
        })
      end
    elseif getmetatable (proxy [meta][collection].key_type) == Layer.Proxy then
      for key, _ in pairs (proxy) do
        local resolved = Layer.Reference.resolve (key, proxy)
        check_type (resolved, proxy [meta][collection].key_type, {
          proxy  = proxy,
          key    = key,
          prefix = prefix .. ".key_type",
        })
      end
    else
      Layer.coroutine.yield (prefix .. ".key_type.invalid", {
        proxy = proxy,
        used  = proxy [meta][collection].key_type,
      })
    end
  end

  collection [checks] [prefix .. ".value_type"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end
    if not proxy [meta][collection].value_type then
      return
    end
    if type (proxy [meta][collection].value_type) == "string"
    or getmetatable (proxy [meta][collection].value_type) == Layer.Proxy then
      for key, value in pairs (proxy) do
        --print ("key " .. key)
        --print ("value ")
       -- print  (value)
     --   print ("prefix " .. prefix)
   --     print (proxy [meta][collection].value_type)
  --     print (proxy [meta][collection].value_type <= value )
        check_type (value, proxy [meta][collection].value_type, {
          proxy  = proxy,
          key    = key,
          prefix = prefix .. ".value_type",
        })
      end
    else
      Layer.coroutine.yield (prefix .. ".value_type.invalid", {
        proxy = proxy,
        used  = proxy [meta][collection].value_type,
      })
    end
  end

  collection [checks] [prefix .. ".key_container"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end
    if not proxy [meta][collection].key_container then
      return
    end
    for key, _ in pairs (proxy) do
      check_container (key, proxy [meta][collection].key_container, {
        proxy  = proxy,
        key    = key,
        prefix = prefix .. ".key_container",
      })
    end
  end

 collection [checks] [prefix .. ".value_container"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end
    if not proxy [meta][collection].value_container then
      return
    end
    for key, value in pairs (proxy) do
      check_container (value, proxy [meta][collection].value_container, {
        proxy  = proxy,
        key    = key,
        prefix = prefix .. ".value_container",
      })
    end
  
	end

end
