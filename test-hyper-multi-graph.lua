--test_hyper_multi_graph

package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local graph = require "graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end
	
repository.graph = graph	

local _ = Repository.placeholder(repository)

repository.hyper_multi_graph_inst = {	

  [Repository.depends] = {
		repository.hyper_multi_graph,
	},
	
	[Repository.refines] = {
	  _.hyper_multi_graph_type,
	},

  vertices = {
	  n1 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  _ = "n1",
		},
		
		n2 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  _ = "n2",
		},
		
		n3 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		  _ = "n3",
		},
  },
  
  edges = {
    e1 = {
      [Repository.refines] = {
		    _.hyper_multi_graph_type.edge_type
		  },
		  arrows = {
		    [Repository.refines] = {
		      _.hyper_multi_graph_type.edge_type.arrow_type
		    },
		    [1] = "n1",
		    [2] = "n2",
		    [3] = "n3",
		  },
    },
    
    e2 = {
      [Repository.refines] = {
		    _.hyper_multi_graph_type.edge_type
		  },
		  arrows = {
		    [Repository.refines] = {
		      _.hyper_multi_graph_type.edge_type.arrow_type
		    },
		    [1] = "n1",
		    [2] = "n2",
      },
    }
    
  },



}



do
  local G = repository.hyper_multi_graph_inst
  local V = G.vertices

  for k,v in Repository.iterate(G) do
    print(k, G[k])
    for k2, v2 in Repository.iterate(G[k]) do
      print(k2, G[k][k2]._)
    end
  end
end

return repository.graph_inst


