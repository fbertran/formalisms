local Layer      = require "layeredata"
local automaton  = require "formalisms.automaton"
local polynomial = require "formalisms.polynomial"
local layer      = Layer.new {
  name = "interrupt timed automaton",
}
local _          = Layer.reference "ITA"
local root       = Layer.reference (false)

-- Formalism of Interrupt Timed Automaton
-- ======================================
--
-- An interrupt timed automaton is a tuple (Q, Σ, q0, F, X, λ, δ) where:
--
-- * Q is a set of vertices called states. Each q in Q has a level l. There are as many levels as there are clocks.
-- * Σ is a finite alphabet, describe [here](./alphabet.html)
-- * q0 is the start state, q0 is in Q
-- * F is a subset of Q, they are the accept states
-- * X is a set of interrupt clocks.
-- * λ associate a state with is level and x[λ(q)] is the active clocks. The others are stopped.
-- * δ is a set of labelled edges called transition. this edges are labelled by:
--      * a guard, it's a conjunction of polynomial constraints
--      * a symbol of Σ
--      * an update, it's the new valuation of a clock calculate by a polynomial of the others.
--
--For more information of Interrupt timed automaton see [here](http://arxiv.org/abs/1504.04541)


layer.__depends__ = {
  automaton,
  polynomial,
}

layer.__meta__ = {

  interrupt_timed_automaton_type = {
    __label__   = "ITA",

    __refines__ = {
        root.__meta__.automaton_type
    },

    __meta__    = {
      analog_type = {
        __refines__ = {
          root.__meta__.record,
        },
        __meta__ = {
          __tags__ = {
            active_level = {
              __value_type__      = _.__meta__.level_type,
              __value_container__ = _.levels,
            },
          },
        },
      },

      level_type = {},

      guard_type = {
        __refines__ = {
          root.__meta__.record,
        },
        __meta__ = {
          __tags__ = {
            comparison = {
              __value_type__      = "string",
              __value_container__ = {"<", "<=", "=", ">=", ">"},
            },
          },
        },
        polynomial = {
          __refines__ = {
            root.__meta__.collection,
          },
          __meta__    = {
            __value_type__ = root.__meta__.polynomial_type,
          },
          __default__ = {
            __refines__ = {
              root.__meta__.polynomial_type,
            },
          },
        },
      },

      update_type = {
        __refines__ = {
          root.__meta__.collection,
        },
        __meta__ = {
          __value_type__    = root.__meta__.polynomial_type,
          __key_type__      = _.__meta__.analog_type,
          __key_container__ = _.analogs,
        },
      },

      edge_type = {
        update = {
          __refines__ = {
            _.__meta__.update_type,
          },
        },

        guard = {
          __refines__ = {
            _.__meta__.guard_type
          },
        },
      },

      vertex_type  = {
        __meta__ = {
          __tags__ = {
            level = {
              __value_type__      = _.__meta__.level_type,
              __value_container__ = _.levels,
            },
          },
        },
      },

      initial_state_type = {
        analogs_init = {
          __refines__ = {
            root.__meta__.collection,
          },

          __meta__ = {
            __value_type__    = "number",
            __key_type__      = _.__meta__.analog_type,
            __key_container__ = _.analogs,
          },
        },
      },
    },

    analogs = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.analog_type,
      },
      __default__ = {
        __refines__ = {
          _.__meta__.analog_type,
        },
      },
    },

    levels = {
      __refines__ = {
        root.__meta__.collection,
      },
      __meta__ = {
        __value_type__ = _.__meta__.level_type,
      },
      __default__ = {
        __refines__ = {
          _.__meta__.level_type,
        },
      },
    },
  },
}

return layer
