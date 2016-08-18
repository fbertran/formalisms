-- SuperiorEqual Operator
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, superiorequal)
  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local relational  = Layer.require "cosy/formalism/operation/relational"

  superiorequal [refines] = {
    relational,
    binary
  }
  
  superiorequal .operator = ">="
  superiorequal .priority = 8

end
