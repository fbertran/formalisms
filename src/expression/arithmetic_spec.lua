require "busted.runner" {}

local Layer      = require "layeredata"
local arithmetic = Layer.require "expression.arithmetic"
local expression = Layer.require "expression"
local refines    = Layer.key.refines
local meta       = Layer.key.meta
local collection = Layer.require "data.collection"

describe ("Arithmetic expression", function ()
  it ("can be instantiated", function ()

    -- Warning: here we create an **instance** of the `arithmetic` expression.
    -- We **must** use `arithmetic` instead of self-`ref` everywhere,
    -- or the checks fail.
    local layer, ref = Layer.new {}
    layer [refines] = { arithmetic }

    -- `l1`, `l2`, and `layer` **must** refine `arithmetic` instead of self-`ref`,
    -- otherwise a loop is created within the operands.
    local l1 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].number,
      operands  = { 5 },
    }

    local l2 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].number,
      operands  = { 2 },
    }

    local l3 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].number,
      operands  = { 5 },
    }

    local l4 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].number,
      operands  = { 2 },
    }

    local add1 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].addition,
      operands  = { l1, l2 }
    }


    local sub1 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].substraction,
      operands  = { l3, l4 },
    }

    layer.operator = arithmetic[meta][expression].multiplication
    layer.operands = { add1, sub1 }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)

  it ("accepts all the defined expressions", function ()
    local layer     = Layer.new {}
    layer [refines] = { arithmetic }

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

    local sub = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].substraction,
      operands  = { l1, l2 },
    }

    local add = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].addition,
      operands  = { sub, l1 },
    }

    layer.operator = arithmetic [meta] [expression].multiplication
    layer.operands = { add, sub }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))

  end)

  it ("fails on wrong type passed", function ()
    local layer = Layer.new {}
    layer [refines] = { arithmetic }

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

    local sub = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].substraction,
      operands  = { l1, l2 },
    }

    local add = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression].addition,
      operands  = { sub, sub },
    }

    layer.operator = arithmetic [meta] [expression].multiplication
    layer.operands = { add, sub }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
