local Layer      = require "layeredata"
local collection = require "cosy.formalism.data.collection"
local layer      = Layer.new {
  name = "cosy.formalism.data.enumeration",
}

-- Enumerations
-- ============
--
-- This formalism describes what is an enumeration: a set of symbols.
-- We do not use the usual Lua representation for sets (name to Boolean),
-- as we want the symbols to be referenced by other parts of the models.
-- Instead, the `symbols` collection uses symbols as values. this does not
-- guarantee uniqueness of the symbols.

layer [Layer.key.labels] = {
  ["cosy.formalism.data.enumeration"] = true,
}
local _ = Layer.reference "cosy.formalism.data.enumeration"

layer [Layer.key.refines] = {
  collection,
}

layer [Layer.key.meta] = {
  symbol_type = false,
  collection = {
    value_type = _ [Layer.key.meta].symbol_type,
  },
}

layer [Layer.key.default] = {
  [Layer.key.refines] = {
    _ [Layer.key.meta].symbol_type,
  },
}

return layer
