-- Graph with binary edges
-- =======================
--
-- This formalism restricts the hypermultigraph to binary edges, that only link
-- two vertices. Thus, it removes the hypergraph properties.
--
-- For more information see [here](https://en.wikipedia.org/wiki/Hypergraph)

return function (Layer, binary_edges)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection = Layer.require "cosy/formalism/data.collection"
  local graph      = Layer.require "cosy/formalism/graph"

  binary_edges [refines] = {
    graph
  }

  binary_edges [meta].edge_type.arrows [meta] [collection] .minimum = 2
  binary_edges [meta].edge_type.arrows [meta] [collection] .maximum = 2

end
