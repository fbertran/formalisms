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
        local record = Layer.require "cosy/formalism/data.record"
        local ref = Layer.reference (automaton)
        local s1 = Layer.new {}
        local layer = Layer.new {}
        s1 [Layer.key.refines] = {record}
        s1.value_type = ref [Layer.key.meta].state_type
        s1.value = "s1"
        s1.initial = true
        s1.final = true
        layer [Layer.key.refines] = {automaton}
        layer.states = {
          s1,
        }
        Layer.Proxy.check_all (layer)
        assert.is_nil ( Layer.messages[layer.states.s1] )
      end)

      it ("bad type of information", function()
        local automaton = Layer.require "cosy/formalism/automaton"
        local record = Layer.require "cosy/formalism/data.record"
        local ref = Layer.reference (automaton)
        local s1 = Layer.new {}
        local layer = Layer.new {}
        s1 [Layer.key.refines] = {record}
        s1.value_type = ref [Layer.key.meta].state_type
        s1.value = "s1"
        s1.initial = "wrong"
        s1.final = true
        layer [Layer.key.refines] = {automaton}
        layer.states = {
          s1,
        }
        Layer.Proxy.check_all (layer)
        assert.is_nil ( Layer.messages[layer.states.s1] )
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

  end)

end)
