return function (Layer, Nullary, ref)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"
  local record     = Layer.require "data.record"

  Nullary [refines] = {
    operator,
  }

  Nullary.operands[meta][collection].minimum = 0
  Nullary.operands[meta][collection].maximum = 0

  return Nullary
end
