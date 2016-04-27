--Equal Operation

return function (Layer, equal_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/operation/relational_operation"

  equal_operation [refines] = {
    relational_operation,
  }

  equal_operation.operands[meta][collection].minimum = 2
  equal_operation.operands[meta][collection].maximum = 2
  equal_operation[meta][record].operator.value = "=="
  
  return equal_operation
end
