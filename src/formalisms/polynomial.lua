local Layer      = require "layeredata"
local collection = require "formalisms.collection"
local record     = require "formalisms.record"
local layer      = Layer.new {
  name = "Polynomial",
}
local _          = Layer.reference "polynomial"

layer[Layer.key.labels] = { polynomial = true }

layer[Layer.key.meta] = {
  variable_type = {},

  monomial_type = {
    [Layer.key.refines] = {
      record
    },
    [Layer.key.meta] = {
      __tags__ = {
        coefficient = {
          __value_type__ = "number",
        },
      },
      exponents = {
        [Layer.key.refines] = {
          collection,
        },
        [Layer.key.meta] = {
          __key_type__      = _ [Layer.key.meta].variable_type,
          __key_container__ = _.variables,
          __value_type__    = "number",
        },
      },
    },
  },
}
    
layer.variables = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    __value_type__ = _ [Layer.key.meta].variable_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].variable_type,
    },
  },
}
    
layer.monomials = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    __value_type__ = _ [Layer.key.meta].monomial_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].monomial_type,
    },
  },
}

return layer
