local Layer = require "layeredata"
--local default_checks = require "formalisms.checks"
local object = require "formalisms.object"
local layer = Layer.new { 
  name = "hyper & multi graph",
}
local _     = Layer.reference "HMGT"

-- Formalism of Hyper and Multi Graph
-- ==================================
--
-- We describe here Hyper and Multi Graph
-- 
-- An Hyper and Multi Graph is a set V of vertices and a set E of edges. Each edge is a subset of V. In this formalism some edges may be identical.
-- 
-- For more information of Hyper and Multi Graph, see [here](https://en.wikipedia.org/?title=Hypergraph)

layer.__depends__ =  {
  object,
  --default_checks,
}

layer.__label__ = "HMGT"

layer.__meta__ = {

  hyper_multi_graph_type = {
    __meta__ = {
      vertex_type = {
        __refines__ = {
          _.__meta__.object_type.record_type,
        },
      },
      
      edge_type   = {
        __refines__ = {
          _.__meta__.object_type.record_type,
        },
        
        __meta__ = {
          arrow_type = {
            __refines__ = {
              _.__meta__.object_type.record_type,
            },
            __tags__ = {
              vertex = _.__meta__.hyper_multi_graph_type.vertices,
            },
          },
        },

        __tags__ = {
          arrows = _.__meta__.hyper_multi_graph_type.__meta__.edge_type.__meta__.arrow_type,
        },
      },
    },

    vertices = {
      __meta__ = {
        content_type = _.__meta__.hyper_multi_graph_type.__meta__.vertex_type,
      },
      __default__ = {
        content_type = _.__meta__.hyper_multi_graph_type.__meta__.vertex_type,
      },
    },

    edges = {
      __meta__ = {
        content_type = _.__meta__.hyper_multi_graph_type.__meta__.edge_type,
      },
      __default__ = {
        content_type = _.__meta__.hyper_multi_graph_type.__meta__.edge_type,
      },
    },
  },
}

return layer
