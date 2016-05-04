-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.number", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.number"
  end)

  describe ("with type information", function ()

    it ("using good type", function ()
      local number = Layer.require "cosy/formalism/literal.number"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { number },
          value = 42,  
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("forbids a different type (primitive)", function ()
      local number = Layer.require "cosy/formalism/literal.number"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { number },
          value = "lol",  
        },
      }

      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("forbids a different type (reference)", function ()
      local number = Layer.require "cosy/formalism/literal.number" 
			local string = Layer.require "cosy/formalism/literal.string"

			local refines = Layer.key.refines
			local wrong = Layer.new {
				name = "wrong",
				data = {
					[refines] = {string},
					value = "test",
				},			
			}

      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { number },
          value = wrong,  
        },
      }

      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)
	end)

end)
