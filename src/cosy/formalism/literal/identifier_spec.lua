--[[ These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.identifier", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.identifier"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local record = Layer.require "cosy/formalism/data.record"
      local identifier = Layer.require "cosy/formalism/literal.identifier"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { identifier },
          [Layer.key.meta] = {
            [record]={
             value={
               value_type="number"
             },
            },
          },
          value = 12,  
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)]]--
