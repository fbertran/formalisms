--hyper_graph

local Proxy                       = require "layeredata"
Proxy.hyper_multi_graph           = require "formalisms.hyper_multi_graph"
local directed_hyper_multi_graph  = Proxy.new_layer { name = "hyper_graph" }
local _                           = Proxy.placeholder


hyper_graph.__depends__ = {
  Proxy.hyper_multi_graph,
}

hyper_graph.hyper_graph_type = {

  __refines__ = {
    _.hyper_multi_graph.hyper_multi_graph_type,
  },

-- 	check_edges_duplicated = function ()
--		for k1,v1 in pairs(_.edges) do
--			for k2, v2 in pairs(_.edges) do
--				if(k1 ~= k2 and v1 == v2) then
--					return false;
--				end
--			end
--		end
--		return true
--	end
	},
	
	vertices = {},
}

return repository.hyper_graph
					
