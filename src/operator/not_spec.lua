local Layer = require "layeredata"
local refines = Layer.key.refines

local not_op = Layer.require "operator.not"

describe("Not operator", function()
  it("has the properties imposed by Operator", function ()
    local layer = Layer.new {}

    layer [refines] = {
      not_op
    }

    Layer.Proxy.check_all(layer)

    assert.is_nil(next(Layer.messages))
  end)
end)
