--NOT Operation

return function (Layer, not_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local boolean_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params.boolean_operation"

  not_operation [refines] = {
    boolean_operation,
  }

  not_operation.operands[meta][collection].minimum = 1
  not_operation.operands[meta][collection].maximum = 1
  not_operation[meta][record].operator.value = "NOT"
  
  return not_operation
end
