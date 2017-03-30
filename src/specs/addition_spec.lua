require "busted.runner" {}

local Layer = require "layeredata"
local addition_op = Layer.require "operator.addition"

describe ("Addition operator", function ()
  it ("Requires two and exactly two operands", function ()
    local layer = Layer.new {}
    layer [Layer.key.refines] = { addition_op }
    layer.operands.left = 2
    layer.operands.right = 5
    layer.operands.middle = 11
    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("Only allows operands of type \"number\"", function ()
    local layer = Layer.new {}
    layer [Layer.key.refines] = { addition_op }
    layer.operands.left = 5
    layer.operands.right = "ajsdhkhfkjhasddfjh"
    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)
end)
