local Layer = require "layeredata"
local graph = require "cosy.formalism.graph"
local layer = Layer.new {
  name = "cosy.formalism.graph.binary-edges",
}

-- Graph with binary edges
-- =======================
--
-- This formalism restricts the hypermultigraph to binary edges, that only link
-- two vertices. Thus, it removes the hypergraph properties.
--
-- For more information see [here](https://en.wikipedia.org/wiki/Hypergraph)

layer [Layer.key.refines] = {
  graph
}

layer [Layer.key.meta].edge_type [Layer.key.meta].arrows [Layer.key.meta] = {
  minimum = 2,
  maximum = 2,
}

return layer
