--tests

package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local graph = require "graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end
	
repository.multi_graph = graph	

local _ = Repository.placeholder(repository)

repository.graph_inst = {	
	[Repository.depends] = {
		repository.graph,
	},
	
	vertices = {
	  n1 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		},
		
		n2 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		},
		
		n3 = {
		  [Repository.refines] = {
		    _.hyper_multi_graph_type.vertex_type
		  },
		},
	
	},
  
}

do
  local G = repository.graph_inst
  local V = G.vertices

  for k,v in pairs(V) do
    print(repository [RESOURCES])
  end
end

return repository.graph_inst
	
	
	
	
	
	
	
	
