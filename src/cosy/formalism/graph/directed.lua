-- Directed graphs
-- ===============
--
-- A directed graph types its arrows with two properties: `input` and `output`.
-- An arrow can be of both types.
--
-- See [this article](http://link.springer.com/chapter/10.1007/3-540-45446-2_20).

return function (Layer, directed, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local record       = Layer.require "cosy/formalism/data.record"
  local graph        = Layer.require "cosy/formalism/graph"
  local binary_edges = Layer.require "cosy/formalism/graph.binary_edges"

  directed [refines] = {
    graph,
    binary_edges,
  }

  directed [meta].edge_type [meta] [record] = {
    source = {
      value_container = ref.vertices,
    },
    target = {
      value_container = ref.vertices,
    },
  }

  local edge = Layer.reference (directed [meta].edge_type)

  directed [meta].edge_type.arrows = {
    source = {
      vertex = edge.source,
    },
    target = {
      vertex = edge.target,
    },
  }

end
