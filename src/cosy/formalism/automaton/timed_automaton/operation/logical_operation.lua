--Logical Operation

return function (Layer, logical_operation)

  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta
  local boolean_operation  = Layer.require "cosy/formalism/automaton/timed_automaton/operation/boolean_operation"
  local collection = Layer.require "cosy/formalism/data.collection"
  


  logical_operation [refines] = {
      boolean_operation,
    }

  logical_operation.operands [meta] [collection].value_type = boolean_operation


  return logical_operation
end
