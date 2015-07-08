local Layer                     = require "layeredata"
local interrupt_timed_automaton = require "formalisms.interrupt_timed_automaton"
local layer                     = Layer.new {
  name = "ita instance"
}
local _         = Layer.reference "ITA_model"
local root      = Layer.reference (false)

layer.__depends__ = {
  interrupt_timed_automaton,
}

layer.model = {
  __label__ = "ITA_model",

  __refines__ = {
    root.__meta__.interrupt_timed_automaton_type,
  },

  symbols = {
    a  = {},
    a2 = {},
    b  = {},
    c  = {},
  },

  analogs = {
    x1 = { active_level = _.levels.l1 },
    x2 = { active_level = _.levels.l2 },
  },

  levels = {
    l1 = {},
    l2 = {},
  },

  vertices = {
    q0 = {
      id = "q0",
      level = _.levels.l1,
    },

    q1 = {
      id = "q1",
      level = _.levels.l2,
    },

    q2 = {
      id = "q2",
      level = _.levels.l2,
    },
  },

  edges = {
    e1 = {
      arrows = {
        {
          vertex = _.vertices.q0,
          input  = true,
        },
        {
          vertex = _.vertices.q1,
          output = true,
        },
      },
      letter = _.symbols.a,
      guards = "x1^2 <= x1 + 1",
    },

    e2 = {
      arrows = {
        {
          vertex = _.vertices.q0,
          input  = true,
        },
        {
          vertex = _.vertices.q0,
          output = true,
        },
      },
      letter = _.symbols.a2,
      guards = "x1^2 > x1 + 1",
      updates = "x1 = 0",

    },

    e3 = {
      arrows = {
        {
          vertex = _.vertices.q1,
          input  = true,
        },
        {
          vertex = _.vertices.q2,
          output = true,
        },
      },
      letter = _.symbols.b,
      guards = "(2x1 - 1) * x2^2 > 1",
    },

    e4 = {
      arrows = {
        {
          vertex = _.vertices.q2,
          input  = true,
        },
        {
          vertex = _.vertices.q1,
          output = true,
        },
      },
      letter = _.symbols.c,
      guards = "x2 <= 5 - x1^2",
    },
  },

  initials_states = {
    {
      vertex = _.vertices.q0,
      analogs_init = {
        [_.analogs.x1] = 0,
        [_.analogs.x2] = 0,
      },
    },
  },

  accept_states = {
    { vertex = _.vertices.q2 },
  },
}

do
  print(Layer.dump(Layer.flatten(layer)))
end
