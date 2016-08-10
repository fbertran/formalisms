-- InferiorEqual Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, inferiorequal_operation)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines

  local collection  = Layer.require "cosy/formalism/data.collection"
  local binary      = Layer.require "cosy/formalism/operator.binary"
  
  inferiorequal_operation [refines] = {
    binary
  }

  inferiorequal_operation .operands [meta] [collection] .minimum = 2
  inferiorequal_operation .operands [meta] [collection] .maximum = 2
  inferiorequal_operation .operator = "<="
  inferiorequal_operation .priority = 9

  return inferiorequal_operation
end
