local Layer      = require "layeredata"
local collection = require "formalisms.collection"
local record     = require "formalisms.record"
local layer      = Layer.new {
  name = "hyper & multi graph",
}
local _          = Layer.reference "HMGT"

-- Formalism of Hyper and Multi Graph
-- ==================================
--
-- We describe here Hyper and Multi Graph
--
-- An Hyper and Multi Graph is a set V of vertices and a set E of edges. Each edge is a subset of V. In this formalism some edges may be identical.
--
-- For more information of Hyper and Multi Graph, see [here](https://en.wikipedia.org/?title=Hypergraph)

layer[Layer.key.labels] = { HMGT = true }

layer[Layer.key.meta] = {
  vertex_type = {},

  edge_type = {
    [Layer.key.meta] = {
      arrow_type = {
        [Layer.key.refines] = {
          record,
        },

        [Layer.key.meta] = {
          tags = {
            vertex = {
              value_type      = _ [Layer.key.meta].vertex_type,
              value_container = _.vertices,
            },
          },
        },
      },
    },
    arrows = {
      [Layer.key.refines] = {
        collection,
      },
      [Layer.key.meta] = {
        value_type = _ [Layer.key.meta].edge_type[Layer.key.meta].arrow_type,
      },
      [Layer.key.default] = {
        [Layer.key.refines] = {
          _ [Layer.key.meta].edge_type[Layer.key.meta].arrow_type,
        },
      },
    },
  },
}

layer.vertices = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    value_type = _ [Layer.key.meta].vertex_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].vertex_type,
    },
  },
}

layer.edges = {
  [Layer.key.refines] = {
    collection,
  },
  [Layer.key.meta] = {
    value_type = _ [Layer.key.meta].edge_type,
  },
  [Layer.key.default] = {
    [Layer.key.refines] = {
      _ [Layer.key.meta].edge_type,
    }
  },
}

return layer
