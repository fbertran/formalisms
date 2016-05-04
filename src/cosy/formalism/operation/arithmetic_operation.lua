--Arithmetic Operation

return function (Layer, arithmetic_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/operation"

  arithmetic_operation [refines] = {
    operation,
  }

  return arithmetic_operation
end
