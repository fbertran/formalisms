-- Automata
-- ========

-- An automaton is a graph where vertices are called "states", edges are
-- called "transitions", and edges are labeled with symbols.
-- These symbols are taken from an alphabet, represented by an enumeration.
--
-- See [here](http://www.cs.odu.edu/~toida/nerzic/390teched/regular/fa/nfa-definitions.html)

return function (Layer, automaton, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection       = Layer.require "data.collection"
  local enumeration      = Layer.require "data.enumeration"
  local record           = Layer.require "data.record"
  local graph            = Layer.require "graph"
  local directed         = Layer.require "graph.directed"
  local binary_edges     = Layer.require "graph.binary_edges"

  automaton [refines] = {
    graph,
    directed,
    binary_edges,
  }

  automaton.alphabet = {
    [refines] = {
      enumeration,
    }
  }

  automaton [meta].state_type = {
    [refines] = {
      ref [meta].vertex_type,
    },
    [meta] = {
      [record] = {
        identifier = false,
        initial    = { value_type = "boolean" },
        final      = { value_type = "boolean" },
      }
    }
  }

  automaton [meta].transition_type = {
    [refines] = {
      ref [meta].edge_type,
    },
    [meta] = {
      [record] = {
        letter = {
          value_type      = ref.alphabet [Layer.key.meta] [enumeration].symbol_type,
          value_container = ref.alphabet,
        },
      },
    },
  }

  automaton.states = {
    [meta] = {
      [refines] = {
        ref [meta].vertices [meta],
      },
      [collection] = {
        value_type = ref [meta].state_type,
      }
    }
  }

  automaton.transitions = {
    [meta] = {
      [refines] = {
        ref [meta].edges [meta],
      },
      [collection] = {
        value_type = ref [meta].transition_type,
      }
    }
  }

  automaton.vertices [refines] = {
    ref.states,
  }
  automaton.edges    [refines] = {
    ref.transitions,
  }

  return automaton

end
