local Layer      = require "layeredata"
local collection = Layer.new {
  name = "collection",
}

local check_type      = require "cosy.formalism.data.check_type"
local check_container = require "cosy.formalism.data.check_container"

-- Collection
-- ==========
--

collection [Layer.key.meta] = {
  collection = {
    key_type        = false,
    value_type      = false,
    key_container   = false,
    value_container = false,
  },
}

collection [Layer.key.checks] = {}

collection [Layer.key.checks] ["collection.key_type"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.key_type then
    return
  end
  if type (proxy [Layer.key.meta].collection.key_type) == "string" then
    for key, _ in pairs (proxy) do
      if getmetatable (key) ~= Layer.Key then
        check_type (key, proxy [Layer.key.meta].collection.key_type, {
          proxy  = proxy,
          key    = key,
          prefix = "formalism:data:collection:key_type",
        })
      end
    end
  elseif getmetatable (proxy [Layer.key.meta].collection.key_type) == Layer.Proxy then
    for key, _ in pairs (proxy) do
      if getmetatable (key) ~= Layer.Key then
        local resolved = Layer.Reference.resolve (key, proxy)
        check_type (resolved, proxy [Layer.key.meta].collection.key_type, {
          proxy  = proxy,
          key    = key,
          prefix = "formalism:data:collection:key_type",
        })
      end
    end
  else
    Layer.coroutine.yield ("formalism:data:collection:key_type:invalid", {
      proxy = proxy,
      used  = proxy [Layer.key.meta].collection.key_type,
    })
  end
end

collection [Layer.key.checks] ["collection.value_type"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.value_type then
    return
  end
  if type (proxy [Layer.key.meta].collection.value_type) == "string"
  or getmetatable (proxy [Layer.key.meta].collection.value_type) == Layer.Proxy then
    for key, value in pairs (proxy) do
      if getmetatable (key) ~= Layer.Key then
        check_type (value, proxy [Layer.key.meta].collection.value_type, {
          proxy  = proxy,
          key    = key,
          prefix = "formalism:data:collection:value_type",
        })
      end
    end
  else
    Layer.coroutine.yield ("formalism:data:collection:value_type:invalid", {
      proxy = proxy,
      used  = proxy [Layer.key.meta].collection.value_type,
    })
  end
end

collection [Layer.key.checks] ["collection.key_container"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.key_container then
    return
  end
  for key, _ in pairs (proxy) do
    if getmetatable (key) ~= Layer.Key then
      check_container (key, proxy [Layer.key.meta].collection.key_container, {
        proxy  = proxy,
        key    = key,
        prefix = "formalism:data:collection:key_container",
      })
    end
  end
end

collection [Layer.key.checks] ["collection.value_container"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.value_container then
    return
  end
  for key, value in pairs (proxy) do
    if getmetatable (key) ~= Layer.Key then
      check_container (value, proxy [Layer.key.meta].collection.value_container, {
        proxy  = proxy,
        key    = key,
        prefix = "formalism:data:collection:value_container",
      })
    end
  end
end

return collection
