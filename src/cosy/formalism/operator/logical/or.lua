-- OR Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, or_operation)

  local refines    =  Layer.key.refines
  local binary     = Layer.require "cosy/formalism/operator.binary"
  local logical    = Layer.require "cosy/formalism/operation/logical"

  or_operation [refines] = {
    logical,
    binary
  }

  or_operation .operator = "||"
  or_operation .priority = 3

end
