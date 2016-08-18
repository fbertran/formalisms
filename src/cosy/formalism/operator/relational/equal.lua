-- Equal Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, equal)

  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local relational  = Layer.require "cosy/formalism/operation/relational"

  equal [refines] = {
    relational,
    binary
  }

  equal .operator = "=="
  equal .priority = 7

end
