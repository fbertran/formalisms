local Layer                               = require "layeredata"
local labelled_edges_hyper_multi_graph    = require "formalisms.labelled_edges_hyper_multi_graph"
local labelled_vertices_hyper_multi_graph = require "formalisms.labelled_vertices_hyper_multi_graph"
local directed_hyper_multi_graph          = require "formalisms.directed_hyper_multi_graph"
local multi_graph                         = require "formalisms.multi_graph"
local alphabet                            = require "formalisms.alphabet"
local layer                               = Layer.new {
  name = "automaton", 
}
local _                                   = Layer.placeholder

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

layer.__depends__ = {
  labelled_edges_hyper_multi_graph,
  labelled_vertices_hyper_multi_graph,
  directed_hyper_multi_graph,
  multi_graph,
  alphabet,
}
  
layer.__meta__ = {

  automaton_type = {
    __refines__ = {
      _.__meta__.labelled_edges_hyper_multi_graph_type,
      _.__meta__.labelled_vertices_hyper_multi_graph_type,
      _.__meta__.directed_hyper_multi_graph_type,
      _.__meta__.multi_graph_type,
      _.__meta__.alphabet_type,
    },
    
    __meta__ = { 
      label_edge_type = {
        __value__ = {
          content_type    = _.__meta__.alphabet_type.symbol_type,
          value_container = _.__meta__.alphabet_type.symbols,
        },
      },
      
      label_vertex_type = {
        id = {},
      },
      
      initial_state_type = {
        __value__ = {
          content_type    = _.__meta__.hyper_multi_graph_type.__meta__.vertex_type,
          value_container = _.__meta__.hyper_multi_graph_type.vertices,
        },
      },
      
      accept_state_type = {
        __value__ = {
          content_type    = _.__meta__.hyper_multi_graph_type.__meta__.vertex_type,
          value_container = _.__meta__.hyper_multi_graph_type.vertices,
        },
      },
    },
    
    initials_states = {
      __meta__ = {
        content_type = _.__meta__.automaton_type.__meta__.initial_state_type,
      },
    },

    accept_states = {
      __meta__ = {
        content_type = _.__meta__.automaton_type.__meta__.accept_state_type,
      },
    },
  },
}

return layer
