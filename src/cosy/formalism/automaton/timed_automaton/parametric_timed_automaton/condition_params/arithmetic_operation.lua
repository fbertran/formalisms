--Arithmetic Operation

return function (Layer, arithmetic_operation)

  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta
  local operation  = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params"
  local collection = Layer.require "cosy/formalism/data.collection"
  local operands_arithmetic_type = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/operands_arithmetic_type"
  local operands_relational_type = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params/operands_relational_type"

  arithmetic_operation [refines] = {
    operation,
    --arithmetic operation can be used as an operands in a relational and arithmetic operation
    operands_arithmetic_type,
    operands_relational_type,
  }

  arithmetic_operation.operands [meta] [collection].value_type = operands_arithmetic_type


  return arithmetic_operation
end
