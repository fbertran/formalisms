return function (Layer, addition)
  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"

  addition [refines] = {
    operator
  }

  addition.operator = "+"
  addition.priority = 11

  addition.is_associative = true
  addition.is_commutative = true
  addition.operands = {
    [refines] = { collection },
    [meta   ] = {
      [collection] = {
        minimum = 2,
        maximum = 2,
      },
    },
  }

  return addition
end
