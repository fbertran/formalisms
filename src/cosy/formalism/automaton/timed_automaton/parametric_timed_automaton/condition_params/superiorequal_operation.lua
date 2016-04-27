--SuperiorEqual Operation

return function (Layer, superiorequal_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params.relational_operation"

  superiorequal_operation [refines] = {
    relational_operation,
  }

  superiorequal_operation.operands[meta][collection].minimum = 2
  superiorequal_operation.operands[meta][collection].maximum = 2
  superiorequal_operation[meta][record].operator.value = ">="
  
  return superiorequal_operation
end
