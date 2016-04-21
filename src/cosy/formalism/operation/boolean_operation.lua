--Boolean Operation

return function (Layer, boolean_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/operation"

  boolean_operation [refines] = {
    operation,
  }

  

  return boolean_operation
end
