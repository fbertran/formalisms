return function (Layer, timed_automaton, ref)
  


 
  --local prefix = "cosy/formalism/automaton/timed_automaton/" 
  
  local meta               = Layer.key.meta
  --local checks             = Layer.key.checks
  local refines            = Layer.key.refines

  local collection         = Layer.require "cosy/formalism/data.collection"
  local record             = Layer.require "cosy/formalism/data.record"
  local automaton          = Layer.require "cosy/formalism/automaton"
  
  --LITERAL FORMAlISME
  local operands_type = Layer.require "cosy/formalism/flag.operands_type"
  local literal = Layer.require "cosy/formalism/literal"
  local number = Layer.require "cosy/formalism/literal.number"
  local bool = Layer.require "cosy/formalism/literal.bool"
  local identifier = Layer.require "cosy/formalism/literal.identifier"


  --ARITHMETIC FORMALISME
  local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"
  local addition_operation = Layer.require "cosy/formalism/operator/arithmetic.addition"
  local arithmetic_operands_type = Layer.new {name="arithmetic_operands_type"}
  local increment_operation = Layer.require "cosy/formalism/operator/arithmetic/increment"
  

  local increment_variant = Layer.new{name = "increment_variant"}
  local arithmetic_variant = Layer.new {name="arithmetic_variant"}
  local addition_variant = Layer.new {name="addition_variant"}
  

  arithmetic_operands_type [refines] = {operands_type}

  arithmetic_variant [refines] = {arithmetic_operands_type,arithmetic_operation}
  arithmetic_variant[meta].operands_type = arithmetic_operands_type

  increment_variant[refines]= {arithmetic_variant, increment_operation }
  addition_variant [refines] = {arithmetic_variant, addition_operation}
 
  
  --LITERAL VARIANT
  local literal_variant = Layer.new {name="literal_variant"}
  local number_variant = Layer.new {name="number_variant"}
  local bool_variant = Layer.new {name="boolean_variant"}
  local identifier_variant = Layer.new {name="identifier_variant"}

  literal_variant [refines] = {literal}
  number_variant [refines] = {literal_variant,arithmetic_variant, number}--arithmetic_variant [meta].operands_type,relational_variant [meta].operands_type,number}
  bool_variant [refines] = {literal_variant, bool}--,logical_variant [meta].operands_type}--, boolean_variant [meta].operands_type,bool}
  identifier_variant [refines] = {literal_variant, arithmetic_variant, identifier}--,arithmetic_variant [meta].operands_type,relational_variant [meta].operands_type,identifier}


  literal_variant [meta].operators = {
    ["number"] = number_variant,
    ["bool"] = bool_variant,
    ["identifier"] = identifier_variant
  }

 arithmetic_variant [meta].operators = {
    ["addition_operation"] = addition_variant,
    ["increment_operation"] = increment_variant,
    ["identifier"] = identifier_variant,
    ["number"] = number_variant,
  }

  --PUNCTUATOR FORMALISME
  local parenthesis_operation = Layer.require "cosy/formalism/operator/punctuator.parenthesis"
  local punctuator_operation = Layer.require "cosy/formalism/operation/punctuator"
  local parenthesis_variant = Layer.new {name="parenthesis_variant"}
  local punctuator_variant = Layer.new {name="punctuator_variant"}

  punctuator_variant [refines] = {punctuator_operation}
  parenthesis_variant [refines] = {punctuator_variant,parenthesis_operation}

 -- parenthesis_variant [meta].operators = {
    --[inferior_operation] = inferior_variant,
    --[addition_operation] = addition_variant,
    --[substraction_operation] = substraction_variant,
  --  [multiplication_operation] = multiplication_variant,
--    [division_operation] = division_variant,
  --  [number] = number_variant
  --}

  --literal_variant[meta].punctuators = {parenthesis_variant,}

--*********************** TA *******************************
  timed_automaton [refines] = {
    automaton,
  }
  
  timed_automaton [meta].guard_operations = {
    [refines] = {collection}
  }

  timed_automaton [meta].guard_operations = {
   --[boolean_operation] = boolean_variant,
   --[logical_operation] = logical_variant,
   --[relational_operation] = relational_variant,
   ["arithmetic_operation"] = arithmetic_variant,
   ["literal"] = literal_variant
  }

  --arithmetic_variant [meta].operators [refines] = {literal_variant[meta].operators}
  timed_automaton [meta].guard_type = ref [meta].guard_operations["arithmetic_operation"]
  

  timed_automaton [meta].state_type [meta] = {
    [record] = {
      invariant  = { value_type = ref [meta].guard_type},
    },
  }

  timed_automaton [meta].clock_type = {
    [refines] = {
      timed_automaton [meta].guard_operations["literal"][meta].operators["identifier"],
    },
  }

  timed_automaton.clocks = {
    [refines] = {
      collection,
    },

    [meta] = {
      [collection] = {
        value_type = ref [meta].clock_type,
      },
    },
  }

  timed_automaton [meta].transition_type [meta][record] = {
    guard = { value_type = ref [meta].guard_type },
    clock_update = {
      [refines] = {
        collection,
      },

      [meta] = {
        [collection] = {
          value_type = ref [meta].clock_type,
          value_container = ref.clocks,
        },
      },
    },--clock_update
  }
  timed_automaton.transitions = {
    [meta] = {
      [collection] = {
        value_type = ref [meta].transition_type,
      },
    },
  }

  timed_automaton.states = {
    [meta] = {
      [collection] = {
        value_type = ref [meta].state_type,
      },
    },
  }
  timed_automaton.invariants = {
    [meta] = {
      [collection] = {
        value_type = ref [meta].guard_type,
      },
    },
  }

--[[  

  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
  local not_operation = Layer.require "cosy/formalism/operator/boolean.not"
  local boolean_operands_type = Layer.new {name=""}
  boolean_operands_type [refines] = {operands_type}

  local logical_operation = Layer.require "cosy/formalism/operation/logical"
  local and_operation = Layer.require "cosy/formalism/operator/logical.and"
  local or_operation = Layer.require "cosy/formalism/operator/logical.or"
  local nor_operation = Layer.require "cosy/formalism/operator/logical.nor"
  local xor_operation = Layer.require "cosy/formalism/operator/logical.xor"
  local logical_operands_type = Layer.new {name=""}
  logical_operands_type [refines] = {operands_type}

  local relational_operation = Layer.require "cosy/formalism/operation/relational"
  local different_operation = Layer.require "cosy/formalism/operator/relational.different"
  local equal_operation = Layer.require "cosy/formalism/operator/relational.equal"
  local inferior_operation = Layer.require "cosy/formalism/operator/relational.inferior"
  local inferiorequal_operation = Layer.require "cosy/formalism/operator/relational.inferiorequal"
  local superior_operation = Layer.require "cosy/formalism/operator/relational.superior"
  local superiorequal_operation = Layer.require "cosy/formalism/operator/relational.superiorequal"
  local relational_operands_type = Layer.new {name=""}
  relational_operands_type [refines] = {operands_type}


  
  

  

  --local boolean_variant = Layer.new {name=""}
  --local not_variant = Layer.new {name=""}

--  local logical_variant = Layer.new {name=""}
 -- local and_variant = Layer.new {name=""}
 -- local or_variant = Layer.new {name=""}
  --local nor_variant = Layer.new {name=""}
  --local xor_variant = Layer.new {name=""}

 
  local relational_variant = Layer.new {name=""}
  local different_variant = Layer.new {name=""}
  local equal_variant = Layer.new {name=""}
  local inferior_variant = Layer.new {name=""}
  local inferiorequal_variant = Layer.new {name=""}
  local superior_variant = Layer.new {name=""}
  local superiorequal_variant = Layer.new {name=""}



    


  --[[logical_variant [refines] = {logical_operation}
  logical_variant [meta].operands_type = logical_operands_type

  boolean_variant [refines] = {boolean_operation,logical_variant [meta].operands_type}
  boolean_variant [meta].operands_type = boolean_operands_type
  boolean_variant [refines][#boolean_variant [refines]+1] = boolean_variant [meta].operands_type
  not_variant  [refines] = {boolean_variant,not_operation}

  
  logical_variant [refines][#logical_variant [refines]+1] = logical_variant [meta].operands_type
  and_variant [refines] = {boolean_variant,logical_variant,and_operation}
  or_variant [refines] = {boolean_variant,logical_variant,or_operation}
  nor_variant [refines] = {boolean_variant,logical_variant,nor_operation}
  xor_variant [refines] = {boolean_variant,logical_variant,xor_operation}

  relational_variant [refines] = {relational_operation}--,logical_variant [meta].operands_type}
  relational_variant [meta].operands_type = relational_operands_type
  different_variant [refines] = {relational_variant,different_operation}
  equal_variant [refines] = {relational_variant,equal_operation}
  inferior_variant [refines] = {relational_variant,inferior_operation}
  inferiorequal_variant [refines] = {relational_variant,inferiorequal_operation}
  superior_variant [refines] = {relational_variant,superior_operation}
  superiorequal_variant [refines] = {relational_variant,superiorequal_operation}

  arithmetic_variant [refines] = {arithmetic_operation,relational_operands_type}
  arithmetic_variant [meta].operands_type = arithmetic_operands_type
  arithmetic_variant [refines][#arithmetic_variant [refines]+1] = arithmetic_variant [meta].operands_type
  addition_variant [refines] = {arithmetic_variant,addition_operation}
  increment_variant [refines] = {arithmetic_variant,increment_operation}
  substraction_variant [refines] = {arithmetic_variant,substraction_operation}
  multiplication_variant [refines] = {arithmetic_variant,multiplication_operation}
  division_variant [refines] = {arithmetic_variant,division_operation}



]]

  --[[punctuaturu-jutsu
  

  --operashunu alimentashunu
 -- print(identifier)
  arithmetic_variant [meta].operators = {
    [addition_operation] = addition_variant,
    [substraction_operation] = substraction_variant,
    [multiplication_operation] = multiplication_variant,
    [division_operation] = division_variant,
    [increment_operation] = increment_variant
  }
  relational_variant [meta].operators = {
    [different_operation] = different_variant,
    [equal_operation] = equal_variant,
    [inferior_operation] = inferior_variant,
    [inferiorequal_operation] = inferiorequal_variant,
    [superior_operation] = superior_variant,
    [superiorequal_operation] = superiorequal_variant
  }

  --[[logical_variant [meta].operators = {
    [and_operation] = and_variant,
    [or_operation] = or_variant,
    [nor_operation] = nor_variant,
    [xor_operation] = xor_variant,
  }

  boolean_variant [meta].operators = {
    [not_operation] = not_variant,
  }

  arithmetic_variant [meta].operators [refines] = {literal_variant[meta].operators}
  relational_variant [meta].operators [refines] = {arithmetic_variant [meta].operators}
  
  --logical_variant [meta].operators [refines] = {relational_variant [meta].operators}
  
  --boolean_variant [meta].operators [refines] = {logical_variant [meta].operators}
  --boolean_variant [meta].punctuators = {[parenthesis_operation] = parenthesis_variant}
]]

  --CHECKS
  --[[
  multiplication_variant [checks][ prefix .. ".multiplication operands_type_constraints"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end

    local count = 0
    for _,v in pairs (proxy.operands) do 
      if( proxy [meta].clock_type <= v) then
        count = count+1
      end
        if(count == 2) then
          Layer.coroutine.yied (prefix .. ".multiplication: cannot use more than one clock.invalid", {
              proxy = proxy,
              used = v,
            })  
          break
        end
    end
  end

  division_variant [checks][ prefix .. ".division operands_type_constraints"] = function (proxy)
    if Layer.Proxy.has_meta (proxy) then
      return
    end

    local count = 0
    for _,v in pairs (proxy.operands) do 
      if( proxy [meta].clock_type <= v) then
        count = count+1
      end
        if(count == 2) then
          Layer.coroutine.yied (prefix .. ".division: cannot use more than one clock.invalid", {
              proxy = proxy,
              used = v,
            })  
          break
        end
    end
  end
    ]]
  return timed_automaton
end

--[[ 
-not refined because we are using a boolean_operation specific for timed_automaton (no need to inherit it).
-if we refine we will lose the tree structure of the operations.
]]--


