--Addition Operation

return function (Layer, and_operation)

  local lpeg = require "lpeg" 

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"
  local record =  Layer.require "cosy/formalism/data.record"

  local logical_operation  = Layer.require "cosy/formalism/operation/logical"

  and_operation [refines] = {logical_operation}
  

  and_operation.operands [meta][collection].minimum = 2
  and_operation.operands [meta][collection].maximum = math.huge
  and_operation [meta][record].operator = "&&"
  and_operation [meta][record].priority = 6
  and_operation [meta][record].pattern = function ()
      local pattern = lpeg.C {lpeg.P ( and_operation [meta][record].operator )/function ()
         -- print("and")
          local layer = Layer.new {}
          layer [refines] = { and_operation }
          and_operation [meta][record].result = layer
          end }
      return pattern
   end
  return and_operation
end
