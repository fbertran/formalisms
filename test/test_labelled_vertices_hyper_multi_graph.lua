local Layer                      = require "layeredata"
local labelled_vertices_hyper_multi_graph = require "formalisms.labelled_vertices_hyper_multi_graph"
local layer                      = Layer.new {
  name = "labelled vertices & hyper & multi graph instance",
}
local _                          = Layer.reference "LVHMGT_model"
local root                       = Layer.reference (false)

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
      name = "n1",
    },
    n2 = {
      name = "n2",
    },
    n3 = {
      name = "n3", --TODO ticket affectation avec référence
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
  print(Layer.dump(Layer.flatten(layer)))
end
