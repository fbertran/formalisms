--labelled_vertex_HyperMultiGraph
local Labelled_vertex_HyperMultiGraph = require "hyper-multi-graph"

--on ajoute les labels sur les vertex, le type dans Labelled_vertex_hypergraph et le label dans vertex_type
Labelled_vertex_HyperMultiGraph.label_edge_type = {}
Labelled_vertex_HyperMultiGraph.vertex_type.label = {} --extends typed_collection with type label_vertex_type 

return Labelled_vertex_HyperMultiGraph
