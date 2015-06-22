local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "labelled edges & hyper & multi graph", 
}
local _                 = Layer.placeholder

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__meta__ = {
  labelled_edges_hyper_multi_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = { 
      label_edge_type = {},
      
      edge_type = {
        labels = {
          __meta__ = {
            content_type = _.__meta__.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type,
          },
        },
      },
    },  
  },
}

return layer
