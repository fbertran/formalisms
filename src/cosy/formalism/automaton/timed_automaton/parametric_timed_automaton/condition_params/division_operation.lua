--Division Operation

return function (Layer, division_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local arithmetic_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/arithmetic_operation"

  division_operation [refines] = { 
    arithmetic_operation,
  }

  division_operation.operands[meta][collection].minimum=2
  division_operation.operands[meta][collection].maximum=2 
  division_operation[meta][record].operator.value="/"

  return division_operation
end
