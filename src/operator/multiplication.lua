return function (Layer, multiplication)
  local refines    = Layer.key.refines
  local meta       = Layer.key.meta
  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"

  multiplication [refines] = {
    operator,
  }

  multiplication.operator = "*"
  multiplication.priority = 12

  multiplication.is_associative = true
  multiplication.is_commutative = true
  multiplication.operands = {
    [refines] = { collection },
    [meta   ] = {
      [collection] = {
        minimum = 2,
        maximum = 2,
      },
    },
  }

  return multiplication
end
