-- XOR Operator
-- Here priority value is subjectiv, it is just coherent with the rest of operator

return function (Layer, xor_operation)

  local refines     = Layer.key.refines
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local logical    = Layer.require "cosy/formalism/operation/logical"

  xor_operation [refines] = {
    logical,
    binary
  }

  xor_operation .operator = "XOR"
  xor_operation .priority = 7

end
