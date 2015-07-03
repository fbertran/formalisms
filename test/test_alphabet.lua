local Layer    = require "layeredata"
local alphabet = require "formalisms.alphabet"
local layer    = Layer.new {
  name = "alphabet instance"
}
local _        = Layer.reference "alphabet_model"
local root     = Layer.reference "root"

layer.__depends__ = {
  alphabet,
}

layer.model = {
  __label__ = "alphabet_model",

  __refines__ = {
    root.__meta__.alphabet_type,
  },

  symbols = {
    a = {},
    b = {},
    c = {},
  },
}

do
  print(Layer.dump(Layer.flatten(layer), true))
end
