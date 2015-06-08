--hypergraph

local hyper_graph = require "hyper-multi-graph"

local function hyper_graph.check(){
	for k1,v1 in pairs(hyper_graph.edges) do
		for k2, v2 in pairs(hyper_graph.edges) do
			if(k1 ~= k2 and v1 == v2) then
				return false;
			end
		end
	end
	return true
end

return hyper_graph
					
