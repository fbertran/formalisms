local Layer = require "layeredata"
local layer = Layer.new { 
  name = "alphabet",
}
local _     = Layer.placeholder

-- Alphabet
-- ========
--
-- This formalism describe what is an Alphabet. 
--
-- An alphabet is an set of symbols. 
 
layer.__meta__ = {

  alphabet_type = {
    __meta__ = {
      symbol_type = {},
    },

    symbols = {
      __meta__ = {
        content_type = _.__meta__.alphabet_type.__meta__.symbol_type,
      },
    },
  },
}

return layer
