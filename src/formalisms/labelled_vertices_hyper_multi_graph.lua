local Proxy             = require "layeredata"
Proxy.hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Proxy.new {
  name = "labelled vertices & hyper & multi graph", 
}
local _                 = Proxy.placeholder


layer.labelled_vertices_hyper_multi_graph_type = {
  __depends__ = {
    Proxy.hyper_multi_graph,
  },

  __refines__ = {
    _.hyper_multi_graph_type,
  },
  
  __meta__ = { 
    label_vertex_type = {},
    
    vertex_type = {
      labels = {
        __meta__ = {
          content_type = _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
        },
      },
    },
  },  
}

return layer
