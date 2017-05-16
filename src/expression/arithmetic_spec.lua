require "busted.runner" {}

local Layer       = require "layeredata"
local arithmetic  = Layer.require "expression.arithmetic"
local expression  = Layer.require "expression"
local refines     = Layer.key.refines
local meta        = Layer.key.meta
local collection  = Layer.require "data.collection"


local function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


describe("Arithmetic expression", function()
  it("can be instantiated", function ()
    local layer, rl = Layer.new {}

    local literal_layer1, r1 = Layer.new {}
    local literal_layer2, r2 = Layer.new {}

    layer [refines] = {
      arithmetic,
    }

    literal_layer1 [refines] = {
      arithmetic,
    }

    literal_layer2 [refines] = {
      arithmetic,
    }

    literal_layer1.operator = {
      [refines] = {
        r1[meta][expression].number
      }
    }

    literal_layer1.operator.operands = {
      5
    }

    literal_layer2.operator = {
      [refines] = {
        r2[meta][expression].number
      }
    }

    literal_layer2.operator.operands = {
      2
    }

    layer.operator = {
      [refines] = {
        layer[meta][expression].addition
      }
    }

    layer.operator.operands = {
      literal_layer1,
      literal_layer2
    }

    -- print(tablelength(layer.operator.operands))

    -- print("check literal_layer1")
    -- This one passes
    -- Layer.Proxy.check_all (literal_layer1)

    -- print("check literal_layer2")
    -- This one too
    -- Layer.Proxy.check_all (literal_layer2)

    -- print("check layer")
    Layer.Proxy.check_all (layer)

    assert.is_nil (next(Layer.messages))
  end)
end)
