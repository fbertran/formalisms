--directed_HyperMultiGraph
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local HMG = require "hyper-multi-graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.hyper_multi_graph = HMG

local _ = Repository.placeholder(repository)

repository.directed_hyper_multi_graph = {
	[Repository.depends] = {
		repository.hyper_multi_graph
	},
	
	directed_hyper_multi_graph_type = {
		[Repository.refines] = {
			_.hyper_multi_graph_type
		},

		label_edge_type = {},
		
		edge_type = {
		  
		  direction_type = {},
		  
		  arrow_type = {
		    direction = {},
		  },
		  
    },
	},
	
}

return repository.directed_hyper_multi_graph
