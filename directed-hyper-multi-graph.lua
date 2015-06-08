--directed_HyperMultiGraph
local DirectedHyperMultiGraph = require "hyper-multi-graph"

--on ajoute les labels d'orientation, le type dans edge_type et la direction dans arrow_type
DirectedHyperMultiGraph.edge_type.direction_type = {} 
DirectedHyperMultiGraph.edge_type.arrow_type[2] = "direction"
