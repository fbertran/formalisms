--NOT Operation

return function (Layer, not_operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  
  local boolean_operation  = Layer.require "cosy/formalism/operation/boolean"

  not_operation [refines] = {
    boolean_operation,
  }

  not_operation.operands [meta][collection].minimum = 1
  not_operation.operands [meta][collection].maximum = 1
  not_operation [meta][record].operator = "~"
  not_operation [meta][record].priority = 14
  not_operation [meta][record].pattern = function ()
    local pattern = lpeg.C { lpeg.P ( not_operation [meta][record].operator )/function ()
        --print("not")
        local layer = Layer.new {}
        layer [refines] = { not_operation }
        not_operation.result = layer
        end }
    return pattern
  end
  not_operation.printer = function (root_expression)
    
    local operation  = Layer.require "cosy/formalism/operation"
    io.write(root_expression[meta][record].operator .. "(")
    if operation < root_expression.operands [1] then
      root_expression.operands [1][meta][record].printer(root_expression.operands [1])
    else
      io.write(root_expression.operands [1].value)
    end
    io.write(")")
  end
  return not_operation
end
