require "busted.runner" {}

local Layer          = require "layeredata"
local arithmetic_var = Layer.require "expression.arithmetic_var"
local expression     = Layer.require "expression"
local refines        = Layer.key.refines
local meta           = Layer.key.meta

-- linearization fail on all tests

describe ("Arithmetic expression with variable", function ()
  it ("can be instantiated", function ()

    local layer = Layer.new {}
    layer [refines] = { arithmetic_var }

    local l1 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression].variable,
      operands  = { "variable_name" },
    }

    local l2 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression].number,
      operands  = { 1 },
    }

    -- print (arithmetic_var [meta] [expression].addition)
    layer.operator = arithmetic_var [meta] [expression].addition
    layer.operands = { l1, l2 }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)

  it ("accepts the operators from arithmetic (subset)", function ()

    -- arithmetic has add, sub, mult, number
    local layer = Layer.new {}
    layer [refines] = { arithmetic_var }

    local l2 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression].number,
      operands  = { 1 },
    }

    local l1 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression].number,
      operands  = { 2 },
    }

    local sub = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression].substraction,
      operands  = { l1, l2 }
    }

    local mult = {
      [refines] = { arithmetic_var },
      operators = arithmetic_var [meta] [expression].multiplication,
      operands  = { sub, l2 },
    }

    layer.operator = arithmetic_var [meta] [expression].addition
    layer.operands = { mult, sub }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
