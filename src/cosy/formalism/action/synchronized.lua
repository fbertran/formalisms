-- Synchronized

return function (Layer, synchronized,ref)

  local meta      =  Layer.key.meta
  local refines   =  Layer.key.refines
  local action  =  Layer.require "cosy/formalism/action"
  local string    =  Layer.require "cosy/formalism/literal.string"
  local record    =  Layer.require "cosy/formalism/data.record"
	local collection = Layer.require "cosy/formalism/data.collection"  
  synchronized [refines] = {
    action,
  }


	synchronized.types = {
		[refines] = {collection},
		
		send={
			[refines] = {string},
			value = "send",
		},	
		recv={
			[refines] = {string},
			value = "recv",
		},	
	}

 synchronized [meta] = {
      [record] = {
        type = {
					value_container = ref.types,
        },
    },
  }

	
	
	


  return synchronized

end
