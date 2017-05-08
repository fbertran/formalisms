local Layer = require "layeredata"
local refines = Layer.key.refines

local multiplication_expression = Layer.require "expression.multiplication_expression"

describe ("Multiplication expression", function()
  it ("has the properties imposed by Expression", function ()
    local layer = Layer.new {}

    layer [refines] = {
      multiplication_expression
    }

    layer.operands = {
      10, 20
    }

    assert.True (layer.operator.is_associative)
    assert.True (layer.operator.is_commutative)

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
