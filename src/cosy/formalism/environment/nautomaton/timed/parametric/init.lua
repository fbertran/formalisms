return function (Layer, nparametric_timed_automaton)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local ntimed_automaton = Layer.require "cosy/formalism/environment/nautomaton/timed"

  local parametric_timed_automaton = Layer.require "cosy/formalism/automaton/timed/parametric"

  local collection = Layer.require "cosy/formalism/data.collection"

  nparametric_timed_automaton [refines] = {
    ntimed_automaton,
  }

  nparametric_timed_automaton.container [meta][collection].value_type = parametric_timed_automaton
  
  nparametric_timed_automaton[meta].init_condition_type = parametric_timed_automaton [meta].init_condition_type
  nparametric_timed_automaton[meta].parameter_type = parametric_timed_automaton [meta].parameter_type
  nparametric_timed_automaton[meta].clock_type = parametric_timed_automaton [meta].clock_type
  nparametric_timed_automaton[meta].discrete_type = parametric_timed_automaton [meta].discrete_type 

  nparametric_timed_automaton.shared.parameters = {
    [refines] = {parametric_timed_automaton.parameters}
  }
 -- nparametric_timed_automaton[meta].init_condition_type = 
 --print("choulou")
 --print(parametric_timed_automaton.init_condition==nil)
 --print("choulou")
  nparametric_timed_automaton.shared.init_conditions = {
    [refines] = {parametric_timed_automaton.init_condition}
  }  




return nparametric_timed_automaton
end