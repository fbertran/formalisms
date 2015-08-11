local Layer                               = require "layeredata"
local record                              = require "formalisms.record"
local collection                          = require "formalisms.collection"
local labelled_edges_hyper_multi_graph    = require "formalisms.labelled_edges_hyper_multi_graph"
local labelled_vertices_hyper_multi_graph = require "formalisms.labelled_vertices_hyper_multi_graph"
local directed_hyper_multi_graph          = require "formalisms.directed_hyper_multi_graph"
local multi_graph                         = require "formalisms.multi_graph"
local alphabet                            = require "formalisms.alphabet"
local layer                               = Layer.new {
  name = "automaton",
}
local _      = Layer.reference "automaton"

-- Description of automaton
-- ========================
--
-- An automaton is a 5-tuple (Q, Σ, δ, q0, F)
--
-- Q is a set of vertices called states.
--
-- Σ is a finite alphabet, describe [here](./Alphabet.html)
--
-- δ is a set of labelled edges called transition. this edges are labelled by a symbol of Σ.
--
-- q0 is the start state, q0 is in Q
--
-- F is a subset of Q, they are the accept states
--
-- For more information of automaton see [here](http://www.cs.odu.edu/~toida/nerzic/390teched/regular/fa/nfa-definitions.html)

layer.__refines__ = {
  labelled_edges_hyper_multi_graph,
  labelled_vertices_hyper_multi_graph,
  directed_hyper_multi_graph,
  multi_graph,
  alphabet,
}

layer.__labels__ = { automaton = true }

layer.__meta__ = {
  edge_type = {
    __tags__ = {
      letter = {
        __value_type__      = _.__meta__.symbol_type,
        __value_container__ = _.symbols,
      },
    },
  },
  
  vertex_type  = {
    __meta__ = {
      __tags__ = {
        id = {},
      },
    },
  },

  initial_state_type = {
    __refines__ = {
      record,
    },
    __meta__ = {
      tags = {
        vertex = {
          __value_type__ = _.__meta__.vertex_type,
          __value_container__ = _.vertices,
        },
      },
    },
  },

  accept_state_type = {
    __refines__ = {
      record,
    },
    __meta__ = {
      tags = {
        vertex = {
          __value_type__ = _.__meta__.vertex_type,
          __value_container__ = _.vertices,
        },
      },
    },
  },
}

layer.initials_states = {
  __refines__ = {
    collection,
  },
  __meta__ = {
    __value_type__ = _.__meta__.initial_state_type,
  },
  __default__ = {
    __refines__ = {
      _.__meta__.initial_state_type,
    },
  },
}

layer.accept_states = {
  __refines__ = {
    collection,
  },
  __meta__ = {
    __value_type__ = _.__meta__.accept_state_type,
  },
  __default__ = {
    __refines__ = {
      _.__meta__.accept_state_type,
    },
  },
}

return layer
