return function (Layer, Arithmetic)
  local refines = Layer.key.refines
  local meta    = Layer.key.meta

  local operator = Layer.require "operator"

  Arithmetic [refines] = {
    operator,
  }

  Arithmetic [meta].operands_type = "number"

  return Arithmetic
end
