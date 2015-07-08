local Layer     = require "layeredata"
local automaton = require "formalisms.automaton"
local layer     = Layer.new {
  name = "automaton instance"
}
local _         = Layer.reference "automaton_model"
local root      = Layer.reference (false)

layer.__depends__ = {
  automaton,
}

layer.model = {
  __label__ = "automaton_model",

  __refines__ = {
    root.__meta__.automaton_type,
  },

  symbols = {
    a  = {},
    a2 = {},
    b  = {},
    c  = {},
  },

  vertices = {
    q0 = { id = "q0" },
    q1 = { id = "q1" },
    q2 = { id = "q2" },
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

      label = { letter = _.symbols.b },
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
    },
  },

  initials_states = {
    { vertex = _.vertices.q0 },
  },

  accept_states = {
    { vertex = _.vertices.q2 },
  },
}

do
  print(Layer.dump(Layer.flatten(layer)))
end
