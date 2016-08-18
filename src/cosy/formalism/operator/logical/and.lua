-- And Operator (binary)
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, and_operation)

  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local logical     = Layer.require "cosy/formalism/operation/logical"

  and_operation [refines] = { 
    logical,
    binary 
  }
  
  and_operation .operator = "&&"
  and_operation .priority = 4
  
end
