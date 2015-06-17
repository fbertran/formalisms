local Proxy             = require "layeredata"
Proxy.hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Proxy.new {
  name = "multi graph", 
}
local _                 = Proxy.placeholder


layer.multi_graph_type = {
  __depends__ = {
    Proxy.hyper_multi_graph,
  },

  __refines__ = {
    _.hyper_multi_graph_type,
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
}

return layer
