return function (Layer, Substraction_Expression)
  local refines = Layer.key.refines

  local expression   = Layer.require "expression"
  local substraction = Layer.require "operator.substraction"

  Substraction_Expression [refines] = {
    expression
  }

  Substraction_Expression.operator = substraction

  return Substraction_Expression
end
