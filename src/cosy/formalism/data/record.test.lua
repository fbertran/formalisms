-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism data.record", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/data.record"
  end)

  it ("detects wrongly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {
      name = "layer",
      data = {
        [Layer.key.refines] = { record },
        [Layer.key.meta   ] = {
          [record] = {
             clef2 = { value_type = "boolean"},
          },
        },
        clef2 = 1,
      },
    }
    Layer.Proxy.check (layer)
		--print(layer[messages])
    assert.is_not_nil (Layer.messages (layer) ())
  end)
end)
