return function (Layer, Prefix)
  local refines = Layer.key.refines

  local unary = Layer.require "operator.unary"

  Prefix [refines] = {
    unary,
  }

  return Prefix
end
