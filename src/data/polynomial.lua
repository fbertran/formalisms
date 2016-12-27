return function (Layer, polynomial, ref)

  local defaults = Layer.key.defaults
  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection = Layer.require "data.collection"
  local record     = Layer.require "data.record"

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
    [defaults] = {
      ref [meta].variable_type,
    },
  }

  polynomial.monomials = {
    [refines] = {
      collection,
    },
    [meta] = {
      value_type = ref [meta].monomial_type,
    },
    [defaults] = {
      ref [meta].monomial_type,
    },
  }

end
