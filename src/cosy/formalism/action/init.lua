-- action

return function (Layer, action)

  local refines       =  Layer.key.refines
  local identifier    =  Layer.require "cosy/formalism/literal.identifier"

  action [refines] = {
      identifier,
    }


  return action
end
