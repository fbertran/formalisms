-- Synchronized

return function (Layer, synchronized, ref)

  local meta      =  Layer.key.meta
  local refines   =  Layer.key.refines
  local alphabet  =  Layer.require "cosy/formalism/alphabet"
  local string    =  Layer.require "cosy/formalism/literal.string"
  local record    =  Layer.require "cosy/formalism/data.record"
  
  synchronized = {
    [refines] = {
      alphabet,
    },

    [meta]={
      [record]={--I don't know if I should put record or alphabet
        type={
          value_type=string,
          value_container={"send","recv"},
        },
      },
    },
  }

  return synchronized

end
