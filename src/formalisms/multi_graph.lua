local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "multi graph",
}

-- Formalism of a Multi Graph
-- ===========================
--
-- We describe here what is a Multi Graph
--
-- A Multi Graph is a Hyper and Multi Graph with a contrains on edges. The edges have a maximum arity of 2.
--
-- Formalism of Hyper and Multi Graph is describe [here](./hyper_multi_graph.html)
--
-- A Multi Graph may be define by a Graph which have identical edges.
--
-- For more information see [here](https://en.wikipedia.org/wiki/Multigraph)

layer.__refines__ = {
  hyper_multi_graph
}

layer.__meta__ = {
  edge_type = {
    arrows = {
      __checks__ = {
        function ()
          -- TODO
          -- check arity (size of arrows must equals 2)
        end,
      },
    },
  },
}

return layer
