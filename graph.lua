--graph
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local MG = require "multi-graph"
local HG = require "hyper-graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.multi_graph = MG
repository.hyper_graph = HG

local _ = Repository.placeholder(repository)

repository.graph = {
	[Repository.depends] = {
		repository.hyper_graph,
		repository.multi_graph
	},
	
	graph_type = {
		[Repository.refines] = {
			_.hyper_graph_type,
			_.multi_graph_type
		},
	  
	  vertices = {},
	}
}

return repository.graph
				
