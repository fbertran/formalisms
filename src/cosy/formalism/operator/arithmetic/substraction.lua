--Substraction Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, substraction_operation)

  local refines              = Layer.key.refines
  local binary               = Layer.require "cosy/formalism/operator.binary"
  local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"

  substraction_operation [refines] = {
    arithmetic_operation,
    binary
  }

  substraction_operation .priority = 11
  substraction_operation .operator = "-"
  
end

