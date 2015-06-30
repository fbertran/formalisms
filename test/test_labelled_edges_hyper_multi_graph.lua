local Serpent                          = require "serpent"
local Layer                            = require "layeredata"
local labelled_edges_hyper_multi_graph = require "formalisms.labelled_edges_hyper_multi_graph"
local layer                            = Layer.new { 
  name = "labelled edges & hyper & multi graph instance",
}
local _                                = Layer.reference "LEHMGT_model"
local root                             = Layer.reference "root"

layer.__depends__ = {
  labelled_edges_hyper_multi_graph,
}

layer.model = {	
  __label__ = "LEHMGT_model",

  __refines__ = {
    root.__meta__.labelled_edges_hyper_multi_graph_type,
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
          vertex = _.vertices.n1,
        },
        [2] = {
          vertex = _.vertices.n2,
        },
        [3] = {
          vertex =  _.vertices.n3,
        },
      },
      
      labels = {        
        name = "a",
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
      
      labels = {          
        name = "b",
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
