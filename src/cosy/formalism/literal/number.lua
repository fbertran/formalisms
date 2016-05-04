-- number

return function (Layer, number)
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines 
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/literal"
 
 
  number [refines] = {
    literal, 
  }
  
  number [meta] = {
    [record] = {
     value = { value_type = "number" },
    },
  }

  
  return number
end
