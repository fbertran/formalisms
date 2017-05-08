return function (Layer, Multiplication)
  local refines = Layer.key.refines
  local collection = Layer.require "data.collection"
  local operator = Layer.require "operator"

  Multiplication [refines] = {
    operator,
  }

  Multiplication.operator = "*"
  Multiplication.priority = 12

  Multiplication.is_associative = true
  Multiplication.is_commutative = true
  Multiplication.operands = {
    [collection] = {
      minimum = 2,
      maximum = 2,
      value_type = "number",
    },
    type = collection,
  }

  return Multiplication
end
