-- XOR Operator
-- Here priority value is subjectiv, it is just coherent with the rest of operator

return function (Layer, xor_operation)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines
  local collection  = Layer.require "cosy/formalism/data.collection"
  local binary      = Layer.require "cosy/formalism/operator.binary"

  xor_operation [refines] = {
    binary
  }

  xor_operation .operands [meta] [collection] .minimum = 2
  xor_operation .operands [meta] [collection] .maximum = 2
  xor_operation .operator = "XOR"
  xor_operation .priority = 7


  return xor_operation
end
