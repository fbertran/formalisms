return function (Layer, constrained)

  local type_   = Layer.require "cosy/formalism/type"
  local meta    = Layer.key.meta
  local refines = Layer.key.refines

  constrained [refines] = {
    type_,
  }
  constrained [meta] = {
    [type] = false
  }

end
