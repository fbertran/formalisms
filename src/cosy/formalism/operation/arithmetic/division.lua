--Division Operation

return function (Layer, division_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  division_operation [refines] = { 
    arithmetic_operation,
  }

  division_operation.operands [meta][collection].minimum = 2
  division_operation.operands [meta][collection].maximum = 2 
  division_operation [meta][record].operator = "/"
  division_operation [meta][record].priority = 13
  division_operation [meta][record].pattern = function ()
      local pattern = lpeg.C { lpeg.P ( division_operation [meta][record].operator )/function ()
        --print("division")
        local layer = Layer.new {}
        layer [refines] = { division_operation }
        division_operation [meta][record].result = layer
        end }
      return pattern
   end

  return division_operation
end

