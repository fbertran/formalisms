--Different Operation

return function (Layer, different_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  
  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local binary = Layer.require "cosy/formalism/operator.binary"

  different_operation [refines] = {
  binary
  }

  different_operation.operands [meta][collection].minimum = 2
  different_operation.operands [meta][collection].maximum = 2
  different_operation.operator = "~="
  different_operation.priority = 9

  return different_operation
end
