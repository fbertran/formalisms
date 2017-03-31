return function (Layer, Nullary)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator   = Layer.require "operator"
  local collection = Layer.require "data.collection"

  Nullary [refines] = {
    operator,
  }

  Nullary.operands[meta][collection].minimum = 0
  Nullary.operands[meta][collection].maximum = 0

  return Nullary
end
