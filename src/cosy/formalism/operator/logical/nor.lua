--NOR Operation

return function (Layer, nor_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"

  local binary = Layer.require "cosy/formalism/operator.binary"

  nor_operation [refines] = {
    binary
  }

  nor_operation.operands [meta][collection].minimum = 2
  nor_operation.operands [meta][collection].maximum = math.huge
  nor_operation.operator = "NOR"
  nor_operation.priority = 5

  return nor_operation
end
