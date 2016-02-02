local Layer  = require "layeredata"
local graph  = require "cosy.formalism.graph"
local record = require "cosy.formalism.data.record"

local labeled_edges  = Layer.new {
  name = "cosy.formalism.graph.labeled.edges",
}

-- Edge-labeled graphs
-- ===================
--
-- This formalism adds labels on edges, by setting `edge_type` as a record.

labeled_edges [Layer.key.refines] = {
  graph
}

labeled_edges [Layer.key.meta].edge_type [Layer.key.refines] = {
  record
}

return labeled_edges
