require "busted.runner" {}

local Layer      = require "layeredata"
local arithmetic = Layer.require "expression.arithmetic"
local literal    = Layer.require "operator.literal"
local expression = Layer.require "expression"
local refines    = Layer.key.refines
local meta       = Layer.key.meta
local collection = Layer.require "data.collection"

describe ("Arithmetic expression", function ()
  it ("can be instantiated", function ()

    -- Warning: here we create an **instance** of the `arithmetic` expression.
    -- We **must** use `arithmetic` instead of self-`ref` everywhere,
    -- or the checks fail.
    local layer = Layer.new {}
    layer [refines] = { arithmetic }

    -- `l1`, `l2`, and `layer` **must** refine `arithmetic` instead of self-`ref`,
    -- otherwise a loop is created within the operands.
    local l1 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].number,
      operands  = { 1 },
    }

    local l2 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].number,
      operands  = { 5 },
    }

    layer.operator  = arithmetic [meta] [expression].addition
    layer.operands  = { l1, l2, }

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)
