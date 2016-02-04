-- Graph with binary edges
-- =======================
--
-- This formalism restricts the hypermultigraph to binary edges, that only link
-- two vertices. Thus, it removes the hypergraph properties.
--
-- For more information see [here](https://en.wikipedia.org/wiki/Hypergraph)

return function (Layer)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph = Layer.require "cosy/formalism/graph"

  local binary_edges = Layer.new {
    name = "cosy/formalism/graph.binary-edges",
  }

  binary_edges [refines] = {
    graph
  }

  binary_edges [meta].edge_type [meta].arrows [meta] = {
    minimum = 2,
    maximum = 2,
  }

  return binary_edges

end
