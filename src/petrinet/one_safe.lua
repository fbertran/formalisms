-- One-Safe Petri nets
-- ===================
--
-- See [here](https://en.wikipedia.org/wiki/Petri_net)

return function (Layer, one_safe --[[, ref]])

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local record   = Layer.require "data.record"
  local petrinet = Layer.require "petrinet"

  one_safe [refines] = {
    petrinet,
  }

  one_safe [meta].place_type [meta] [record].identifier = {}
  one_safe [meta].place_type [meta] [record].marking    = {
    value_type = "boolean",
  }
  one_safe [meta].arc_type   [meta] [record].valuation  = {
    value_type = "boolean",
  }
  one_safe [meta].arc_type.valuation = true

end
