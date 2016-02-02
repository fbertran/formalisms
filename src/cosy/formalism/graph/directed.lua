local Layer = require "layeredata"
local graph = require "cosy.formalism.graph"

local directed = Layer.new {
  name = "cosy.formalism.graph.directed",
}

-- Directed graphs
-- ===============
--
-- A directed graph types its arrows with two properties: `input` and `output`.
-- An arrow can be of both types.
--
-- See [this article](http://link.springer.com/chapter/10.1007/3-540-45446-2_20).

directed [Layer.key.refines] = {
  graph
}

directed [Layer.key.meta].edge_type [Layer.key.meta].arrow_type = {
  [Layer.key.meta] = {
    record = {
      input  = {
        value_type = "boolean",
      },
      output = {
        value_type = "boolean",
      },
    },
  },
  input  = false,
  output = false,
}

return directed
