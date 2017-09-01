local parser = require "parser"

require "busted.runner" {}

-- http://lua-users.org/lists/lua-l/2014-09/msg00421.html
local function deepcompare(t1,t2,ignore_mt)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  -- non-table types can be directly compared
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then return t1 == t2 end
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not deepcompare(v1,v2) then return false end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not deepcompare(v1,v2) then return false end
  end
  return true
end


local literal = {
  priority   = 15,
  operator   = "",
  value_type = "number",
  type       = "literal",
}

local bool = {
  priority   = 15,
  operator   = "",
  value_type = "boolean",
  type       = "literal"
}

local variable = {
  priority   = 15,
  operator   = "",
  value_type = "variable",
  type       = "literal"
}

local plus = {
  priority   = 11,
  operator   = "+",
  type       = "binary",
  left_assoc = true
}

local minus = {
  priority   = 11,
  operator   = "-",
  type       = "binary",
  left_assoc = true
}

local negation = {
  priority   = 14,
  operator   = "-",
  type       = "unary_prefix",
}

local multiplication = {
  priority   = 12,
  operator   = "*",
  left_assoc = true,
  type       = "binary"
}

local not_op = {
  priority = 14,
  operator = "~",
  type     = "unary_postfix"
}

local nary = {
  priority = 15,
  operator = "sum",
  type     = "nary"
}


local ternary = {
  operator = {
    [1] = "?", [2] = ":"
  },
  type = "ternary",
  priority = 2
}

local ternary_alternative = {
  operator  = "if",
  operator2 = "then",
  operator3 = "else",
  type      = "ternary_alternative",
  priority  = 15,
}

local exp1 = {
  literal  = literal,
}

local exp2 = {
  literal = literal,
  mult    = multiplication,
  plus    = plus
}

local exp3 = {
  literal,
  multiplication,
  plus,
  not_op,
}

local exp4 = {
  literal = literal,
  n       = not_op,
}

local exp5 = {
  literal,
  nary,
  plus
}

local exp6 = {
  literal,
  ternary,
  plus,
  multiplication,
  not_op
}

local exp7 = {
  literal,
  negation,
  minus
}

local exp8 = {
  literal,
  minus,
  plus
}

local exp9 = {
  literal,
  plus,
  not_op
}

local exp10 = {
  literal,
  minus,
  negation
}

local exp11 = {
  bool,
  multiplication
}

local exp12 = {
  literal,
  variable,
  plus,
  multiplication,
  nary
}

local exp13 = {
  literal,
  variable,
  plus,
  multiplication,
  ternary_alternative
}

local expressions = {
  {
    expression        = exp1,
    expression_string = "1234567",
    expected          = "1234567"
  },
  {
    expression        = exp2,
    expression_string = "1 + 2 * 3",
    expected          = {
      left    = "1",
      op      = "+",
      op_type = "binary",
      right   = {
        left    = "2",
        op      = "*",
        op_type = "binary",
        right   = "3"
      }
    }
  },
  {
    expression        = exp3,
    expression_string = "(1 + 2) * 3~",
    expected          = {
      left = { {
        left = "1",
        right = "2",
        op = "+",
        op_type = "binary"
      } },
      right = {
        op = "~",
        left = "3",
        op_type = "unary_postfix"
      },
      op = "*",
      op_type = "binary"
    }
  },
  {
    expression        = exp4,
    expression_string = "3 ~ ~ ~ ~",
    expected          = {
      left = {
        left = {
          left = {
            left    = "3",
            op      = "~",
            op_type = "unary_postfix"
          },
          op      = "~",
          op_type = "unary_postfix"
        },
        op      = "~",
        op_type = "unary_postfix"
      },
      op      = "~",
      op_type = "unary_postfix"
    }
  },
  {
    expression        = { literal },
    expression_string = "((((5))))",
    expected          = { { { { "5" } } } }
  },
  {
    expression        = exp5,
    expression_string = "9 + sum(30 + 2, 5) + 3",
    expected          = {
      left = {
        left = "9",
        right = {
          op = "sum",
          op_type = "nary",
          operands = {
            {
              left = "30",
              right = "2",
              op    = "+",
              op_type = "binary"
            },
            { "5" }
          }
        },
        op_type = "binary",
        op = "+",
      },
      op = "+",
      op_type = "binary",
      right   = "3"
    }
  },
  {
    expression        = exp6,
    expression_string = "30 + 20 ? ((90 + 30 + 2) * 3) : 300",
    expected          = {
      left = {
        left = "30",
        right = "20",
        op    = "+",
        op_type = "binary"
      },
      middle = { {
        left = { {
          left = {
            left = "90",
            right = "30",
            op = "+",
            op_type = "binary"
          },
          right = "2",
          op = "+",
          op_type = "binary"
        } },
        right = "3",
        op = "*",
        op_type = "binary"
      } },
      right = "300",
      op1 = "?",
      op2 = ":",
      op_type = "ternary"
    }
  },
   {
     expression = exp7,
     expression_string = "-3",
     expected          = {
       right   = "3",
       op      = "-",
       op_type = "unary_prefix"
     }
   },
   {
     expression        = exp8,
     expression_string = "3 - 2 - 1",
     expected          = {
       left = {
         left = "3",
         op   = "-",
         op_type = "binary",
         right = "2",
       },
       op = "-",
       op_type = "binary",
       right = "1",
     }
   },
  {
    expression        = exp8,
    expression_string = "3 + 2 - 1",
    expected          = {
      left = {
        left = "3",
        op      = "+",
        op_type = "binary",
        right = "2"
      },
      op = "-",
      right = "1",
      op_type = "binary"
    }
  },
  {
    expression = exp9,
    expression_string = "1 + 2 + 3 + 4",
    expected = {
      left = {
        left = {
          left    = "1",
          op      = "+",
          op_type = "binary",
          right   = "2"
        },
        op = "+",
        op_type = "binary",
        right = "3"
      },
      op = "+",
      op_type = "binary",
      right = "4"
    }
  },
  {
    expression = exp10,
    expression_string = "1 - 2 - -3",
    expected = {
      left = {
        left = "1",
        op = "-",
        op_type = "binary",
        right = "2",
      },
      op_type = "binary",
      op = "-",
      right = {
        right = "3",
        op = "-",
        op_type = "unary_prefix"
      }
    }
  },
  {
    expression        = exp11,
    expression_string = "true * false",
    expected          = {
      left    = "true",
      op      = "*",
      op_type = "binary",
      right   = "false",
    }
  },
  {
    expression        = exp12,
    expression_string = "hello + sum(90 * one1)",
    expected          = {
      left    = "hello",
      op      = "+",
      op_type = "binary",
      right   = {
        op        = "sum",
        operands  = { {
          left    = "90",
          op      = "*",
          op_type = "binary",
          right   = "one1"
        } },
        op_type = "nary",
      }
    }
  },
  {
    expression        = exp13,
    expression_string = "if hello then null else 35",
    expected          = {
      left    = "hello",
      middle  = "null",
      right   = "35",
      op      = "if",
      op2     = "then",
      op3     = "else",
      op_type = "ternary_alternative",
    }
  },
  {
    expression        = exp13,
    expression_string = "if 5 * 2 then null else 35 + 20",
    expected          = {
      left    = {
        left    = "5",
        op      = "*",
        op_type = "binary",
        right   = "2",
      },
      middle  = "null",
      right   = {
        left    = "35",
        op      = "+",
        op_type = "binary",
        right   = "20",
      },
      op      = "if",
      op2     = "then",
      op3     = "else",
      op_type = "ternary_alternative",
    }
  },
  {
    expression        = exp3,
    expression_string = "1 * 2 * 3 * 4~",
    expected          = {
      left = {
        left = {
          left    = "1",
          op      = "*",
          op_type = "binary",
          right   = "2",
        },
        op      = "*",
        op_type = "binary",
        right   = "3",
      },
      op      = "*",
      op_type = "binary",
      right   = {
        left    = "4",
        op      = "~",
        op_type = "unary_postfix"
      }
    }
  },
  {
    expression        = exp3,
    expression_string = "1 * 2 * 3 * 4~ + 1",
    expected          = {
      left = {
        left = {
          left = {
            left    = "1",
            op      = "*",
            op_type = "binary",
            right   = "2",
          },
          op      = "*",
          op_type = "binary",
          right   = "3",
        },
        op      = "*",
        op_type = "binary",
        right   = {
          left    = "4",
          op      = "~",
          op_type = "unary_postfix"
        }
      },
      op      = "+",
      op_type = "binary",
      right   = "1"
    }
  }
}


describe("parser", function ()
  it("doesnt accept empty grammars", function ()
    assert.is_nil(parser())
  end)

  for _, v in ipairs(expressions) do
    local p      = parser(v.expression)
    local result = p:match(v.expression_string)

    it("parses correctly, input = " .. v.expression_string, function ()
      assert.is_true(deepcompare(result, v.expected, true))
    end)
  end
end)
