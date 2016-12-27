-- Philosopphers Petri nets
-- ========================
--
-- See [here](https://en.wikipedia.org/wiki/Petri_net)
-- See [here](https://fr.wikipedia.org/wiki/Réseau_de_Petri)

return function (Layer, philosophers, ref)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local record   = Layer.require "data.record"
  local pt       = Layer.require "petrinet.pt"

  philosophers [refines] = {
    pt,
  }

  philosophers [meta].place_type [meta] [record] = {
    identifier = {
      value_type = "string",
    },
    philosopher = {
      value_type = "number",
    },
  }

  philosophers [meta].fork = {
    [refines] = {
      ref [meta].place_type,
    },
  }
  philosophers [meta].thinking = {
    [refines] = {
      ref [meta].place_type,
    },
  }
  philosophers [meta].has_left = {
    [refines] = {
      ref [meta].place_type,
    },
  }
  philosophers [meta].eating = {
    [refines] = {
      ref [meta].place_type,
    },
  }
  philosophers [meta].take_left = {
    [refines] = {
      ref [meta].transition_type,
    },
  }
  philosophers [meta].take_right = {
    [refines] = {
      ref [meta].transition_type,
    },
  }
  philosophers [meta].release = {
    [refines] = {
      ref [meta].transition_type,
    },
  }

end
