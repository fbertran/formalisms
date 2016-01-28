local Layer  = require "layeredata"
local record = Layer.new {
  name = "record",
}

-- Record
-- ======
--
-- A record is a table where some keys are mandatory.
-- To create a new record type, refine this formalism and add the fields
-- descriptions in its `[meta].record` table.
--
-- `[meta].record` is a mapping from keys to their require value type,
-- that can be either the string representation of the Lua type name
-- (for instance "boolean", "number", "string"), or a proxy of the expected
-- parent type (for instance `record`).

record [Layer.key.meta] = {
  record = {},
}

record [Layer.key.checks] = {}

record [Layer.key.checks].value_type = function (proxy)
  for key, description in pairs (proxy [Layer.key.meta].record) do
    local value = proxy [key]
    if value == nil then
      Layer.coroutine.yield ("record:value_type:missing", {
        proxy    = proxy,
        key      = key,
        expected = type (description.value_type),
      })
    elseif type (description.value_type) == "string" then
      if type (value) ~= description.value_type then
        Layer.coroutine.yield ("record:value_type:illegal", {
          proxy    = proxy,
          key      = key,
          expected = type (description.value_type),
          used     = type (value),
        })
      end
    elseif type (description.value_type) == "table" then
      if getmetatable (value) ~= Layer.Proxy then
        Layer.coroutine.yield ("record:value_type:illegal", {
          proxy    = proxy,
          key      = key,
          expected = description.value_type,
          used     = type (value),
        })
      elseif not (description.value_type <= value) then
        Layer.coroutine.yield ("record:value_type:illegal", {
          proxy    = proxy,
          key      = key,
          expected = description.value_type,
          used     = value,
        })
      end
    else
      assert (false)
    end
  end
end

return record
