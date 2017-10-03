require "busted.runner" {}

local Layer      = require "layeredata"
local arnm       = Layer.require "expression.arithmetic_no_multiplication"
local ar         = Layer.require "expression.arithmetic"
local refines    = Layer.key.refines
local meta       = Layer.key.meta
local expression = Layer.require "expression"
local deleted    = Layer.key.deleted

describe ("Arithmetic without multiplication", function ()
  it ("doesn't allow multiplication operator", function ()
    local layer = Layer.new {}
    layer [refines] = { arnm }

    local l1 = {
      [refines] = arnm,
      operator  = arnm[meta][expression].number,
      operands  = { 1 }
    }

    local l2 = {
      [refines] = { arnm },
      operator  = arnm[meta][expression].number,
      operands  = { 2 },
    }

    layer.operator = layer[meta][expression].substraction
    layer.operands = { l1, l2}

    Layer.Proxy.check_all(layer)

    assert.is_nil(next(Layer.messages))
  end)
end)
