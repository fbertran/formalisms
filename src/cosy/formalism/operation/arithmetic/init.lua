--Arithmetic Operation

return function (Layer, arithmetic_operation, ref)

  
  local lpeg = require "lpeg"
  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  
  local operation  = Layer.require "cosy/formalism/operation"
  --local operands_arithmetic_type = Layer.require "cosy/formalism/operation/arithmetic.operands_type"
  --local operands_relational_type = Layer.require "cosy/formalism/operation/relational.operands_type"
  local addition_operation = Layer.require "cosy/formalism/operation/arithmetic.addition"
  local substraction_operation = Layer.require "cosy/formalism/operation/arithmetic.substraction"
  local multiplication_operation = Layer.require "cosy/formalism/operation/arithmetic.multiplication"
  local division_operation = Layer.require "cosy/formalism/operation/arithmetic.division"

  local addition_variant = Layer.new {}
  local substraction_variant = Layer.new {}
  local multiplication_variant = Layer.new {}
  local division_variant = Layer.new {}

  arithmetic_operation [refines] = {
    operation,
    --arithmetic operation can be used as an operands in a relational and arithmetic operation
    --operands_arithmetic_type,
    --operands_relational_type,
  }
  

  arithmetic_operation.operator = "t"
  
  arithmetic_operation [meta].operands_type = ref
  arithmetic_operation [meta][record].pattern = function ()

    

      local pattern = lpeg.C { ( addition_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = addition_operation [meta][record].result end ) + ( substraction_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = substraction_operation [meta][record].result end ) + ( multiplication_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = multiplication_operation [meta][record].result end ) + ( division_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = division_operation [meta][record].result end )}

      return pattern
    end

  addition_variant [refines] = {addition_operation,ref}
  substraction_variant [refines] = {substraction_operation,ref}
  multiplication_variant [refines] = {multiplication_operation,ref}
  division_variant [refines] = {division_operation,ref}
  arithmetic_operation [meta].operators = { addition_variant,substraction_variant,multiplication_variant,division_variant}

  return arithmetic_operation
end
