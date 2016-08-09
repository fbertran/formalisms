--Operation

return function (Layer, operation)

  local lpeg = require "lpeg"

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local collection =  Layer.require "cosy/formalism/data.collection"

  local operator = Layer.require "cosy/formalism/operator"
  local suffix  = Layer.require "cosy/formalism/operator/unary.suffix"
  local prefix  = Layer.require "cosy/formalism/operator/unary.prefix"    
  local nary = Layer.require "cosy/formalism/operator/nary"
  local binary = Layer.require "cosy/formalism/operator.binary"
  local nullary = Layer.require "cosy/formalism/operator/nullary"

  operation [refines] = {operator}
 
  operation [meta].operators = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = operator,
      }
    }
  }

  operation.operator ="operation"
  

  operation [meta].partitionner = function (T,Begin,End)
    local pivot = T[End].priority
    local j = Begin
    for i=Begin, End-1 do
      if T[i].priority ~=nil and pivot ~=nil and T[i].priority <= pivot then
        T[i],T[j] = T[j],T[i]
        j = j+1
      end
    end
    T[End],T[j] = T[j],T[End]
    return j
  end

  operation [meta].quick_sort = function (ref,T,Begin,End)

    local pivot
    if Begin < End then

      pivot = ref [meta].partitionner(T,Begin,End)
      ref [meta].quick_sort(ref,T,Begin,pivot -1)
      ref [meta].quick_sort(ref,T,pivot+1,End)
    end
  end


  operation [meta].parser = function (ref,expression,instance)

    print("----- AVANT PARSER")
      for k,v in pairs(instance [meta].guard_operations) do
        print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end
        print("\n")
      end
  print("-------------------")

    local pattern = {}
    local exp_index = 1
    local curr_priority
    local trace
    local result
    local sub_result
    local global_expression = expression
    local tmp_operators = {}

    --Nom de l'expression de départ
    pattern [1] = tostring(ref)
    pattern [tostring(ref)] = lpeg.V (tostring(ref)..1)
    pattern ["priority"] = nil

    --TRIER LES OPERATEURS PAR PRIORITE
    --*************TO DO*******************
    for _,v in pairs(ref [meta].operators) do
      print(tostring(v))
      print(v.priority)
      tmp_operators [#tmp_operators+1] = v
    end

 print("----- AVANT QUICKSORT")
      for k,v in pairs(instance [meta].guard_operations) do
          print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print"\n"
      end
  print("-------------------")
  
    ref [meta].quick_sort(ref,tmp_operators,1,#tmp_operators)

   for _,v in pairs(tmp_operators) do
      --print(tostring(k).." "..tostring(v))
      print(v.priority)
     end

    curr_priority = tmp_operators[1].priority
 print("----- APRES QUICKSORT")
      for k,v in pairs(instance [meta].guard_operations) do
          print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print"\n"
      end
  print("-------------------")
  
    
    for i=1, #tmp_operators do
      local oper_curr = tmp_operators[i]

    --  assert(oper_curr.priority >= curr_priority, "PB with sort "..oper_curr.priority.." < "..curr_priority)

      if oper_curr.priority > curr_priority then
        pattern [tostring(ref)..exp_index] = pattern [tostring(ref)..exp_index] + lpeg.V (tostring(ref)..(exp_index+1))
        exp_index = exp_index+1
        pattern [tostring(ref)..exp_index] = lpeg.V (tostring(oper_curr))
        curr_priority = oper_curr.priority
      else
        if(pattern [tostring(ref)..exp_index] ~= nil) then
          pattern [tostring(ref)..exp_index] = pattern [tostring(ref)..exp_index]+lpeg.V (tostring(oper_curr))
        else
          pattern [tostring(ref)..exp_index] = lpeg.V(tostring(oper_curr))
        end
      end

      if binary <= oper_curr then    
        pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr, lpeg.V(tostring(ref)..(exp_index+1)), lpeg.V(tostring(ref)..exp_index),instance [meta].guard_operations)
      elseif prefix <= oper_curr or nary <= oper_curr then  
        pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr, lpeg.V(tostring(ref)..exp_index),instance [meta].guard_operations)
      elseif suffix <= oper_curr then
        pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr, lpeg.V(tostring(ref)..(exp_index+1)),instance [meta].guard_operations)
      elseif nullary <= oper_curr then
        pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr,instance [meta].guard_operations,instance)
      else 
        print("CHOULOU")
        print(tostring(oper_curr))
        for k,v in pairs(oper_curr) do 
          print(k)

          print(v)
        end
        print("FIN CHOULOU")
      end  
    end
    for _,v in pairs(ref [meta].punctuators) do     
      if pattern ["priority"] == nil then
        pattern ["priority"] = v [meta].parser(v)
       else
        pattern ["priority"] = pattern ["priority"] + v [meta].parser(v)
      end
    end

    if pattern["priority"] ~=nil then
     for j=1 , exp_index do 
        pattern[tostring(ref)..j] = pattern["priority"] + pattern[tostring(ref)..j]  
      end
    end

   
   print("----- APRES Pattern")
      for k,v in pairs(instance [meta].guard_operations) do
          print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print"\n"
      end
  print("-------------------")

      for _,v in pairs(ref [meta].operators) do
      print(tostring(v))
      print(v.priority)
      tmp_operators [#tmp_operators+1] = v
    end

    sub_result,trace = lpeg.P(pattern):match(expression)
 
   print("----- APRES First match")
for k,v in pairs(instance [meta].guard_operations) do
          print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print "\n"
      end      
  print("-------------------")
      for _,v in pairs(ref [meta].operators) do
      print(tostring(v))
      print(v.priority)
      tmp_operators [#tmp_operators+1] = v
    end

    if sub_result ~= nil and global_expression ~= trace then
      print("subresult")
      curr_priority = tmp_operators[1].priority
      
      for i=1, #tmp_operators do
        local oper_curr = tmp_operators[i]
        if curr_priority ~= oper_curr.priority then
          pattern [tostring(ref)..exp_index] = pattern [tostring(ref)..exp_index] + lpeg.V (tostring(ref)..(exp_index+1))
          exp_index = exp_index+1
          pattern [tostring(ref)..exp_index] = lpeg.V (tostring(oper_curr))
          curr_priority = oper_curr.priority
        else
          if(pattern [tostring(ref)..exp_index] ~= nil) then
            pattern [tostring(ref)..exp_index] = pattern [tostring(ref)..exp_index]+lpeg.V (tostring(oper_curr))
          else
            pattern [tostring(ref)..exp_index] = lpeg.V(tostring(oper_curr))
          end
        end

        if binary <= oper_curr then    
          pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr, lpeg.V(tostring(ref)..(exp_index+1)), lpeg.V(tostring(ref)..exp_index))
        elseif prefix <= oper_curr or nary <= oper_curr then  
          pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr, lpeg.V(tostring(ref)..exp_index))
        elseif suffix <= oper_curr then
          pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr, lpeg.V(tostring(ref)..(exp_index+1)))
        else
          pattern [tostring(oper_curr)] = oper_curr [meta].parser(oper_curr,instance)
        end  
      end
      for _,v in pairs(ref [meta].punctuators) do     
        if pattern ["priority"] == nil then
          pattern ["priority"] = v [meta].parser(v)
         else
          pattern ["priority"] = pattern ["priority"] + v [meta].parser(v)
        end
      end

      if pattern["priority"] ~=nil then
        for j=1 , exp_index do 
          pattern[tostring(ref)..j] = pattern["priority"] + pattern[tostring(ref)..j]  
        end
      end

      pattern [tostring(sub_result)] = lpeg.P(tostring(sub_result))/function (patt) print(patt) return sub_result,trace end
      expression = expression:sub(trace:len()+1, expression:len())
      local b = tostring(sub_result)..expression

      pattern [tostring(ref)..exp_index] = lpeg.V(tostring(sub_result)) + pattern [tostring(ref)..exp_index]
      pattern [tostring(ref)] = pattern [tostring(ref)..1]

      lpeg.pprint(pattern)
      result, trace = lpeg.P(pattern):match(b)
    else
      result=sub_result   
    end

    assert(result ~= nil, "Expression \""..expression.."\" did not match. Trace = \""..tostring(trace).."\")")
    print("ON A TrOUVE")
    print(result.value)
    for k in pairs(result) do
      print(k)
    end
    result[meta].printer(result)


    --lpeg.pprint(pattern):match(expression)

    assert(ref <= result, "wrong type of main operation")
 
    if trace ~= nil and global_expression ~= trace then
      print("pattern error detected after :"..trace)
    end
    return result
  end
  
  return operation
end
