--Multiplication Operation

return function (Layer, multiplication_operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local arithmetic_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params.arithmetic_operation"

  multiplication_operation [refines] = {
    arithmetic_operation,
  }

  multiplication_operation.operands[meta][collection].minimum=2
  multiplication_operation.operands[meta][collection].maximum=math.huge
  multiplication_operation[meta][record].operator.value="*"

  return multiplication_operation
end
