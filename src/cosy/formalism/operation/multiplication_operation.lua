--Multiplication Operation

return function (Layer, multiplication_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local arithmetic_operation  = Layer.require "cosy/formalism/arithmetic_operation"

  multiplication_operation = {
    [refines] = {arithmetic_operation},
  }

  multiplication_operation[meta][collection].minimum=2
  multiplication_operation[meta][collection].maximum=math.huge
  multiplication_operation[meta][collection].operator="*"

  return multiplication_operation
end
