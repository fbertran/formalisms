--InferiorEqual Operation

return function (Layer, inferiorequal_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  local relational_operation  = Layer.require "cosy/formalism/operation/relational"

  inferiorequal_operation [refines] = {
    relational_operation,
  }

  inferiorequal_operation.operands [meta][collection].minimum = 2
  inferiorequal_operation.operands [meta][collection].maximum = 2
  inferiorequal_operation [meta][record].operator = "<="
  inferiorequal_operation [meta][record].priority = 10
  inferiorequal_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( inferiorequal_operation [meta][record].operator )/function ()
        --print("inferiorequal")
        local layer = Layer.new {}
        layer [refines] = { inferiorequal_operation }
        inferiorequal_operation.result = layer
        end }
    return pattern
  end
  return inferiorequal_operation
end
