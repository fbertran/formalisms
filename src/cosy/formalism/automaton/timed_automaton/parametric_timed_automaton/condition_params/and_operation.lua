--Addition Operation

return function (Layer, and_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local collection =  Layer.require "cosy/formalism/data.collection"
  local record =  Layer.require "cosy/formalism/data.record"
  local logical_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params.logical_operation"

  and_operation [refines] = {logical_operation}
  

  and_operation.operands[meta][collection].minimum = 2
  and_operation.operands[meta][collection].maximum = math.huge
  and_operation[meta][record].operator.value = "AND"
  
  return and_operation
end
