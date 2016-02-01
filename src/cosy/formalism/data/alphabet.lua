local Layer      = require "layeredata"
local collection = require "cosy.formalism.data.collection"
local layer      = Layer.new {
  name = "cosy.formalism.data.alphabet",
}

-- Alphabets
-- =========
--
-- This formalism describes what is an alphabet: a set of symbols.
-- We do not use the usual Lua representation for sets (name to Boolean),
-- as we want the symbols to be referenced by other parts of the models.
-- Instead, the `symbols` collection uses symbols as values. this does not
-- guarantee uniqueness of the symbols.

layer[Layer.key.labels] = {
  ["cosy.formalism.data.alphabet"] = true,
}
local _ = Layer.reference "cosy.formalism.data.alphabet"

layer [Layer.key.meta] = {
  symbol_type = false,
}

layer.symbols = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    collection = {
      value_type = _ [Layer.key.meta].symbol_type,
    },
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].symbol_type,
    },
  }
}

return layer
