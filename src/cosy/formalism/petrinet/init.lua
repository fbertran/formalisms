-- Petri nets
-- ==========
--
-- This formalism defines the basic structure of any Petri net: a collection
-- of places, a collection of transitions (both being graph vertices), and
-- a collection of arcs.
--
-- See [here](https://en.wikipedia.org/wiki/Petri_net)

return function (Layer)

  local labels   = Layer.key.labels
  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph            = Layer.require "cosy/formalism/graph"
  local labeled_edges    = Layer.require "cosy/formalism/graph.labeled.edges"
  local labeled_vertices = Layer.require "cosy/formalism/graph.labeled.vertices"
  local directed         = Layer.require "cosy/formalism/graph.directed"
  local binary_edges     = Layer.require "cosy/formalism/graph.binary_edges"

  local petrinet = Layer.new {
    name = "cosy/formalism/petrinet",
  }

  petrinet [labels] = {
    ["cosy/formalism/petrinet"] = true,
  }
  local _ = Layer.reference "cosy/formalism/petrinet"

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
      _ [meta].vertices,
    },
    [meta] = {
      collection = {
        value_type = _ [meta].place_type,
      }
    }
  }

  petrinet.transitions = {
    [refines] = {
      _ [meta].vertices,
    },
    [meta] = {
      collection = {
        value_type = _ [meta].transition_type,
      }
    }
  }

  petrinet.arcs = {
    [refines] = {
      _ [meta].edges,
    },
    [meta] = {
      collection = {
        value_type = _ [meta].arc_type,
      }
    }
  }

  petrinet.vertices [refines] [#petrinet.vertices [refines] + 1] = _.places
  petrinet.vertices [refines] [#petrinet.vertices [refines] + 1] = _.transitions
  petrinet.edges    [refines] [#petrinet.edges    [refines] + 1] = _.arcs

  return petrinet

end
