-- local lp = require("lulpeg")
local lp = require("lpeg")

local function node (p)
  return p / function (left, op, right)
    return { op, left, right }
  end
end

local function node_postfix (p)
  return p / function (left, op)
    return { op, left }
  end
end

local function node_prefix (p)
  return p / function (op, right)
    return { op, right }
  end
end

local function ternary_node (p)
  return p / function (left, op1, middle, op2, right)
    return { left, op1, middle, op2, right}
  end
end

local function nary_node (p)
  return p / function (...)
    return { ... }
  end
end

local str = ""
local function printrec (t, f)
  if f then
    str = str .. "{"
  else
    str = str .. " {"
  end
  if type(t) == "table" then
    for _, v in pairs(t) do
      if type(v) == "table" then
        printrec(v, false)
      else
        str = str .. " " .. v
      end
    end
  else
    str = str .. t
  end
  str = str .. " }"
end

-- assert(false)

local white = lp.S(" \t") ^ 0

local value_types = {
  ["number"]   = (lp.R("09") ^ 1 / tonumber),
  ["variable"] = (lp.R("az") ^ 1 / tostring),
  ["boolean"]  = (lp.R("09") ^ 1 / tonumber + lp.R("az") ^ 1 / tostring)
}

local op_plus = {
  priority   = 11,
  operator   = "+",
  value_type = "",
  n_operands = 2,
  type       = "binary",
}

local op_minus = {
  priority   = 11,
  operator   = "-",
  value_type = "",
  n_operands = 2,
  type       = "binary",
}

local op_modulo = {
  priority   = 12,
  operator   = "%",
  value_type = "",
  n_operands = 2,
  type       = "binary",
}

local op_multiplication = {
  priority   = 12,
  operator   = "*",
  value_type = "",
  n_operands = 2,
  type       = "binary",
}

local op_literal = {
  priority   = 15,
  operator   = "",
  value_type = "number",
  n_operands = 1,
  type       = "literal",
}

local op_variable = {
  priority   = 14,
  operator   = "",
  value_type = "variable",
  n_operands = 1,
  type       = "literal",
}

local op_unary = {
  priority   = 13,
  operator   = "!",
  value_type = "number",
  n_operands = 1,
  type       = "unary_postfix"
}

local op_negative = {
  priority   = 13,
  operator   = "-",
  value_type = "number",
  n_operands = 1,
  type       = "unary_prefix"
}

local op_ternary = {
  priority   = 0,
  operator   = {
    "if",
    "else"
  },
  value_type = "",
  n_operands = 3,
  type       = "ternary"
}

local op_ternary2 = {
  priority   = 0,
  operator   = {
    "?",
    ":"
  },
  value_type = "",
  n_operands = 3,
  type       = "ternary"
}

local op_equals = {
  priority   = 10,
  operator   = "==",
  value_type = "",
  n_operands = 2,
  type       = "binary"
}

local op_le = {
  priority   = 10,
  operator   = "<=",
  value_type = "",
  n_operands = 2,
  type       = "binary"
}

local op_ge = {
  priority   = 10,
  operator   = ">=",
  value_type = "",
  n_operands = 2,
  type       = "binary"
}

local op_or = {
  priority   = 8,
  operator   = "||",
  value_type = "",
  n_operands = 2,
  type       = "binary"
}

local op_and = {
  priority   = 9,
  operator   = "&&",
  value_type = "",
  n_operands = 2,
  type       = "binary"
}

local op_sum = {
  priority   = 14,
  operator   = "sum",
  value_type = "",
  n_operands = 2,
  type       = "nary"
}

local expression = {
  r_number         = op_literal,
  r_sum            = op_sum,
  r_plus           = op_plus,
  r_minus          = op_minus,
  r_multiplication = op_multiplication,
  r_not            = op_unary,
  -- r_variable       = op_variable,
  r_modulo         = op_modulo,
  r_if             = op_ternary,
  r_negative       = op_negative,
  r_ternary        = op_ternary2,
  r_equal          = op_equals,
  r_less_equal     = op_le,
  r_greater_equal  = op_ge,
  r_or             = op_or,
  r_and            = op_and,
}


-- local function tlen (t)
--   local i = 0
--   for _ in pairs (t) do
--     i = i + 1
--   end
--   return i
-- end


local function sort_by_priority(t)
  local nt = {}
  local i  = 1

  for _, v in pairs (t) do
    nt[i] = v
    i = i + 1
  end

  table.sort (nt, function (op1, op2)
      return op1.priority > op2.priority
  end)

  return nt
end

-- Hashmap for the patterns so we don't need
-- a ton of `if - else if - else` statements
-- for the different types of operators
local patterns = {
  binary = function (operator, around)
    local op_repr = lp.C(lp.P(operator.operator))
    return node(around * white * op_repr * white * (lp.V(operator.priority) + around))
  end,

  unary_prefix = function (operator, around)
    local op_repr = lp.C(lp.P(operator.operator))
    return node_prefix(white * op_repr * white * (lp.V(operator.priority) + around))
  end,

  literal = function (literal)
    return value_types[literal.value_type]
  end,

  ternary = function (operator, around)
    local first = operator.operator[1]
    local second = operator.operator[2]

    first  = lp.C(lp.P(first))
    second = lp.C(lp.P(second))

    return ternary_node(
      around * white * first * white * (lp.V(operator.priority) + around)
      * white * second * white * (lp.V(operator.priority) + around)
    )
  end,

  unary_postfix = function (operator, around)
    local op_repr = lp.C(lp.P(operator.operator))

    return node_postfix(white * around * op_repr * (white + lp.V(operator.priority)))
  end,

  nary = function (operator, around)
    local op_repr = lp.C(lp.P(operator.operator))

    return nary_node(
          white *
          op_repr *
           white
           * lp.P("(") * white *
           ((lp.V(operator.priority) + around) * white * (lp.P(",") + white) * white) ^ 1 *
            white * lp.P(")") * white *
            (lp.V(operator.priority) + around + white)
          )
  end,
}

-- Adds the expression to the corresponding priority
-- of the expression
local function add_expr(grammar, expr, priority, second_pass, it)
  if not second_pass then
    if grammar[priority] == nil then
      grammar[priority] = expr
    else
      grammar[priority] = grammar[priority] + expr
    end
  else
    if it == 1 then
      grammar[priority] = expr
    else
      grammar[priority] =  grammar[priority] + expr
    end
  end
  return grammar
end

-- Builds the grammar up from the bottom,
-- i.e. we start with the highest priority operators
-- and end with the lowest ones
local function build_grammar(expr)
  local grammar = { "axiom" }

  expr = sort_by_priority(expr)

  local prior_exprs       = {}
  local prior_exprs_count = 1

  local nary_counter = 0
  local nary_table   = {}

  local old_priority = expr[1].priority

  for _, v in pairs (expr) do
    local around, stop

    -- We do this because we don't want to include expressions
    -- that have the same priority in the expressions that are going to left / right
    -- hand sides of the expression
    if v.priority == old_priority then
      stop = prior_exprs_count - 1
    else
      stop = prior_exprs_count
    end

    -- Add the prior expressions to put
    -- on the left / right hand sides of the current operator
    for i = 1, stop, 1 do
      if around ~= nil then
        around = lp.V(prior_exprs[i]) + around
      else
        around = lp.V(prior_exprs[i])
      end
    end

    grammar = add_expr(grammar, patterns[v.type](v, around), v.priority)

    if v.type == "nary" then
      nary_counter             = nary_counter + 1
      nary_table[nary_counter] = v
    end

    if v.priority ~= old_priority then
      prior_exprs_count = prior_exprs_count + 1
    end

    prior_exprs[prior_exprs_count] = v.priority
    old_priority = v.priority
  end

  -- second pass for naries
  grammar[nary_table[1].priority] = nil
  for i = 1, nary_counter, 1 do
    local stop, around

    local op = nary_table[i]

    stop = prior_exprs_count

    -- Add the prior expressions to put
    -- on the left / right hand sides of the current operator
    for j = 1, stop, 1 do
      if prior_exprs[j] ~= op.priority then
        if around ~= nil then
          around = lp.V(prior_exprs[j]) + around
        else
          around = lp.V(prior_exprs[j])
        end
      end
      print(prior_exprs[j])
    end

    grammar = add_expr(grammar, patterns[op.type](op, around), op.priority, true, i)
  end

  for i = 1, prior_exprs_count, 1 do
    if grammar.axiom == nil then
      grammar.axiom = lp.V(prior_exprs[i])
    else
      grammar.axiom = lp.V(prior_exprs[i]) + grammar.axiom
    end
  end

  return lp.P(grammar)
end


local g4    = build_grammar(expression)
local input = io.read()
-- lp.pprint(g4) -- doesn't work with lpeg, have to use lulpeg package for this
while input ~= "d" do
  -- local result = g4:match("sum(20, 30, 40,) + 90")
  local result = g4:match(input)
  str = ""
  if type(result) == "table" then
    printrec(result)
  else
    str = result
  end

  print(str)
  input = io.read()
end
