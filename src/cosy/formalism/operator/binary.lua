return function (Layer,binary)

  local lpeg = require "lulpeg"
  local refines = Layer.key.refines
  local meta = Layer.key.meta
  local collection  = Layer.require "cosy/formalism/data.collection"
  local operator = Layer.require "cosy/formalism/operator"


  binary [refines] = {
    operator,    
  }

  binary .operands [meta] [collection]  = {
    minimum = 2,
    maximum = 2,
  }

  binary [meta].parser = function(ref,exp1, exp2)
    local tmp_ignored_character = ""
    local pattern

    if #ref [meta].ignored_character >0 then
      tmp_ignored_character = lpeg.P (ref [meta].ignored_character[1])
    end
    for i=2,#ref [meta].ignored_character do
        tmp_ignored_character = tmp_ignored_character + lpeg.P (ref [meta].ignored_character[i])
    end

    if #ref [meta].ignored_character > 0 then
      pattern = lpeg.P(exp1 * lpeg.P(tmp_ignored_character)^0 * lpeg.C(ref.operator) * lpeg.P(tmp_ignored_character)^0 * exp2)
    else
      pattern = lpeg.P(exp1 * lpeg.C(ref.operator) * exp2)
    end

    pattern = pattern/function(left,left_trace,patt,right,right_trace)
      local layer= Layer.new {}
      local trace = left_trace..patt..right_trace
      layer [refines] = {ref}
      print("trace:"..trace)
      layer.operands = {left,right}
      assert(layer [meta].operands_type < left ,"wrong type in left operand")
      assert(layer [meta].operands_type < right ,"wrong type in right operand")
      return layer,trace
    end  
    return pattern
  end
  
  return binary
end
