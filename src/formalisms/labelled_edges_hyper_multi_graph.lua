local Proxy             = require "layeredata"
Proxy.hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Proxy.new {
  name = "labelled edges & hyper & multi graph", 
}
local _                 = Proxy.placeholder


layer.labelled_edges_hyper_multi_graph_type = {
  __depends__ = {
    Proxy.hyper_multi_graph,
  },

  __refines__ = {
    _.hyper_multi_graph_type,
  },
  
  __meta__ = { 
    label_edge_type = {},
    
    edge_type = {
      labels = {
        __meta__ = {
          content_type = _.hyper_multi_graph_type.__meta__.label_edge_type
        },
      },
    },
  },  
}

return layer
