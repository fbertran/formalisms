-- Arithmetic expression

return function (Layer, arithmetic_expression)

  local meta                 =  Layer.key.meta
  local refines              =  Layer.key.refines
 
  local collection           =  Layer.require "cosy/formalism/data.collection"
  local expression           =  Layer.require "cosy/formalism/expression"
  local arithmetic_operation =  Layer.require "cosy/formalism/operation/arithmetic_operation"

  arithmetic_expression [refines] = {
    expression
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
