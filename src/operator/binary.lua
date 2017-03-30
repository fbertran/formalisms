return function (Layer, Binary)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local record     = Layer.require "data.record"

  Binary [refines] = {
    operator,
  }

  Binary.operands[meta][collection].minimum = 2
  Binary.operands[meta][collection].maximum = 2

  Binary [meta][record].operator.optional = false
  Binary [meta][record].priority.optional = false


  return Binary
end
