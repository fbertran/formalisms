-- string

return function (Layer, string)
  local lpeg    = require "lulpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local nullary =  Layer.require "cosy/formalism/operator/nullary"
  local literal = Layer.require "cosy/formalism/literal"

  string [refines] = {
    literal,
    nullary,
  }

  string [meta] [record] .value = { value_type = "string" }
  
  string.priority = math.huge

  string [meta] .parser = function (reference)
    local pattern = (lpeg.P "\"" *(lpeg.R "az" + lpeg.R "AZ" + lpeg.P "_" + lpeg.R "09")^1 * lpeg.P "\"")/function (patt)
      local layer = Layer.new{}
      layer [refines] = {reference}
      layer.value = patt
      return layer,patt
    end
    return pattern
  end

  string [meta] .printer = function(reference)
    return (tostring(reference.value))
  end
  
end
