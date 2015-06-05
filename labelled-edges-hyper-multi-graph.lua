--labelled_edges_HyperMultiGraph
local Labelled_edges_HyperMultiGraph = require "hyper-multi-graph"

--on ajoute les labels sur les edges, le type dans Labelled_edges_hypergraph et le label dans edge_type
Labelled_edges_HyperMultiGraph.label_edge_type = {}
Labelled_edges_HyperMultiGraph.edge_type.label = {} --extends typed_collection with type label_edge_type 

return Labelled_edges_HyperMultiGraph
