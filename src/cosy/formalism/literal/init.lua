-- literal

return function (Layer, literal)

  local refines =  Layer.key.refines
  local operation  =  Layer.require "cosy/formalism/operation"

  literal [refines] = {
    operation
  }

  literal .priority = math.huge
  
end
