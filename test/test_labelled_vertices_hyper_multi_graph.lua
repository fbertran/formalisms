local Serpent                    = require "serpent"
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
      labels = {
        name = "n1",
      },
    },
    n2 = {
      labels = {
        name = "n2",
      },
    },
    n3 = {
      labels = {
        name = "n3",
      },
    },
  },
  
  edges = {
    e1 = {
      arrows = {
        [1] = {
          vertex = _.vertices.n1,
        },
        [2] = {
          vertex = _.vertices.n2,
        },
        [3] = {
          vertex =  _.vertices.n3,
        },
      },
    },
    
    e2 = {
      arrows = {
        [1] = {
          vertex = _.vertices.n1,
        },
        [2] = {
          vertex = _.vertices.n2,
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
