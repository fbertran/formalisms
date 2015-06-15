--tests

package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local ITA = require "interrupt-timed-automaton"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end
	
repository.interrupt_timed_automaton = ITA	

local _ = Repository.placeholder(repository)

repository.ita_inst = {	
	[Repository.depends] = {
		repository.interrupt_timed_automaton,
	},
	
	[Repository.refines] = {
	  _.interrupt_timed_automaton_type,
	},
	
	analogs = {
	  x1 = {
	    [Repository.refines] = {
	      _.hybrid_automaton_type.analog_type,
	    },
	    
	    _ = "x1",
      
    },
    
	  x2 = {
	    [Repository.refines] = {
	      _.hybrid_automaton_type.analog_type,
	    },
    },
	},
	
	vertices = {
	  q0 = {
		  [Repository.refines] = {
		    _.interrupt_timed_automaton_type.vertex_type
		  },
		  level = 1,
		  flows_analogs = {
		    x1 = 1,
		    x2 = 0,
		  },
		  
		  invariants = {
		    x1 = "[-inf; +inf]",
		    x2 = "[-inf; +inf]",
		  },  
		  
		},
		
		q1 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  
		  level = 2,
		  flows_analogs = {
		    x1 = 0,
		    x2 = 1,
		  },
		  
		  invariants = {
		    x1 = "[-inf; +inf]",
		    x2 = "[-inf; +inf]",
		  },  
		  
		},
		
		q2 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  
		  level = 2,
		  flows_analogs = {
		    x1 = 0,
		    x2 = 1,
		  },
		  
		  invariants = {
		    x1 = "[-inf; +inf]",
		    x2 = "[-inf; +inf]",
		  },
		},
	
	},
	
	
--	initials_states = {
--	  i1 = {
--	    [Repository.refines] = {
--	      _.hybrid_automaton_type.initial_state_type
--	    },
--	    value = _.ita_inst.vertices.q0,
--	    
--	    analogs_valuation = {
--	      x1 = 0,
--	      x2 = 0,
--	    },
--	  },
--	},
--	
--	accept_states = {
--	  f1 = {
--	    [Repository.refines] = {
--	      _.automaton_type.accept_state_type
--	    },
--	    _ = _.ita_inst.vertices.q2, 
--	  }
--	},
--	
--	
--	edges = {
--	  e1 = {
--	    [Repository.refines] = {
--	      _.labelled_edges_hyper_multi_graph_type.edge_type,
--	    },
--	   
--	    labels = {
--	      [Repository.refines] = {
--	        _.automaton_type.label_edge_type,
--	      },
--	      symbol = "a'",
--	      guards = {
--	        g1 = "x1^2 - x1 - 1 > 0",
--	      },
--	      updates = {
--	        x1 = 0,
--	      },
--	      
--	    },
--      
--      arrows = {
--        [Repository.refines] = {
--          _.hyper_multi_graph_type.arrow_type,
--        },
--        input = {
--          _.ita_inst.vertices.q0,
--        },
--        
--        output = {
--          _.ita_inst.vertices.q0,
--        },
--        
--      },
--    },
--    
--    e2 = {
--	    [Repository.refines] = {
--	      _.labelled_edges_hyper_multi_graph_type.edge_type,
--	    },
--	   
--	    labels = {
--	      [Repository.refines] = {
--	        _.automaton_type.label_edge_type,
--	      },
--	      symbol = "a",
--	      guards = {
--	        g1 = "x1^2 - x1 - 1 > 0",
--	      },
--	      updates = {},
--	      
--	    },
--      
--      arrows = {
--        [Repository.refines] = {
--          _.hyper_multi_graph_type.arrow_type,
--        },
--        input = {
--          _.ita_inst.vertices.q0,
--        },
--        
--        output = {
--          _.hyper_multi_graph_type.vertices.q0,
--        },
--        
--      },
--	      
--	  },
--	  
--	  
--	  e3 = {
--	    [Repository.refines] = {
--	      _.labelled_edges_hyper_multi_graph_type.edge_type,
--	    },
--	   
--	    labels = {
--	      [Repository.refines] = {
--	        _.automaton_type.label_edge_type,
--	      },
--	      symbol = "b",
--	      guards = {
--	        g1 = "2.x2^2.x1 - x2^2 - 1 > 0",
--	      },
--	      updates = {},
--	      
--	    },
--      
--      arrows = {
--        [Repository.refines] = {
--          _.hyper_multi_graph_type.arrow_type,
--        },
--        input = {
--          _.hyper_multi_graph_type.vertices.q1,
--        },
--        
--        output = {
--          _.hyper_multi_graph_type.vertices.q2,
--        },
--        
--      },
--    },
--    
--    e4 = {
--	    [Repository.refines] = {
--	      _.labelled_edges_hyper_multi_graph_type.edge_type,
--	    },
--	   
--	    labels = {
--	      [Repository.refines] = {
--	        _.automaton_type.label_edge_type,
--	      },
--	      symbol = "c",
--	      guards = {
--	        g1 = "x1^2 + x2 - 5 > 0",
--	      },
--	      updates = {},
--	      
--	    },
--      
--      arrows = {
--        [Repository.refines] = {
--          _.hyper_multi_graph_type.arrow_type,
--        },
--        input = {
--          _.hyper_multi_graph_type.vertices.q2,
--        },
--        
--        output = {
--          _.hyper_multi_graph_type.vertices.q1,
--        },
--        
--      },
--    },
--	},
  
}

do
  local G = repository.ita_inst
  local V = G.analogs
  print(repository.ita_inst.analogs.x1.value._)
  
--  for k,v in Repository.iterate(V) do
--    print(k, v)
--  end
end

return repository.ita_inst
	
	
	
	
	
	
	
	
