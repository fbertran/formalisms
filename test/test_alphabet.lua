local Serpent  = require "serpent"
local Proxy    = require "layeredata"
Proxy.alphabet = require "formalisms.alphabet"
local layer    = Proxy.new { 
  name = "alphabet instance" 
}
local _        = Proxy.placeholder

layer.model = {
  __depends__ = {
    Proxy.alphabet,
  },
  
  __refines__ = {
    _.alphabet_type,
  },

  symbols = {
    a = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
    },

    b = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
    },

    c = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
    },
  },
}

local function dump (x)
  return Serpent.dump (x, {
    indent   = "  ",
    comment  = false,
    sortkeys = true,
    compact  = false,
  })
end

do
  print(dump(Proxy.flatten(layer)))
end
