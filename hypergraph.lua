--hypergraph
local Hypergraph = {}
Hypergraph.vertex_type = {}
Hypergraph.edge_type = {
	arrow_type = {"vertex"}, --vertex est une variable de type vertex_type
	arrows = {} --extends typed_collection with type arrow_type
	}
Hypergraph.vertices = {} --extends typed_collection with type vertex_type
Hypergraph.edges = {} --extends typed_collection with type edge_type

return Hypergraph
