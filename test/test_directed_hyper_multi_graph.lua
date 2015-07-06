local Layer                      = require "layeredata"
local directed_hyper_multi_graph = require "formalisms.directed_hyper_multi_graph"
local layer                      = Layer.new {
  name = "directed hyper & multi graph instance",
}
local _                 = Layer.reference "DHMGT_model"
local root              = Layer.reference (false)

layer.__depends__ = {
  directed_hyper_multi_graph,
}

layer.model = {
  __refines__ = {
    root.__meta__.directed_hyper_multi_graph_type,
  },
  __label__ = "DHMGT_model",

  vertices = {
    n1 = {},
    n2 = {},
    n3 = {},
  },

  edges = {
    e1 = {
      arrows = {
        {
          vertex = _.vertices.n1,
          directions = { "input" },
        },
        {
          vertex = _.vertices.n2,
          directions = { "output" },
        },
        {
          vertex =  _.vertices.n3,
          directions = { "output" },
        },
      },
    },

    e2 = {
      arrows = {
        {
          vertex = _.vertices.n1,
          direction = { "input" },
        },
        {
          vertex = _.vertices.n2,
          direction = { "output" },
        },
      },
    },
  },
}

do
  print(Layer.dump(Layer.flatten(layer), true))
end
