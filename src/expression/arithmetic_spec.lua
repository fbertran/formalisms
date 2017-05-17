require "busted.runner" {}

local Layer      = require "layeredata"
local arithmetic = Layer.require "expression.arithmetic"
local expression = Layer.require "expression"
local refines    = Layer.key.refines
local meta       = Layer.key.meta
local collection = Layer.require "data.collection"

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

describe ("Arithmetic expression", function ()
  it ("can be instantiated", function ()

    local layer = Layer.new {
      data = {
        [refines] = { arithmetic }
      }
    }

    local l1 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression] .number,
      operands  = { 5 },
    }

    local l2 = {
      [refines] = { arithmetic },
      operator  = arithmetic [meta] [expression] .number,
      operands  = { 5 },
    }

    layer.operator = layer [meta] [expression] .addition
    layer.operands = {
      l1, l2
    }

    -- print("check layer")
    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
