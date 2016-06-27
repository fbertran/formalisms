

  local instance ={}

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

local exp0  = {}

exp0.operator={}


exp0.operator.value=">="
exp0.operands = {
  instance.clocks.x,
  instance.parameters.p1
}

-- x=10
local exp1  = {}

local cte1 = {}

cte1.value=10

exp1.operator={}

exp1.operator.value="="
exp1.operands = {
  instance.clocks.x,
  cte1
}
-- p3=y
local exp2  = {}


exp2.operator={}

exp2.operator="="
exp2.operands = {
  instance.parameters.p3,
  instance.clocks.y
}

--p2=y
local exp3  = {}

exp3.operator={}

exp3.operator.value="="

exp3.operands = {
  instance.parameters.p2,
  instance.clocks.y
}


--10>=x
local exp4  = {}
local cte4 = {}

cte4.value=10
exp4.operator={}

exp4.operator.value=">="

exp4.operands = {
  cte4,
  instance.clocks.x
}

--p3>=y

local exp5  = {}

exp5.operator={}

exp5.operator.value=">="

exp5.operands = {
  instance.parameters.p3,
  instance.clocks.y
}

--p2>=y

local exp6  = {}

exp6.operator={}

exp6.operator.value=">="
exp6.operands = {
  instance.parameters.p2,
  instance.clocks.y
}

--p2=y


local exp7  = {}

exp7.operator={}

exp7.operator.value="="
exp7.operands = {
  instance.parameters.p2,
  instance.clocks.y
}

--Contrainte Initiale
--p1 >=0

local exp8  = {}
local cte8 = {}

cte8.value=0
exp8.operator={}

exp8.operator.value=">="
exp8.operands = {
  instance.parameters.p1,
  cte8
}

--p2>=0

local exp9  = {}

local cte9 = {}

cte9.value=0


exp9.operator={}

exp9.operator.value=">="
exp9.operands = {
  instance.parameters.p2,
  cte9
}

--p3>=0


local exp10  = {}

local cte10 = {}

cte10.value=0

exp10.operator={}

exp10.operator.value=">="
exp10.operands = {
  instance.parameters.p3,
  cte10
}

--p1>=0 && p2>=0 && p3>=0

local exp11  = {}

exp11.operator={}

exp11.operator.value="&&"

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

instance.condition_params = instance.invariants.exp11

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
    invariants= instance.invariants.exp4
  },
add_sugar = {
  value="add_sugar",
  initial = {
    value=false,
  },
  final = {
    value=false,
  },
  invariants= instance.invariants.exp6

},
preparing_coffee = {
  value="preparing_coffee",
  initial = {
    value=false,
  },
  final = {
    value=false,
  },
  invariants= instance.invariants.exp5
  },
}

instance.transitions = {
  t1 = {
    arrows = {
    { vertex = instance.states.idle,
      input = {
        value  = true 
      }
    },
    { vertex = instance.states.add_sugar,
      output = {
        value = true 
      },
    }
  },
  letter=instance.alphabets.press,
  resets = {
    instance.clocks.x,
    instance.clocks.y
  }
},

  t2 = {
    arrows = {
    { vertex = instance.states.add_sugar,
      input = {
        value  = true 
      }
    },
    { vertex = instance.states.preparing_coffee,
      output = {
        value = true 
      },
    }
  },
  letter=instance.alphabets.cup,
  guard = instance.invariants.exp7
},

  t3 = {
    arrows = {
      { vertex = instance.states.preparing_coffee,
        input = {
          value  = true 
        }
      },
      { vertex = instance.states.cdone,
        output = {
          value = true 
        },
      }
    },
    letter=instance.alphabets.coffee,
    resets = {
      instance.clocks.x
    }
  },

  t4 = {
    arrows = {
      { vertex = instance.states.cdone,
        input = {
          value  = true 
        }
      },
      { vertex = instance.states.add_sugar,
        output = {
          value = true 
        },
      }
    },
    letter=instance.alphabets.press,
    resets = {
      instance.clocks.x,
      instance.clocks.y
    }
  },

  t5 = {
    arrows = {
      { vertex = instance.states.cdone,
        input = {
          value  = true 
        }
      },
      { vertex = instance.states.idle,
        output = {
          value = true 
        },
      }
    },
    letter=instance.alphabets.sleep,
    guard=instance.invariants.exp1
  },

}

print (instance.clocks.x.value)

