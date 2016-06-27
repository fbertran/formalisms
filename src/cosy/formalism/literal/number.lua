-- number

return function (Layer, number)
  
  local lpeg = require "lpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/literal"
  local operands_arithmetic_type = Layer.require "cosy/formalism/operation/arithmetic.operands_type"
  local operands_relational_type = Layer.require "cosy/formalism/operation/relational.operands_type"

  number [refines] = {
    literal,
    operands_arithmetic_type,
    operands_relational_type,
  }
  number [meta] = {
    [record] = {
      value = { value_type = "number" },
    },
  }
   number.pattern = function ()
      --print ("ici"..addition_operation [meta][record].operator)
      local pattern = lpeg.C {(lpeg.R "09"^1)/function (patt)
          --print("number")
          local layer = Layer.new {}
          layer [refines] = {number}
            layer.value = tonumber(patt)
            number.result = layer
        end }
      return pattern
   end

  return number
end
