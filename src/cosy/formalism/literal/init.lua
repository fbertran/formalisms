-- literal

return function (Layer, literal)

  local refines =  Layer.key.refines
  local meta    = Layer.key.meta
  local operation  =  Layer.require "cosy/formalism/operation"


  literal [refines] = {
    operation
  }
  literal.priority = math.huge

  literal[meta].printer = function(instance)
    io.write(instance.value)
  end
  
  return literal
end
