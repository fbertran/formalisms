--Superior Operation

return function (Layer, superior_operation)

  local lpeg = require "lpeg"
  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local relational_operation  = Layer.require "cosy/formalism/operation/relational"

  superior_operation [refines] = {
    relational_operation,
  }

  superior_operation.operands[meta][collection].minimum = 2
  superior_operation.operands[meta][collection].maximum = 2
  superior_operation[meta][record].operator = ">"
  superior_operation [meta][record].priority = 10
  superior_operation [meta][record].pattern = function ()
    local pattern = lpeg.C {lpeg.P(superior_operation [meta][record].operator)/function ()
        --print("superior")
        local layer = Layer.new{}
        layer [refines] = {superior_operation}
        superior_operation [meta][record].result = layer
        end }
    return pattern
  end
  return superior_operation
end
