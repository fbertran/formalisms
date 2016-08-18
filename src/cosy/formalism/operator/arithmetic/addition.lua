-- Addition Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, addition_operation)

  local refines               = Layer.key.refines
  local binary                = Layer.require "cosy/formalism/operator.binary"
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  addition_operation [refines] = {
    arithmetic_operation,
    binary,
  }

  addition_operation .operator = "+"
  addition_operation .priority = 11

end
