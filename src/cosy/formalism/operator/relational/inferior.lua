-- Inferior Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, inferior_operation)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines

  local collection  = Layer.require "cosy/formalism/data.collection"
  local binary      = Layer.require "cosy/formalism/operator.binary"

  inferior_operation [refines] = {
    binary
  }

  inferior_operation .operands [meta] [collection] .minimum = 2
  inferior_operation .operands [meta] [collection] .maximum = 2
  inferior_operation .operator = "<"
  inferior_operation .priority = 9

  return inferior_operation
end
