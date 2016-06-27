--Inferior Operation

return function (Layer, inferior_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"

  local relational_operation  = Layer.require "cosy/formalism/operation/relational"

  inferior_operation [refines] = {
    relational_operation,
  }

  inferior_operation.operands [meta][collection].minimum = 2
  inferior_operation.operands [meta][collection].maximum = 2
  inferior_operation [meta][record].operator = "<"
  inferior_operation [meta][record].priority = 10
  inferior_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( inferior_operation [meta][record].operator )/function ()
        
        local layer = Layer.new {}
        layer [refines] = { inferior_operation }
        inferior_operation [meta][record].result = layer
        end }
    return pattern
  end
  return inferior_operation
end
