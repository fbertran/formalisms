local Serpent                    = require "serpent"
local Proxy                      = require "layeredata"
Proxy.directed_hyper_multi_graph = require "formalisms.labelled_edges_hyper_multi_graph"
local layer                      = Proxy.new { 
  name = "labelled edges & hyper & multi graph instance",
}
local _                               = Proxy.placeholder

layer.model = {	

  __depends__ = {
    Proxy.labelled_edges_hyper_multi_graph,
  },

  __refines__ = {
    _.labelled_edges_hyper_multi_graph_type,
  },

  vertices = {
    n1 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
    },

    n2 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
    },

    n3 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
    },
  },
  
  edges = {
    e1 = {
      __refines__ = {
        _.labelled_edges_hyper_multi_graph_type.__meta__.edge_type
      },
    
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
        },
        
        [2] = {
          vertex = _.model.vertices.n2,
        },
        
        [3] = {
          vertex =  _.model.vertices.n3,
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.hyper_multi_graph_type.__meta__.label_edge_type
          },
          
          __value__ = "a",
        },
      },
    },
    
    e2 = {
      __refines__ = {
        _.labelled_edges_hyper_multi_graph_type.__meta__.edge_type
      },
    
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
        },
        
        [2] = {
          vertex = _.model.vertices.n2,
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.hyper_multi_graph_type.__meta__.label_edge_type
          },
          
          __value__ = "b",
        },
        
        [2] = {
          __refines__ = {
            _.hyper_multi_graph_type.__meta__.label_edge_type
          },
          
          __value__ = "c",
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
  print(dump(Proxy.flatten(layer)))
end
