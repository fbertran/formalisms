--test_hyper_multi_graph
local Proxy                   = require "layeredata"
Proxy.hyper_multi_graph       = require "formalisms.hyper_multi_graph"
local hyper_multi_graph_inst  = Proxy.new_layer { name = "instance hyper_multi_graph" }
local _                       = Proxy.placeholder
local Serpent = require "serpent"

local function dump (x)
  return Serpent.dump (x, {
    indent   = "  ",
    comment  = false,
    sortkeys = true,
    compact  = false,
  })
end

hyper_multi_graph_inst.__depends__ = {
  Proxy.hyper_multi_graph,
}

hyper_multi_graph_inst.model = {	
	
	__refines__ = {
	  _.hyper_multi_graph.hyper_multi_graph_type,
	},

  vertices = {
	  [1] = {
		  __refines__ = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  vertex = "n1",
		},
		
		[2] = {
		  __refines__ = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  vertex = "n2",
		},
		
		[3] = {
		  __refines__ = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  vertex = "n3",
		},
  },
  
  edges = {
    e1 = {
      __refines__ = {
		    _.hyper_multi_graph_type.edge_type
		  },
		  arrows = {
		    __refines__ = {
		      _.hyper_multi_graph_type.edge_type.arrow_type
		    },
		    [1] = {
		      vertex = "n1",
		    },
		    [2] = {
		      vertex = "n2",
		    },
		    [3] = {
		      vertex = "n3",
		    },
		  },
    },
    
    e2 = {
      __refines__ = {
		    _.hyper_multi_graph_type.edge_type
		  },
		  arrows = {
		    __refines__ = {
		      _.hyper_multi_graph_type.edge_type.arrow_type
		    },
		    [1] = {
		      vertex = "n1",
		    },
  	    [2] = {
  	      vertex = "n2",
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
  print(dump(Proxy.flatten( hyper_multi_graph_inst)))


end


