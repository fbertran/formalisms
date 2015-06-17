local Proxy = require "layeredata"
local layer = Proxy.new { 
  name = "hyper & multi graph",
}
local _     = Proxy.placeholder

-- 
layer.hyper_multi_graph_type = {

  __meta__ = {
    vertex_type = {
      __value__ = {
        key_type        = nil,
        content_type    = nil,
        key_container   = nil,
        value_container = nil,
      },
    },
    
    edge_type   = {
      __meta__ = {
        arrow_type = {
          vertex = {
            key_type        = nil,
            content_type    = _.hyper_multi_graph_type.__meta__.vertex_type,
            key_container   = nil,
            value_container = _.hyper_multi_graph_type.vertices,
          },
          checks = {},
        },
      },
      arrows = {
        __meta__ = {
          content_type = _.hyper_multi_graph_type.__meta__.edge_type.arrow_type
        },
      },
    },
  },

  vertices = {
    __meta__ = {
      content_type = _.hyper_multi_graph_type.__meta__.vertex_type,
    },
  },

  edges = {
    __meta__ = {
      content_type = _.hyper_multi_graph_type.__meta__.edge_type,
    },
  } --extends typed_collection with type edge_type
}

return layer
