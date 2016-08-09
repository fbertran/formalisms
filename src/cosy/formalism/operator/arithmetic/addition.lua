--Addition Operation

return function (Layer, addition_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"

  local binary = Layer.require "cosy/formalism/operator.binary"
  addition_operation [refines] = {
     binary
  }

  addition_operation.operands[meta][collection].minimum = 2
  addition_operation.operands[meta][collection].maximum = math.huge
  addition_operation.operator = "+"
  addition_operation.priority = 12
 
  
  return addition_operation
end
