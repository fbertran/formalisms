local Serpent                    = require "serpent"
local Proxy                      = require "layeredata"
Proxy.directed_hyper_multi_graph = require "formalisms.labelled_vertices_hyper_multi_graph"
local layer                      = Proxy.new { 
  name = "labelled vertices & hyper & multi graph instance",
}
local _                               = Proxy.placeholder

layer.model = {	

  __depends__ = {
    Proxy.labelled_vertices_hyper_multi_graph,
  },

  __refines__ = {
    _.labelled_vertices_hyper_multi_graph_type,
  },

  vertices = {
    n1 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          __value__ = "node 1",
        },
      },
    },

    n2 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          __value__ = "node 2",
        },
        
        [2] = {
          __refines__ = {
            _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          __value__ = "argument",
        },
      },
    },

    n3 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
      
      labels = {},
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
