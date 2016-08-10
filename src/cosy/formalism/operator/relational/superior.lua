-- Superior Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number
return function (Layer, superior_operation)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines

  local collection  = Layer.require "cosy/formalism/data.collection"
  local binary      = Layer.require "cosy/formalism/operator.binary"

  superior_operation [refines] = {
    binary
  }

  superior_operation .operands [meta] [collection] .minimum = 2
  superior_operation .operands [meta] [collection] .maximum = 2
  superior_operation .operator = ">"
  superior_operation .priority = 9

  return superior_operation
end
