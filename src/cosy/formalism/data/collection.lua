local Layer = require "layeredata"

local collection = Layer.new {
  name = "collection",
}

local check_type      = require "cosy.formalism.data.check_type"
local check_container = require "cosy.formalism.data.check_container"

-- Collection
-- ==========
--
-- A collection is a set, map or sequence of elements where keys or values
-- always have the same type.
--
-- To create a new collection type, refine this formalism and add the fields
-- descriptions in its `[meta].collection` table.
--
-- `[meta].collection` can define a `key_type` field, with either the string
-- representation of the Lua type name (for instance "boolean", "number",
-- "string"), or a reference to the expected parent type.
--
-- `[meta].collection` can define a `value_type` field, with either the string
-- representation of the Lua type name (for instance "boolean", "number",
-- "string"), or a reference to the expected parent type.

local prefix = "cosy.formalism.data.collection"

collection [Layer.key.meta] = {
  collection = {
    key_type        = false,
    value_type      = false,
    key_container   = false,
    value_container = false,
    minimum         = false,
    maximum         = false,
  },
}

collection [Layer.key.checks] = {}

collection [Layer.key.checks] [prefix .. ".size"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if  not proxy [Layer.key.meta].collection.minimum
  and not proxy [Layer.key.meta].collection.maximum then
    return
  end
  local size = 0
  for _ in pairs (collection) do
    size = size+1
  end
  if  (size < (proxy [Layer.key.meta].collection.minimum or  math.huge))
  or  (size > (proxy [Layer.key.meta].collection.maximum or -math.huge)) then
    Layer.coroutine.yield (prefix .. ".size.illegal", {
      proxy   = proxy,
      minimum = proxy [Layer.key.meta].collection.minimum,
      maximum = proxy [Layer.key.meta].collection.maximum,
      size    = size,
    })
  end
end

collection [Layer.key.checks] [prefix .. ".key_type"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.key_type then
    return
  end
  if type (proxy [Layer.key.meta].collection.key_type) == "string" then
    for key, _ in pairs (proxy) do
      check_type (key, proxy [Layer.key.meta].collection.key_type, {
        proxy  = proxy,
        key    = key,
        prefix = prefix .. ".key_type",
      })
    end
  elseif getmetatable (proxy [Layer.key.meta].collection.key_type) == Layer.Proxy then
    for key, _ in pairs (proxy) do
      local resolved = Layer.Reference.resolve (key, proxy)
      check_type (resolved, proxy [Layer.key.meta].collection.key_type, {
        proxy  = proxy,
        key    = key,
        prefix = prefix .. ".key_type",
      })
    end
  else
    Layer.coroutine.yield (prefix .. ".key_type.invalid", {
      proxy = proxy,
      used  = proxy [Layer.key.meta].collection.key_type,
    })
  end
end

collection [Layer.key.checks] [prefix .. ".value_type"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.value_type then
    return
  end
  if type (proxy [Layer.key.meta].collection.value_type) == "string"
  or getmetatable (proxy [Layer.key.meta].collection.value_type) == Layer.Proxy then
    for key, value in pairs (proxy) do
      check_type (value, proxy [Layer.key.meta].collection.value_type, {
        proxy  = proxy,
        key    = key,
        prefix = prefix .. ".value_type",
      })
    end
  else
    Layer.coroutine.yield (prefix .. ".value_type.invalid", {
      proxy = proxy,
      used  = proxy [Layer.key.meta].collection.value_type,
    })
  end
end

collection [Layer.key.checks] [prefix .. ".key_container"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.key_container then
    return
  end
  for key, _ in pairs (proxy) do
    check_container (key, proxy [Layer.key.meta].collection.key_container, {
      proxy  = proxy,
      key    = key,
      prefix = prefix .. ".key_container",
    })
  end
end

collection [Layer.key.checks] [prefix .. ".value_container"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  if not proxy [Layer.key.meta].collection.value_container then
    return
  end
  for key, value in pairs (proxy) do
    check_container (value, proxy [Layer.key.meta].collection.value_container, {
      proxy  = proxy,
      key    = key,
      prefix = prefix .. ".value_container",
    })
  end
end

return collection
