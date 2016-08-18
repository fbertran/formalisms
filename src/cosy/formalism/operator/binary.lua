--
return function (Layer,binary)

  local lpeg        = require "lulpeg"
  local refines     = Layer.key.refines
  local meta        = Layer.key.meta
  local collection  = Layer.require "cosy/formalism/data.collection"
  local record       = Layer.require "cosy/formalism/data.record"
  local operator    = Layer.require "cosy/formalism/operator"


  binary [refines] = {
    operator,    
  }

  binary .operands [meta] [collection] .minimum = 2
  binary .operands [meta] [collection] .maximum = 2
  binary [meta] [record] .operator .optional = false
  binary [meta] [record] .priority .optional = false

--  binary [meta] .parser = function(ref, exp1, exp2)
  binary [meta] .parser = function(ref, exp1, exp2)
    local tmp_ignored_characters
    local pattern

    if #ref .ignored_characters >0 then
      tmp_ignored_characters = lpeg.P (ref .ignored_characters [1])
      for i=2,#ref .ignored_characters do
        tmp_ignored_characters = tmp_ignored_characters + lpeg.P (ref .ignored_characters [i])
      end

     pattern = lpeg.P(exp1 * lpeg.P(tmp_ignored_characters)^0 * lpeg.C(ref .operator) * lpeg.P(tmp_ignored_characters)^0 * exp2)
    else
      pattern = lpeg.P(exp1 * lpeg.C(ref .operator) * exp2)
    end

    pattern = pattern/function(left, left_trace, patt, right, right_trace)
      local layer = Layer.new {}
      local trace = left_trace..patt..right_trace

      layer [refines] = { ref }
      
      layer .operands [1]  = left
      layer .operands [2]  = right
    

      assert(layer [meta].operands_type  and layer [meta].operands_type < left ,"wrong type in left operand")

      assert(layer [meta].operands_type and layer [meta].operands_type < right ,"wrong type in right operand")

      return layer,trace
    end  
    return pattern
  end

  binary [meta] .printer = function (root_expression)
    local tmp 
    tmp = root_expression .operands [1] [meta] .printer(root_expression.operands [1])
    tmp = tmp..tostring(root_expression.operator)
    tmp = tmp..root_expression.operands [2] [meta] .printer(root_expression.operands [2])
    return tmp
  end
  
end
