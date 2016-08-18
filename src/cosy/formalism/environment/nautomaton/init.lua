return function (Layer, nautomaton,ref)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local ngraph = Layer.require "cosy/formalism/environment.ngraph"

  local automaton = Layer.require "cosy/formalism/automaton"

  local collection = Layer.require "cosy/formalism/data.collection"
  local record = Layer.require "cosy/formalism/data.record"

  nautomaton [refines] = {
    ngraph,
  }
  nautomaton.container [meta][collection].value_type = automaton

  nautomaton.shared [meta][record] = {
    states = {
      [refines] = {ref.shared.vertices},
      [meta] = {
        [collection] = {
          value_type = automaton [meta].state_type,
        }
      }
    },
    actions = {
      [refines] = {collection},
      [meta] = {
        [collection] = {
          value_type = automaton.actions [meta][collection].value_type,
        }
      }
    },
    
  }



return nautomaton
end