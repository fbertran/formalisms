--[[ These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.string", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.string"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local string = Layer.require "cosy/formalism/literal.string"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { string },
          value = "test",  
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)]]--
