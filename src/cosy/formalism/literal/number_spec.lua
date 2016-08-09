--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.number", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.number"
  end)

  describe ("with type information", function ()

    it ("forbids a different type (primitive)", function ()
      local number  = Layer.require "cosy/formalism/literal.number"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { number }
      layer .value    = "lol"

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("forbids a different type (proxy)", function ()
      local number  = Layer.require "cosy/formalism/literal.number"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { number }
      layer .value    = Layer.new {}

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("using good type", function ()
      local number  = Layer.require "cosy/formalism/literal.number"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { number }
      layer .value    = 42
      
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)

	end)
end)
