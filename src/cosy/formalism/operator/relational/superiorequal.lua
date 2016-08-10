-- SuperiorEqual Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, superiorequal_operation)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines

  local collection  = Layer.require "cosy/formalism/data.collection"
  local binary      = Layer.require "cosy/formalism/operator.binary"

  superiorequal_operation [refines] = {
    binary
  }

  superiorequal_operation .operands [meta] [collection] .minimum = 2
  superiorequal_operation .operands [meta] [collection] .maximum = 2
  superiorequal_operation .operator = ">="
  superiorequal_operation .priority = 9

  return superiorequal_operation
end
