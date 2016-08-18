-- Nullary formalism reprensents an operator without operands (usually a constant)
return function (Layer, nullary)

  local refines     = Layer.key.refines
  local meta        = Layer.key.meta

  local record      = Layer.require "cosy/formalism/data.record"
  local collection  = Layer.require "cosy/formalism/data.collection"
  local operator    = Layer.require "cosy/formalism/operator"


  nullary [refines] = {
    operator,
  }

  nullary [meta] [record] .priority .optional  = false

  nullary .operands [meta] [collection] .minimum = 0
  nullary .operands [meta] [collection] .maximum = 0

  return nullary
end