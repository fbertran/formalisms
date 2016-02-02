local Layer            = require "layeredata"
local graph            = require "cosy.formalism.graph"
local labeled_edges    = require "cosy.formalism.graph.labeled.edges"
local labeled_vertices = require "cosy.formalism.graph.labeled.vertices"
local directed         = require "cosy.formalism.graph.directed"
local binary_edges     = require "cosy.formalism.graph.binary_edges"
local collection       = require "cosy.formalism.data.collection"
local enumeration      = require "cosy.formalism.data.enumeration"
local layer            = Layer.new {
  name = "cosy.formalism.automaton",
}

local labels  = Layer.key.labels
local meta    = Layer.key.meta
local refines = Layer.key.refines

-- Autpmata
-- ========

-- An automaton is a graph where vertices are called "states", edges are
-- called "transitions", and edges are labeled with symbols.
-- These symbols are taken from an alphabet, represented by an enumeration.
--
-- See [here](http://www.cs.odu.edu/~toida/nerzic/390teched/regular/fa/nfa-definitions.html)

layer [labels] = {
  ["cosy.formalism.automaton"] = true,
}
local _ = Layer.reference "cosy.formalism.automaton"

layer [refines] = {
  graph,
  directed,
  binary_edges,
  labeled_vertices,
  labeled_edges,
}

layer.alphabet = {
  [refines] = {
    enumeration,
  }
}

layer [meta].state_type = {
  [refines] = {
    layer [meta].vertex_type,
  },
  [meta] = {
    record = {
      identifier = false,
      initial    = "boolean",
      final      = "boolean",
    }
  }
}

layer [meta].transition_type = {
  [refines] = {
    layer [meta].edge_type,
  },
  [meta] = {
    record = {
     letter = {
       value_type      = _.alphabet [Layer.key.meta].symbol_type,
       value_container = _.alphabet,
     },
   },
 },
}

layer.states = {
  [refines] = {
    collection,
  },
  [meta] = {
    value_type = _ [meta].state_type,
  }
}

layer.transitions = {
  [refines] = {
    collection,
  },
  [meta] = {
    value_type = _ [meta].transition_type,
  }
}

layer.vertices [refines] = {
  _.states,
}

layer.edges [refines] = {
  _.transitions,
}

return layer
