local Layer    = require "layeredata"
local alphabet = require "formalisms.alphabet"
local layer    = Layer.new {
  name = "alphabet instance"
}
local _        = Layer.reference "alphabet_model"
local root     = Layer.reference (false)

layer.__depends__ = {
  alphabet,
}

layer.model = {
  __label__ = "alphabet_model",

  [Layer.key.refines] = {
    root[Layer.key.meta].alphabet_type,
  },

  symbols = {
    a = {},
    b = {},
    c = {},
  },
}

do
  print(Layer.dump(Layer.flatten(layer)))
end
