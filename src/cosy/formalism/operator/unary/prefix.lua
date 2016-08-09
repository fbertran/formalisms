return function (Layer,prefix)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local lpeg = require "lulpeg"

  local unary = Layer.require "cosy/formalism/operator/unary"


  prefix [refines] = {
    unary,    
  }

  prefix [meta].printer = function (root_expression)
  --use parenthesis if an operation has 1 one operands 
 
   io.write(root_expression.operator)
   root_expression.operands [1][meta].printer(root_expression.operands [1])
  end
  
  prefix [meta].parser = function (ref,exp0)
     local ignored_character = ""

    if #ref [meta].ignored_character >0 then
      ignored_character = lpeg.P (ref [meta].ignored_character[1])
    end
    for i=2,#ref [meta].ignored_character do
        ignored_character = ignored_character + lpeg.P (ref [meta].ignored_character[i])
    end
    local pattern
    if #ref [meta].ignored_character > 0 then
      pattern =  lpeg.P(lpeg.P(ref.operator) * lpeg.P(ignored_character)^0 * exp0)
    else
      pattern = lpeg.P(lpeg.P(ref.operator) * exp0)
    end
    
    print("ayylmao")
    pattern = pattern/function (patt,right,right_trace)
      local layer= Layer.new {}
      local trace = patt..right_trace
      layer [refines] = {ref}
      layer.operands = {right}
      assert(layer [meta].operands_type <= right,"wrong type in:")
      layer [meta].printer(layer)
      return layer,trace
    end
 
   
   return pattern
  end
  return prefix
end