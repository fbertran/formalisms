local Layer      = require "layeredata"
local collection = require "cosy.formalism.data.collection"
local record     = require "cosy.formalism.data.record"

local polynomial = Layer.new {
  name = "cosy.formalism.data.polynomial",
}

local default = Layer.key.default
local labels  = Layer.key.labels
local meta    = Layer.key.meta
local refines = Layer.key.refines

polynomial [labels] = {
  ["cosy.formalism.data.polynomial"] = true
}
local _ = Layer.reference "cosy.formalism.data.polynomial"

polynomial [meta] = {
  variable_type = {},

  monomial_type = {
    [refines] = {
      record
    },
    [meta] = {
      record = {
        coefficient = {
          value_type = "number",
        },
      },
      exponents = {
        [refines] = {
          collection,
        },
        [meta] = {
          collection = {
            key_type      = _ [meta].variable_type,
            key_container = _.variables,
            value_type    = "number",
          },
        },
      },
    },
  },
}

polynomial.variables = {
  [refines] = {
    collection,
  },
  [meta] = {
    value_type = _ [meta].variable_type,
  },
  [default] = {
    [refines] = {
      _ [meta].variable_type,
    },
  },
}

polynomial.monomials = {
  [refines] = {
    collection,
  },
  [meta] = {
    value_type = _ [meta].monomial_type,
  },
  [default] = {
    [refines] = {
      _ [meta].monomial_type,
    },
  },
}

return polynomial
