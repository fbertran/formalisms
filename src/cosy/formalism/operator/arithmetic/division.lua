-- Division Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, division_operation)

  local refines               = Layer.key.refines
  local binary                = Layer.require "cosy/formalism/operator.binary"
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  division_operation [refines] = {
    arithmetic_operation,
    binary
  }

  division_operation .operator = "/"
  division_operation .priority = 12
  
end

