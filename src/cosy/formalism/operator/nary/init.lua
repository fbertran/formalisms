return function (Layer,nary)

  local refines = Layer.key.refines


  local operator = Layer.require "cosy/formalism/operator"

  nary [refines] = {operator}

  return nary

end