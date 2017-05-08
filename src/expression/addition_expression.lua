return function (Layer, Addition_Expression)
  local refines = Layer.key.refines

  local expression = Layer.require "expression"
  local addition   = Layer.require "operator.addition"

  Addition_Expression [refines] = {
    expression
  }

  Addition_Expression.operator = addition

  return Addition_Expression
end
