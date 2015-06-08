--tests

--do 
--	local Collection = require "collection"
--	Collection.content.bla = "bla"
--	print(Collection.content.bla)
--end

--function alphabet()
--	local alphabet = require "typed_collection"
--	alphabet.content_type.a = "a"
--	alphabet.content_type.b = "b"
--	alphabet.content_type.c = "c"
--	
--	return alphabet
--end

--do
--	a_b = alphabet()
--	a_b.content.a = true

--end


local function createHyperMultiGraph()
	repository = require "hyper-multi-graph"
	return repository
end



--function createMultiGraph()

--	repository.hyperMultiGraph = require "hyper-multi-graph"
--	repository.multi_graph = require "multi-graph"

--	function repository.addNode(v, k)
--		repository.hyperMultiGraph.vertices[k] = v
--	end
--	
--	function repository.addEdge(node1, node2, k)
--		repository.hyperMultiGraph.edges[k] = {}
--		repository.hyperMultiGraph.edges[k].node1 = node1
--		repository.hyperMultiGraph.edges[k].node2 = node2
--		print(repository.multi_graph.edge_type.check())
--	end
--	
--	function repository.toString()
--		print("[vertices : ")
--		for k,v in pairs(repository.hyperMultiGraph.vertices) do
--			print(k .. " = " .. v .. "; ")
--		end
--		print("]\n")
--		
--		print("[edges : ")
--		for k,v in pairs(repository.hyperMultiGraph.edges) do
--			print("(" .. v.node1 .. ", " .. v.node2 .. "); ")
--		end
--		print("]\n")
--	end
--	
--	return repository
--end

do
	local multi_graph = createHyperMultiGraph()
--	multi_graph.addNode("nil", 1) 
--	multi_graph.addNode("nil", 2)
--	multi_graph.addNode(3, 1)
--	multi_graph.addEdge(1, 2, 1)
--	multi_graph.toString()
end	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
