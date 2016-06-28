return function (Layer, nipta)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local collection = Layer.require "cosy/formalism/data.collection"

  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
  local assignment_operation = Layer.require "cosy/formalism/operation/assignment"

  local ipta = Layer.require "cosy/formalism/automaton/timed/parametric/imitator"


  nipta [refines] = {
    ipta,
  }

  nipta.parametric_instances = {
    [refines] = {collection},
    [meta] = {
      [collection] = {
        value_type = ipta,
      }
    }
  }
  nipta [meta].init_condition_type = {
    [refines] = {
      boolean_operation,
      assignment_operation
    }
    
  }
  nipta [meta].initial_state = nil


return nipta
end