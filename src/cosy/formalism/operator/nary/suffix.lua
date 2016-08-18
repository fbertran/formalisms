return function (Layer,suffix)

  local refines = Layer.key.refines
  local meta    = Layer.key.meta
  local lpeg    = require "lulpeg"
  local nary    = Layer.require "cosy/formalism/operator/nary"

  suffix [refines] = {
    nary,    
  }
  
  suffix [meta].parser = function(ref,exp0)
    local pattern = (lpeg.P "(" * exp0 * lpeg.P(lpeg.P "," * exp0)^0 * lpeg.P ")" * lpeg.C(ref.operator))/function(...)
      local layer = Layer.new {}
      local tab = {...}
      local trace =""
      layer [refines] = {ref}
      for i=1 , #tab-1 do
        if i%2 ~= 0 then
          layer.operands[#layer.operands+1] = tab[i]
        else
          trace = trace..tab[i]
        end
      end
      trace = trace..tab[#tab]
      return layer,trace
    end
    return pattern
  end

  suffix [meta].printer = function (root_expression)
    --use parenthesis if an operation has 1 one operands 
    io.write(root_expression.operator.."(")
    root_expression.operands[1][meta].printer(root_expression.operands[1])
    for i=2,#root_expression.operands do
      io.write(",")   
      root_expression.operands[i][meta].printer(root_expression.operands[i])
    end
    io.write ")"
  end

end