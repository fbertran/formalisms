local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "directed hyper & multi graph",
}

-- Formalism for a Directed Hyper and Multi Graph
-- ==============================================
--
-- A Directed Hyper and Multi Graph refine a Hyper and Multi Graph. It's a Hyper and Multi Graph where edges' ends are typed.
--
-- A definition of Directed Hyper Graph is given [here](http://link.springer.com/chapter/10.1007/3-540-45446-2_20)

layer.__refines__ = {
  hyper_multi_graph
}

layer.__meta__ = {
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
        input  = false,
        output = false,
      },
    },
  },
}

return layer
