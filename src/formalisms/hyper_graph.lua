local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "hyper graph", 
}
local _                 = Layer.placeholder

-- Formalism of a Hyper Graph
-- ===========================
--
-- We describe here what is a Hyper Graph
-- 
-- A Hyper Graph extends definition of Hyper and Multi Graph with one constraint, we cannot have identical edges.
-- 
-- Formalism of Hyper and Multi Graph is describe [here](./hyper_multi_graph.html)
--
-- For more information see [here](https://en.wikipedia.org/wiki/Hypergraph) 

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
              -- TODO check identical edges in table
            end,
          },
        },
      },
    },
  },
}

return layer
