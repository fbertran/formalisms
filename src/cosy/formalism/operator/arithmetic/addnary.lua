--Addition Operation

return function (Layer, addnary_operation)

  local refines               = Layer.key.refines
  local prefix                = Layer.require "cosy/formalism/operator/nary.prefix"
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  addnary_operation [refines] = {
    arithmetic_operation,
    prefix
  }

  addnary_operation.operator = "+"
  addnary_operation.priority = 13

end
