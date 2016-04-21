-- Non Synchronized

return function (Layer, nonsynchronized)

  local refines  =  Layer.key.refines
  local alphabet =  Layer.require "cosy/formalism/alphabet"
  
  nonsynchronized [refines] = {
    alphabet,
  }

  return nonsynchronized
end
