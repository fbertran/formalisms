local Proxy             = require "layeredata"
Proxy.hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Proxy.new {
  name = "directed hyper & multi graph", 
}
local _                 = Proxy.placeholder


layer.directed_hyper_multi_graph_type = {
  __depends__ = {
    Proxy.hyper_multi_graph,
  },

  __refines__ = {
    _.hyper_multi_graph_type,
  },
  
  __meta__ = { 
    edge_type = {
      __meta__ = {
        direction_type = {},
          
        arrow_type = {
          direction = {
            __meta__ = {
              content_type = _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
          },
        },
      },
    },
  },  
}

return layer
