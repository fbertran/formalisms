return function (Layer, Infix)
  local refines = Layer.key.refines

  local binary = Layer.require "operator.binary"

  Infix [refines] = {
    binary,
  }

  return Infix
end
