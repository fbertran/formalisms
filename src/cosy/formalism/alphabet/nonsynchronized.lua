-- Non Synchronized

return function (Layer, nonsynchronized, ref)

  local meta     =  Layer.key.meta
  local refines  =  Layer.key.refines
  local alphabet =  Layer.require "cosy/formalism/alphabet"
  
  nonsynchronized = {
    [refines] = {
      alphabet,
    },
  }

  return nonsynchronized
end
