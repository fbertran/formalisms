--Multiplication Operation

return function (Layer, multiplication_operation)

  local lpeg = require "lpeg"
  
  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local operator  = Layer.require "cosy/formalism/operator"

  multiplication_operation [refines] = {
    operator,
  }

  multiplication_operation.operands [meta][collection].minimum = 2
  multiplication_operation.operands [meta][collection].maximum = math.huge
  multiplication_operation [meta][record].operator = "*"
  multiplication_operation [meta][record].priority = 13
  multiplication_operation [meta][record].pattern = function ()
      local pattern = lpeg.C { lpeg.P ( multiplication_operation [meta][record].operator )/function ()
        --print("multiplication")
        local layer = Layer.new {}
        layer [refines] = { multiplication_operation }
        multiplication_operation [meta][record].result = layer
        end }
      return pattern
   end

  return multiplication_operation
end

