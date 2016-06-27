--Relational Operation

return function (Layer, relational_operation)

  local lpeg = require "lpeg"

  local refines    =  Layer.key.refines
  local meta    =  Layer.key.meta

  local record = Layer.require "cosy/formalism/data.record"

  local boolean_operation  = Layer.require "cosy/formalism/operation/boolean"
  local operands_relational_type = Layer.require "cosy/formalism/operation/relational.operands_type"

  relational_operation [refines] = {
    boolean_operation,
  }

  relational_operation [meta].operands_type = operands_relational_type
  relational_operation [meta][record].pattern = function ()
    local different_operation = Layer.require "cosy/formalism/operation/relational.different"
    local equal_operation = Layer.require "cosy/formalism/operation/relational.equal"
    local inferiorequal_operation = Layer.require "cosy/formalism/operation/relational.inferiorequal"
    local inferior_operation = Layer.require "cosy/formalism/operation/relational.inferior"
    local superiorequal_operation = Layer.require "cosy/formalism/operation/relational.superiorequal"
    local superior_operation = Layer.require "cosy/formalism/operation/relational.superior"
    local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"
    local pattern = lpeg.C { ( different_operation [meta][record].pattern() / function() relational_operation [meta][record].result = different_operation [meta][record].result end ) + ( equal_operation [meta][record].pattern() / function() relational_operation [meta][record].result = equal_operation [meta][record].result end ) + ( inferiorequal_operation [meta][record].pattern() / function() relational_operation [meta][record].result = inferiorequal_operation [meta][record].result end ) + ( superiorequal_operation [meta][record].pattern() / function() relational_operation [meta][record].result = superiorequal_operation [meta][record].result end ) + ( inferior_operation [meta][record].pattern() / function() relational_operation [meta][record].result = inferior_operation [meta][record].result end ) + ( superior_operation [meta][record].pattern() / function() relational_operation [meta][record].result = superior_operation [meta][record].result end ) + ( arithmetic_operation [meta][record].pattern() / function() relational_operation [meta][record].result = arithmetic_operation [meta][record].result end ) }

    return pattern
  end

  return relational_operation
end
