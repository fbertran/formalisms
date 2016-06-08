-- bool

return function (Layer, bool)
  
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/automaton/timed_automaton/literal"
 
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

  return bool
end
