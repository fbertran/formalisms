--[[ These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"


describe ("Formalism literal.literal", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local literal = Layer.require "cosy/formalism/literal"
      local record  = Layer.require "cosy/formalism/data.record"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { literal },
          [Layer.key.meta   ] = {
            [record] = {
              value = {value_type="number"},
            },       
			   	},
          value = "test",  
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)]]--
