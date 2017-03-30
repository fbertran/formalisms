return function (Layer, Substraction)
  local refines = Layer.key.refines

  local addition = Layer.require "operator.addition"

  Substraction [refines] = {
    addition,
  }

  Substraction.operator = "-"

  return Substraction
end
