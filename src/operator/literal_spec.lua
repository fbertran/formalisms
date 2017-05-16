require "busted.runner" {}

local Layer       = require "layeredata"
local literal = Layer.require "operator.literal"
local refines     = Layer.key.refines


describe("Literal operator", function()
  it("has the properties imposed by Operator", function ()
    local layer = Layer.new {}

    layer [refines] = {
      literal
    }

    layer.operands = { 1 }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next(Layer.messages))
  end)
end)
