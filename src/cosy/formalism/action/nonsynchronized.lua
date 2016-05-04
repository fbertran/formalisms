-- Non Synchronized

return function (Layer, nonsynchronized)

  local refines  =  Layer.key.refines
  local action =  Layer.require "cosy/formalism/action"
  
  nonsynchronized [refines] = {
    action,
  }

  return nonsynchronized
end
