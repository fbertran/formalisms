--interrupt_timed_automaton

package.path = package.path .. ";/home/alexis/Documents/Stage_M1_01-06-15/CosyVerif/library/src/?.lua"

local Repository = require "cosy.repository"
local HA = require "hybrid-automaton"


repository = Repository.new()
Repository.options (repository).create = function () return {} end
Repository.options (repository).import = function () return {} end

repository.hybrid_automaton = HA

local _ = Repository.placeholder(repository)

repository.interrupt_timed_automaton = {
  [Repository.depends] = {
    repository.hybrid_automaton,
  },
  
  interrupt_timed_automaton_type = {
    [Repository.refines] = {
      _.hybrid_automaton_type,
    },
    
    level_type = {},
    levels = {
      ["cosy:meta"] = {
        content_type = _.level_type,
		    checks = {
		      --#level == #clocks
		    },
		  },
    },
    
    differential_clocks_type = {
      value_type, --polynomial_type
    },
    
    invariants_type = {
      _ = "[-inf; inf]",
    },
    
    guard_type = {
      value_type, --polynomial_type
    },
    
    update_type = {
      value_type, --polynomial_type
    },
  }
}

return hybrid_automaton
