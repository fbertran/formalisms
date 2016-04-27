-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.tool.parser"

describe ("Formalism literal.literal", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operation.addition_operation"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local addition_operation = Layer.require "cosy/formalism/operation.addition_operation"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { addition_operation },
          value = true,  
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)
