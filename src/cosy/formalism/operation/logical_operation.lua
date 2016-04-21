--Logical Operation

return function (Layer, logical_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/operation"

  logical_operation [refines] = {
      operation,
    }

  

  return logical_operation
end
