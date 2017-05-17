require "busted.runner" {}

local Layer      = require "layeredata"
local arithmetic = Layer.require "expression.arithmetic"
local expression = Layer.require "expression"
local refines    = Layer.key.refines
local meta       = Layer.key.meta

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

describe ("Arithmetic expression", function ()
  it ("can be instantiated", function ()

    local layer, ref = Layer.new {
      data = {
        [refines] = { arithmetic }
      }
    }

    local a_type  = ref [meta] .type

    local l1 = {
      [refines] = { a_type },
      operator  = a_type [meta] [expression] .number,
      operands  = { 5 },
    }

    local l2 = {
      [refines] = { a_type },
      operator  = a_type [meta] [expression] .number,
      operands  = { 5 },
    }

    layer.operator = ref [meta] [expression] .addition
    layer.operands = {
      l1, l2
    }

    -- print("check layer")
    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
