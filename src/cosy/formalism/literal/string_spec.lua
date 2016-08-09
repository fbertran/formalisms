--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.string", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.string"
  end)

  describe ("with type information", function ()

    it ("forbids a different type (primitive)", function ()
      local string  = Layer.require "cosy/formalism/literal.string"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { string }
      layer .value    = 42

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("forbids a different type (proxy)", function ()
      local string  = Layer.require "cosy/formalism/literal.string"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { string }
      layer .value    = Layer.new {}

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("using good type", function ()
      local string  = Layer.require "cosy/formalism/literal.string"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { string }
      layer .value    = "ok"
      
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)

  end)
end)
