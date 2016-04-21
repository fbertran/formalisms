--Expression

return function (Layer, expression)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local collection =  Layer.require "cosy/formalism/data.collection"
  local operation  =  Layer.require "cosy/formalism/operation"


  expression[refines] = {
    collection
}
  expression [meta] = {
    [collection] = {
      value_type=operation
  }
}


  return expression
end
