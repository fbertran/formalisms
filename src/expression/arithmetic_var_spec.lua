require "busted.runner" {}

local Layer          = require "layeredata"
local arithmetic_var = Layer.require "expression.arithmetic_var"
local expression     = Layer.require "expression"
local refines        = Layer.key.refines
local meta           = Layer.key.meta
local collection     = Layer.require "data.collection"


local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

describe ("Arithmetic expression", function ()
  it ("can be instantiated", function ()

    local layer, ref = Layer.new {
      data = {
        [refines] = { arithmetic_var }
      }
    }

    local l1 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression] .number,
      operands  = { 5 },
    }

    local l2 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression] .variable,
      operands  = { l1 },
    }

    local l3 = {
      [refines] = { arithmetic_var },
      operator  = arithmetic_var [meta] [expression] .multiplication,
      operands  = { l1, l1 },
    }

    layer.operator  = layer [meta] [expression] .addition
    layer.operands  = { l3, l2 }

    print (ref [meta] .type)

    print (layer [meta] [expression] .multiplication  .operands [meta] [collection] .value_type)
    print (layer [meta] [expression] .variable .operands [meta] [collection] .value_type )

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
