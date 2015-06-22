local Layer     = require "layeredata"
local automaton = require "formalisms.automaton"
local layer     = Layer.new {
  name = "interrupt timed automaton", 
}
local _         = Layer.placeholder

layer.__depends__ = {
  automaton
}

layer.__meta__ = {

  interrupt_timed_automaton_type = {
    __refines__ = {
        _.__meta__.automaton_type
    },
    
    __meta__ = {
      analog_type = {},
      
      level_type = {
        __value__ = {
          content_type = "number",
        },
        checks = {
          function ()
            -- TODO check if #analogs == #levels
          end,
        },
      },
      
      guard_type = {
        -- polynomial_type
      },
      
      update_type = {
        -- polynomial_type
      },    
      
      label_vertex_type = {
        level = {
          __value__ = {
            content_type = _.__meta__.interrupt_timed_automaton_type.__meta__.level_type,
            value_container = _.__meta__.interrupt_timed_automaton_type.levels,
          },
        },
        checks = {
          function () 
            -- TODO check if level contains only one element
          end,
        },
      },
      
      label_edge_type = {
        guards = {
          __meta__ = {
            content_type = _.__meta__.hybrid_automaton_type.guard_type,
          },
        },
        updates = {
          __meta__ = {
            content_type = _.__meta__.hybrid_automaton_type.update_type,
          },
        },
      },
      
      analogs_init_type = {
        __value__ = {
          value_type    = "number",
          key_type      = _.__meta__.interrupt_timed_automaton_type.__meta__.analog_type,
          key_container = _.__meta__.interrupt_timed_automaton_type.analogs,
        },
      },
    
      initial_state_type = {
        analogs_init = {
          __meta__ = {
            content_type = {
              _.__meta__.interrupt_timed_automaton_type.__meta__.analogs_init_type
            },
          },
        }, 
      },
    },
    
    analogs = {
      __meta__ = {
        content_type = _.__meta__.hybrid_automaton_type.__meta__.analog_type,
      },
    },
    
    levels = {
      __meta__ = {
        content_type = _.__meta__.interrupt_timed_automaton_type.__meta__.level_type,
      },
    },
  },
}

return layer
