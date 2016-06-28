return function (Layer, assignment_operation)

  local lpeg = require "lpeg"

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local operation = Layer.require "cosy/formalism/operation"
  
  local record = Layer.require "cosy/formalism/data.record"
  local collection = Layer.require "cosy/formalism/data.collection" 

  assignment_operation [refines] = {
    operation,
  }

  assignment_operation.operands[meta][collection].minimum = 2
  assignment_operation.operands[meta][collection].maximum = 2
  assignment_operation[meta][record].operator = "="
  assignment_operation [meta][record].priority = 0 --need to be changed
  assignment_operation.pattern = function ()
      local pattern = lpeg.C { lpeg.P ( assignment_operation [meta][record].operator )/function ()
        --print("addition")
        local layer = Layer.new {}
        layer [refines] = { assignment_operation }
        assignment_operation [meta][record].result = layer
        end }
      return pattern
   end

  return assignment_operation
end