--directed_hypergraph
local DirectedHypergraph = require "hypergraph"

--on ajoute les labels d'orientation, le type dans edge_type et la direction dans arrow_type
DirectedHypergraph.edge_type.direction_type = {} 
DirectedHypergraph.edge_type.arrow_type[2] = "direction"
