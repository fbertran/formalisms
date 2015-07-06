local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "directed hyper & multi graph",
}
local _                 = Layer.reference "DHMGT"
local root              = Layer.reference (false)

-- Formalism for a Directed Hyper and Multi Graph
-- ==============================================
--
-- A Directed Hyper and Multi Graph refine a Hyper and Multi Graph. It's a Hyper and Multi Graph where edges' ends are typed.
--
-- A definition of Directed Hyper Graph is given [here](http://link.springer.com/chapter/10.1007/3-540-45446-2_20)

layer.__depends__ = {
  hyper_multi_graph,
}

layer.__meta__ = {
  directed_hyper_multi_graph_type = {
    __label__ = "DHMGT",

    __refines__ = {
      root.__meta__.hyper_multi_graph_type,
    },

    __meta__ = {
      edge_type = {
        __meta__ = {
          arrow_type = {
            __meta__ = {
              __tags__ = {
                input = {
                  __value_type__ = "boolean",
                },
                output = {
                  __value_type__ = "boolean",
                },
              },
            },
            input = false,
            output = false,
          },
        },
      },
    },
  },
}

return layer
