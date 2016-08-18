-- NOT Operator
-- Here pri-- Priority based on https://en.wikipedia.org/wiki/Order_of_operations
-- In our case biggest priority involves biggest number

return function (Layer, not_operator)

  local refines = Layer.key.refines
  local prefix  = Layer.require "cosy/formalism/operator/unary.prefix"
  local boolean = Layer.require "cosy/formalism/operation/boolean"

  not_operator [refines] = {
    boolean,
    prefix
  }

  not_operator.operator = "~"
  not_operator.priority = 13

end
