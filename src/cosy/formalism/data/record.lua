local Layer  = require "layeredata"
local record = Layer.new {
  name = "record",
}

local check_type = require "cosy.formalism.data.check_type"

-- Record
-- ======
--
-- A record is a table where some keys are mandatory, and their corresponding
-- values are typed.
-- To create a new record type, refine this formalism and add the fields
-- descriptions in its `[meta].record` table.
--
-- `[meta].record` is a mapping from keys to their require value type,
-- that can be either the string representation of the Lua type name
-- (for instance "boolean", "number", "string"), or a proxy of the expected
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
    check_type (proxy [key], description.value_type,{
      proxy  = proxy,
      key    = key,
      prefix = "formalism:data:record:value_type",
    })
  end
end

return record
