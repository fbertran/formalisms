--Arithmetic Operation

return function (Layer, arithmetic_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/operation"

 -- local addition_operation = Layer.require "cosy/formalism/operator/arithmetic.addition"
 -- local substraction_operation = Layer.require "cosy/formalism/operator/arithmetic.substraction"
  --local multiplication_operation = Layer.require "cosy/formalism/operator/arithmetic.multiplication"
  --local division_operation = Layer.require "cosy/formalism/operator/arithmetic.division"
  arithmetic_operation [refines] = {
    operation,

  }

 --[[ arithmetic_operation [meta].operators = {
    [addition_operation] = addition_operation, 
    [substraction_operation] = substraction_operation, 
    [multiplication_operation] = multiplication_operation, 
    [division_operation] = division_operation 
  }]]
  
end
