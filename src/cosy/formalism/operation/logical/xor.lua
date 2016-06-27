--XOR Operation

return function (Layer, xor_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local logical_operation  = Layer.require "cosy/formalism/operation/logical"

  xor_operation [refines] = {
    logical_operation,
  }

  xor_operation.operands [meta][collection].minimum = 2
  xor_operation.operands [meta][collection].maximum = math.huge
  xor_operation [meta][record].operator = "XOR"
  xor_operation [meta][record].priority = 7
  xor_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( xor_operation [meta][record].operator )/function ()
        --print("xor")
        local layer = Layer.new {}
        layer [refines] = {xor_operation}
        xor_operation [meta][record].result = layer
        end }
    return pattern
  end
  return xor_operation
end
