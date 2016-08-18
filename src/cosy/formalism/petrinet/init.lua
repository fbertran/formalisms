-- Petri nets
-- ==========
--
-- This formalism defines the basic structure of any Petri net: a collection
-- of places, a collection of transitions (both being graph vertices), and
-- a collection of arcs.
--
-- See [here](https://en.wikipedia.org/wiki/Petri_net)

return function (Layer, petrinet, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local collection       = Layer.require "cosy/formalism/data.collection"
  local record           = Layer.require "cosy/formalism/data.record"
  local graph            = Layer.require "cosy/formalism/graph"
  local directed         = Layer.require "cosy/formalism/graph.directed"
  local binary_edges     = Layer.require "cosy/formalism/graph.binary_edges"

  petrinet [refines] = {
    graph,
    binary_edges,
    directed,
  }

  petrinet [meta].place_type = {
    [refines] = {
      ref [meta].vertex_type,
    },
    [meta] = {
      [record] = {
        identifier = false,
        marking    = false,
      }
    }
  }

  petrinet [meta].transition_type = {
    [refines] = {
      ref [meta].vertex_type,
    }
  }

  petrinet [meta].arc_type = {
    [refines] = {
      ref [meta].edge_type,
    },
  }

  petrinet.places = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].place_type,
      }
    },
  }

  petrinet.transitions = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].transition_type,
      }
    },
  }

  petrinet [meta].pre_arc_type = {
    [refines] = {
      ref [meta].arc_type,
    },
    [meta] = {
      [record] = {
        source = {
          value_container = ref.places,
        },
        target = {
          value_container = ref.transitions,
        },
      },
    },
  }

  petrinet [meta].post_arc_type = {
    [refines] = {
      ref [meta].arc_type,
    },
    [meta] = {
      [record] = {
        source = {
          value_container = ref.transitions,
        },
        target = {
          value_container = ref.places,
        },
      },
    },
  }

  petrinet.pre_arcs = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].pre_arc_type,
      }
    },
  }

  petrinet.post_arcs = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].post_arc_type,
      }
    },
  }

  petrinet.arcs = {
    [refines] = {
      ref.pre_arcs,
      ref.post_arcs,
    },
  }

  petrinet.vertices [refines] = {
    ref.places,
    ref.transitions,
  }
  petrinet.edges    [refines] = {
    ref.arcs,
  }

end
