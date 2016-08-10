-- And Operator (binary)
-- Here priority value is subjectiv, it is just coherent with the rest of operator

return function (Layer, and_operation)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines
  local collection  = Layer.require "cosy/formalism/data.collection"
  local binary      = Layer.require "cosy/formalism/operator.binary"

  and_operation [refines] = { binary }
  

  and_operation .operands [meta] [collection] .minimum = 2
  and_operation .operands [meta] [collection] .maximum = 2
  and_operation .operator = "&&"
  and_operation .priority = 6
  
  return and_operation
end
