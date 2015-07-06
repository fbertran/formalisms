local Layer  = require "layeredata"
local object = require "formalisms.object"
local layer  = Layer.new {
  name = "alphabet",
}
local _      = Layer.reference "alphabet"
local root   = Layer.reference (false)

-- Alphabet
-- ========
--
-- This formalism describe what is an Alphabet.
--
-- An alphabet is a set of symbols.

layer.__depends__ =  {
  object,
}

layer.__meta__ = {

  alphabet_type = {
    __label__ = "alphabet",

    __meta__ = {
      symbol_type = {},
    },

    symbols = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.symbol_type,
      },
      __default__ = {
        _.__meta__.symbol_type,
      }
    },
  },
}

return layer
