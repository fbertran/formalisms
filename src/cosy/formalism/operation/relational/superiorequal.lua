--SuperiorEqual Operation

return function (Layer, superiorequal_operation)

  local lpeg = require "lpeg"
  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/operation/relational"

  superiorequal_operation [refines] = {
    relational_operation,
  }

  superiorequal_operation.operands[meta][collection].minimum = 2
  superiorequal_operation.operands[meta][collection].maximum = 2
  superiorequal_operation[meta][record].operator = ">="
  superiorequal_operation [meta][record].priority = 10
  superiorequal_operation [meta][record].pattern = function ()
    local pattern = lpeg.C {lpeg.P(superiorequal_operation [meta][record].operator)/function ()
        --print("superiorequal")
        local layer = Layer.new{}
        layer [refines] = {superiorequal_operation}
        superiorequal_operation [meta][record].result = layer
        end }
    return pattern
  end
  
  return superiorequal_operation
end
