-- Boolean expression

return function (Layer, boolean_expression, ref)

  local meta              =  Layer.key.meta
  local refines           =  Layer.key.refines
  local record            =  Layer.require "cosy/formalism/data.record"
  local collection        =  Layer.require "cosy/formalism/data.collection"
  local operation         =  Layer.require "cosy/formalism/operation"
  local expression        =  Layer.require "cosy/formalism/expression"
  local boolean_operation =  Layer.require "cosy/formalism/operation/boolean_operation"
  
  boolean_expression = {
    [refines] = {expression}
  }
  boolean_expression.operations [meta] [collection].value_type=boolean_operation

  return boolean_expression
end
