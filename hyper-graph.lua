--hypergraph
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local HMG = require "hyper-multi-graph"

repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.hyper_multi_graph = HMG

local _ = Repository.placeholder(repository)

repository.hyper_graph = {
	[Repository.depends] = {
		repository.hyper_multi_graph
	},
	
	hyper_graph_type = {
		[Repository.refines] = {
			_.hyper_multi_graph_type
		},

	 	check_edges_duplicated = function ()
			for k1,v1 in pairs(_.edges) do
				for k2, v2 in pairs(_.edges) do
					if(k1 ~= k2 and v1 == v2) then
						return false;
					end
				end
			end
			return true
		end
	}
}

return repository.hyper_graph
					
