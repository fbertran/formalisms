-- Boolean formalism

return function (Layer, bool)
  
  local lpeg = require "lulpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local nullary  =  Layer.require "cosy/formalism/operator/nullary"

  bool [refines] = {
    nullary, 
  }

  bool [meta] [record] .value = { value_type = "boolean" }
  
  bool.priority = math.huge

  bool [meta].parser = function (reference)
    local pattern =(lpeg.P "true" + lpeg.P "false")/function (patt)
      local layer = Layer.new {}
      layer [refines] = {reference}
      if patt == "true" then
        layer.value = "true"
      else
        layer.value = "false"
      end

      return layer,patt
    end

    return pattern
   end
  
  bool [meta].printer = function(root_expression)
    io.write(root_expression.value)
  end

  return bool
end
