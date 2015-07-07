local Layer = require "layeredata"
local object = require "formalisms.object"
local layer = Layer.new {
  name = "Polynomial",
}
local _     = Layer.reference "polynomial"
local root  = Layer.reference (false)

layer.__depends__ = {
  object,
}

layer.__meta__ = {
  polynomial_type = {
    __label__ = "polynomial",

    __meta__ = {
      variable_type = {},

      monomial_type = {
        __refines__ = {
          root.__meta__.record
        },
        __meta__ = {
          __tags__ = {
            coefficient = {
              __value_type__ = "number",
            },
          },
        },
        exponents = {
          __refines__ = {
            root.__meta__.collection,
          },
          __meta__ = {
            __key_type__ = _.__meta__.variable_type,
            __key_container__ = _.variables,
            __value_type__ = "number",
          },
        },
      },
    },

    variables = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.variable_type,
      },
      __default__ = {
        __refines__ = {
          _.__meta__.variable_type,
        },
      },
    },

    monomials = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.monomial_type,
      },
      __default__ = {
        __refines__ = {
          _.__meta__.monomial_type,
        },
      },
    },
  },
}

return layer
