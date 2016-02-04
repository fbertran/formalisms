-- Vertex-labeled graphs
-- =====================
--
-- This formalism adds labels on vertices, by setting `vertex_type` as a record.

return function (Layer)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph  = Layer.require "cosy.formalism.graph"
  local record = Layer.require "cosy.formalism.data.record"

  local labeled_vertices  = Layer.new {
    name = "cosy.formalism.graph.labeled.vertices",
  }

  labeled_vertices [refines] = {
    graph
  }

  labeled_vertices [meta].vertex_type [refines] = {
    record,
  }

  return labeled_vertices

end
