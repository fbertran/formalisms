-- logical expression

return function (Layer, logical_expression, ref)

  local meta              =  Layer.key.meta
  local refines           =  Layer.key.refines
  local record            =  Layer.require "cosy/formalism/data.record"
  local collection        =  Layer.require "cosy/formalism/data.collection"
  local operation         =  Layer.require "cosy/formalism/operation"
  local expression        =  Layer.require "cosy/formalism/expression"
  local logical_operation =  Layer.require "cosy/formalism/operation/logical_operation"
  
  boolean_expression = {
    [refines] = {expression}
  }
  logical_expression.operations [meta] [collection].value_type=logical_operation

  return logical_expression
end
