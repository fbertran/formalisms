return function (Layer, literal)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local collection = Layer.require "data.collection"
  local operator   = Layer.require "operator"

  literal [refines] = {
    operator,
  }

  literal.operator = ""
  literal.priority = 12

  literal.is_associative = true
  literal.is_commutative = true
  literal.operands = {
    [refines] = { collection },
    [meta   ] = {
      [collection] = {
        minimum = 1,
        maximum = 1,
      },
    },
  }

  return literal
end
