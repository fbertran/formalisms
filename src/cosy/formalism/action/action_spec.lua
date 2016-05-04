-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
require "busted.runner" ()


local Layer = require "cosy.formalism.layer"

describe ("Formalism action", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/action"
  end)

  it ("detects wrongly typed key/value (primitive)", function ()
    local record = Layer.require "cosy/formalism/data.record"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { record }
    layer [Layer.key.meta   ] = {
      [record] = {
        key = { value_type = "boolean" },
      },
    }
    layer.key = 1
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

end)
