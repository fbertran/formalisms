return function (Layer, imitator, ref)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  local collection = Layer.require "cosy/formalism/data.collection"
  
  local parametric_timed_automaton = Layer.require "cosy/formalism/automaton/timed/parametric"
  local literal = Layer.require "cosy/formalism/literal"
  local identifier = Layer.require "cosy/formalism/literal.identifier"
  local number = Layer.require "cosy/formalism/literal.number"
  local bool = Layer.require "cosy/formalism/literal.bool"

  local operands_type = Layer.require "cosy/formalism/flag.operands_type"
  local assignment = Layer.require "cosy/formalism/operation/assignment"
  local assignment_operation = Layer.require "cosy/formalism/operator/assignment"
  local assignment_operands_type = Layer.new {}
  local assignment_variant = Layer.new {}
  local assignment_operation_variant = Layer.new {}


  assignment_variant [refines] = {assignment}

  assignment_operation_variant [refines] = {assignment_variant,assignment_operation}



  assignment_operands_type [refines] = {operands_type}
  
  assignment_operation_variant[meta].operands_type = assignment_operands_type
 
  imitator [refines] = {
    parametric_timed_automaton,
  }

  assignment_variant [meta].operators = {
    [assignment_operation] = assignment_operation_variant,
    [identifier] = imitator [meta].guard_operations[literal][meta].operators[identifier],
    [number] = imitator [meta].guard_operations[literal][meta].operators[number],
    [bool] = imitator [meta].guard_operations[literal][meta].operators[bool]}

  imitator [meta].clock_assignment_type = {
    [refines] = {assignment_variant},
    [meta] = {
      operands_type = assignment_operands_type,
    }
  }
  imitator [meta].guard_operations[literal][meta].operators[number][refines][#imitator [meta].guard_operations[literal][meta].operators[number][refines]+1] = assignment_operands_type 
  imitator [meta].guard_operations[literal][meta].operators[identifier][refines][#imitator [meta].guard_operations[literal][meta].operators[identifier][refines]+1] = assignment_operands_type 
  imitator [meta].guard_operations[literal][meta].operators[bool][refines][#imitator [meta].guard_operations[literal][meta].operators[bool][refines]+1] = assignment_operands_type 
  imitator [meta].discrete_type = {
    [refines] = {
     imitator [meta].guard_operations[literal][meta].operators[identifier]
    },
  }

  imitator [meta].discrete_assignment_type = {
    [refines] = {assignment_variant},
    [meta] = {
      operands_type = assignment_operands_type,
    }
  }

  imitator.discrete_variables = {
    [refines] = {
      collection,
    },
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
  imitator [meta].assignment_operation = {
   [assignment] = assignment_variant,
  }


return imitator
end