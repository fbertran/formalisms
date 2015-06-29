local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "directed hyper & multi graph", 
}
local _                 = Layer.reference "DHMGT"

-- Formalism for a Directed Hyper and Multi Graph
-- ==============================================
-- 
-- A Directed Hyper and Multi Graph refine a Hyper and Multi Graph. It's a Hyper and Multi Graph with edges' ends are typed.
-- 
-- A definition of Directed Hyper Graph is given [here](http://link.springer.com/chapter/10.1007/3-540-45446-2_20)

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__label__ = "DHMGT"

layer.__meta__ = {
  directed_hyper_multi_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = { 
      edge_type = {
        __meta__ = {
          direction_type = {
            __refines__ = {
              _.__meta__.object_type.collection_type
            },
          },
                      
          arrow_type = {
            __tags__ = {
              direction = _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type,
            },
          },
        },
      },
    },  
  },
}

return layer
