return function (Layer, Substraction)
  local refines = Layer.key.refines

  local addition = Layer.require "operator.addition"

  Substraction [refines] = {
    addition,
  }

  Substraction.operator = "-"
  Substraction.is_associative = false
  Substraction.is_commutative = false

  return Substraction
end
