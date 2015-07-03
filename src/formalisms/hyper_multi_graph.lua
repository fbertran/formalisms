local Layer = require "layeredata"
--local default_checks = require "formalisms.checks"
local object = require "formalisms.object"
local layer = Layer.new {
  name = "hyper & multi graph",
}
local _     = Layer.reference "HMGT"
local root  = Layer.reference "root"

-- Formalism of Hyper and Multi Graph
-- ==================================
--
-- We describe here Hyper and Multi Graph
--
-- An Hyper and Multi Graph is a set V of vertices and a set E of edges. Each edge is a subset of V. In this formalism some edges may be identical.
--
-- For more information of Hyper and Multi Graph, see [here](https://en.wikipedia.org/?title=Hypergraph)
layer.__label__ = "root"
layer.__depends__ =  {
  object,
  --default_checks,
}

layer.__meta__ = {

  hyper_multi_graph_type = {
    __label__ = "HMGT",

    __refines__ = {
      root.__meta__.object_type.record,
    },

    __meta__ = {
      vertex_type = {},

      edge_type = {
        __meta__ = {
          arrow_type = {
            __refines__ = {
              root.__meta__.record,
            },

            __meta__ = {
              __tags__ = {
                vertex = {
                  __value_type__ = _.__meta__.vertex_type,
                  __value_container__ = _.vertices,
                },
              },
            },
          },
        },
        arrows = {
          __refines__ = {
            root.__meta__.collection,
          },
          __meta__ = {
            __value_type__ = _.__meta__.edge_type.__meta__.arrow_type,
          },
          __default__ = {
            _.__meta__.edge_type.__meta__.arrow_type,
          },
        },

        arrows = {
          __refines__ = {
            root.__meta__.object_type.collection,
          },
          __meta__ = {
            __value_type__ = _.__meta__.edge_type.__meta__.arrow_type,
          },
          __default__ = {
            __value_type__ = _.__meta__.edge_type.__meta__.arrow_type,
          },
        },
      },

      __tags__ = {
        vertices = root.__meta__.object_type.collection,
        edges = root.__meta__.object_type.collection,
      },
    },

    vertices = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.vertex_type,
      },
      __default__ = {
        _.__meta__.vertex_type,
      },
    },

    edges = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.edge_type,
      },
      __default__ = { --?? TODO ticket pas clair
        __refines__ = {
          _.__meta__.edge_type,
        }
      },
    },
  },
}

return layer
