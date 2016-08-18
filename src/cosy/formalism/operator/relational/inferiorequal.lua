-- InferiorEqual Operation
-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, inferiorequal)

  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local relational  = Layer.require "cosy/formalism/operation/relational"

  inferiorequal [refines] = {
    relational,
    binary
  }

  inferiorequal .operator = "<="
  inferiorequal .priority = 8

end
