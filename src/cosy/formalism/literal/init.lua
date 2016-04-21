-- literal

return function (Layer, literal)


  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"



  literal [refines] = {
    record, 
  }
  literal [meta] = {
    [record] = {
     value = { value_type = false },
    },
  }
  --return literal
end
