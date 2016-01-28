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

layer[Layer.key.refines] = {
  hyper_multi_graph
}

layer[Layer.key.meta] = {
  edge_type = {
    [Layer.key.meta] = {
      arrow_type = {
        [Layer.key.meta] = {
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
