--These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.identifier", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal.identifier"
  end)

  describe ("with type information", function ()

    it ("forbids a different type (primitive)", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { identifier }
      layer .value    = 42
      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("forbids a different type (proxy)", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { identifier }
      layer .value    = Layer.new {}

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("using good type", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { identifier }
      layer .value    = "x1"
      
      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)
  end)

  describe ("with format check", function ()

    it ("using good identifier", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { identifier }
      layer .value    = "x1"

      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)

    it ("forbids a number at the begining", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { identifier }
      layer .value    = "1x"

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)

    it ("forbids a special char at the begining", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines = Layer.key.refines    
      local layer   = Layer.new {}
      
      layer [refines] = { identifier }
      layer .value    = "_x"

      Layer.Proxy.check_all (layer)
      assert.is_not_nil (next (Layer.messages))
    end)
  end)

  describe ("test function get_id", function ()

    it ("find the identifier", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines     = Layer.key.refines  
      local meta        = Layer.key.meta 
      local collection  = Layer.require "cosy/formalism/data.collection"

      local layer       = Layer.new {}
      local id1         = Layer.new {}
      local id2         = Layer.new {}

      id1 [refines] = {identifier}
      id2 [refines] = {identifier}

      id1 .value = "id1"
      id2 .value = "id2"

      layer [refines] = { collection }

      layer .id1    = id1
      layer .id2    = id2

      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))

      assert.is_true(id2 == identifier [meta] .get_id (layer, "id2"), "Identifier id2 not found in layer")
    end)

    it ("Don't find the id if it's not an identifier", function ()
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local refines     = Layer.key.refines  
      local meta        = Layer.key.meta 
      local collection  = Layer.require "cosy/formalism/data.collection"

      local layer       = Layer.new {}
      local id1         = Layer.new {}
      local id2         = Layer.new {}

      id1 [refines] = {identifier}

      id1 .value = "id1"
      id2 .value = "id2"

      layer [refines] = { collection }

      layer .id1    = id1
      layer .id2    = id2

      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))

      assert.is_nil(identifier [meta] .get_id (layer, "id2"))
    end)

    it ("Dont find the identifier", function ()
      local refines     = Layer.key.refines  
      local meta        = Layer.key.meta 
      local identifier  = Layer.require "cosy/formalism/literal.identifier"  
      local collection  = Layer.require "cosy/formalism/data.collection"

      local layer       = Layer.new {}
      local id1         = Layer.new {}
      local id2         = Layer.new {}

      id1 [refines] = {identifier}
      id2 [refines] = {identifier}

      id1 .value = "id1"
      id2 .value = "id2"

      layer [refines] = { collection }

      layer .id1    = id1
      layer .id2    = id2

      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))

      assert.is_nil(identifier [meta] .get_id(layer, "id3"), "Identifier id3 not suposed to be found in layer")
    end)
  end)
end)
