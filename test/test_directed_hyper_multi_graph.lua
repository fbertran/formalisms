local Serpent                    = require "serpent"
local Layer                      = require "layeredata"
local directed_hyper_multi_graph = require "formalisms.directed_hyper_multi_graph"
local layer                      = Layer.new { 
  name = "directed hyper & multi graph instance",
}
local _                 = Layer.reference "DHMGT_model"

layer.__depends__ = {
  directed_hyper_multi_graph,
}
  
layer.model = {	
  __refines__ = {
    _.__meta__.directed_hyper_multi_graph_type,
  },

  vertices = {
    n1 = {},
    n2 = {},
    n3 = {},
  },
  
  edges = {
    e1 = {
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
          direction = {
            [1] = "input",
          },
        },
        [2] = {
          vertex = _.model.vertices.n2,
          direction = {
            [1] = "output",
          },
        },
        [3] = {
          vertex =  _.model.vertices.n3,
          direction = {
            [1] = "output",
          },
        },
      },
    },
    
    e2 = {
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
          direction = {
            [1] = "input",
          },
        },
        [2] = {
          vertex = _.model.vertices.n2,
          direction = {
            [1] = "output",
          },
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
