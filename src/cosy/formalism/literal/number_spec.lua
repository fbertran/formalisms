--[[ These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.number", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.number"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local number = Layer.require "cosy/formalism/literal.number"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { number },
          value = 12,  
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)]]--
