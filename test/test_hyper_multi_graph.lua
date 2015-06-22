local Serpent                 = require "serpent"
local Layer                   = require "layeredata"
local hyper_multi_graph       = require "formalisms.hyper_multi_graph"
local layer  = Layer.new { 
  name = "hyper & multi graph instance" 
}
local _                       = Layer.placeholder

layer.__depends__ = {
  hyper_multi_graph,
}

layer.model = {
  __refines__ = {
    _.__meta__.hyper_multi_graph_type,
  },

  vertices = {
    n1 = {},

    n2 = {},

    n3 = {},
  },
  
  edges = {
    e1 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.edge_type
      },
      arrows = {
        [1] = {
          __refines__ = {
            _.__meta__.hyper_multi_graph_type.__meta__.edge_type.__meta__.arrow_type
          },
          vertex = _.model.vertices.n1,
        },
        [2] = {
          vertex =  _.model.vertices.n2,
        },
        [3] = {
          vertex =  _.model.vertices.n3,
        },
      },
    },
    
    e2 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.edge_type
      },
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
        },
        [2] = {
          vertex = _.model.vertices.n2,
        },
      },
    },
  },
}


local function dump (x)
  return Serpent.dump (x, {
    indent   = "  ",
    comment  = false,
    sortkeys = true,
    compact  = false,
  })
end

do
  print(dump(Layer.flatten(layer)))
end
