return function (Layer, automaton, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines
  local collection       = Layer.require "cosy/formalism/data.collection"
  local record           = Layer.require "cosy/formalism/data.record"
  local graph            = Layer.require "cosy/formalism/graph"
  local directed         = Layer.require "cosy/formalism/graph.directed"
  local action         = Layer.require "cosy/formalism/action"
  local identifier       = Layer.require "cosy/formalism/literal.identifier"

  automaton [refines] = {
    graph,
    directed,
  }

  identifier [meta][record].value.value_type = "string"
  automaton [meta].state_type = {
    [refines] = {
      automaton  [meta].vertex_type,
      identifier,
    },
    [meta] = {
      [record] = {
        initial    = { value_type = "boolean" },
        final      = { value_type = "boolean" },
      }
    }
  }
  automaton.actions = {
    [refines] = {
    collection,
    }
    
  }
  automaton.actions [meta][collection] = {
      value_type=action,

  }
  automaton [meta].transition_type = {
    [refines] = {
      automaton [meta].edge_type,
    },
  }
  automaton [meta].transition_type [meta][record].letter={
        value_type=action,
        value_container = ref.actions,
       }

  automaton.states = {
    [refines] = {
      automaton .vertices ,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].state_type,
      }
    }
  }

  automaton.transitions = {
    [refines] = {
      automaton .edges ,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].transition_type,
      }
    }
  }

  return automaton
end
