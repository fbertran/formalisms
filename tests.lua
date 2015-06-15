--tests

package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local graph = require "graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end
	
repository.graph = graph	

local _ = Repository.placeholder(repository)

repository.graph_inst = {	
	[Repository.depends] = {
		repository.graph,
	},
	
	[Repository.refines] = {
	  _.graph_type,
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
	
  
}

do
  local G = repository.graph_inst
  local V = G.vertices

  for k,v in Repository.iterate(V) do
    print(k, V[k]._)
  end
end

return repository.graph_inst
	
	
	
	
	
	
	
	
