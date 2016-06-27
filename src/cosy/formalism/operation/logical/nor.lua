--NOR Operation

return function (Layer, nor_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  local logical_operation  = Layer.require "cosy/formalism/operation/logical"

  nor_operation [refines] = {
    logical_operation,
  }

  nor_operation.operands [meta][collection].minimum = 1
  nor_operation.operands [meta][collection].maximum = 1
  nor_operation [meta][record].operator = "NOR"
  nor_operation [meta][record].priority = 5
  nor_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( nor_operation [meta][record].operator )/function ()
        --print("nor")
        local layer = Layer.new {}
        layer [refines] = { nor_operation }
        nor_operation [meta][record].result = layer
        end }
    return pattern
  end
  return nor_operation
end
