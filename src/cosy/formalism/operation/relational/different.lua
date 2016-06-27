--Different Operation

return function (Layer, different_operation)
  
  local lpeg = require "lpeg"
  
  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local relational_operation  = Layer.require "cosy/formalism/operation/relational"

  different_operation [refines] = {
  relational_operation,
  }

  different_operation.operands [meta][collection].minimum = 2
  different_operation.operands [meta][collection].maximum = 2
  different_operation [meta][record].operator = "~="
  different_operation [meta][record].priority = 9
  different_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( different_operation [meta][record].operator )/function ()
        --print("different")
        local layer = Layer.new {}
        layer [refines] = { different_operation }
        different_operation [meta][record].result = layer
        end }
    return pattern
  end
  return different_operation
end
