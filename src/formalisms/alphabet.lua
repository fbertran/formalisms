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

layer.__labels__ = { alphabet = true }

layer.__meta__ = {
  symbol_type = {},
}

layer.symbols = {
  __refines__ = {
    collection,
  },
  __meta__ = {
    __value_type__ = _.__meta__.symbol_type,
  },
  __default__ = {
    __refines__ = {
      _.__meta__.symbol_type,
    },
  }
}

return layer
