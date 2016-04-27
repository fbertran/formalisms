--Boolean Operation

return function (Layer, boolean_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/automaton/timed_automaton/operation"

  boolean_operation [refines] = {
    operation,
  }

  

  return boolean_operation
end
