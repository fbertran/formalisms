local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "hyper graph", 
}
local _                 = Layer.placeholder

layer.__depends__ = {
  hyper_multi_graph,
}
  
layer.__meta__ = {

  hyper_graph_type = {
    __refines__ = {
      _.__meta__.hyper_multi_graph_type,
    },
    
    __meta__ = {
      edge_type = {
        __meta__ = {
          checks = {
            function ()
              -- TODO check same edges in table
            end,
          },
        },
      },
    },
  },
}

return layer
