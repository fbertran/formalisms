-- string

return function (Layer, string)


  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/literal"
 
  string [refines] = {
    literal, 
  }
  
  string [meta] = {
    [record] = {
     value = { value_type = "string" },
    },
  }
  return string
end
