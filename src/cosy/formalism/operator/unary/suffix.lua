return function (Layer,suffix)

  local refines = Layer.key.refines
  local meta = Layer.key.meta

  local lpeg = require "lpeg"

  local unary = Layer.require "cosy/formalism/operator/unary"

  local plop

  suffix [refines] = {
    unary,    
  }

  suffix.count_id = 0

  suffix [meta].parser = function (reference,exp0, test)

    local ignored_character = ""

    if #reference [meta].ignored_character > 0 then
      ignored_character = lpeg.P (reference [meta].ignored_character[1])
    end
    for i=2,#reference [meta].ignored_character do
        ignored_character = ignored_character + lpeg.P (reference [meta].ignored_character[i])
    end

    local pattern
    if #reference [meta].ignored_character > 0 then
      pattern = lpeg.P(exp0 * lpeg.P(ignored_character)^0 *lpeg.C(reference.operator))
    else
      pattern = lpeg.P(exp0 * lpeg.C(reference.operator))
    end

    pattern = pattern/function(left,left_trace, patt)

      print("**************SUFFIX BEFORE LAYERNEW*************")
      print(reference.operator)
      print(test)
      for k,v in pairs(test) do
        print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print("\n")
      end

      print("bloublou")
      print(left.priority)


      plop  = Layer.new ({name ="inc_"..reference.count_id}, test)
      reference.count_id=reference.count_id+1


      print("*********** AFTER LAYER NEW****************")
      print(reference.operator)
      print(test)
      for k,v in pairs(test) do
        print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print("\n")
      end
      plop [refines] = {reference}

      plop [refines] = {reference}
      plop.operands = {left}
      assert(plop [meta].operands_type <= left,"wrong type in:")

      plop [meta].printer(plop)
      return plop, left_trace..patt
    end
    return pattern  
  end

  suffix [meta].printer = function (root_expression)
  --use parenthesis if an operation has 1 one operands 
    root_expression.operands [1][meta].printer(root_expression.operands [1])
    io.write(root_expression.operator)
  end

  return suffix
end