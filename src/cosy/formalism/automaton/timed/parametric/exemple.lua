return function(Layer, instance,ref)

  local meta       =  Layer.key.meta
  local refines    =  Layer.key.refines

  local collection  = Layer.require "cosy/formalism/data.collection"

  local parametric_timed_automaton  = Layer.require "cosy/formalism/automaton/parametric_timed_automaton"
  

  local relational_operation  = Layer.require "cosy/formalism/operation/relational_operation"

 
  local arithmetic_operation  = Layer.require "cosy/formalism/operation/arithmetic_operation"
  
  local inferior_operation = Layer.require "cosy/formalism/operation/inferior_operation"
  local inferiorequal_operation = Layer.require "cosy/formalism/operation/inferiorequal_operation"
  local addition_operation = Layer.require "cosy/formalism/operation/addition_operation"

  
  --Definition des types d'operandes que peuvent prendre les operations
  local operands_type_arithmetic = Layer.new{}
  local operands_type_relational = Layer.new{}

  operands_type_relational [refines] = {
    operands_type_arithmetic,
}
  instance [refines] ={
    parametric_timed_automaton,
  }
--Definition du type de l'identifiant
  instance[meta].parameter_type.value.value_type="string"
  instance [meta].alphabet_type.value.value_type="string"
  
  instance.parameters_type [refines] = {

    arithmetic_operation,
    
}
instance [meta] = {
  number_type = {
    [refines] = {
      Layer.require "cosy/formalism/literal/number",
      operands_type_arithmetic,
      operands_type_relational,
    }
   }
  }


arithmetic_operation [refines] = {
  operands_type_arithmetic,
  
}



relational_operation [refines] = {
  operands_type_relational,
}

instance[meta].parameter_type = {
  [refines] = {
    operands_type_arithmetic,
    operands_type_relational,
  }
}

instance[meta].clock_type = {
  [refines] = {
    operands_type_arithmetic,
    operands_type_relational,
  }
}

-- Definition d'horloge
  instance.clocks = {
    y1 = {
      value="y1",
  },
    x1 = {
      value="x1",
  }
 }

-- Definition de paramètres
  instance.parameters = {
    p1 = {
      value="p1",
  }
 }
--Declaration d'expression 
  local exp0 = Layer.new{}
  exp0 [refines] = {
      addition_operation,
  }
 exp0.operands [meta] [collection].value_type =operands_type_arithmetic

  exp0.operands = {
    ref.clocks.y1,
    cte1= {
       value=1,
    }
}

  local exp1=Layer.new{}

  

   exp1 [refines] = {
      inferior_operation,
  }
 exp1.operands [meta] [collection].value_type =operands_type_relational
  exp1.operands = {
    ref.clocks.x1,
    cte1= {
       value=3,
    }
}

 local exp2 = Layer.new{}



  exp2 [refines] = {
      inferior_operation,
  }

 exp2.operands [meta] [collection].value_type =operands_type_relational
  exp2.operands = {
    exp0,
    ref.parameters.p1,
}

 local exp3 = Layer.new{}



  exp3 [refines] = {
      inferior_operation,
  }

 exp3.operands [meta] [collection].value_type =operands_type_relational

  exp3.operands = {
    ref.clocks.y1,
    ref.clocks.x1,
}

local condition_params = Layer.new{}



 condition_params [refines] = {
      inferiorequal_operation,
  }

condition_params.operands [meta] [collection].value_type =operands_type_relational
 
 condition_params.operands = {
    ref.parameters.p1,
    cte1 = {
      value=10,
    }
}

--Remplissage de l'ensemble d'invariants (regarder diapo sur svn)
  instance.invariants = {
    exp1,
    exp2,
    exp3,
    condition_params,
    }

  --Affecter conditions sur les paramètres à condition_params (ensemble K sur diapo)
   instance.condition_params = ref.invariants.condition_params
   


  --Remplissage de l'ensemble alphabet

   instance.alphabets = {
    a1 = {
      value="a1",
    },
    a2 = {
      value="a2",
    },
    b1 = {
      value="b1",
    },
    b2 = {
      value="b2",
    }
  }
  -- Remplissage de l'ensemble des états
   instance.states = {
    e0 = {
      value="e0",
      initial = {
      value=true,
      },
      final = {
        value=false,
      }
    },
    e1 = {
      value="e1",
      initial = {
        value=false,
      },
      final = {
        value=false,
      }
    },
    e2 = {
      value="e2",
      initial = {
        value=false,
        },
      final = {
        value=false,
      },
      invariant = ref.invariants.exp3,
    },
    e3 = {
      value="e3",
      initial = {
        value=false,
        },
      final = {
        value=true,
      }
    }
  }
  
 --Remplissage de l'ensemble des transitions
  instance.transitions = {
    t1 = {
      arrows = {
        { vertex = ref.states.e0,
          input = {
          value  = true 
          }
          },
        { vertex = ref.states.e1,
          output = {
          value = true 
          },
        }
      },
      letter=ref.alphabets.a1,
      guard=ref.invariants.exp1,
    },
    t2 = {
      arrows = {
        { vertex = ref.states.e1,
          input = {
          value  = true 
          }
        },
        { vertex = ref.states.e2,
          output = {
            value = true 
          }
        }
      },
      letter=ref.alphabets.a1,
      guard=ref.invariants.exp2
    },
    t3 = {
      arrows = {
        { vertex = ref.states.e2,
          input = {
          value  = true 
          }
        },
        { vertex = ref.states.e1,
          output = {
          value = true 
        }
      }
      },
      letter = ref.alphabets.b1,
      resets = {
        ref.clocks.y1,
      }
    },
    t4 = {
      arrows = {
        { vertex = ref.states.e2,
          input = {
          value  = true 
          }
        },
        { vertex = ref.states.e3,
          output = {
            value = true 
            }
          }
      },
      letter = ref.alphabets.b2
     }
    }
  


end
