return function (Layer, polynomial, ref)

  local default  = Layer.key.default
  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection = Layer.require "cosy/formalism/data.collection"
  local record     = Layer.require "cosy/formalism/data.record"

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
              key_type      = ref [meta].variable_type,
              key_container = ref.variables,
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
      value_type = ref [meta].variable_type,
    },
    [default] = {
      [refines] = {
        ref [meta].variable_type,
      },
    },
  }

  polynomial.monomials = {
    [refines] = {
      collection,
    },
    [meta] = {
      value_type = ref [meta].monomial_type,
    },
    [default] = {
      [refines] = {
        ref [meta].monomial_type,
      },
    },
  }

end
