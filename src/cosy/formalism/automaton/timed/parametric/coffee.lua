return function (Layer, instance, ref)

local meta       =  Layer.key.meta
local refines    =  Layer.key.refines

local collection  = Layer.require "cosy/formalism/data.collection"

local parametric_timed_automaton  = Layer.require "cosy/formalism/automaton/parametric_timed_automaton"


local relational_operation  = Layer.require "cosy/formalism/operation/relational_operation"


local equal_operation = Layer.require "cosy/formalism/operation/equal_operation"
local superiorequal_operation = Layer.require "cosy/formalism/operation/superiorequal_operation"
local and_operation = Layer.require "cosy/formalism/operation/and_operation"

instance [refines] = {
  parametric_timed_automaton,
}

local operands_type_relational = Layer.new{}


instance[meta].parameter_type.value.value_type="string"
instance [meta].alphabet_type.value.value_type="string"

instance.parameters_type [refines] = {
  relational_operation,
}

instance  [meta] = {
  number_type = {
    [refines] = {
      Layer.require "cosy/formalism/literal/number",
      operands_type_relational,
    }
  }
}
relational_operation [refines] = {
  operands_type_relational,
}

instance[meta].parameter_type = {
  [refines] = {
    operands_type_relational,
  }
}
instance[meta].clock_type = {
  [refines] = {
    operands_type_relational,
  }
}

instance.clocks = {
  y = {
    value="y",
  },
  x = {
    value="x",
  }
}
instance.parameters = {
  p1 = {
    value="p1",
  },
  p2 = {
    value="p2",
  },
  p3 = {
    value="p3",
  }
}
--x>=p1

local exp0  = Layer.new{}

exp0 [refines] = {
  superiorequal_operation,
}
exp0.operands [meta] [collection].value_type =operands_type_relational

exp0.operands = {
  ref.clocks.x,
  ref.parameters.p1
}

-- x=10
local exp1  = Layer.new{}
local cte1 = Layer.new{}
cte1 [refines] = {
  ref[meta].number_type,
}
cte1.value=10
exp1 [refines] = {
  equal_operation,
}
exp1.operands [meta] [collection].value_type =operands_type_relational

exp1.operands = {
  ref.clocks.x,
  cte1
}
-- p3=y
local exp2  = Layer.new{}

exp2 [refines] = {
  equal_operation,
}
exp2.operands [meta] [collection].value_type =operands_type_relational

exp2.operands = {
  ref.parameters.p3,
  ref.clocks.y
}

--p2=y
local exp3  = Layer.new{}

exp3 [refines] = {
  superiorequal_operation,
}
exp3.operands [meta] [collection].value_type =operands_type_relational

exp3.operands = {
  ref.parameters.p2,
  ref.clocks.y
}


--10>=x
local exp4  = Layer.new{}
local cte4 = Layer.new{}
cte4 [refines] = {
  ref[meta].number_type,
}
cte4.value=10
exp4 [refines] = {
  superiorequal_operation,
}
exp4.operands [meta] [collection].value_type =operands_type_relational

exp4.operands = {
  cte4,
  ref.clocks.x
}

--p3>=y

local exp5  = Layer.new{}

exp5 [refines] = {
  superiorequal_operation,
}
exp5.operands [meta] [collection].value_type =operands_type_relational

exp5.operands = {
  ref.parameters.p3,
  ref.clocks.y
}

--p2>=y

local exp6  = Layer.new{}

exp6 [refines] = {
  superiorequal_operation,
}
exp6.operands [meta] [collection].value_type =operands_type_relational

exp6.operands = {
  ref.parameters.p2,
  ref.clocks.y
}

--p2=y


local exp7  = Layer.new{}

exp7 [refines] = {
  equal_operation,
}
exp7.operands [meta] [collection].value_type =operands_type_relational

exp7.operands = {
  ref.parameters.p2,
  ref.clocks.y
}

--Contrainte Initiale
--p1 >=0

local exp8  = Layer.new{}

local cte8 = Layer.new{}

cte8 [refines] = {
  ref[meta].number_type,
}
cte8.value=0
exp8 [refines] = {
  superiorequal_operation,
}
exp8.operands [meta] [collection].value_type =operands_type_relational

exp8.operands = {
  ref.parameters.p1,
  cte8
}

--p2>=0

local exp9  = Layer.new{}

local cte9 = Layer.new{}

cte9 [refines] = {
  ref[meta].number_type,
}
cte9.value=0

exp9 [refines] = {
  superiorequal_operation,
}
exp9.operands [meta] [collection].value_type =operands_type_relational

exp9.operands = {
  ref.parameters.p2,
  cte9
}

--p3>=0


local exp10  = Layer.new{}

local cte10 = Layer.new{}

cte10 [refines] = {
  ref[meta].number_type,
}
cte10.value=0


exp10 [refines] = {
  superiorequal_operation,
}
exp10.operands [meta] [collection].value_type =operands_type_relational

exp10.operands = {
  ref.parameters.p3,
  cte10
}

--p1>=0 && p2>=0 && p3>=0

local exp11  = Layer.new{}

exp11 [refines] = {
  and_operation,
}
exp11.operands [meta] [collection].value_type =operands_type_relational

exp11.operands = {
  exp8,
  exp9,
  exp10
}


instance.invariants = {
  exp0,
  exp1,
  exp2,
  exp3,
  exp4,
  exp5,
  exp6,
  exp7,
  exp8,
  exp9,
  exp10,
  exp11
}

instance.condition_params = ref.invariants.exp11

instance.alphabets = {
  press = {
   value="press",
  },
  sleep = {
    value="sleep",
  },
  coffee = {
    value="coffee",
  },
  cup = {
    value="cup",
  }
}

instance.states = {
  idle = {
    value = "idle",
    initial = {
      value=true,
    },
    final = {
      value=false,
    }
  },
  cdone = {
    value="cdone",
    initial = {
      value=false,
    },
    final = {
      value=false,
    },
    invariants= ref.invariants.exp4
  },
  add_sugar = {
    value="add_sugar",
    initial = {
     value=false,
    }, 
    final = {
     value=false,
    },
    invariants= ref.invariants.exp6
  },
  preparing_coffee = {
   value="preparing_coffee",
    initial = {
      value=false,
    },
    final = {
      value=false,
    },
    invariants= ref.invariants.exp5
  },
}

instance.transitions = {
  t1 = {
    arrows = {
       { vertex = ref.states.idle,
          input = {
            value  = true 
          }
        },
        { vertex = ref.states.add_sugar,
          output = {
            value = true 
          },
        }
      },
      letter=ref.alphabets.press,
      resets = {
        ref.clocks.x,
        ref.clocks.y
      }
    },

  t2 = {
    arrows = {
        { vertex = ref.states.add_sugar,
          input = {
            value  = true 
          }
        },
        { vertex = ref.states.preparing_coffee,
          output = {
            value = true 
          },
        }
      },
      letter=ref.alphabets.cup,
      guard = ref.invariants.exp7
    },

  t3 = {
    arrows = {
        { vertex = ref.states.preparing_coffee,
          input = {
            value  = true 
          }
        },
        { vertex = ref.states.cdone,
          output = {
            value = true 
          },
        }
      },
      letter=ref.alphabets.coffee,
      resets = {
        ref.clocks.x
      }
    },

  t4 = {
    arrows = {
        { vertex = ref.states.cdone,
          input = {
            value  = true 
          }
        },
        { vertex = ref.states.add_sugar,
          output = {
            value = true 
          },
        }
    },
    letter=ref.alphabets.press,
    resets = {
      ref.clocks.x,
      ref.clocks.y
    }
  },

  t5 = {
    arrows = {
        { vertex = ref.states.cdone,
          input = {
            value  = true 
          }
        },
        { vertex = ref.states.idle,
          output = {
            value = true 
          },
        }
    },
    letter=ref.alphabets.sleep,
    guard=ref.invariants.exp1
  },

}


return  instance
end