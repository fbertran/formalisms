local Layer  = require "layeredata"
local graph  = require "cosy.formalism.graph"
local record = require "cosy.formalism.data.record"
local layer  = Layer.new {
  name = "cosy.formalism.graph.labeled.vertices",
}

-- Vertex-labeled graphs
-- =====================
--
-- This formalism adds labels on vertices, by setting `vertex_type` as a record.

layer [Layer.key.refines] = {
  graph
}

layer [Layer.key.meta].vertex_type [Layer.key.refines] = {
  record,
}

return layer
