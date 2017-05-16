return function (Layer, arithmetic, ref)

  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local collection     = Layer.require "data.collection"
  local expression     = Layer.require "expression"
  local literal        = Layer.require "operator.literal"
  local addition       = Layer.require "operator.addition"
  local multiplication = Layer.require "operator.multiplication"

  arithmetic [refines] = {
    expression
  }

  local r_number = {
    [refines] = { literal },
    operands  = {
      [meta] = {
        [collection] = {
          value_type = "number",
        },
      },
    },
  }

  local r_addition = {
    [refines] = { addition },
    operands  = {
      [meta] = {
        [collection] = {
          -- this works
          -- value_type = arithmetic,
          -- this causes "linearization fail"
          value_type = ref,
        },
      },
    },
  }


  local r_multiplication = {
    [refines] = { multiplication },
    operands  = {
      [meta] = {
        [collection] = {
          value_type = ref,
        },
      },
    },
  }

  arithmetic [meta] = {
    [expression] = {
      number         = r_number,
      multiplication = r_multiplication,
      addition       = r_addition,
    },
  }

  -- exercices:
  -- create the literal operator
  -- create a new expression above another, adding some operators
  -- create a new expression above another, removing some operators

  return arithmetic
end
