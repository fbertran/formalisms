if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism literal.identifier", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.identifier"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local record = Layer.require "cosy/formalism/data.record"
      local identifier = Layer.require "cosy/formalism/literal.identifier"  
      local layer      = Layer.new {}

      layer [Layer.key.refines] = { identifier }
      layer [Layer.key.meta] = {
              [record]={
                value={
                  value_type="number"
                },
              }
            }
      layer.value = "test"  
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    end)

    it ("allows good type", function ()
      local record = Layer.require "cosy/formalism/data.record"
      local identifier = Layer.require "cosy/formalism/literal.identifier"  
      local layer      = Layer.new {}

      layer [Layer.key.refines] = { identifier }
      layer [Layer.key.meta] = {
              [record]={
                value={
                  value_type="number"
                },
              }
            }
      layer.value = 42  
      Layer.Proxy.check_all (layer)
      assert.is_nil ( next ( Layer.messages ) )
    end)
	end)

end)
