if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism automaton", function ()

  it ("can be loaded", function ()

    local _ = Layer.require "cosy/formalism/automaton"

  end)

  describe ("Formalism automaton", function ()

    describe ("states tests", function()

      it ("good type of information", function()
        local automaton = Layer.require "cosy/formalism/automaton"
       -- local record = Layer.require "cosy/formalism/data.record"
       -- local ref = Layer.reference (automaton)
       
        local layer = Layer.new {}
        --s1 [Layer.key.meta][record].value ={value_type = ref [Layer.key.meta].state_type}
        layer [Layer.key.refines] = {automaton}
        layer.states = {
          s1 = {
            value = "s1",
            initial = true,
            final = true,
          }
        }
        Layer.Proxy.check_all (layer)
        assert.is_nil ( next ( Layer.messages ) )
      end)

      it ("bad type of information", function()
        local automaton = Layer.require "cosy/formalism/automaton"
        --local record = Layer.require "cosy/formalism/data.record"
        --local ref = Layer.reference (automaton)
        local layer = Layer.new {}
        layer [Layer.key.refines] = {automaton}
        layer.states = {
          s1 = {
            value = 1,
            initial = true,
            final = true,
          }
        }
        Layer.Proxy.check_all (layer)
        assert.is_not_nil ( next (Layer.messages ) )
        assert.is_true ( layer [Layer.key.meta].state_type <= layer.states.s1 )
      end)

    end)

    describe ("actions tests", function()
      it ("put an action in actions", function()
        local automaton = Layer.require "cosy/formalism/automaton"
        local action = Layer.require "cosy/formalism/action"
        local a1 = Layer.new {}
        local layer = Layer.new {}
        layer [Layer.key.refines] = {automaton}
        a1 [Layer.key.refines] = {action}
        a1.value = "a1"
        layer.actions = {a1}

        Layer.Proxy.check_all(layer)
        assert.is_nil( next ( Layer.messages ) )

      end)

      it ("put something else in actions", function()
        local automaton = Layer.require "cosy/formalism/automaton"
        local string = Layer.require "cosy/formalism/literal.string"
        local a1 = Layer.new {}
        local layer = Layer.new {}
        layer [Layer.key.refines] = {automaton}
        a1 [Layer.key.refines] = {string}
        a1.value = "a1"
        layer.actions = {a1}

        Layer.Proxy.check_all(layer)
        assert.is_not_nil( next (Layer.messages))

    end)

  end)

  describe ("transitions tests", function()
      
    it("put an action in transition", function() 
      local automaton = Layer.require "cosy/formalism/automaton"
      local record = Layer.require "cosy/formalism/data.record"
      local action = Layer.require "cosy/formalism/action"
      local ref = Layer.reference(automaton)
      local a1 = Layer.new {}
      local layer = Layer.new {}
      layer [Layer.key.refines] = {automaton}
      a1 [Layer.key.refines] = {action}
      a1 [Layer.key.meta][record].value.value_type = "string"
      a1.value = "a1"

      layer [Layer.key.refines] = {automaton}
      layer.states = {
          s1 = {
          initial = true,
          final = true,
          value = "s1"
        }
      }
      layer.transitions = {
        t1 = {
          arrows = {
            { vertex = ref.states.s1,
              input  = true },
            { vertex = ref.states.s1,
              output = true },
          },
          letter = a1
        }
      }
      Layer.Proxy.check_all (layer)
      assert.is_nil( Layer.messages [layer.transitions.t1.letter] )
      end)

      it("put something else (not an action) in transition", function() 
        local automaton = Layer.require "cosy/formalism/automaton"
        --local record = Layer.require "cosy/formalism/data.record"
        local string = Layer.require "cosy/formalism/literal.string"
        --local meta = Layer.key.meta
        local ref = Layer.reference(automaton)
        local string_instance = Layer.new {}
        local layer = Layer.new {}
        layer [Layer.key.refines] = {automaton}
        string_instance [Layer.key.refines] = {string}
        string_instance.value = "a1"

        layer [Layer.key.refines] = {automaton}
        layer.states = {
            s1 = {
            initial = true,
            final = true,
            value = "s1"
          }
        }

        layer.transitions = {
          t1 = {
            arrows = {
              { vertex = ref.states.s1,
                input  = true },
              { vertex = ref.states.s1,
                output = true },
            },
            letter = string_instance
          }
        }
        Layer.Proxy.check_all (layer)
        assert.is_not_nil( Layer.messages [layer.transitions.t1.letter] )
      
      end)
    end)

  end)

end)
