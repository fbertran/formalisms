local Proxy                               = require "layeredata"
Proxy.labelled_edges_hyper_multi_graph    = require "formalisms.labelled_edges_hyper_multi_graph"
Proxy.labelled_vertices_hyper_multi_graph = require "formalisms.labelled_vertices_hyper_multi_graph"
Proxy.directed_hyper_multi_graph          = require "formalisms.directed_hyper_multi_graph"
Proxy.multi_graph                         = require "formalisms.multi_graph"
Proxy.alphabet                            = require "formalisms.alphabet"
local layer                               = Proxy.new {
  name = "automaton", 
}
local _                                   = Proxy.placeholder


layer.automaton_type = {
  __depends__ = {
    Proxy.labelled_edges_hyper_multi_graph,
    Proxy.labelled_vertices_hyper_multi_graph,
    Proxy.directed_hyper_multi_graph,
    Proxy.multi_graph,
    Proxy.alphabet,
  },

  __refines__ = {
    _.labelled_edges_hyper_multi_graph_type,
    _.labelled_vertices_hyper_multi_graph_type,
    _.directed_hyper_multi_graph_type,
    _.multi_graph_type,
    _.alphabet_type,
  },
  
  __meta__ = { 
    label_edge_type = {
      __value__ = {
        content_type    = _.alphabet_type.symbol_type,
        value_container = _.alphabet_type.symbols,
      },
    },
    
    initial_state_type = {
      __value__ = {
        content_type    = _.hyper_multi_graph_type.__meta__.vertex_type,
        value_container = _.hyper_multi_graph_type.vertices,
      },
    },
    
    accept_state_type = {
      __value__ = {
        content_type    = _.hyper_multi_graph_type.__meta__.vertex_type,
        value_container = _.hyper_multi_graph_type.vertices,
      },
    },
  },
  
  initials_states = {
    __meta__ = {
      content_type = _.automaton_type.__meta__.initial_state_type,
    },
  },

  accept_states = {
    __meta__ = {
      content_type = _.automaton_type.__meta__.accept_state_type,
    },
  },
}

return layer
