--InferiorEqual Operation

return function (Layer, inferiorequal_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/operation.relational_operation"

  inferiorequal_operation [refines] = {
    relational_operation,
  }

  inferiorequal_operation.operands[meta][collection].minimum = 2
  inferiorequal_operation.operands[meta][collection].maximum = 2
  inferiorequal_operation[meta][record].operator.value= "<="
  
  return inferiorequal_operation
end
