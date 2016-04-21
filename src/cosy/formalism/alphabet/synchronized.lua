-- Synchronized

return function (Layer, synchronized)

  local meta      =  Layer.key.meta
  local refines   =  Layer.key.refines
  local alphabet  =  Layer.require "cosy/formalism/alphabet"
  local string    =  Layer.require "cosy/formalism/literal.string"
  local record    =  Layer.require "cosy/formalism/data.record"
  
  synchronized [refines] = {
    alphabet,
  }

  synchronized [meta] = {
      [record] = {
        type = {
          value_type=string,
          value_container={"send","recv"},
        },
    },
  }

  return synchronized

end
