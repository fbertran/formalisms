--hyperMultiGraph
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local repository = Repository.new()

Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.hyper_multi_graph = {
	hyper_multi_graph_type = {
		vertex_type = {},
		
		edge_type = {
			arrow_type = {value_type = vertex_type}, --vertex est une variable de type vertex_type
			arrows = {} --extends typed_collection with type arrow_type
		},
		
		vertices = {}, --extends typed_collection with type vertex_type
		edges = {} --extends typed_collection with type edge_type
	}
}
return repository.hyper_multi_graph
