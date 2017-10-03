local Layer = require "layeredata"
local refines = Layer.key.refines

local addition_expression = Layer.require "expression.addition_expression"

describe ("Addition expression", function()
  it ("has the properties imposed by Expression", function ()
    local layer, ref = Layer.new {}

    layer [refines] = {
      addition_expression
    }

    local l1 = {
      [refines] = { addition_expression },
      operator  = addition_expression [meta] [expression] .number,
      operands  = { 1 },
    }

    local l2 = {
      [refines] = { addition_expression },
      operator  = addition_expression [meta] [expression] .addition,
      operands  = { l1, l1 }
    }

    assert.True (layer.operator.left_associative)
    assert.True (layer.operator.is_commutative)

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
