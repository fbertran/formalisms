--Equal Operation

return function (Layer, equal_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"

  local binary = Layer.require "cosy/formalism/operator.binary"

  equal_operation [refines] = {
    binary
  }

  equal_operation.operands [meta][collection].minimum = 2
  equal_operation.operands [meta][collection].maximum = 2
  equal_operation.operator = "=="
  equal_operation.priority = 9

  return equal_operation
end
