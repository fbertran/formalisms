local Serpent                    = require "serpent"
local Proxy                      = require "layeredata"
Proxy.directed_hyper_multi_graph = require "formalisms.directed_hyper_multi_graph"
local layer                      = Proxy.new { 
  name = "directed hyper & multi graph instance",
}
local _                               = Proxy.placeholder

layer.model = {	

  __depends__ = {
    Proxy.directed_hyper_multi_graph,
  },

  __refines__ = {
    _.directed_hyper_multi_graph_type,
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
        _.directed_hyper_multi_graph_type.__meta__.edge_type
      },
    
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        
        [2] = {
          vertex = _.model.vertices.n2,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
          
        },
        [3] = {
          vertex =  _.model.vertices.n3,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
    },
    
    e2 = {
      __refines__ = {
        _.directed_hyper_multi_graph_type.__meta__.edge_type
      },
    
      arrows = {
        [1] = {
          vertex = _.model.vertices.n1,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        
        [2] = {
          vertex = _.model.vertices.n2,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
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
  print(dump(Proxy.flatten(layer)))
end
