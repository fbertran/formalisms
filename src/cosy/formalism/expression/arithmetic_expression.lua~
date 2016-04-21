-- Arithmetic expression

return function (Layer, arithmetic_expression, ref)

  local meta                 =  Layer.key.meta
  local refines              =  Layer.key.refines
  
  local record               =  Layer.require "cosy/formalism/data.record"
  local collection           =  Layer.require "cosy/formalism/data.collection"
  local operation            =  Layer.require "cosy/formalism/operation"
  local expression           =  Layer.require "cosy/formalism/expression"
  local arithmetic_operation =  Layer.require "cosy/formalism/operation/arithmetic_operation"

  arithmetic_expression = {
    [refines] = {expression},
  }

  arithmetic_expression.operations = {
    [meta]={
      [collection] = {
        value_type = arithmetic_operation
      },
    },
  }

  return arithmetic_expression
end
