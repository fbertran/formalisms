--labelled_edges_hypergraph
local Labelled_edges_hypergraph = require "hypergraph"

--on ajoute les labels sur les edges, le type dans Labelled_edges_hypergraph et le label dans edge_type
Labelled_edges_hypergraph.label_edge_type = {}
Labelled_edges_hypergraph.edge_type.label = {} --extends typed_collection with type label_edge_type 

return Labelled_edges_hypergraph
