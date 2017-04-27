require "busted.runner" {}

local Layer = require "layeredata"
local addition_op = Layer.require "operator.addition"
local refines = Layer.key.refines


describe("Addition operator", function()
  it("has the properties imposed by Operator", function ()
    local layer = Layer.new {}

    layer [refines] = {
      addition_op
    }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next(Layer.messages))
  end)
end)
