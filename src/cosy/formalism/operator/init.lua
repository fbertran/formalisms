return function (Layer, operator)

  local refines = Layer.key.refines
  local record = Layer.require "cosy/formalism/data.record"

  operator [refines] = {record}

  return operator
end