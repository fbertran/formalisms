-- Inferior Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, inferior)

  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local relational  = Layer.require "cosy/formalism/operation/relational"

  inferior [refines] = {
    relational,
    binary
  }

  inferior .operator = "<"
  inferior .priority = 8

end
