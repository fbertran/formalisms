--These lines are required to correctly run tests.
require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

describe ("Formalism literal.bool", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/action.synchronized"
  end)

  describe ("with type information", function ()

    it ("using the good type (send)", function ()
			local meta			= Layer.key.meta    
		  local synchro		= Layer.require "cosy/formalism/action.synchronized"
			local record		= Layer.require "cosy/formalism/data.record"
		 
     
			local layer			= Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { synchro },
					[meta]={
						[record]={ 
							value={value_type = "string"},
						},					
					},
								
          value = "A1",
					type  = {
						value = "send",
					},
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

	it ("using the good type (recv)", function ()
			local meta			= Layer.key.meta    
		  local synchro		= Layer.require "cosy/formalism/action.synchronized"
			local record		= Layer.require "cosy/formalism/data.record"
		 
     
			local layer			= Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { synchro },
					[meta]={
						[record]={ 
							value={value_type = "string"},
						},					
					},
								
          value = "A1",
					type  = {
						value = "recv",
					},
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

	it ("using a wrong type", function ()
			local meta			= Layer.key.meta    
		  local synchro		= Layer.require "cosy/formalism/action.synchronized"
			local record		= Layer.require "cosy/formalism/data.record"
		 
     
			local layer			= Layer.new {
        name = "layer",
        data = {
          [Layer.key.refines] = { synchro },
					[meta]={
						[record]={ 
							value={value_type = "string"},
						},					
					},
								
          value = "A1",
					type  = {
						value = "Blabla",
					},
        },
      }
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)
	end)

end)
