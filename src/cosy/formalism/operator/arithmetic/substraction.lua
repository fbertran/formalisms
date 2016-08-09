--Substraction Operation

return function (Layer, substraction_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"

  local binary = Layer.require "cosy/formalism/operator.binary"

  substraction_operation [refines] = {
    binary
  }

  substraction_operation.operands [meta][collection].minimum = 2
  substraction_operation.operands [meta][collection].maximum = 2
  substraction_operation .priority = 12
  substraction_operation .operator = "-"
 
  return substraction_operation
end

