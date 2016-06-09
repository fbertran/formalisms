if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"

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
      local layer=Layer.new {}
      layer [refines] = {
            parametric_timed_automaton,
          }
      
      --lorsque j'execute ces deux lignes ci-dessous, parametric_timed_automaton.parser devient nulle
      layer.clocks.c1 = { value = "x1"}
      --print(layer.clocks.c1.value)

      --print(parametric_timed_automaton.parser)
      local op=layer.parser("INF(ADD(layer.clocks.c1,2),1)",layer)
      print(layer.printer(op))
  


    end)
	end)

end)
