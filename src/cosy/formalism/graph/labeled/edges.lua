local Layer  = require "layeredata"
local graph  = require "cosy.formalism.graph"
local record = require "cosy.formalism.data.record"
local layer  = Layer.new {
  name = "cosy.formalism.graph.labeled.edges",
}

-- Edge-labeled graphs
-- ===================
--
-- This formalism adds labels on edges, by setting `edge_type` as a record.

layer [Layer.key.refines] = {
  graph
}

layer [Layer.key.meta].edge_type [Layer.key.refines] = {
  record
}

return layer
