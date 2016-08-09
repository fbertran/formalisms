--Multiplication Operation

return function (Layer, multiplication_operation)
  
  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"

  local binary = Layer.require "cosy/formalism/operator.binary"

  multiplication_operation [refines] = {
    binary
  }

  multiplication_operation.operands [meta][collection].minimum = 2
  multiplication_operation.operands [meta][collection].maximum = math.huge
  multiplication_operation .priority = 13
  multiplication_operation .operator = "*"


  return multiplication_operation
end

