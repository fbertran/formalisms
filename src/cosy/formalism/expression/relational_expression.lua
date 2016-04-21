-- relational expression

return function (Layer, relational_expression)

  local meta                 =  Layer.key.meta
  local refines              =  Layer.key.refines
  local collection           =  Layer.require "cosy/formalism/data.collection"
  local expression           =  Layer.require "cosy/formalism/expression"
  local relational_operation =  Layer.require "cosy/formalism/operation/relational_operation"
  
  relational_expression [refines] = {
    expression,
  }
  relational_expression.operations [meta] [collection].value_type=relational_operation

  return relational_expression
end
