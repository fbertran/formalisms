-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"


describe ("Formalism literal.literal", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local literal = Layer.require "cosy/formalism/literal"
      local record  = Layer.require "cosy/formalism/data.record"
      local layer      = Layer.new {name = "layer"}
        layer [Layer.key.refines] = { literal }
        layer [Layer.key.meta] = {
            [record] = {
              value = {value_type = "number"},
            },       
			   	}
        layer.value = "test"
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ))
    end)
	end)

end)
