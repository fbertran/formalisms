local Layer      = require "layeredata"
local collection = require "formalisms.collection"
local record     = require "formalisms.record"
local layer      = Layer.new {
  name = "Polynomial",
}
local _          = Layer.reference "polynomial"

layer.__labels__ = { polynomial = true }

layer.__meta__ = {
  variable_type = {},

  monomial_type = {
    __refines__ = {
      record
    },
    __meta__ = {
      __tags__ = {
        coefficient = {
          __value_type__ = "number",
        },
      },
      exponents = {
        __refines__ = {
          collection,
        },
        __meta__ = {
          __key_type__      = _.__meta__.variable_type,
          __key_container__ = _.variables,
          __value_type__    = "number",
        },
      },
    },
  },
}
    
layer.variables = {
  __refines__ = {
    collection,
  },
  __meta__ = {
    __value_type__ = _.__meta__.variable_type,
  },
  __default__ = {
    __refines__ = {
      _.__meta__.variable_type,
    },
  },
}
    
layer.monomials = {
  __refines__ = {
    collection,
  },
  __meta__ = {
    __value_type__ = _.__meta__.monomial_type,
  },
  __default__ = {
    __refines__ = {
      _.__meta__.monomial_type,
    },
  },
}

return layer
