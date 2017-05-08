local Layer = require "layeredata"
local refines = Layer.key.refines

local substraction_expression = Layer.require "expression.substraction_expression"

describe ("Substraction expression", function()
  it ("has the properties imposed by Expression", function ()
    local layer = Layer.new {}

    layer [refines] = {
      substraction_expression
    }

    layer.operands = {
      10, 20
    }

    assert.False (layer.operator.is_associative)
    assert.False (layer.operator.is_commutative)

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
