local Layer = require "layeredata"
local refines = Layer.key.refines

local substraction_op = Layer.require "operator.substraction"

describe("Multiplication operator", function()
  it("has the properties imposed by Operator", function ()
    local layer = Layer.new {}

    layer [refines] = {
      substraction_op
    }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
