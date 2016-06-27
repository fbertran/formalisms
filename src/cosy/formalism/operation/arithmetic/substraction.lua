--Substraction Operation

return function (Layer, substraction_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  substraction_operation [refines] = {
    arithmetic_operation,
  }

  substraction_operation.operands [meta][collection].minimum = 2
  substraction_operation.operands [meta][collection].maximum = 2
  substraction_operation [meta][record].priority = 12
  substraction_operation [meta][record].operator = "-"
  substraction_operation.pattern = function ()
      local pattern = lpeg.C {lpeg.P ( substraction_operation [meta][record].operator ) /function ()
        --print("substraction")
        local layer = Layer.new {}
        layer [refines] = { substraction_operation }
        substraction_operation [meta][record].result = layer
        end }
      return pattern
   end
  return substraction_operation
end

