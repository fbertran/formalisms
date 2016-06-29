return function (Layer, operator_operation,ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record =  Layer.require "cosy/formalism/data.record"
  local operator = Layer.require "cosy/formalism/operator"
  local collection =  Layer.require "cosy/formalism/data.collection"
 

  operator_operation [refines] = {operator}
  
  operator_operation [meta] = {

    operands_type = { value_type = ref },
    [record] = {
      operator = {
        value_type = "string",
      },
      priority = {
        value_type = "number"
      },
      pattern = {
        value_type = "function",
      },
      parser = {
        value_type = "function",
      },
      printer = {
        value_type = "function",
      },
      result = {
        value_type = false
      }
    }
  }

  
 
  
 

  operator_operation.operands = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].operands_type,
        minimum = false,
        maximum = false
      }
    },
  }
  operator_operation.priority = 0
  operator_operation.pattern = function() end
  operator_operation.parser = function() end
  operator_operation.printer = function() end

  return operator_operation

end