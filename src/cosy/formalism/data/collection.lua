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
  if not proxy [Layer.key.meta].collection.key_type then
    return
  end
  for key, _ in pairs (proxy) do
    check_type (key, proxy [Layer.key.meta].collection.key_type, {
      proxy  = proxy,
      key    = key,
      prefix = "formalism:data:collection:key_type",
    })
  end
end

collection [Layer.key.checks] ["collection.value_type"] = function (proxy)
  if not proxy [Layer.key.meta].collection.value_type then
    return
  end
  for key, value in pairs (proxy) do
    check_type (value, proxy [Layer.key.meta].collection.key_type, {
      proxy  = proxy,
      key    = key,
      prefix = "formalism:data:collection:value_type",
    })
  end
end

collection [Layer.key.checks] ["collection.key_container"] = function (proxy)
  if not proxy [Layer.key.meta].collection.key_container then
    return
  end
  for key, _ in pairs (proxy) do
    check_container (key, proxy [Layer.key.meta].collection.key_container, {
      proxy  = proxy,
      key    = key,
      prefix = "formalism:data:collection:key_container",
    })
  end
end

collection [Layer.key.checks] ["collection.value_container"] = function (proxy)
  if not proxy [Layer.key.meta].collection.value_container then
    return
  end
  for key, value in pairs (proxy) do
    check_container (value, proxy [Layer.key.meta].collection.value_container, {
      proxy  = proxy,
      key    = key,
      prefix = "formalism:data:collection:value_container",
    })
  end
end

return collection
