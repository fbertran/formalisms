--Equal Operation

return function (Layer, equal_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  local relational_operation  = Layer.require "cosy/formalism/operation/relational"

  equal_operation [refines] = {
    relational_operation,
  }

  equal_operation.operands [meta][collection].minimum = 2
  equal_operation.operands [meta][collection].maximum = 2
  equal_operation [meta][record].operator = "=="
  equal_operation [meta][record].priority = 9
  equal_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( equal_operation [meta][record].operator )/function ()
        --print("equal")
        local layer = Layer.new {}
        layer [refines] = { equal_operation }
        equal_operation [meta][record].result = layer
        end }
    return pattern
  end
  return equal_operation
end
