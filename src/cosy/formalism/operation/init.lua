--Operation

return function (Layer, operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  operation [refines] = {record,}

  operation[meta] = {
		operands_type = false,
    [record] = {
      operator = {
        value_type = "string",
      },
    }
	}

	operation.operands = {
  	[refines] = {
      collection,
    },
		[meta] = {
			[collection] = {
        value_type = ref[meta].operands_type,
        minimum = false,
        maximum = false
      }
		},
  }
    
       
  
  return operation
end
