local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "labelled edges & hyper & multi graph", 
}
local _                 = Layer.reference "LEHMGT"

-- Formalism of a Hyper and Multi Graph with labels on edges
-- =========================================================
--
-- For more information of Hyper and Multi Graph formalism, see [here](./hyper_multi_graph.html)
--
-- We only add in this formalism labels on edges.

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__label__ = "LEHMGT"

layer.__meta__ = {
  labelled_edges_hyper_multi_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = { 
      label_edge_type = {
        __refines__ = {
          _.__meta__.object_type.record_type,
        },
      },
      
      edge_type = {
        __meta__ = {
          __tags__ = {
            labels = _.__meta__.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type,
          },
        },
      },
    },  
  },
}

return layer
