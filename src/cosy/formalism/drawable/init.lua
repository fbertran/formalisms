-- Formalisme Drawable is a formalism that can be represented (drawn) by a svg sequence

return function (Layer, drawable)

  local refines       =  Layer.key.refines
  local meta          =  Layer.key.meta
  local record        =  Layer.require "cosy/formalism/data.record"

  drawable [refines] = {
    record,
  }

  drawable [meta] [record] .svg_sequence  = { value_type = "string" }
  drawable .svg_sequence = "NONE"

  drawable [meta] .draw = function() print "NOT IMPLEMENTED YET" end
end
