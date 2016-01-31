local Layer  = require "layeredata"
local record = Layer.new {
  name = "record",
}

local check_type      = require "cosy.formalism.data.check_type"
local check_container = require "cosy.formalism.data.check_container"

-- Record
-- ======
--
-- A record is a table where some keys are mandatory, and their corresponding
-- values are typed.
--
-- To create a new record type, refine this formalism and add the fields
-- descriptions in its `[meta].record` table.
--
-- `[meta].record` is a mapping from keys to their require value type,
-- that can be either the string representation of the Lua type name
-- (for instance "boolean", "number", "string"), or a reference to the expected
-- parent type.

record [Layer.key.meta] = {
  record = {},
}

record [Layer.key.checks] = {}

record [Layer.key.checks] ["formalism:data:record:value_type"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  for key, description in pairs (proxy [Layer.key.meta].record) do
    if description.value_container ~= nil then
      if  type (description.value_type) ~= "string"
      and getmetatable (description.value_type) ~= Layer.Proxy then
        Layer.coroutine.yield ("formalism:data:record:value_type:invalid", {
          proxy = proxy,
          key   = key,
          used  = description.value_type,
        })
      else
        check_type (proxy [key], description.value_type, {
          proxy  = proxy,
          key    = key,
          prefix = "formalism:data:record:value_type",
        })
      end
    end
  end
end

record [Layer.key.checks] ["formalism:data:record:value_container"] = function (proxy)
  if Layer.Proxy.has_meta (proxy) then
    return
  end
  for key, description in pairs (proxy [Layer.key.meta].record) do
    if description.value_container ~= nil then
      if  getmetatable (description.value_container) ~= Layer.Proxy then
        Layer.coroutine.yield ("formalism:data:record:value_container:invalid", {
          proxy = proxy,
          key   = key,
          used  = description.value_container,
        })
      else
        check_container (proxy [key], description.value_container, {
          proxy  = proxy,
          key    = key,
          prefix = "formalism:data:record:value_container",
        })
      end
    end
  end
end

return record
