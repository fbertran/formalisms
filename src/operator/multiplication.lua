return function (Layer, Multiplication)
  local refines = Layer.key.refines

  local infix      = Layer.require "operator.infix"
  local arithmetic = Layer.require "operator.arithmetic"

  Multiplication [refines] = {
    infix,
    arithmetic,
  }

  Multiplication.operator = "*"
  Multiplication.priority = 12

  return Multiplication
end
