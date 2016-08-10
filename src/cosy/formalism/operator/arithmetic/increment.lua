--Increment Operation

return function (Layer, increment_operation)

  local refines    =  Layer.key.refines


  local suffix = Layer.require "cosy/formalism/operator/unary.suffix"
  
  increment_operation [refines] = {
     suffix
  }


  increment_operation.operator = "++ "
  increment_operation.priority = 13
 
  
  return increment_operation
end
