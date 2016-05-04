-- Graph
-- =====
--
-- Base graph structure for all graph-based formalisms.
-- This formalism defines a special kind of graphs, the most generic we could
-- find: hyper multi graphs.
--
-- For more information of Hyper and Multi Graph, see
-- [hypergraph](https://en.wikipedia.org/wiki/Hypergraph) and
-- [multigraph](https://en.wikipedia.org/wiki/Multigraph).

return function (Layer, graph, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection = Layer.require "cosy/formalism/data.collection"
  local record     = Layer.require "cosy/formalism/data.record"

  graph [refines] = {
    record,
  }

  -- Vertices are empty in base graph.
  graph [meta].vertex_type = {
    [refines] = {
      record,
    }
  }

  -- Arrows are records with only one predefined field: `vertex`.
  -- It points to the destination of the arrow, that must be a vertex of the
  -- graph.
  -- Edges have no label in base graph.
  -- They only contain zero to several arrows. The arrow type is defined for
  -- each edge type.
  -- The `default` key states that all elements within the `arrows` container
  -- are of type `arrow_type`.
  graph [meta].edge_type = {
    [refines] = {
      record,
    },
    [meta] = {
      arrow_type = {
        [refines] = {
          record,
        },
        [meta] = {
          [record] = {
            vertex = {
              value_type      = ref [meta].vertex_type,
              value_container = ref.vertices,
            }
          }
        },
        vertex = nil,
      },
    },
  }

  local current_edge = Layer.reference (graph [meta].edge_type)
  graph [meta].edge_type.arrows = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = current_edge [meta].arrow_type,
      }
    },
  }

  -- A graph contains a collection of vertices.
  -- The `default` key states that all elements within the `vertices` container
  -- are of type `vertex_type`.
  graph.vertices = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].vertex_type,
      },
    },
  }

  -- A graph contains a collection of edges.
  -- The `default` key states that all elements within the `edges` container
  -- are of type `edge_type`.
  graph.edges = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].edge_type,
      },
    },
  }

end
