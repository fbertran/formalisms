-- Edge-labeled graphs
-- ===================
--
-- This formalism adds labels on edges, by setting `edge_type` as a record.

return function (Layer, labeled_edges)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph  = Layer.require "cosy/formalism/graph"
  local record = Layer.require "cosy/formalism/data.record"

  labeled_edges [refines] = {
    graph
  }

  labeled_edges [meta].edge_type [refines] = {
    record
  }

end
