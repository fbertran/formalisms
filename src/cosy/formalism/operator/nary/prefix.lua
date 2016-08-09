return function (Layer,prefix)

  local refines = Layer.key.refines
  local meta = Layer.key.meta
  
  local lpeg = require "lulpeg"

  local nary = Layer.require "cosy/formalism/operator/nary"


  prefix [refines] = {
    nary,    
  }  

  prefix [meta].parser = function(ref,exp0)
    
    local pattern = ((lpeg.C(ref.operator) * lpeg.P "(" * exp0 * lpeg.P(lpeg.P "," * exp0)^0) * lpeg.P ")")/function(...)
      local tab = {...}
      local trace = ""
      local layer = Layer.new {}
      layer [refines] = {ref}
      trace = trace..tab[1]
      for i=2, #tab do
        if i%2 ==0 then
          layer.operands[#layer.operands+1] = tab[i]
        else
          trace = trace.. tab[i]
        end
      end
      return layer,trace
    end
     
    return pattern
  end
  prefix [meta].printer = function (root_expression)
  --use parenthesis if an operation has 1 one operands 
 
   io.write(root_expression.operator.."(")
   root_expression.operands[1][meta].printer(root_expression.operands[1])
   for i=2,#root_expression.operands do
    io.write(",")
    root_expression.operands[i][meta].printer(root_expression.operands[i])
   end
   io.write ")"

  end
  return prefix
end