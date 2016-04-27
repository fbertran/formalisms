--Addition Operation

return function (Layer, or_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local logical_operation  = Layer.require "cosy/formalism/operation.logical_operation"

  or_operation [refines] = {
    logical_operation,
  }

  or_operation.operands[meta][collection].minimum = 2
  or_operation.operands[meta][collection].maximum = math.huge
  or_operation[meta][record].operator.value = "OR"
  
  return or_operation
end
