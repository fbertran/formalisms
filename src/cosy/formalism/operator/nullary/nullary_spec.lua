if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

describe ("Formalism Nullary", function ()

  it ("can be loaded", function ()
    local Layer = require "layeredata"
    local _     = Layer.require "cosy/formalism/operator/nullary"
  end)
end)

describe ("Formalism Nullary : priority", function ()
  it ("detects missing priority", function ()
    local Layer   = require "layeredata"
    local refines            = Layer.key.refines
    local nullary_formalism  = Layer.require "cosy/formalism/operator/nullary"
    local layer               = Layer.new {}

    layer [refines] = { nullary_formalism }
    
    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Nullary : operator", function ()
  it ("allows using an operator", function ()
    local Layer   = require "layeredata"
    local refines            = Layer.key.refines
    local nullary_formalism  = Layer.require "cosy/formalism/operator/nullary"
    local layer               = Layer.new {}

    layer [refines] = { nullary_formalism }
    layer .operator = "test"
    layer .priority = 1
    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Nullary : operands_size (should be 0)", function ()
  it ("detects adding operands with operands_type primitive", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local nullary_formalism  = Layer.require "cosy/formalism/operator/nullary"
    local layer               = Layer.new {}

    layer [refines] = { nullary_formalism }
    layer [meta] .operands_type = "number"

    layer .operands [#layer .operands+1] = 1
    layer .operands [#layer .operands+1] = 9
    layer .operands [#layer .operands+1] = 8
    layer .operands [#layer .operands+1] = 4
    layer .operands [#layer .operands+1] = 2

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects adding operands with operands_type proxy", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local nullary_formalism   = Layer.require "cosy/formalism/operator/nullary"
    local layer               = Layer.new {}

    layer [refines] = { nullary_formalism }
    layer [meta] .operands_type = Layer.new {}

    layer .operands [1] = Layer.new {}
    layer .operands [1] [refines] = { layer [meta] .operands_type }

    layer .operands [2] = Layer.new {}
    layer .operands [2] [refines] = { layer [meta] .operands_type }

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)
end)
