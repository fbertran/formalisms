local Serpent   = require "serpent"
local Layer     = require "layeredata"
local automaton = require "formalisms.automaton"
local layer     = Layer.new { 
  name = "automaton instance" 
}
local _         = Layer.placeholder

layer.__depends__ = {
  automaton
}

layer.model = {  
  __refines__ = {
    _.__meta__.automaton_type,
  },

  symbols = {
    a = {
      __refines__ = {
        _.__meta__.alphabet_type.__meta__.symbol_type
      },
      __value__ = "a",
    },

    a2 = {
      __refines__ = {
        _.__meta__.alphabet_type.__meta__.symbol_type
      },
      __value__ = "a'",
    },
    
    b = {
      __refines__ = {
        _.__meta__.alphabet_type.__meta__.symbol_type
      },
      __value__ = "b",
    },

    c = {
      __refines__ = {
        _.__meta__.alphabet_type.__meta__.symbol_type
      },
      __value__ = "c",
    },
  },
  
  vertices = {
    q0 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.vertex_type
      },
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          id = "q0",
        },
      },
    },

    q1 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.vertex_type
      },
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          id = "q1",
        },
      },
    },

    q2 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.vertex_type
      },
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_vertices_hyper_multi_graph_type.__meta__.label_vertex_type
          },
          
          id = "q2",
        },
      },
    },
  },
  
  edges = {
    e1 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q0,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        [2] = {
          vertex = _.model.vertices.q1,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.a,
        },
      },
    },
    
    e2 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q0,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        [2] = {
          vertex = _.model.vertices.q0,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.a2,
        },
      },
    },
    
    e3 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q1,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },
        },
        [2] = {
          vertex = _.model.vertices.q2,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
          },
          __value__ = _.model.symbols.b,
        },
      },
    },
    
    e1 = {
      __refines__ = {
        _.__meta__.hyper_multi_graph_type.__meta__.edge_type
      },
      
      arrows = {
        [1] = {
          vertex = _.model.vertices.q2,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "input"
          },          
        },
        [2] = {
          vertex = _.model.vertices.q1,
          direction = {
            __refines__ = {
              _.__meta__.directed_hyper_multi_graph_type.__meta__.edge_type.__meta__.direction_type
            },
            __value__ = "output"
          },
        },
      },
      
      labels = {
        [1] = {
          __refines__ = {
            _.__meta__.labelled_edges_hyper_multi_graph_type.__meta__.label_edge_type
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
  print(dump(Layer.flatten(layer)))
end
