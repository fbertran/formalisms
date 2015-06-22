local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "directed hyper & multi graph", 
}
local _                 = Layer.placeholder

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__meta__ = {

  directed_hyper_multi_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = { 
      edge_type = {
        __meta__ = {
          direction_type = {},
            
          arrow_type = {
            direction = {
              __meta__ = {
                content_type = _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
              },
            },
          },
        },
      },
    },  
  },
}

return layer
