-- Unary formalism

return function (Layer, unary)

  local refines     = Layer.key.refines
  local meta        = Layer.key.meta
  local operator    = Layer.require "cosy/formalism/operator"
  local collection  = Layer.require "cosy/formalism/data.collection"
  local record      = Layer.require "cosy/formalism/data.record"

  unary [refines] = {
    operator,
  }

  unary .operands [meta] [collection] .minimum = 1
  unary .operands [meta] [collection] .maximum = 1

  unary [meta] [record] .operator .optional = false
  unary [meta] [record] .priority .optional = false

  return unary
end