--Operation

return function (Layer, operation)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local value_string = Layer.require "cosy/formalism/literal.string"

  operation [refines] = {record,}

  operation[meta] = {
    [record] = {
      operator = {
        value_type = value_string,
      },
    
      }
    }
     operation.operands = {
      [refines] = {
          collection,
          }
      }
  
     operation.operands [meta] = {
          [collection] = {
            value_type=false,
          }
        }
    
       
  
  return operation
end
