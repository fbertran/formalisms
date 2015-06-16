--test_hyper_multi_graph
local Proxy                           = require "layeredata"
Proxy.directed_hyper_multi_graph      = require "formalisms.directed_hyper_multi_graph"
local directed_hyper_multi_graph_inst = Proxy.new_layer { name = "instance hyper_multi_graph" }
local _                               = Proxy.placeholder


directed_hyper_multi_graph_inst.__depends__ = {
  Proxy.directed_hyper_multi_graph,
}

directed_hyper_multi_graph_inst.model = {	
	
	__refines__ = {
	  _.directed_hyper_multi_graph.directed_hyper_multi_graph_type,
	},

  vertices = {
	  [1] = {
		  __refines__ = {
		    _.directed_hyper_multi_graph_type.vertex_type
		  },
		  vertex = "n1",
		},
		
		[2] = {
		  __refines__ = {
		    _.directed_hyper_multi_graph_type.vertex_type
		  },
		  vertex = "n2",
		},
		
		[3] = {
		  __refines__ = {
		    _.directed_hyper_multi_graph_type.vertex_type
		  },
		  vertex = "n3",
		},
  },
  
  edges = {
    e1 = {
      __refines__ = {
		    _.directed_hyper_multi_graph_type.edge_type
		  },
		  arrows = {
		    __refines__ = {
		      _.directed_hyper_multi_graph_type.edge_type.arrow_type
		    },
		    
		    [1] = {
		      vertex = "n1", 
		      direction = "input",
		    },
		    
		    [2] = {
		      vertex = "n2",
		      direction = "output",
		    },
		    
		    [3] = {
		      vertex = "n3",
  		    direction  = "output",
  		  },
		  },
    },
    
    e2 = {
      __refines__ = {
		    _.directed_hyper_multi_graph_type.edge_type
		  },
		  arrows = {
		    __refines__ = {
		      _.directed_hyper_multi_graph_type.edge_type.arrow_type
		    },
		    [1] = {
		      vertex = "n1",
		      direction = "input",
  	    },
  	    [2] = {
  	      vertex = "n2",
  	      direction  = "output",
        },       
      },
    }
  },
}


function printStructure(proxy, depth) 
  local d = ""
  for i = 1, depth do
    d = d .. "  "
  end
   
  for k, p in pairs(proxy) do
    if k ~= "__refines__" and k ~="__meta__" then
     if type(p) == "table" and p.__value__ ~= nil then
       print(d .. k, p.__value__)
       
     elseif type(p) == "table" then
       print(d .. k)
       printStructure(p, depth + 1)      
     
     else 
        print(d .. k, p)
     end
   end
  end     
end

do
  g = Proxy.flatten( directed_hyper_multi_graph_inst )
  printStructure(g, 0)
end


