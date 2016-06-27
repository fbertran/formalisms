--Arithmetic Operation

return function (Layer, arithmetic_operation)

  
  local lpeg = require "lpeg"
  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  
  local operation  = Layer.require "cosy/formalism/operation"
  local operands_arithmetic_type = Layer.require "cosy/formalism/operation/arithmetic.operands_type"
  local operands_relational_type = Layer.require "cosy/formalism/operation/relational.operands_type"

  arithmetic_operation [refines] = {
    operation,
    --arithmetic operation can be used as an operands in a relational and arithmetic operation
    operands_arithmetic_type,
    operands_relational_type,
  }

  --arithmetic_operation [meta].operators = {multiplication = Layer.require "multiplication"}
  arithmetic_operation [meta].operands_type = operands_arithmetic_type --ref
  arithmetic_operation [meta][record].pattern = function ()

      local addition_operation = Layer.require "cosy/formalism/operation/arithmetic.addition"

      local substraction_operation = Layer.require "cosy/formalism/operation/arithmetic.substraction"

      local multiplication_operation = Layer.require "cosy/formalism/operation/arithmetic.multiplication"

      local division_operation = Layer.require "cosy/formalism/operation/arithmetic.division"

      local pattern = lpeg.C { ( addition_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = addition_operation [meta][record].result end ) + ( substraction_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = substraction_operation [meta][record].result end ) + ( multiplication_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = multiplication_operation [meta][record].result end ) + ( division_operation [meta][record].pattern()/function() arithmetic_operation [meta][record].result = division_operation [meta][record].result end )}

      return pattern
    end

  return arithmetic_operation
end
