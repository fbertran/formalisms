--These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()
----

local Layer = require "cosy.formalism.layer"

describe ("Formalism action.synchronized", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/action.synchronized"
  end)

  describe ("with type information", function ()

    it ("using a reference to ref[meta].types (send)", function ()
			local meta			= Layer.key.meta    
			local synchro 	= Layer.require "cosy/formalism/action.synchronized"	
			local layer,ref	= Layer.new {}
      
      layer [Layer.key.refines] = { synchro }
		
    	layer.id   = "Signal"
			layer.type = ref[meta].types.send
      
      Layer.Proxy.check_all (layer)
      assert.is_nil ( next ( Layer.messages) )
    end)

    it ("using a reference to ref[meta].types (recv)", function ()
			local meta			= Layer.key.meta    
			local synchro 	= Layer.require "cosy/formalism/action.synchronized"	
			local layer,ref	= Layer.new {}

      layer [Layer.key.refines] = { synchro }
		
			layer.id = "Signal"
			layer.type 		= ref[meta].types.recv
      Layer.Proxy.check_all (layer)
      assert.is_nil (next ( Layer.messages) )
    end)

		it ("using a wrong type (primitive)", function ()
			local synchro 	= Layer.require "cosy/formalism/action.synchronized"
			local layer			= Layer.new {}

      layer [Layer.key.refines] = { synchro }
	
			layer.id 	= "Signal"
			layer.type = 42
      Layer.Proxy.check_all(layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    end)

		it ("using a wrong type (reference)", function ()
			local synchro 	= Layer.require "cosy/formalism/action.synchronized"	 
			local string 		= Layer.require "cosy/formalism/literal.string"      
			local layer			= Layer.new {}

      layer [Layer.key.refines] = { synchro }

			layer.id 	= "Signal"

			local wrong_ref = Layer.new{}
			wrong_ref[Layer.key.refines] = {string}
			wrong_ref.value = "send"

			layer.type = wrong_ref

      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ) )
    end)
	end)
end)
