--Operation

return function (Layer, operation,ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines
  local record =  Layer.require "cosy/formalism/data.record"
  local collection =  Layer.require "cosy/formalism/data.collection"
  local variant = Layer.require "cosy/formalism/variant"
 

  operation [refines] = {record,variant}

  operation [meta] = {

    operands_type = { value_type = false },
    [record] = {
      operator = {
        value_type = "string",
      },
      priority = {
        value_type = "number"
      },
      pattern = {
        value_type = "function",
      },
      parser = {
        value_type = "function",
      },
      printer = {
        value_type = "function",
      },
      result = {
        value_type = false
      }
    }
  }

  
 
  
 

  operation.operands = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].operands_type,
        minimum = false,
        maximum = false
      }
    },
  }
--[[
    operation.parser = function (self, expression, instance)

      local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
      print(boolean_variant.pattern)
      local global_pattern = lpeg.C { ( boolean_operation [meta][record].pattern (instance) /function() operation [meta][record].result = boolean_operation [meta][record].result end ) }
      
      --Phase de vérification:
      expression = expression:gsub (" ", "")

  
      local count = 0

      
  
       -- vérifier si toutes parenthèses ouvertes est fermées
  
      for i=1 , #expression do

        if expression:sub(i,i) == '(' then
    
          count = count + 1
    
        else if expression:sub (i, i) == ')' then
    
          count = count - 1
    
          end
    
        end

      end

      if count ~= 0 then
        print("error: check your parenthesis ()")
        return
      end

    --permet d'éviter l'optimisation d'opération identiques qui se suivent ayant des parenthèses (encapsulée) ex: ~(~(x2<5))

    local closing_parenthesis = 0

    --contient partie de la condition jusqu'à priority<old_priority

    local sub_string = {}

    --contient le type de chaque case du sub_string (operator/operand)

    local sub_type = {}


    --contient le résultat du pattern

    local curr

    --première opération du sub_string courant (éviter d'insérer l'opération d'un autre sub_string à la première opération du sub_string courant)

    local first_op

    --contient l'expression courante

    local curr_expression = {}


    --expression racine de l'arbre

    local root_expression = curr_expression

    --conteneur temporaire de l'expression précédente

    local toggle_expression = {}

    --ancienne priorité

    local old_priority

    --priorité courante

    local priority = 8

    local is_operand

    local is_parenthesis

    local priority_level = 0


    local priority_up = lpeg.C "("

    local priority_down = lpeg.C ")"

   
    --init curr_expression

    curr_expression.operator = ""

    curr_expression.operands = {}

    --tant que la chaine n'est pas vide

    while #expression > 0 do

      is_operand = false
      is_parenthesis = false

      --affecter priorité courante à l'ancienne (comparaison entre priorité de l'opérateur le plus courant avec le le courant)

      old_priority = priority

      --verifier si l'expression courante commence par un operateur + priorité=priorité de l'opérateur

      curr = global_pattern:match ( expression ) 

      if curr ~= nil then
        if operation < self.result then 
          priority = self.result [meta][record].priority + priority_level  
        else
         sub_string [#sub_string + 1] = self.result
         sub_type [#sub_type + 1] = "operands"
         expression = expression:sub(#curr + 1, #expression)
         is_operand = true
        end
      else
        curr = priority_up:match(expression) 
        if curr ~= nil then
          priority_level = priority_level + 99
          is_parenthesis = true
          expression = expression:sub(#curr + 1, #expression)
        else
          curr = priority_down:match(expression)
            if curr ~=nil then
              priority_level = priority_level - 99
              is_parenthesis = true
              expression = expression:sub(#curr + 1, #expression)
              closing_parenthesis =  closing_parenthesis + 1
            else
                error("error:unknow characters in the beginning of : " .. expression)
                return
            end
        end
         
      end

      
    -- priority<old_priority veut dire que l'opérateur courant ne permet plus une ascendance de priorité d'operateur

    if (priority < old_priority and is_parenthesis == false) or expression == "" then
      first_op = false

      for i = 1, #sub_string do

        if sub_type [#sub_type - i + 1] == "operator" then

          if curr_expression [meta] == nil or (curr_expression [meta][record].operator == sub_string[#sub_string - i + 1][meta][record].operator and closing_parenthesis == 0) then
            
            local operands = curr_expression.operands
            curr_expression = sub_string [#sub_string - i + 1]
            
            curr_expression.operands = operands
            for z = 1, #curr_expression.operands do

               if (curr_expression [meta].operands_type <= curr_expression.operands [z]) == false then
                error(" wrong type of operation: " .. curr_expression.operands [z].." expecting : " .. tostring(curr_expression [meta].operands_type).." in operation "..tostring(curr_expression [meta][record][refines][1]))
                return
               end       
            end
            first_op = true
         
          else
            if #curr_expression.operands < curr_expression.operands [meta][collection].minimum or #curr_expression.operands > curr_expression.operands [meta][collection].maximum then
              error("error: incorrect number of operands : " .. #curr_expression.operands .. " for operation: " .. tostring(curr_expression [refines][1]))
              return
            end
            if closing_parenthesis > 0 then
              closing_parenthesis = closing_parenthesis - 1
            end
            toggle_expression [#toggle_expression+1] = curr_expression
            
            curr_expression = sub_string [#sub_string - i + 1]
        
         
            if first_op == true then
         
         
              curr_expression.operands [#curr_expression.operands+1] = toggle_expression [#toggle_expression]
         
              toggle_expression [#toggle_expression] = nil
         
              
            end
        
          end

        else
          if curr_expression [meta] ~= nil then
            if curr_expression [meta].operands_type <= sub_string [#sub_string - i + 1] then
              curr_expression.operands [#curr_expression.operands + 1] = sub_string [#sub_string - i + 1]
            else
              error ("wrong type of operands: " .. sub_string [#sub_string - i + 1] .. " expecting : " .. tostring(curr_expression [meta].operands_type) .. " in operation " .. tostring(curr_expression [meta][record][refines][1]))
              return
            end
          else
            
            curr_expression.operands [#curr_expression.operands + 1] = sub_string [#sub_string - i + 1]
          end
        end
        if i == #sub_string then
        
          root_expression = curr_expression
        
          for j = 1, #toggle_expression do
            if curr_expression [meta].operands_type < toggle_expression [#toggle_expression - j + 1] then
              curr_expression.operands [#curr_expression.operands + 1] = toggle_expression [#toggle_expression - j + 1]
            else
              error ("wrong type of operation: " .. tostring(toggle_expression [#toggle_expression - j + 1][refines][1]) .. " expecting : " .. tostring(curr_expression [meta].operands_type) .. " in operation " .. tostring(curr_expression [refines][1]))
              return
            end
        
          end
         
          toggle_expression = {curr_expression}

          curr_expression = {}
            
          curr_expression.operator = ""
            
          curr_expression.operands = {}
          
        end
      
      end
      
      sub_string = {}
      
      sub_type = {}

    else
    --if it is the end of the string expression avoid having an operand as an operator
      if is_operand == false and is_parenthesis == false then
        
        sub_string [#sub_string+1] = self [meta][record].result
        sub_type [#sub_type+1] = "operator"
     
        expression = expression:sub(#curr + 1, #expression)
      
      end

    end
  
  end

  if(self < root_expression) == false then 
    error ("error: wrong type of operation " .. tostring(root_expression [refines][1]) .. " expecting: " .. tostring(self))
  end 
  if #root_expression.operands < root_expression.operands [meta][collection].minimum or #root_expression.operands > root_expression.operands [meta][collection].maximum then
    error ("error: incorrect number of operands : " .. #root_expression.operands .. " for operation: " .. tostring(root_expression [refines][1]))
    return
  end
  --reverse operands table
  local function reverse (curr_op)
    local identifier = Layer.require "cosy/formalism/literal.identifier"
    local has_identifier = false
    local ceil = math.ceil(#curr_op.operands / 2)
    for j = 1, ceil do
    
      if(operation < curr_op.operands [j]) then
      
        has_identifier = true
      
        reverse(curr_op.operands [j])
      
      else
      
        if(identifier < curr_op.operands [j]) then

          has_identifier = true
        
        end
      
      end
      
      
      if(#curr_op.operands % 2 ~= 0 and j == ceil) == false then
      
        if operation < curr_op.operands [#curr_op.operands - j + 1] then

          has_identifier = true

          reverse(curr_op.operands [#curr_op.operands - j + 1])

        else

        if identifier < curr_op.operands [#curr_op.operands - j + 1] then

          has_identifier = true
        
        end
        
      end
      
      end
      
      curr_op.operands [j], curr_op.operands [#curr_op.operands - j + 1] = curr_op.operands [#curr_op.operands - j + 1], curr_op.operands [j]
      
    
    end
    --check if the operation has at least one operands
    if has_identifier == false then
      error ("error: an operation must have at least one id")
      return
    end
  end
  reverse(root_expression)
  return root_expression
  
end

operation.printer = function (root_expression)
   local literal = Layer.require "cosy/formalism/literal"
  --use parenthesis if an operation has 1 one operands 
 
  
  for i = 1, #root_expression.operands do

    if literal < root_expression.operands [i] then
  
      io.write(root_expression.operands [i].value)
  
    else
    
      root_expression.operands [i].printer(root_expression.operands [i])
  
    end
  
    if(i<#root_expression.operands) then
  
      io.write(root_expression [meta][record].operator)
  
    end
  
  end


end
  ]]
  return operation
end
