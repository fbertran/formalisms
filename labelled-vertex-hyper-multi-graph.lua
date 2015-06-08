--labelled_vertex_HyperMultiGraph
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local HMG = require "hyper-multi-graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.hyper_multi_graph = HMG

local _ = Repository.placeholder(repository)

repository.labelled_vertex_hyper_multi_graph = {
	[Repository.depends] = {
		repository.hyper_multi_graph
	},
	
	labelled_vertex_hyper_multi_graph_type = {
		[Repository.refines] = {
			_.hyper_multi_graph_type
		},

		label_vertex_type = {},
		
		vertex_type = {
		  labels = {},
		}
	}
}

return repository.labelled_edges_vertex_multi_graph
