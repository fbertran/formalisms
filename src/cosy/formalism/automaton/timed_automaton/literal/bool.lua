-- bool

return function (Layer, bool)


  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/automaton/timed_automaton/literal"
  --local lpeg     = require "lpeg" 


 
  bool [refines] = {
    literal, 
    Layer.require "cosy/formalism/automaton/timed_automaton/operation/operands_logical_type",
    Layer.require "cosy/formalism/automaton/timed_automaton/operation/operands_relational_type",
    Layer.require "cosy/formalism/automaton/timed_automaton/operation/boolean_operation",
  }
  
  bool [meta] = {
    [record] = {
     value = { value_type = "boolean" },
    },
  }
--[[ bool.instanciate = function(patt)
   local bool_value=nil
   bool_value=loadstring(patt)
   return bool_value
 end
 bool.parse = function(expression)
  
  local bool_parse = lpeg.P {"bool",
          bool = lpeg.P("true")/instanciate + lpeg.P ("false")/instanciate
        }
 
return 
 end]]--
  return bool
end
