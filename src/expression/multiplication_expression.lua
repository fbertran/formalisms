return function (Layer, Multiplication_Expression)
  local refines = Layer.key.refines

  local expression = Layer.require "expression"
  local multiplication = Layer.require "operator.multiplication"

  Multiplication_Expression [refines] = {
    expression,
  }

  Multiplication_Expression.operator = multiplication

  return Multiplication_Expression
end
