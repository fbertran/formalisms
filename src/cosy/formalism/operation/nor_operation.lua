--NOR Operation

return function (Layer, nor_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local boolean_operation  = Layer.require "cosy/formalism/operation.boolean_operation"

  nor_operation [refines] = {
    boolean_operation,
  }

  nor_operation.operands[meta][collection].minimum = 1
  nor_operation.operands[meta][collection].maximum = 1
  nor_operation[meta][record].operator.value = "NOR"
  
  return nor_operation
end
