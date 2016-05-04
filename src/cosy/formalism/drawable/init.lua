-- action

return function (Layer, drawable)

  local refines       =  Layer.key.refines
  local meta          =  Layer.key.meta
  local record        =  Layer.require "cosy/formalism/data.record"
  drawable [refines] = {
      record,
    }
  drawable [meta] = {
    [record] = {
      svg_sequence={value_type="string"},
      draw        ={value_type="function"}
    }
  }
  drawable.draw= function() print "NOT IMPLEMENTED YET" end


  return drawable
end
