return function (Layer, operator,ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
 

  operator [refines] = {record}
  operator [meta] = {

    operands_type = { value_type = false },
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

  
 
  
 

  operator.operands = {
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
  operator [meta][record].priority = 0
  operator [meta][record].pattern = function() end
  operator [meta][record].parser = function() end
  operator [meta][record].printer = function() end

  return operator

end