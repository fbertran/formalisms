return function (Layer, ntimed_automaton)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local nautomaton = Layer.require "cosy/formalism/environment/nautomaton"

  local timed_automaton = Layer.require "cosy/formalism/automaton/timed"

  local collection = Layer.require "cosy/formalism/data.collection"
  local record = Layer.require "cosy/formalism/data.record"

  ntimed_automaton [refines] = {
    nautomaton,
  }
  ntimed_automaton.container [meta][collection].value_type = timed_automaton

  ntimed_automaton.shared [meta][record].clocks = {
    [refines] = {timed_automaton.clocks}
  }  

  ntimed_automaton.shared [meta][record]. states [meta][collection] = {
          value_type = timed_automaton [meta].state_type,
  }



return ntimed_automaton
end