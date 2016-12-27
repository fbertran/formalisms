-- Place/Transition Petri nets
-- ===========================
--
-- See [here](https://en.wikipedia.org/wiki/Petri_net)

return function (Layer, pt --[[, ref]])

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local record   = Layer.require "data.record"
  local petrinet = Layer.require "petrinet"

  pt [refines] = {
    petrinet,
  }

  pt [meta].place_type [meta] [record].identifier = {}
  pt [meta].place_type [meta] [record].marking    = {
    value_type = "number",
  }
  pt [meta].arc_type   [meta] [record].valuation  = {
    value_type = "number",
  }
  pt [meta].arc_type.valuation = 1

end
