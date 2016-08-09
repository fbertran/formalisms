return function (Layer, nimitator_parametric_timed_automaton)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local nparametric_timed_automaton = Layer.require "cosy/formalism/environment/nautomaton/timed/parametric"

  local parametric_timed_automaton = Layer.require "cosy/formalism/automaton/timed/parametric"

  local imitator_parametric_timed_automaton = Layer.require "cosy/formalism/automaton/timed/parametric/imitator"

  local collection = Layer.require "cosy/formalism/data.collection"
  local record = Layer.require "cosy/formalism/data.record"

  local assignment = Layer.require "cosy/formalism/operation/assignment"
  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"

  local operands_type = Layer.require "cosy/formalism/flag.operands_type"
  local init_operands_type =Layer.new {}
  init_operands_type [refines] = {operands_type}

  nimitator_parametric_timed_automaton [refines] = {
    nparametric_timed_automaton,
  }
  nimitator_parametric_timed_automaton.container [meta][collection].value_type = imitator_parametric_timed_automaton

  nimitator_parametric_timed_automaton.shared [meta][record].discrete_variables = {
    [refines] = {imitator_parametric_timed_automaton.discrete_variables}
  }  
  nimitator_parametric_timed_automaton.shared [meta][record].init_condition = {
    [refines] = {parametric_timed_automaton.init_condition}
  }
  imitator_parametric_timed_automaton [meta].init_condition_type [refines][#imitator_parametric_timed_automaton [meta].init_condition_type [refines]+1] = init_operands_type
  imitator_parametric_timed_automaton [meta].assignment_operation[assignment][refines][#imitator_parametric_timed_automaton [meta].assignment_operation[assignment][refines]+1] = init_operands_type 
  imitator_parametric_timed_automaton [meta].guard_operations [boolean_operation][meta].operands_type = init_operands_type
  nimitator_parametric_timed_automaton.shared [meta][record].states [meta][collection].value_type = imitator_parametric_timed_automaton [meta].state_type




return nimitator_parametric_timed_automaton
end