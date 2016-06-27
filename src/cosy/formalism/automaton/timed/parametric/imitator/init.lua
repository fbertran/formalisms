return function (Layer, imitator, ref)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  local collection = Layer.require "cosy/formalism/data.collection"
  
  local parametric_timed_automaton = Layer.require "cosy/formalism/automaton/timed/parametric"

  local assignment_operation = Layer.require "cosy/formalism/operation/assignment"

  imitaror [refines] = {
    parametric_timed_automaton,
  }

  imitator [meta].clock_assignment_type = {
    [refines] = {assignment_operation},
    [meta] = {
      operands_type = ref [meta].clock_type,
    }
  }

  imitator [meta].discrete_type = {
    [refines] = {
      identifier,
      operands_arithmetic_type,
      operands_relational_type,
    },
  }

  imitator [meta].discrete_assignment_type = {
    [refines] = {assignment_operation},
    [meta] = {
      operands_type = ref [meta].discrete_type,
    }
  }

  imitator.discrete_variables = {
    [refines] = {
      collection,
    }
    [meta] = {
      [collection] = {
        value_type = ref [meta].discrete_type,
      }
    }
  }

  imitator.initial_state = {
    value_type = ref [meta].state_type,
    value_container = ref [meta].states
  }

  imitator [meta].transition_type [meta][record].urgent = {value_type = "boolean"}

  imitator [meta].state_type [meta][record].urgent = {value_type = "boolean"}

  imitator [meta].transition_type [meta][record].clock_update [meta][collection] = {
    value_type = ref [meta].clock_assignment_type,  
  }

  imitator [meta].transition_type [meta][record].discrete_update = {
    [refines] = {collection},
    [meta] = {
      [collection] = {
        value_type = ref [meta].discrete_assignment_type,
      }
    }
  }

   imitator [meta].state_type [meta][record].clock_update = {
    [refines] = {collection},
    [meta] = {
      value_type = ref [meta].clock_assignment_type,  
    }
  }

  imitator [meta].state_type [meta][record].discrete_update = {
    [refines] = {collection},
    [meta] = {
      [collection] = {
        value_type = ref [meta].discrete_assignment_type,
      }
    }
  }


  imitator [meta].state_type [meta][record].stopwatches = {
    [refines] = {
    collection,
    },
    [meta] = {
      value_type = ref [meta].clock_type,  
    }
  }

return imitator
end