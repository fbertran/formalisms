local Layer = require "layeredata"
local layer = Layer.new { 
  name = "hyper & multi graph",
}
local _     = Layer.placeholder

-- Formalism for an hyper and multi graph
-- ======================================
--
-- 

layer.__meta__ = {

  hyper_multi_graph_type = {
     -- __id__ = "myid",
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
            checks = {},
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
    },
  },
}

return layer
