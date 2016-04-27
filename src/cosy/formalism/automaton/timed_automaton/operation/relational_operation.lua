--Relational Operation

return function (Layer, relational_operation)

  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta
  local boolean_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/operation/boolean_operation"
  local collection  =  Layer.require "cosy/formalism/data.collection"
  local operands_relational_type = Layer.require "cosy/formalism/automaton/timed_automaton/operation/operands_relational_type"
  relational_operation [refines] = {
    boolean_operation,
  }

  relational_operation.operands [meta] [collection].value_type = operands_relational_type
  

  return relational_operation
end
