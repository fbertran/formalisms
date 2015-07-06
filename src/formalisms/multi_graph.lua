local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "multi graph",
}
local _                 = Layer.reference "MGT"
local root              = Layer.reference (false)

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

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__meta__ = {

  multi_graph_type = {
    __refines__ = {
      root.__meta__.hyper_multi_graph_type,
    },

    __meta__ = {
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
    },
  },
}

return layer
