local Proxy             = require "layeredata"
Proxy.hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Proxy.new {
  name = "hyper_graph", 
}
local _                 = Proxy.placeholder


layer.hyper_graph_type = {
  __depends__ = {
    Proxy.hyper_multi_graph,
  },

  __refines__ = {
    _.hyper_multi_graph_type,
  },
  
  __meta__ = {
    edge_type = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.edge_type,
      },
      __meta__ = {
        checks = {
          function ()
            for k1,v1 in pairs(_.edges) do
              for k2, v2 in pairs(_.edges) do
                if(k1 ~= k2 and v1 == v2) then
                  return false;
                end
              end
            end
            return true
          end,
        },
      },
    },
  },
}

return layer					
