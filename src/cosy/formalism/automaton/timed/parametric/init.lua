return function (Layer, parametric_timed_automaton, ref)

  local meta               = Layer.key.meta
  local refines            = Layer.key.refines
  local collection         = Layer.require "cosy/formalism/data.collection"
  local timed_automaton    = Layer.require "cosy/formalism/automaton/timed"
 -- local identifier         = Layer.require "cosy/formalism/literal.identifier"

  local identifier         = Layer.require "cosy/formalism/literal.identifier"


  local operands_arithmetic_type = Layer.require "cosy/formalism/operation/arithmetic.operands_type"
  local operands_relational_type = Layer.require "cosy/formalism/operation/relational.operands_type"

  
  



  parametric_timed_automaton [refines] = {
    timed_automaton,
  }

 
  parametric_timed_automaton [meta].parameter_type = {
    [refines] = {
      identifier,
      operands_arithmetic_type,
      operands_relational_type,
    },
  }

  parametric_timed_automaton.parameters = {
    [refines] = {
      collection,
     
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].parameter_type,
      },
    },
  }


 return parametric_timed_automaton
end
