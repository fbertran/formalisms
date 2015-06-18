local Serpent                   = require "serpent"
local Proxy                     = require "layeredata"
Proxy.interrupt_timed_automaton = require "formalisms.interrupt_timed_automaton"
local layer                     = Proxy.new { 
  name = "ita instance" 
}
local _                         = Proxy.placeholder

layer.model = {
  __depends__ = {
    Proxy.interrupt_timed_automaton,
  },
  
  __refines__ = {
    _.interrupt_timed_automaton_type,
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
  
  analogs = {
    x1 = {
      __refines__ = {
        _.interrupt_timed_automaton_type.__meta__.analog_type
      },
    },
    
    x2 = {
      __refines__ = {
        _.interrupt_timed_automaton_type.__meta__.analog_type
      },
    },
  },
  
  levels = {
    l1 = {
      __refines__ = {
        _.interrupt_timed_automaton_type.__meta__.level_type
      },
      __value__ = 1,
    },
    
    l2 = {
      __refines__ = {
        _.interrupt_timed_automaton_type.__meta__.level_type
      },
      __value__ = 2,
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
          
          level = {
            __value__ = _.model.levels.l1
          },
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
          
          level = {
            __value__ = _.model.levels.l2
          },
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
          
          level = {
            __value__ = _.model.levels.l2
          },
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
          guards = {
            [1] = {
              __refines__ = {
                _.interrupt_timed_automaton_type.__meta__.guard_type
              },
              __value__ = "x1^2 <= x1 + 1"
            },
          },
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
          
          guards = {
            [1] = {
              __refines__ = {
                _.interrupt_timed_automaton_type.__meta__.guard_type
              },
              __value__ = "x1^2 > x1 + 1"
            },
          },
          
          updates = {
            [1] = {
              __refines__ = {
                _.interrupt_timed_automaton_type.__meta__.update_type
              },
              __value__ = "x1 = 0"
            },
          },
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
          
          guards = {
            [1] = {
              __refines__ = {
                _.interrupt_timed_automaton_type.__meta__.guard_type
              },
              __value__ = "(2x1 - 1) * x2^2 > 1"
            },
          },
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
          
          guards = {
            [1] = {
              __refines__ = {
                _.interrupt_timed_automaton_type.__meta__.guard_type
              },
              __value__ = "x2 <= 5 - x1^2"
            },
          },
        },
      },
    },
  },
  
  initials_states = {
    [1] = {
      vertex = _.model.vertices.q0,
      
      analogs_init = {
        x1 = 0,
        x2 = 0,
      },
    },
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
