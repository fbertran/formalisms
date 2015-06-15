--multigraph
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local HMG = require "hyper-multi-graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.hyper_multi_graph = HMG

local _ = Repository.placeholder(repository)

repository.multi_graph = {
	[Repository.depends] = {
		repository.hyper_multi_graph
	},
	
	multi_graph_type = {
		[Repository.refines] = {
			_.hyper_multi_graph_type
		},

		edge_type = {
		  check_arity = function ()
			  for k,v in pairs(_.edges) do
				  if(#v > 2) then
					  return false
				  end
			  end
			  return true
		  end,
	  }, 
	
	  vertices = {},
	
	}
	
	
}

return repository.multi_graph
				
