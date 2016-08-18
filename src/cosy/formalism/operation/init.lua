-- Operation formalism is a formalism which interacts with Operator formalism.
-- Its purpose is to create the tree structure of the root formalism.
-- Specifically, it will construct the grammar based on patterns given by each Operator of its list 

return function (Layer, operation)

  local lpeg        = require "lulpeg"

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines

  local collection  = Layer.require "cosy/formalism/data.collection"
  local operator    = Layer.require "cosy/formalism/operator"
  local suffix      = Layer.require "cosy/formalism/operator/unary.suffix"
  local prefix      = Layer.require "cosy/formalism/operator/unary.prefix"    
  local nary        = Layer.require "cosy/formalism/operator/nary"
  local binary      = Layer.require "cosy/formalism/operator.binary"
  local nullary     = Layer.require "cosy/formalism/operator/nullary"

  operation [refines] = { operator }
 
  -- We put our list of operators we will not check the conatain of the list 
  -- because there are only formalisms and not instances, so it will throw errors if we do checks
  operation [meta] .operators = {}
  operation [meta] .operators [refines] = { collection }
  operation [meta] .operators [meta] [collection] .value_type = operator
  

  operation [meta] .parser = function (ref,expression,instance)
    local pattern
    local exp_index = 1
    local curr_priority
    local trace
    local result
    local sub_result
    local global_expression = expression
    local tmp_operators = {} -- Used for sorting ours operators (can't sort directly our collection)
    local quick_sort --Used to sort operators list by priority

    quick_sort = function (T, Begin, End)
      local partitionner
      local pivot

      partitionner = function (tab, be, en )
        local p = tab[en].priority
        local j = be
        for i = be, en - 1 do
          if tab[i].priority ~= nil and p ~= nil and tab[i].priority <= p then
            tab[i],tab[j] = tab[j],tab[i]
            j = j + 1
          end
        end
        tab[en],tab[j] = tab[j],tab[en]
        return j
      end

      if Begin < End then
        pivot = partitionner(T, Begin, End)
        quick_sort(T, Begin, pivot - 1)
        quick_sort(T, pivot + 1, End)
      end
    end


    pattern = ref [meta].pattern

    -- If we have ever created the pattern we use it
    -- To reset it, just define ref [meta] .pattern at nil
    if pattern ~= nil then 
      lpeg.pprint(pattern)
      sub_result,trace = lpeg.P(pattern):match(expression)

      if sub_result ~= nil and global_expression ~= trace then
        -- Creating the rule of the sub_result
        pattern [tostring(sub_result)] = lpeg.P(tostring(sub_result))/function (patt) print(patt) return sub_result,trace end
        -- This new rule is considered as a constant, so we add it in the last global expression
        pattern [tostring(ref)..exp_index] = lpeg.V(tostring(sub_result)) + pattern [tostring(ref)..exp_index]
        -- We know that the left operand doesn't have punctuators (in the string expression)
        pattern [tostring(ref)] = pattern [tostring(ref)..1]
        -- Remove the part which has already matched
        expression = expression:sub(trace:len()+1, expression:len())

        result, trace = lpeg.P(pattern):match(tostring(sub_result)..expression)
      else
        result = sub_result   
      end

    -- Else we create the pattern first
    else
      pattern = {}

      -- Name of the first expression that will be called by lulpeg
      pattern [1] = tostring(ref)
      pattern [tostring(ref)] = lpeg.V (tostring(ref)..1)

      -- Expression that will be filled by operators with punctuators
      pattern ["priority"] = nil

      -- Sorting step
      for _,v in pairs(ref [meta] .operators) do
        tmp_operators [#tmp_operators+1] = v
      end
      quick_sort(tmp_operators, 1, #tmp_operators)

      curr_priority = tmp_operators[1].priority
    
      -- Creating the global grammar with Operators list
      for i=1, #tmp_operators do
        local oper_curr = tmp_operators[i]
        assert(oper_curr.priority >= curr_priority, "PB with priorities quick_sort result")

        -- Adding the operator in a global rule of the Operation
        -- If the current operator has a priority superior than the before one
        -- We create a new rule for operators with the new priority 
        if oper_curr.priority > curr_priority then
          pattern [tostring(ref)..exp_index] = pattern [tostring(ref)..exp_index] + lpeg.V (tostring(ref)..(exp_index+1))
          exp_index = exp_index + 1
          pattern [tostring(ref)..exp_index] = lpeg.V (tostring(oper_curr))
          curr_priority = oper_curr.priority
        else
          -- else the current priority has the same priority as the before one we add it in
          -- the same rule.
          if(pattern [tostring(ref)..exp_index] ~= nil) then
            pattern [tostring(ref)..exp_index] = pattern [tostring(ref)..exp_index]+lpeg.V (tostring(oper_curr))
          else
            pattern [tostring(ref)..exp_index] = lpeg.V(tostring(oper_curr))
          end
        end


        -- Now we add the expression of the Operator by its parser
        if binary <= oper_curr then 
          pattern [tostring(oper_curr)] = oper_curr [meta] .parser(oper_curr, lpeg.V(tostring(ref)..(exp_index+1)), lpeg.V(tostring(ref)..exp_index))
        elseif prefix <= oper_curr or nary <= oper_curr then  
          pattern [tostring(oper_curr)] = oper_curr [meta] .parser(oper_curr, lpeg.V(tostring(ref)..exp_index))
        elseif suffix <= oper_curr then
          pattern [tostring(oper_curr)] = oper_curr [meta] .parser(oper_curr, lpeg.V(tostring(ref)..(exp_index+1)))
        elseif nullary <= oper_curr then
          pattern [tostring(oper_curr)] = oper_curr [meta] .parser(oper_curr, instance)
        else 
          print("Not supposed to be here")
          print(oper_curr .operator)
        end
      end

      -- Now we look if they are operator which can be primary
      -- If it's our case then we will check this rule before all others
      for _,v in pairs(ref .punctuators) do
        if pattern ["priority"] == nil then
          pattern ["priority"] = v [meta] .parser(v)
        else
          pattern ["priority"] = pattern ["priority"] + v [meta] .parser(v)
        end
      end
      if pattern["priority"] ~=nil then
       for j=1 , exp_index do 
          pattern[tostring(ref)..j] = pattern["priority"] + pattern[tostring(ref)..j]  
        end
      end

      -- We do a first match
      --ref [meta] .pattern = pattern
      sub_result,trace = lpeg.P(pattern):match(expression)
      -- Our parser returns us the first left part of expression which matched 
      -- If our expression has a left operand which is an operator using punctuator, 
      -- The left operand will match in first and not the others.
      -- That explains why we need a second match
      -- The only difference with the first one is that we will replace the matched part of expression by the name of the new instance
      -- Then we create a pattern for its name which will return the instance found by the first match. This way accords the original parser

      if sub_result ~= nil and global_expression ~= trace then
        -- Creating the rule of the sub_result
        pattern [tostring(sub_result)] = lpeg.P(tostring(sub_result))/function (patt) print(patt) return sub_result,trace end

        -- This new rule is considered as a constant, so we add it in the last global expression
        pattern [tostring(ref)..exp_index] = lpeg.V(tostring(sub_result)) + pattern [tostring(ref)..exp_index]

        -- We know that the left operand doesn't have punctuators (in the string expression)
        pattern [tostring(ref)] = pattern [tostring(ref)..1]

        -- Remove the part which has already matched
        expression = expression:sub(trace:len()+1, expression:len())

        result, trace = lpeg.P(pattern):match(tostring(sub_result)..expression)
      else
        result = sub_result   
      end
    end
    assert(global_expression == trace and result ~= nil, "pattern error detected in "..global_expression.." after :"..tostring(trace))
    assert(ref <= result, "wrong type of main operation")
    return result
  end

end
