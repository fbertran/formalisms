-- Number formalism : Representation of a primitive number in a formalism

return function (Layer, number)
  
  local lpeg    = require "lulpeg"
  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local record  = Layer.require "cosy/formalism/data.record"
  local nullary = Layer.require "cosy/formalism/operator/nullary"
  local literal = Layer.require "cosy/formalism/literal"

  number [refines] = {
    literal,
    nullary,
  }

  number [meta] [record] .value = { value_type = "number" }

  number .priority = math.huge

  number.count_id = 0 --use for debugging

  number [meta] .parser = function (reference)
    local pattern = lpeg.R "09"^1/function (patt)

      local layer = Layer.new {name = "number_"..reference.count_id}
      reference.count_id = reference .count_id + 1

      layer [refines] = { reference }
      layer.value = tonumber(patt)
      return layer,patt
    end
    return pattern
  end

  number [meta] .printer = function(reference)
    return (tostring(reference.value))
  end

  return number
end
