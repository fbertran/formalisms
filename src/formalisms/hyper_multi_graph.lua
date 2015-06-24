local Layer = require "layeredata"
local default_checks = require "formalisms.checks"
local layer = Layer.new { 
  name = "hyper & multi graph",
}
local _     = Layer.placeholder

-- Formalism for an Hyper and Multi Graph
-- ======================================
--
-- We describe here what is an Hyper and Multi Graph
-- 
-- An Hyper and Multi Graph is a set V of vertices and a set E of edges. Each edge is a subset of V. In this formalism some edges may be identical.
-- 
-- For more information of Hyper and Multi Graph, see [here](https://en.wikipedia.org/?title=Hypergraph)

layer.__depends__ =  {
  default_checks,
}

layer.__meta__ = {

  hyper_multi_graph_type = {
     --__label__ = "myid",
    __meta__ = {
      vertex_type = {
        
        key_type        = nil,
        content_type    = nil,
        key_container   = nil,
        value_container = nil,
      },
      
      edge_type   = {
        __meta__ = {
          arrow_type = {
            vertex = {
              key_type        = nil,
              content_type    = _.__meta__.hyper_multi_graph_type.__meta__.vertex_type, -- (_ "myid").__meta__.vertex_type,
              key_container   = nil,
              value_container = _.__meta__.hyper_multi_graph_type.vertices,
            },
          },
          
          checks = { 
            __refines__ = {
              _.__checks__,
            },
          },
        },
        arrows = {
          __meta__ = {
            content_type = _.__meta__.hyper_multi_graph_type.__meta__.edge_type.arrow_type
          },
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
