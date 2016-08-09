--Relational Operation

return function (Layer, relational_operation)

  local refines    =  Layer.key.refines
  local operation  = Layer.require "cosy/formalism/operation"
  
  relational_operation [refines] = {
    operation,
  }

 --[[ 
  
  local different_operation = Layer.require "cosy/formalism/operator/relational.different"
  local equal_operation = Layer.require "cosy/formalism/operator/relational.equal"
  local inferior_operation = Layer.require "cosy/formalism/operator/relational.inferior"
  local inferiorequal_operation = Layer.require "cosy/formalism/operator/relational.inferiorequal"
  local superior_operation = Layer.require "cosy/formalism/operator/relational.superior"
  local superiorequal_operation = Layer.require "cosy/formalism/operator/relational.superiorequal"
  
  relational_operation [meta].operators = { 
    [different_operation]     = different_operation,
    [equal_operation]         = equal_operation,
    [inferior_operation]      = inferior_operation,
    [inferiorequal_operation] = inferiorequal_operation,
    [superior_operation]      = superior_operation,
    [superiorequal_operation] = superiorequal_operation
  }]]

  return relational_operation
end
