local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "multi graph", 
}
local _                 = Layer.placeholder

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__meta__ = {

  multi_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = {
      edge_type = {
        __meta__ = {
          arrow_type = {
            checks = {
              function ()
                -- TODO check arity (size of arrows)
              end,
            },
          },
        },
      },
    },
  },
}

return layer
