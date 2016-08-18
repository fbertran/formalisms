-- NOR Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, nor_operation)

  local refines    = Layer.key.refines
  local binary     = Layer.require "cosy/formalism/operator.binary"
  local logical    = Layer.require "cosy/formalism/operation/logical"

  nor_operation [refines] = {
    logical,
    binary
  }

  nor_operation .operator = "NOR"
  nor_operation .priority = 3

end
