--Relational Operation

return function (Layer, relational_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/operation"

  relational_operation [refines] = {
    operation,
  }

  

  return relational_operation
end
