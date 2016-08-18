return function (Layer,suffix)

  local refines = Layer.key.refines
  local meta    = Layer.key.meta
  local lpeg    = require "lulpeg"
  local unary   = Layer.require "cosy/formalism/operator/unary"

  suffix [refines] = {
    unary,    
  }

  suffix .count_id = 0

  suffix [meta] .parser = function (reference, exp0)
    local ignored_characters
    local pattern, layer


    if #reference .ignored_characters >0 then
      ignored_characters = lpeg.P (reference .ignored_characters [1])
      for i=2,#reference .ignored_characters do
        ignored_characters = ignored_characters + lpeg.P (reference .ignored_characters [i])
      end

      pattern = lpeg.P(exp0 * lpeg.P(ignored_characters)^0 * lpeg.C(reference .operator))
    else
      pattern = lpeg.P(exp0 * lpeg.C(reference .operator))
    end


    pattern = pattern/function(left, left_trace, patt)

      layer  = Layer.new { name = "inc_"..reference.count_id }
      reference.count_id = reference .count_id + 1

      layer [refines] = { reference }
      layer .operands [1] = left

      assert(layer [meta] .operands_type <= left,"wrong type in:")

      return layer, left_trace..patt
    end

    return pattern  
  end

  suffix [meta] .printer = function (root_expression)
  --use parenthesis if an operation has 1 one operands 
    local tmp
    tmp = root_expression.operands [1][meta] .printer(root_expression.operands [1])
    tmp = tmp..tostring(root_expression.operator)
    return tmp

  end

end