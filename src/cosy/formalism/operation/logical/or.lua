--Or Operation

return function (Layer, or_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  local logical_operation  = Layer.require "cosy/formalism/operation/logical"

  or_operation [refines] = {
    logical_operation,
  }

  or_operation.operands [meta][collection].minimum = 2
  or_operation.operands [meta][collection].maximum = math.huge
  or_operation [meta][record].operator = "||"
  or_operation [meta][record].priority = 5
  or_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( or_operation [meta][record].operator )/function ()
        --print("or")
        local layer = Layer.new {}
        layer [refines] = { or_operation }
        or_operation [meta][record].result = layer
        end }
    return pattern
  end
  return or_operation
end
