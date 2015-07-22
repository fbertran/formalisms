local Layer      = require "layeredata"
local polynomial = require "formalisms.polynomial"
local layer      = Layer.new {
  name = "Polynomial instance"
}
local _          = Layer.reference "polynomial_model"
local root       = Layer.reference (false)

layer.__depends__ = {
  polynomial,
}

layer.model = {
  __label__   = "polynomial_model",

  __refines__ = {
    root.__meta__.polynomial_type,
  },

  variables = {
    x1 = {},
    x2 = {},
  },

  monomials = {
    {
      coefficient = 2,
      exponents = {
        [_.variables.x1] = 1,
        [_.variables.x2] = 2,
      },
    },
    {
      coefficient = -1,
      exponents = {
        [_.variables.x2] = 2,
      },
    },
    {
      coefficient = -1,
    },
  },
}

do
  Layer.flatten(layer)
end
