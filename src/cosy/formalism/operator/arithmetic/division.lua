--Division Operation

return function (Layer, division_operation)

  local refines    =  Layer.key.refines
  local meta       = Layer.key.meta

  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local binary = Layer.require "cosy/formalism/operator.binary"
  division_operation [refines] = { 
    binary
  }

  division_operation.operands [meta][collection].minimum = 2
  division_operation.operands [meta][collection].maximum = 2 
  division_operation .operator = "/"
  division_operation .priority = 13
  

  return division_operation
end

