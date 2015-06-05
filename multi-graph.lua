--multigraph

local multi_graph = require "hyper-multi-graph"

function multi_graph.edge_type.check()
	for k,v in pairs(multi_graph.edges) do
		if(#v > 2) then
			return false
		end
	end
	return true
end

return multi_graph
