--These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.bool", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.bool"
  end)

  describe ("with type information", function ()

    it ("forbids a different type (primitive)", function ()
      local bool  = Layer.require "cosy/formalism/literal.bool"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { bool }
      layer .value    = 42
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("forbids a different type (proxy)", function ()
      local bool  = Layer.require "cosy/formalism/literal.bool"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { bool }
      layer .value    = Layer.new {}

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("using good type", function ()
      local bool  = Layer.require "cosy/formalism/literal.bool"  
      local refines = Layer.key.refines    
      local layer   = Layer.new { name ="target" }

      layer [refines] = { bool }

      layer .value    = false
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))

      layer .value    = true
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))

    end)

  end)
end)
