local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "hyper graph",
}

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

layer.__refines__ = {
  hyper_multi_graph
}

layer.__meta__ = {
  edges = {
    __checks__ = {
      function ()
        -- TODO
        -- check identical edges
      end,
    },
  },
}

return layer
