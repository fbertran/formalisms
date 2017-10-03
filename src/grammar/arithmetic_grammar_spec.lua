require "busted.runner" {}

local Layer = require "layeredata"
local refines = Layer.key.refines

local arithmetic = Layer.require "grammar.arithmetic_grammar"

describe ("Arithmetic Grammar", function ()
  it ("has the required things", function ()
    local layer = Layer.new {}

    layer [refines] = { arithmetic }

    layer.expressions[1].operands = {
      10, 20,
    }

    Layer.Proxy.check_all (layer)

    assert.is_nil (next (Layer.messages))
  end)
end)
