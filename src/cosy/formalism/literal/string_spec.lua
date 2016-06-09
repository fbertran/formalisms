-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism literal.string", function ()

  it ("can be loaded", function ()
    
    local _ = Layer.require "cosy/formalism/literal.string"
  
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      
      local string = Layer.require "cosy/formalism/literal.string"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { string }
      layer.value = "test"  
      Layer.Proxy.check_all (layer)
      assert.is_nil ( next ( Layer.messages ) )
    end)

    it ("forbids a different value (number) ", function ()
    
      local string = Layer.require "cosy/formalism/literal.string"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { string }
      layer.value = 42
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    
    end)

     it ("forbids a different value (boolean) ", function ()
    
      local string = Layer.require "cosy/formalism/literal.string"
      local layer      = Layer.new {}
      layer [Layer.key.refines] = { string }
      layer.value = true  
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    
    end)

	end)

end)
