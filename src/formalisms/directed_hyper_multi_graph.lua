--directed_hyper_multi_graph

local Proxy                       = require "layeredata"
Proxy.hyper_multi_graph           = require "formalisms.hyper_multi_graph"
local directed_hyper_multi_graph  = Proxy.new_layer { name = "directed_hyper_multi_graph" }
local _                           = Proxy.placeholder


directed_hyper_multi_graph.__depends__ = {
  Proxy.hyper_multi_graph,
}

directed_hyper_multi_graph.directed_hyper_multi_graph_type = {

  __refines__ = {
    _.hyper_multi_graph.hyper_multi_graph_type,
  },
  

	edge_type = {
		__refines__ = {
		  _.hyper_multi_graph.hyper_multi_graph_type.edge_type,
		},
	  direction_type = {},
		  
    arrow_type = {
      __refines__ = {
        _.hyper_multi_graph.hyper_multi_graph_type.edge_type,
      },
		  direction = {},
	  },
	},	  
}

return directed_hyper_multi_graph
