--Division Operation

return function (Layer, division_operation, ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record     =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local arithmetic_operation  = Layer.require "cosy/formalism/arithmetic_operation"

  division_operation = {
    [refines] = {arithmetic_operation},
  }

  division_operation[meta][collection].minimum=2
  division_operation[meta][collection].maximum=2 -- pas sûr
  division_operation[meta][collection].operator="/"

  return division_operation
end
