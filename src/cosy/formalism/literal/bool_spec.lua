if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "layeredata"

describe ("Formalism literal.bool", function ()

  it ("can be loaded", function ()
 
    local _ = Layer.require "cosy/formalism/literal.bool"
 
  end)

  describe ("with type information", function ()

    it ("forbids a different type (number)", function ()
 
      local bool = Layer.require "cosy/formalism/literal.bool"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { bool },
          value = 42,  
        },
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    
    end)

    it ("forbids a different type (string)", function ()
      local bool = Layer.require "cosy/formalism/literal.bool"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { bool },
          value = "test",  
        },
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    
    end)

    it ("forbids a different type (formalism)", function ()
      
      local bool 		= Layer.require "cosy/formalism/literal.bool" 
      local string	= Layer.require "cosy/formalism/literal.string" 
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { bool },
          value = {
          [Layer.key.refines] = { string }						
          },  
        },
      }
      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    
    end)


    it ("uses the good type", function ()
      
      local bool = Layer.require "cosy/formalism/literal.bool"  
      local layer      = Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { bool },
          value = true,  
        },
      }
      Layer.Proxy.check_all (layer)
      assert.is_nil ( next ( Layer.messages ) )
    
    end)

  end)

end) 
