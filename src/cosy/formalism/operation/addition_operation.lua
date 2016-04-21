--Addition Operation

return function (Layer, addition_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local collection =  Layer.require "cosy/formalism/data.collection"
  local arithmetic_operation  = Layer.require "cosy/formalism/arithmetic_operation"

  addition_operation [refines] = {
     arithmetic_operation,
  }

  addition_operation[meta][collection].minimum = 2
  addition_operation[meta][collection].maximum = math.huge
  addition_operation.operator = "+"
  
  return addition_operation
end
