local Layer            = require "layeredata"
local graph            = require "cosy.formalism.graph"
local labeled_edges    = require "cosy.formalism.graph.labeled.edges"
local labeled_vertices = require "cosy.formalism.graph.labeled.vertices"
local directed         = require "cosy.formalism.graph.directed"
local binary_edges     = require "cosy.formalism.graph.binary_edges"
local collection       = require "cosy.formalism.data.collection"
local layer            = Layer.new {
  name = "cosy.formalism.petrinet",
}

local labels  = Layer.key.labels
local meta    = Layer.key.meta
local refines = Layer.key.refines

-- Petri nets
-- ==========
--
-- This formalism defines the basic structure of any Petri net: a collection
-- of places, a collection of transitions (both being graph vertices), and
-- a collection of arcs.
--
-- See [here](https://en.wikipedia.org/wiki/Petri_net)

layer [labels] = {
  ["cosy.formalism.petrinet"] = true,
}
local _ = Layer.reference "cosy.formalism.petrinet"

layer [refines] = {
  graph,
  directed,
  binary_edges,
  labeled_vertices,
  labeled_edges,
}

layer [meta].place_type = {
  [refines] = {
    layer [meta].vertex_type,
  },
  [meta] = {
    record = {
      identifier = false,
      marking    = false,
    }
  }
}

layer [meta].transition_type = {
  [refines] = {
    layer [meta].vertex_type,
  }
}

layer [meta].arc_type = {
  [refines] = {
    layer [meta].edge_type,
  },
}

layer.places = {
  [refines] = {
    collection,
  },
  [meta   ] = {
    value_type = _ [meta].place_type,
  }
}

layer.transitions = {
  [refines] = {
    collection,
  },
  [meta   ] = {
    value_type = _ [meta].transition_type,
  }
}

layer.arcs = {
  [refines] = {
    collection,
  },
  [meta   ] = {
    value_type = _ [meta].arc_type,
  }
}

layer.vertices [refines] = {
  _.places,
  _.transitions,
}

layer.edges [refines] = {
  _.arcs,
}

return layer
