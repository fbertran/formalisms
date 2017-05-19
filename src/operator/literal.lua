return function (Layer, literal)
  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local _, re      = Layer.require "expression"
  local collection = Layer.require "data.collection"
  local operator   = Layer.require "operator"

  literal [refines] = {
    operator,
  }

  -- literal.operator = ""
  -- literal.priority = 12
  -- literal.is_associative = true
  -- literal.is_commutative = true

  literal [meta] = {
    of       = false,
    operands = {
      [refines] = { collection },
      [meta   ] = {
        [collection] = {
          minimum    = 1,
          maximum    = 1,
          -- re.operator [meta].of
          -- References the expression that contains the instance of the operator,
          -- and that instance of operator holds the expected value type
          -- of its operands
          value_type = re.operator [meta].of,
        },
      },
    },
  }

  return literal
end
