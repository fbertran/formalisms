-- literal

return function (Layer, literal)

  local lpeg = require "lpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"

  literal [refines] = {
    record
  }
  literal [meta] = {
    [record] = {
      value = { value_type = false }, 
      pattern = {value_type = "function"},
      parser = {value_type = "function"},
      result = {value_type = false}
    },
  }

  literal [meta][record].parser = function() end
  literal [meta][record].printer = function() end
  literal.pattern = function (instance)
      local number = Layer.require "cosy/formalism/literal.number"
      local string = Layer.require "cosy/formalism/literal.string"
      local identifier = Layer.require "cosy/formalism/literal.identifier"
      local bool = Layer.require "cosy/formalism/literal.bool"

      local pattern = lpeg.C {(bool.pattern()/function() literal.result = bool.result end) + (number.pattern()/function() literal.result = number.result end) + (string.pattern()/function() literal.result = string.result end) + (identifier.pattern(instance)/function() literal.result = identifier.result end)}
      return pattern
   end
  
  return literal
end
