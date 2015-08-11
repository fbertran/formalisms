local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local record            = require "formalisms.record"
local layer             = Layer.new {
  name = "labelled vertices & hyper & multi graph",
}

-- Formalism of a Hyper and Multi Graph with labels on vertices
-- ============================================================
--
-- For more information of Hyper and Multi Graph formalism, see [here](./hyper_multi_graph.html)
--
-- We only add in this formalism labels on vertices.

layer.__refines__ = {
  hyper_multi_graph
}

layer.__meta__ = {
  vertex_type = {
    __refines__ = {
      record,
    },
  },
}

return layer
