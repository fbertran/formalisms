local Layer  = require "layeredata"
local collection = require "formalisms.collection"
local layer  = Layer.new {
  name = "alphabet",
}
local _      = Layer.reference "alphabet"

-- Alphabet
-- ========
--
-- This formalism describe what is an Alphabet.
--
-- An alphabet is a set of symbols.

layer[Layer.key.labels] = { alphabet = true }

layer[Layer.key.meta] = {
  symbol_type = {},
}

layer.symbols = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    __value_type__ = _ [Layer.key.meta].symbol_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].symbol_type,
    },
  }
}

return layer
