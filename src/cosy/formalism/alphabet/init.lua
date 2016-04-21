-- Alphabet

return function (Layer, alphabet)

  local refines       =  Layer.key.refines
  local identifier    =  Layer.require "cosy/formalism/literal.identifier"

  alphabet [refines] = {
      identifier,
    }


  return alphabet

end
