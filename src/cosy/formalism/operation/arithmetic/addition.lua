--Addition Operation

return function (Layer, addition_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection =  Layer.require "cosy/formalism/data.collection"
  local record     =  Layer.require "cosy/formalism/data.record"

  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic"

  addition_operation [refines] = {
     arithmetic_operation,
  }

  addition_operation.operands[meta][collection].minimum = 2
  addition_operation.operands[meta][collection].maximum = math.huge
  addition_operation[meta][record].operator = "+"
  addition_operation [meta][record].priority = 12
  addition_operation.pattern = function ()
      local pattern = lpeg.C { lpeg.P ( addition_operation [meta][record].operator )/function ()
        --print("addition")
        local layer = Layer.new {}
        layer [refines] = { addition_operation }
        addition_operation [meta][record].result = layer
        end }
      return pattern
   end
  
  return addition_operation
end
