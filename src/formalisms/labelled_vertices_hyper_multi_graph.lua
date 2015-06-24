local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "labelled vertices & hyper & multi graph", 
}
local _                 = Layer.placeholder

-- Formalism of a Hyper and Multi Graph with labels on vertices
-- ============================================================
--
-- For more information of Hyper and Multi Graph formalism, see [here](./hyper_multi_graph.html)
--
-- We only add in this formalism labels on vertices.

layer.__depends__ = {
  hyper_multi_graph,
}
  
layer.__meta__ = {
  labelled_vertices_hyper_multi_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = { 
      label_vertex_type = {},
      
      vertex_type = {
        labels = {
          __meta__ = {
            content_type = _.__meta__.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
        },
      },
    },
  },
}

return layer
