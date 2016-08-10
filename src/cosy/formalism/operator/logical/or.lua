-- OR Operation
-- Here priority value is subjectiv, it is just coherent with the rest of operator

return function (Layer, or_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local collection =  Layer.require "cosy/formalism/data.collection"
  local binary     = Layer.require "cosy/formalism/operator.binary"

  or_operation [refines] = {
    binary
  }

  or_operation .operands [meta] [collection] .minimum = 2
  or_operation .operands [meta] [collection] .maximum = 2
  or_operation .operator = "||"
  or_operation .priority = 5

  return or_operation
end
