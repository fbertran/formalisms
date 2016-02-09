-- Vertex-labeled graphs
-- =====================
--
-- This formalism adds labels on vertices, by setting `vertex_type` as a record.

return function (Layer, labeled_vertices)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph  = Layer.require "cosy/formalism/graph"
  local record = Layer.require "cosy/formalism/data.record"

  labeled_vertices [refines] = {
    graph
  }

  labeled_vertices [meta].vertex_type [refines] = {
    record,
  }

end
