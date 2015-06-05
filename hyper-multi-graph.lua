--hyperMultiGraph
local HyperMultiGraph = {}
HyperMultiGraph.vertex_type = {}
HyperMultiGraph.edge_type = {
	arrow_type = {value_type = HyperMultiGraph.vertex_type}, --vertex est une variable de type vertex_type
	arrows = {} --extends typed_collection with type arrow_type
	}
HyperMultiGraph.vertices = {} --extends typed_collection with type vertex_type
HyperMultiGraph.edges = {} --extends typed_collection with type edge_type

return HyperMultiGraph
