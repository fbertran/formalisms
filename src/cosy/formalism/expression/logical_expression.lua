-- logical expression

return function (Layer, logical_expression)

  local meta              =  Layer.key.meta
  local refines           =  Layer.key.refines
  local collection        =  Layer.require "cosy/formalism/data.collection"
  local expression        =  Layer.require "cosy/formalism/expression"
  local logical_operation =  Layer.require "cosy/formalism/operation/logical_operation"
  
  logical_expression [refines] = {
    expression,
  }
  logical_expression.operations [meta] [collection].value_type=logical_operation

  return logical_expression
end
