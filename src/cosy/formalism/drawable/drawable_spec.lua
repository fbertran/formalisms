-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism data.record", function ()

  it ("can be loaded", function ()
  
    local _ = Layer.require "cosy/formalism/drawable"
  
  end)

  it ("using good type for svg_sequence", function ()
	  local drawable	= Layer.require "cosy/formalism/drawable"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { drawable }
    layer.svg_sequence = "SVG SEQUENCE"
    Layer.Proxy.check_all (layer)
    assert.is_nil (Layer.messages [layer.svg_sequence])
  end)

	it ("using wrong type for svg_sequence", function ()
	  local drawable	= Layer.require "cosy/formalism/drawable"
    local layer  = Layer.new {}
    layer [Layer.key.refines] = { drawable }
    layer.svg_sequence = 18
    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next ( Layer.messages ))
  end)
end)


