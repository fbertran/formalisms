--Punctuator Operation

return function (Layer, punctuator_operation)

  local refines    =  Layer.key.refines

  local operation = Layer.require "cosy/formalism/operation"

  punctuator_operation [refines] = {
    operation,
  }

end