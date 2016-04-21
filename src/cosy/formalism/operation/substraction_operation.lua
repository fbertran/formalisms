--Substraction Operation

return function (Layer, substraction_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local arithmetic_operation  = Layer.require "cosy/formalism/arithmetic_operation"

  substraction_operation = {
    [refines] = {arithmetic_operation},
  }

  substraction_operation[meta][collection].minimum=2
  substraction_operation[meta][collection].maximum=2
  substraction_operation[meta][collection].operator="-"
  
  return substraction_operation
end
