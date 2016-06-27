--Logical Operation

return function (Layer, logical_operation)

  local lpeg = require "lpeg"

  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"

  local boolean_operation  = Layer.require "cosy/formalism/operation/boolean"
  


  logical_operation [refines] = {
      boolean_operation,
    }

  logical_operation [meta].operands_type = boolean_operation
  logical_operation.pattern = function ()

    local and_operation = Layer.require "cosy/formalism/operation/logical.and"

    local or_operation = Layer.require "cosy/formalism/operation/logical.or"

    local nor_operation = Layer.require "cosy/formalism/operation/logical.nor"

    local xor_operation = Layer.require "cosy/formalism/operation/logical.xor"

    local pattern = lpeg.C { ( and_operation [meta][record].pattern() / function() logical_operation [meta][record].result = and_operation [meta][record].result end ) + ( or_operation [meta][record].pattern() / function() logical_operation [meta][record].result = or_operation [meta][record].result end ) + ( nor_operation [meta][record].pattern() / function() logical_operation [meta][record].result = nor_operation [meta][record].result end ) + ( xor_operation [meta][record].pattern() / function() logical_operation [meta][record].result = xor_operation [meta][record].result end ) }

    return pattern
  end

  return logical_operation
end
