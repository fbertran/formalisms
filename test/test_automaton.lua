local Serpent                 = require "serpent"
local Proxy                   = require "layeredata"
Proxy.hyper_multi_graph       = require "formalisms.automaton"
local layer  = Proxy.new { 
  name = "automaton instance" 
}
local _                       = Proxy.placeholder

layer.model = {
  __depends__ = {
    Proxy.automaton,
  },
  
  __refines__ = {
    _.automaton_type,
  },

  symbols = {
    a = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
      __value__ = "a",
    },

    a2 = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
      __value__ = "a'",
    },
    
    b = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
      __value__ = "b",
    },

    c = {
      __refines__ = {
        _.alphabet_type.__meta__.symbol_type
      },
      __value__ = "c",
    },
  },
  
  vertices = {
    q0 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          __value__ = "q0",
        },
      },
    },

    q1 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          __value__ = "q1",
        },
      },
    },

    q2 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.vertex_type
      },
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          __value__ = "q2",
        },
      },
    },
  },
  
  edges = {
    e1 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q0,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        [2] = {
          vertex = _.model.vertices.q1,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.a,
        },
      },
    },
    
    e2 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q0,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        [2] = {
          vertex = _.model.vertices.q0,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.a2,
        },
      },
    },
    
    e3 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q1,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        [2] = {
          vertex = _.model.vertices.q2,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.b,
        },
      },
    },
    
    e1 = {
      __refines__ = {
        _.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q2,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },          
        },
        [2] = {
          vertex = _.model.vertices.q1,
          direction = {
            __refines__ = {
              _.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.a,
        },
      },
    },
  },
  
  initials_states = {
    [1] = _.model.vertices.q0
  },
  
  accept_states = {
    [1] = _.model.vertices.q2
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
