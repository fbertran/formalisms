local Layer            = require "layeredata"
local graph            = require "cosy.formalism.graph"
local labeled_edges    = require "cosy.formalism.graph.labeled.edges"
local labeled_vertices = require "cosy.formalism.graph.labeled.vertices"
local directed         = require "cosy.formalism.graph.directed"
local binary_edges     = require "cosy.formalism.graph.binary_edges"
local collection       = require "cosy.formalism.data.collection"

local petrinet = Layer.new {
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

petrinet [labels] = {
  ["cosy.formalism.petrinet"] = true,
}
local _ = Layer.reference "cosy.formalism.petrinet"

petrinet [refines] = {
  graph,
  directed,
  binary_edges,
  labeled_vertices,
  labeled_edges,
}

petrinet [meta].place_type = {
  [refines] = {
    _ [meta].vertex_type,
  },
  [meta] = {
    record = {
      identifier = false,
      marking    = false,
    }
  }
}

petrinet [meta].transition_type = {
  [refines] = {
    _ [meta].vertex_type,
  }
}

petrinet [meta].arc_type = {
  [refines] = {
    _ [meta].edge_type,
  },
}

petrinet.places = {
  [refines] = {
    collection,
  },
  [meta   ] = {
    value_type = _ [meta].place_type,
  }
}

petrinet.transitions = {
  [refines] = {
    collection,
  },
  [meta   ] = {
    value_type = _ [meta].transition_type,
  }
}

petrinet.arcs = {
  [refines] = {
    collection,
  },
  [meta   ] = {
    value_type = _ [meta].arc_type,
  }
}

petrinet.vertices [refines] [#petrinet.vertices [refines] + 1] = _.places
petrinet.vertices [refines] [#petrinet.vertices [refines] + 1] = _.transitions
petrinet.edges    [refines] [#petrinet.edges    [refines] + 1] = _.arcs

return petrinet
