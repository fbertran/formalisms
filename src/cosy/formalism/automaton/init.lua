return function (Layer, automaton, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines
  
  local collection       = Layer.require "cosy/formalism/data.collection"
  local record           = Layer.require "cosy/formalism/data.record"
  local graph            = Layer.require "cosy/formalism/graph"
 
  local directed         = Layer.require "cosy/formalism/graph.directed"
  local binary_edges     = Layer.require "cosy/formalism/graph.binary_edges"

  local alphabet         = Layer.require "cosy/formalism/alphabet"
  local identifier       = Layer.require "cosy/formalism/literal.identifier"

  automaton [refines] = {
    graph,
    directed,
    binary_edges,
  }


  automaton [meta].state_type = {
    [refines] = {
      ref [meta].vertex_type,
      identifier,
    },
    [meta] = {
      [record] = {
        initial    = { value_type = "boolean" },
        final      = { value_type = "boolean" },
      }
    }
  }
  automaton.alphabets = {
    [refines] = {
    collection,
    }
    
  }
  automaton.alphabets [meta][collection] = {
      value_type=alphabet,

  }
  automaton [meta].transition_type = {
    [refines] = {
      ref [meta].edge_type,
    },
  }
  automaton [meta].transition_type [meta][record] = {
      letter={
        value_type=alphabet,
        value_container = ref.alphabets,
       }
  }

  automaton.states = {
    [refines] = {
      ref [meta].vertices,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].state_type,
      }
    }
  }

  automaton.transitions = {
    [refines] = {
      ref [meta].edges,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].transition_type,
      }
    }
  }



  return automaton
end
