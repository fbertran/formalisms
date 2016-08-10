--Substraction Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, substraction_operation)

  local refines    =  Layer.key.refines
  local binary = Layer.require "cosy/formalism/operator.binary"

  substraction_operation [refines] = {
    binary
  }

  substraction_operation .priority = 11
  substraction_operation .operator = "-"
 
  return substraction_operation
end

