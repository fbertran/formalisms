-- identifier

return function (Layer, identifier)

  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  

  local literal =  Layer.require "cosy/formalism/literal"
  local record  =  Layer.require "cosy/formalism/data.record"

 
  identifier [refines] = {
    literal, 
  }
  
  identifier [meta] = {
    [record] = {
     value = { value_type = false },
    },
  }
  return identifier
end
