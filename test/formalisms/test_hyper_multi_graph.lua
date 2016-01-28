local Layer             = require "layeredata"
local hyper_multi_graph = require "formalisms.hyper_multi_graph"
local layer             = Layer.new {
  name = "hyper & multi graph instance"
}
local _                 = Layer.reference "HMGT_model"

layer[Layer.key.refines] = {
  hyper_multi_graph,
}

layer[Layer.key.labels] = { HMGT_model = true }

layer.vertices = {
  n1 = {},
  n2 = {},
  n3 = {},
}

layer.edges = {
  e1 = {
    arrows = {
      { }, --vertex = _.vertices.n1 },
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
}

do
  print(Layer.toyaml(Layer.flatten(layer)))
end
