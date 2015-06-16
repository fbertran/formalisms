--hyper_multi_graph



local Proxy             = require "layeredata"
local hyper_multi_graph = Proxy.new_layer { name = "hyper_multi_graph" }
local _                 = Proxy.placeholder

hyper_multi_graph.hyper_multi_graph_type = {
	vertex_type = {},
	
	edge_type = {
		arrow_type = {
			value_type = vertex_type,
		}, --vertex est une variable de type vertex_type
		arrows = {
			__meta__ = {
	      content_type = _.arrow_type,
	      checks = {},
    	}
		} --extends typed_collection with type arrow_type
	},
	
	vertices = {
		__meta__ = {
			content_type = _.vertex_type,
	    checks = {},
		},
	}, --extends typed_collection with type vertex_type
	
	edges = {
		__meta__ = {
	    content_type = arrow_type,
	    checks = {},
	  },
	} --extends typed_collection with type edge_type
}
return hyper_multi_graph
