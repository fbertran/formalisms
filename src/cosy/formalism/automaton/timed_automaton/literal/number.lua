-- number

return function (Layer, number)


  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/automaton/timed_automaton/literal"
  local operands_arithmetic_type=Layer.require "cosy/formalism/automaton/timed_automaton/operation/operands_arithmetic_type"
  local operands_relational_type=Layer.require "cosy/formalism/automaton/timed_automaton/operation/operands_relational_type"

 
  number [refines] = {
    literal,
    operands_arithmetic_type,
    operands_relational_type,
  }
  
  number [meta] = {
    [record] = {
     value = { value_type = "number" },
    },
  }

  
  return number
end
