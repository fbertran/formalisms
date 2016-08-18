-- Multiplication Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, multiplication_operation)
  
  local refines               = Layer.key.refines
  local binary                = Layer.require "cosy/formalism/operator.binary"
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  multiplication_operation [refines] = {
    arithmetic_operation,
    binary
  }

  multiplication_operation .priority = 12
  multiplication_operation .operator = "*"

end

