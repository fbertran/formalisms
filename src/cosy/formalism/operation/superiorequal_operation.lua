--SuperiorEqual Operation

return function (Layer, superiorequal_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/operation.relational_operation"

  superiorequal_operation [refines] = {
    relational_operation,
  }

  superiorequal_operation.operands[meta][collection].minimum = 2
  superiorequal_operation.operands[meta][collection].maximum = 2
  superiorequal_operation[meta][record].operator.value = "SUPEQ"
  
  return superiorequal_operation
end
