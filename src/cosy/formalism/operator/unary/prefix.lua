return function (Layer,prefix)

  local refines = Layer.key.refines
  local meta    = Layer.key.meta
  local lpeg    = require "lulpeg"

  local unary   = Layer.require "cosy/formalism/operator/unary"


  prefix [refines] = {
    unary,    
  }

  prefix [meta] .printer = function (root_expression)
  --use parenthesis if an operation has 1 one operands  
   local tmp 
   tmp = tostring(root_expression.operator)
   tmp = tmp..root_expression.operands [1] [meta] .printer(root_expression .operands [1])
   return tmp
  end
  
  prefix [meta] .parser = function (ref, exp0)
    local ignored_characters
    local pattern
    
    if #ref .ignored_characters >0 then
      ignored_characters = lpeg.P (ref .ignored_characters [1])
      for i=2,#ref .ignored_characters do
        ignored_characters = ignored_characters + lpeg.P (ref .ignored_characters [i])
      end

      pattern = lpeg.P(lpeg.P(ref .operator) * lpeg.P(ignored_characters)^0 * exp0)
    else
      pattern = lpeg.P(lpeg.P(ref .operator) * exp0)
    end
    
    pattern = pattern/function (right, right_trace)
      local layer = Layer.new {}
     
      local trace = ref.operator ..right_trace

      layer [refines] = { ref }
      layer .operands [1] = right

      assert(layer [meta] .operands_type <= right, "wrong type in:")
      return layer,trace
    end   
    return pattern
  end
  

end