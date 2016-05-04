-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end
require "busted.runner" ()



local Layer = require "cosy.formalism.layer"

describe ("Formalism data.record", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/drawable"
  end)

  it ("using good type for svg_sequence", function ()
		local drawable	= Layer.require "cosy/formalism/drawable"

    local layer  = Layer.new {}
    layer [Layer.key.refines] = { drawable }
    layer.svg_sequence = "SVG SEQUENCE"
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

	it ("detects using wrong type for svg_sequence", function ()
		local drawable	= Layer.require "cosy/formalism/drawable"

    local layer  = Layer.new {}
    layer [Layer.key.refines] = { drawable }
    layer.svg_sequence = 18
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

	it ("using good type for draw", function ()
		local drawable	= Layer.require "cosy/formalism/drawable"

    local layer  = Layer.new {}
    layer [Layer.key.refines] = { drawable }
    layer.svg_sequence = "svg sequence"
		layer.draw = function () print "Function draw" end
    Layer.Proxy.check (layer)
    assert.is_nil (Layer.messages (layer) ())
  end)

	it ("detects using wrong type for svg_sequence", function ()
		local drawable	= Layer.require "cosy/formalism/drawable"

    local layer  = Layer.new {}
    layer [Layer.key.refines] = { drawable }
    layer.svg_sequence = "svg sequence"
		layer.draw = "not a function"
    Layer.Proxy.check (layer)
    assert.is_not_nil (Layer.messages (layer) ())
  end)

end)


