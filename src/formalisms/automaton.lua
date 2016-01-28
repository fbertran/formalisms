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

layer[Layer.key.refines] = {
  labelled_edges_hyper_multi_graph,
  labelled_vertices_hyper_multi_graph,
  directed_hyper_multi_graph,
  multi_graph,
  alphabet,
}

layer[Layer.key.labels] = { automaton = true }

layer[Layer.key.meta] = {
  edge_type = {
    __tags__ = {
      letter = {
        __value_type__      = _ [Layer.key.meta].symbol_type,
        __value_container__ = _.symbols,
      },
    },
  },
  
  vertex_type  = {
    [Layer.key.meta] = {
      __tags__ = {
        id = {},
      },
    },
  },

  initial_state_type = {
    [Layer.key.refines] = {
      record,
    },
    [Layer.key.meta] = {
      tags = {
        vertex = {
          __value_type__ = _ [Layer.key.meta].vertex_type,
          __value_container__ = _.vertices,
        },
      },
    },
  },

  accept_state_type = {
    [Layer.key.refines] = {
      record,
    },
    [Layer.key.meta] = {
      tags = {
        vertex = {
          __value_type__ = _ [Layer.key.meta].vertex_type,
          __value_container__ = _.vertices,
        },
      },
    },
  },
}

layer.initials_states = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    __value_type__ = _ [Layer.key.meta].initial_state_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].initial_state_type,
    },
  },
}

layer.accept_states = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    __value_type__ = _ [Layer.key.meta].accept_state_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].accept_state_type,
    },
  },
}

return layer
