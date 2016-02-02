local Layer  = require "layeredata"
local graph  = require "cosy.formalism.graph"
local record = require "cosy.formalism.data.record"

local labeled_vertices  = Layer.new {
  name = "cosy.formalism.graph.labeled.vertices",
}

-- Vertex-labeled graphs
-- =====================
--
-- This formalism adds labels on vertices, by setting `vertex_type` as a record.

labeled_vertices [Layer.key.refines] = {
  graph
}

labeled_vertices [Layer.key.meta].vertex_type [Layer.key.refines] = {
  record,
}

return labeled_vertices
