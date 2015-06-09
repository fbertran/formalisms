--automaton
package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local LEHMG = require "labelled-edges-hyper-multi-graph"
local LVHMG = require "labelled-vertex-hyper-multi-graph"
local MG = require "multi-graph"
local DHMG = require "directed-hyper-multi-graph"
local A = require "alphabet"


repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.multi_graph = MG
repository.directed_hyper_multi_graph = dHMG
repository.labelled_edges_hyper_multi_graph = LEHMG
repository.labelled_vertex_hyper_multi_graph = LVHMG
repository.alphabet = A

local _ = Repository.placeholder(repository)

repository.automaton = {
	[Repository.depends] = {
		repository.directed_hyper_multi_graph,
		repository.labelled_edges_hyper_multi_graph,
		repository.labelled_vertex_hyper_multi_graph,
		repository.multi_graph,
		repository.alphabet,
	},
	
	automaton_type = {
		[Repository.refines] = {
			_.multi_graph_type,
			_.directed_hyper_multi_graph_type,
			_.labelled_edges_hyper_multi_graph_type,
			_.labelled_vertex_hyper_multi_graph_type,
			_.alphabet_type,
		},
		
		label_edge_type = {
		  symbol = symbol_type,
		},
		
		initial_state_type = {
		  value_type = vertex_type,
		},
		
		accept_state_type = {
		  value_type = vertex_type,
		},
		
		initials_states = {},
		
		accept_states = {},
	}
	
	
}

return repository.automaton
				

