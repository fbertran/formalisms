-- These lines are required to correctly run tests.
require "busted.runner" ()
local i=0
local Layer = require "cosy.formalism.layer"

describe ("Formalism data.collection", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/data.collection"
  end)

  describe ("with size information", function ()

    it ("forbids a size less than the minimum", function ()
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { collection },
          [Layer.key.meta   ] = {
            [collection] = {
              minimum = 4,
            },       
			   	},
					["a"] = true,
        },
      }
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)
	end)
end)
