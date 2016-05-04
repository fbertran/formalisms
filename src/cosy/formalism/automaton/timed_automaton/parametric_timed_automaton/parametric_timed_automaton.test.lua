--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism timed_automaton", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton"
  end)

  describe ("with type information", function ()

    it ("parsing an operation then printing it", function ()
      local parametric_timed_automaton = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton"
      --local operation = Layer.require "cosy/formalism/automaton/timed_automaton/parametric_timed_automaton/condition_params"
      --local literal = Layer.require "cosy/formalism/automaton/timed_automaton/literal"
      local refines =  Layer.key.refines
      --local meta =  Layer.key.meta


     local layer=Layer.new {
     name="p_timed_automaton",
     data = {
       [refines] = {
         parametric_timed_automaton,
       },
      }
     }

local op=parametric_timed_automaton.parser(layer)


print(parametric_timed_automaton.printer(op))
  


     -- Layer.Proxy.check (layer)
     -- assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)
