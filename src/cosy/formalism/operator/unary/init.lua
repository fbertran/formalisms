return function (Layer, unary)

  local refines = Layer.key.refines
  local operator = Layer.require "cosy/formalism/operator"

  unary [refines] = {
    operator,
  }

  
  return unary
end