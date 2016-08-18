--Increment Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, increment_operation)

  local refines               = Layer.key.refines
  local suffix                = Layer.require "cosy/formalism/operator/unary.suffix"
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  increment_operation [refines] = {
    arithmetic_operation,
    suffix
  }

  increment_operation.operator = "++ " -- There is a whitespace at the end
  increment_operation.priority = 13
 
end
