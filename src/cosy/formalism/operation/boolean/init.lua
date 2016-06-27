--Boolean Operation

return function (Layer, boolean_operation)
  
  local lpeg = require "lpeg"

  local refines    =  Layer.key.refines
  local meta = Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"
  
  local operation  = Layer.require "cosy/formalism/operation"

  boolean_operation [refines] = {
    operation,
  }

  boolean_operation [meta].operands_type = boolean_operation
  boolean_operation [meta][record] .pattern = function (instance)


   
    local not_operation = Layer.require "cosy/formalism/operation/boolean.not"

    local relational_operation = Layer.require "cosy/formalism/operation/relational"

    local logical_operation = Layer.require "cosy/formalism/operation/logical"

    local literal = Layer.require "cosy/formalism/literal"

    local pattern = lpeg.C { (literal [meta][record].pattern(instance)/function() boolean_operation [meta][record].result = literal [meta][record].result end) + (not_operation [meta][record].pattern()/function() boolean_operation [meta][record].result = not_operation [meta][record].result end) + (relational_operation [meta][record].pattern()/function() boolean_operation [meta][record].result = relational_operation [meta][record].result end) + (logical_operation [meta][record].pattern()/function() boolean_operation [meta][record].result = logical_operation [meta][record].result end)}

    return pattern


  end

  return boolean_operation
end
