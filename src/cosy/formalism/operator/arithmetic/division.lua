-- Division Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, division_operation)

  local refines    =  Layer.key.refines
  local binary = Layer.require "cosy/formalism/operator.binary"

  division_operation [refines] = { 
    binary
  }

  division_operation .operator = "/"
  division_operation .priority = 12
  
  return division_operation
end

