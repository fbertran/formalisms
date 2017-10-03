return function (Layer, And_Expression)
  local refines = Layer.key.refines

  local expression = Layer.require "expression"
  local And = Layer.require "operator.and"

  And_Expression [refines] = {
    expression,
  }

  And_Expression.operator = And

  return And_Expression
end
