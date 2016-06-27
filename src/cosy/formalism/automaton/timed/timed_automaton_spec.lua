if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism timed_automaton", function ()

  it ("can be loaded", function ()

    local _ = Layer.require "cosy/formalism/automaton/timed"
  
  end)

  describe ("with type information", function ()
    describe ("clock tests", function()
      it ("add clocks in the collection clocks", function()
        local timed_automaton = Layer.require "cosy/formalism/automaton/timed"
        local layer = Layer.new {}
        layer [Layer.key.refines] = {timed_automaton}
        layer.clocks = {
          c1 = {
            value = "c1",
          }
        }
        Layer.Proxy.check_all(layer)
        assert.is_nil (next ( Layer.messages ) )
      end)
      it ("add wrong type in the collection clocks", function()
        local timed_automaton = Layer.require "cosy/formalism/automaton/timed"
        local number = Layer.require "cosy/formalism/literal.number"
        local layer = Layer.new {}
        layer [Layer.key.refines] = {timed_automaton}
        local c1 = Layer.new {}
        c1 [Layer.key.refines] = {number}
        c1.value = 1
        layer.clocks = {
          c1,
        }
        Layer.Proxy.check_all(layer)
        assert.is_not_nil (next ( Layer.messages ) )
      end)

    end)
    
  end)

end)
