local Layer                      = require "layeredata"
local labelled_vertices_hyper_multi_graph = require "formalisms.labelled_vertices_hyper_multi_graph"
local layer                      = Layer.new {
  name = "labelled vertices & hyper & multi graph instance",
}
local _                          = Layer.reference "LVHMGT_model"
local root                       = Layer.reference "root"

layer.__depends__ = {
  labelled_vertices_hyper_multi_graph,
}

layer.model = {
  __label__ = "LVHMGT_model",

  __refines__ = {
    root.__meta__.labelled_vertices_hyper_multi_graph_type,
  },

  vertices = {
    n1 = {
      label = { name = "n1" },
    },
    n2 = {
      label = { name = "n2" },
    },
    n3 = {
      label = { name = "n3" },
    },
  },

  edges = {
    e1 = {
      arrows = {
        { vertex = _.vertices.n1 },
        { vertex = _.vertices.n2 },
        { vertex = _.vertices.n3 },
      },
    },

    e2 = {
      arrows = {
        { vertex = _.vertices.n1 },
        { vertex = _.vertices.n2 },
      },
    },
  },
}

do
  print(Layer.dump(Layer.flatten(layer), true))
end
