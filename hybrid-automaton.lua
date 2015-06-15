--hybrid_automaton

package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local A = require "automaton"


repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.automaton = A

local _ = Repository.placeholder(repository)

repository.hybrid_automaton = {
  [Repository.depends] = {
    repository.automaton,
  },
  
  hybrid_automaton_type = {
    [Repository.refines] = {
      _.automaton_type,
    },
    
    analog_type = {},
    analogs = {},
    
    initial_state_type = {
      analogs_valuation = {},
    },
    
    flows_analogs_type = {}, -- dans les parties de Rn
    invariants_type = {}, -- dans les parties de Rn
    
    vertex_type = {
      flows_analogs = {},
      invariants = {},
    },
    
    guard_type = {},
    
    update_type = {},
    
    label_edge_type = {
      guards = {},
      updates = {},
    },
      
  }
}

return hybrid_automaton
