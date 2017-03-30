return function (Layer, Boolean)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator = Layer.require "operator"

  Boolean [refines] = {
    operator,
  }

  Boolean [meta].operands_type = "boolean"

  return Boolean
end
