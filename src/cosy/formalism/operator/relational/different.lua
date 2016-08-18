-- Different Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, different)

  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local relational  = Layer.require "cosy/formalism/operation/relational"

  different [refines] = {
    relational,
    binary
  }

  different .operator = "~="
  different .priority = 7

end
