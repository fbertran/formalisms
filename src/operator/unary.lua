return function (Layer, Unary)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local record     = Layer.require "data.record"

  Unary [refines] = {
    operator,
  }

  Unary.operands[meta][collection].minimum = 1
  Unary.operands[meta][collection].maximum = 1

  Unary [meta][record].operator.optional = false
  Unary [meta][record].priority.optional = false

  return Unary
end
