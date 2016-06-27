return function (Layer, nipta, ref)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  local collection = Layer.require "cosy/formalism/data.collection"

  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
  local assignment_operation = Layer.require "cosy/formalism/operation/assignment"

  local ipta = Layer.require "cosy/formalism/automaton/timed/parametric/imitator"

  nipta [refines] = {
    npta,
  }

  npta.parametric_instances = {
    [refines] = {collection},
    [meta] = {
      [collection] = {
        value_type = ipta,
      }
    }
  }
  npta [meta].init_condition_type = {
    boolean_operation,
    assignment_operation
  }


return npta
end