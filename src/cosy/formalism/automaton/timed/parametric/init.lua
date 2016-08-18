--[[return function (Layer, parametric_timed_automaton, ref)

  local meta               = Layer.key.meta
  local refines            = Layer.key.refines
  local collection         = Layer.require "cosy/formalism/data.collection"
  local timed_automaton    = Layer.require "cosy/formalism/automaton/timed"

  local operands_type = Layer.require "cosy/formalism/flag.operands_type"

  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
  local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"
  local logical_operation = Layer.require "cosy/formalism/operation/logical"
  local relational_operation = Layer.require "cosy/formalism/operation/relational"
  local literal = Layer.require "cosy/formalism/literal"
  
  local arithmetic_operands_type = Layer.new {}
  local arithmetic_operands_type_param_cond = Layer.new {}
  arithmetic_operands_type_param_cond [refines] = {operands_type}
  arithmetic_operands_type [refines] = {operands_arithmetic_type,timed_automaton [meta].guard_operations[arithmetic_operation] [meta].operands_type}
  local relational_operands_type = Layer.new {}
  local relational_operands_type_param_cond = Layer.new {}
  relational_operands_type_param_cond [refines] = {operands_type}
  relational_operands_type [refines] = {operands_relational_type_param_cond,timed_automaton [meta].guard_operations[relational_operation] [meta].operands_type}
  local logical_operands_type = Layer.new {}
  local logical_operands_type_param_cond = Layer.new {}
  logical_operands_type_param_cond [refines] = {operands_type}
  logical_operands_type [refines] = {operands_logical_type_param_cond,timed_automaton [meta].guard_operations[logical_operation] [meta].operands_type}
  local boolean_operands_type = Layer.new {}
  local boolean_operands_type_param_cond = Layer.new {}
  boolean_operands_type_param_cond [refines] = {operands_type}
  boolean_operands_type [refines] = {operands_boolean_type_param_cond,timed_automaton [meta].guard_operations[boolean_operation] [meta].operands_type}


  local arithmetic_operation = Layer.require "cosy/formalism/operation/arithmetic"
  local addition_operation = Layer.require "cosy/formalism/operator/arithmetic.addition"
  local substraction_operation = Layer.require "cosy/formalism/operator/arithmetic.substraction"
  local multiplication_operation = Layer.require "cosy/formalism/operator/arithmetic.multiplication"
  local division_operation = Layer.require "cosy/formalism/operator/arithmetic.division"

  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
  local not_operation = Layer.require "cosy/formalism/operator/boolean.not"

  local logical_operation = Layer.require "cosy/formalism/operation/logical"
  local and_operation = Layer.require "cosy/formalism/operator/logical.and"
  local or_operation = Layer.require "cosy/formalism/operator/logical.or"
  local nor_operation = Layer.require "cosy/formalism/operator/logical.nor"
  local xor_operation = Layer.require "cosy/formalism/operator/logical.xor"

  local relational_operation = Layer.require "cosy/formalism/operation/relational"
  local different_operation = Layer.require "cosy/formalism/operator/relational.different"
  local equal_operation = Layer.require "cosy/formalism/operator/relational.equal"
  local inferior_operation = Layer.require "cosy/formalism/operator/relational.inferior"
  local inferiorequal_operation = Layer.require "cosy/formalism/operator/relational.inferiorequal"
  local superior_operation = Layer.require "cosy/formalism/operator/relational.superior"
  local superiorequal_operation = Layer.require "cosy/formalism/operator/relational.superiorequal"

  local parenthesis_operation = Layer.require "cosy/formalism/operator/punctuator.parenthesis"
  
  local literal = Layer.require "cosy/formalism/literal"
  local number = Layer.require "cosy/formalism/literal.number"
  local bool = Layer.require "cosy/formalism/literal.bool"
  local identifier = Layer.require "cosy/formalism/literal.identifier"

  local arithmetic_variant = Layer.new {}
  arithmetic_variant [refines] = {arithmetic_operation}
  local addition_variant = Layer.new {}
  addition_variant [refines] = {addition_operation}
  local substraction_variant = Layer.new {}
  substraction_variant [refines] = {substraction_operation}
  local multiplication_variant = Layer.new {}
  multiplication_variant [refines] = {multiplication_operation}
  local division_variant = Layer.new {}
  division_variant [refines] = {division_operation}

  local boolean_variant = Layer.new {}
  local not_variant = Layer.new {}

  local logical_variant = Layer.new {}
  local and_variant = Layer.new {}
  local or_variant = Layer.new {}
  local nor_variant = Layer.new {}
  local xor_variant = Layer.new {}

  local relational_variant = Layer.new {}
  local different_variant = Layer.new {}
  local equal_variant = Layer.new {}
  local inferior_variant = Layer.new {}
  local inferiorequal_variant = Layer.new {}
  local superior_variant = Layer.new {}
  local superiorequal_variant = Layer.new {}

  local literal_variant = Layer.new {}
  local number_variant = Layer.new {}
  local bool_variant = Layer.new {}
  local identifier_variant = Layer.new {}

  local parenthesis_variant = Layer.new {}


  boolean_variant [refines] = {boolean_operation,boolean_operands_type,logical_operands_type_param_cond}
  boolean_variant [meta].operands_type = boolean_operands_type_param_cond
  not_variant  [refines] = {boolean_variant,not_operation}

  logical_variant [refines] = {logical_operation,logical_operands_type_param_cond}
  logical_variant [meta].operands_type = logical_operands_type_param_cond
  and_variant [refines] = {boolean_variant,logical_variant,and_operation}
  or_variant [refines] = {boolean_variant,logical_variant,or_operation}
  nor_variant [refines] = {boolean_variant,logical_variant,nor_operation}
  xor_variant [refines] = {boolean_variant,logical_variant,xor_operation}

  relational_variant [refines] = {relational_operation,logical_operands_type_param_cond}
  relational_variant [meta].operands_type = relational_operands_type_param_cond
  different_variant [refines] = {boolean_variant,relational_variant,different_operation}
  equal_variant [refines] = {boolean_variant,relational_variant,equal_operation}
  inferior_variant [refines] = {boolean_variant,relational_variant,inferior_operation}
  inferiorequal_variant [refines] = {boolean_variant,relational_variant,inferiorequal_operation}
  superior_variant [refines] = {boolean_variant,relational_variant,superior_operation}
  superiorequal_variant [refines] = {boolean_variant,relational_variant,superiorequal_operation}

  arithmetic_variant [refines] = {arithmetic_operation,relational_operands_type,arithmetic_operands_type_param_cond}
  arithmetic_variant [meta].operands_type = arithmetic_operands_type_param_cond
  addition_variant [refines] = {arithmetic_variant,addition_operation}
  substraction_variant [refines] = {arithmetic_variant,substraction_operation}
  multiplication_variant [refines] = {arithmetic_variant,multiplication_operation}
  division_variant [refines] = {arithmetic_variant,division_operation}

  parenthesis_variant [refines] = {parenthesis_operation}

 
  --punctuaturu-jutsu

  --[[addition_variant [meta].punctuators = {parenthesis_variant}
  substraction_variant [meta].punctuators = {parenthesis_variant}
  multiplication_variant [meta].punctuators = {parenthesis_variant}
  division_variant [meta].punctuators = {parenthesis_variant}
  not_variant  [meta].punctuators = {parenthesis_variant}
  and_variant [meta].punctuators = {parenthesis_variant}
  or_variant [meta].punctuators = {parenthesis_variant}
  nor_variant [meta].punctuators = {parenthesis_variant}
  xor_variant [meta].punctuators = {parenthesis_variant}
  different_variant [meta].punctuators = {parenthesis_variant}
  equal_variant [meta].punctuators = {parenthesis_variant}
  inferior_variant [meta].punctuators = {parenthesis_variant}
  inferiorequal_variant [meta].punctuators = {parenthesis_variant}
  superior_variant [meta].punctuators = {parenthesis_variant}
  superiorequal_variant [meta].punctuators = {parenthesis_variant}

  --operashunu alimentashunu
 -- print(identifier)
  arithmetic_variant [meta].operators = {
    [addition_operation] = addition_variant,
    [substraction_operation] = substraction_variant,
    [multiplication_operation] = multiplication_variant,
    [division_operation] = division_variant,
  }
  relational_variant [meta].operators = {
    [different_operation] = different_variant,
    [equal_operation] = equal_variant,
    [inferior_operation] = inferior_variant,
    [inferiorequal_operation] = inferiorequal_variant,
    [superior_operation] = superior_variant,
    [superiorequal_operation] = superiorequal_variant
  }

  logical_variant [meta].operators = {
    [and_operation] = and_variant,
    [or_operation] = or_variant,
    [nor_operation] = nor_variant,
    [xor_operation] = xor_variant,
  }

  boolean_variant [meta].operators = {
    [not_operation] = not_variant
  }

 
  arithmetic_variant [meta].operators [refines] = {timed_automaton [meta].guard_operations[literal][meta].operators}
  relational_variant [meta].operators [refines] = {arithmetic_variant [meta].operators}
  
  logical_variant [meta].operators [refines] = {relational_variant [meta].operators}
  
  boolean_variant [meta].operators [refines] = {logical_variant [meta].operators}

  parametric_timed_automaton [refines] = {
    timed_automaton,
  }

  boolean_operands_type  [refines] = { boolean_operands_type_param_cond, parametric_timed_automaton [meta].guard_operations[boolean_operation][meta].operands_type }
  logical_operands_type [refines] = { logical_operands_type_param_cond, parametric_timed_automaton [meta].guard_operations[logical_operation][meta].operands_type}
  arithmetic_operands_type [refines] = { arithmetic_operands_type_param_cond, parametric_timed_automaton [meta].guard_operations[arithmetic_operation][meta].operands_type}
  relational_operands_type [refines] = { relational_operands_type_param_cond, parametric_timed_automaton [meta].guard_operations[relational_operation][meta].operands_type}



   print("tigma")
  print(parametric_timed_automaton [meta].guard_operations[arithmetic_operation][meta].operands_type<=parametric_timed_automaton [meta].guard_operations[arithmetic_operation][meta].operators[addition_operation])

 -- parametric_timed_automaton [meta].guard_operations[boolean_operation][meta].operands_type = boolean_operands_type
  --parametric_timed_automaton [meta].guard_operations[logical_operation][meta].operands_type = logical_operands_type
  --parametric_timed_automaton [meta].guard_operations[arithmetic_operation][meta].operands_type = arithmetic_operands_type
  --parametric_timed_automaton [meta].guard_operations[relational_operation][meta].operands_type = relational_operands_type

  parametric_timed_automaton [meta].guard_operations[literal][meta].operators[number][refines][#parametric_timed_automaton [meta].guard_operations[literal][meta].operators[number][refines]+1] = relational_operands_type_param_cond
    parametric_timed_automaton [meta].guard_operations[literal][meta].operators[number][refines][#parametric_timed_automaton [meta].guard_operations[literal][meta].operators[number][refines]+1] = arithmetic_operands_type_param_cond
  parametric_timed_automaton [meta].parameter_type = {
    [refines] = {
      parametric_timed_automaton [meta].guard_operations[literal][meta].operators[identifier],
      relational_operands_type,
      arithmetic_operands_type
    },
  }

  parametric_timed_automaton.parameters = {
    [refines] = {
      collection,
    },
    [meta] = {
      [collection] = {
        value_type = ref [meta].parameter_type,
      },
    },
  }
  parametric_timed_automaton [meta].guard_type = parametric_timed_automaton [meta].guard_operations[boolean_operation]
  parametric_timed_automaton [meta].init_condition_type = boolean_variant
  
  parametric_timed_automaton.init_condition = {
    [refines] = {collection},
    [meta] = {
      [collection] = {
          value_type =  ref [meta].init_condition_type
      }
    }
  }

  parametric_timed_automaton [meta].init_operation = {
   [boolean_operation] = boolean_variant,
   [logical_operation] = logical_variant,
   [relational_operation] = relational_variant,
   [arithmetic_operation] = arithmetic_variant,
   [literal] = ref [meta].guard_operations[literal]
  }


 return parametric_timed_automaton
end
]]