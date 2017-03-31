require "busted.runner" {}

describe ("Not operator", function ()
  it ("can be created", function ()
    local Layer = require "layeredata"
    local not_operator = Layer.require "operator.not"
    local layer = Layer.new {}
    layer [Layer.key.refines] = { not_operator }
    assert.is_equal ((not_operator.operator), (layer.operator))
    assert.True (string.len(layer.operator) > 0)
  end)

  it ("has a string type defined for the token", function ()
    local Layer = require "layeredata"
    local not_operator = Layer.require "operator.not"
    local layer = Layer.new {}
    layer [Layer.key.refines] = { not_operator }
    layer.operands.op = true
    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it("accepts only one boolean as operand", function ()
    local Layer = require "layeredata"
    local not_operator = Layer.require "operator.not"
    local layer = Layer.new {}
    layer [Layer.key.refines] = { not_operator }
    layer.operands.op = true
    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)
