-- local lp = require("lpeg")
-- local lp = require("lpeglabel")

local lp
local prefix = "prefix"

if arg[1] ~= nil then
  lp = require(arg[1])
else
  lp = require("lpeg")
end

local op_map = {}

local str = ""
local function table_to_string (t, f)
  if f then
    str = str .. "{"
  else
    str = str .. " {"
  end
  if type(t) == "table" then
    for _, v in pairs(t) do
      if type(v) == "table" then
        table_to_string(v, false)
      else
        str = str .. " " .. tostring(v)
      end
    end
  else
    str = str .. t
  end
  str = str .. " }"
end

local function ptable(t)
  str = ""
  table_to_string(t, true)
  print(str)
end
-- assert(false)

local white = lp.S(" \t") ^ 0

local value_types = {
  ["number"]   = lp.C(lp.R("09") ^ 1), -- / tonumber),
  ["variable"] = (lp.R("az") ^ 1 * (lp.R("az") + lp.R("09")) ^ 0) / tostring,
  ["boolean"]  = (lp.R("09") ^ 1 / tonumber + lp.R("az") ^ 1 / tostring)
}

local op_plus = {
  priority   = 11,
  operator   = "+",
  value_type = "",
  type       = "binary",
  left_assoc = true
}

local op_minus = {
  priority   = 11,
  operator   = "-",
  value_type = "",
  type       = "binary",
  left_assoc = true,
}

local op_modulo = {
  priority   = 12,
  operator   = "%",
  value_type = "",
  type       = "binary",
}

local op_multiplication = {
  priority   = 12,
  operator   = "*",
  value_type = "",
  type       = "binary",
  left_assoc = true
}

local op_division = {
  priority   = 12,
  operator   = "/",
  value_type = "",
  type       = "binary",
  left_assoc = true
}

local op_literal = {
  priority   = 15,
  operator   = "",
  value_type = "number",
  type       = "literal",
}

local op_variable = {
  priority   = 15,
  operator   = "",
  value_type = "variable",
  type       = "literal",
}

local op_unary = {
  priority   = 14,
  operator   = "~",
  type       = "unary_postfix"
}

local op_negative = {
  priority   = 13,
  operator   = "-",
  type       = "unary_prefix"
}

local op_ternary = {
  priority   = 14,
  operator   = {
    "if",
    "else"
  },
  type       = "ternary"
}

local op_ternary2 = {
  priority   = 2,
  operator   = {
    "?",
    ":"
  },
  value_type = "",
  type       = "ternary"
}

local op_equals = {
  priority   = 10,
  operator   = "==",
  value_type = "",
  type       = "binary"
}

local op_le = {
  priority   = 10,
  operator   = "<=",
  value_type = "",
  type       = "binary"
}

local op_ge = {
  priority   = 10,
  operator   = ">=",
  value_type = "",
  type       = "binary"
}

local op_or = {
  priority   = 8,
  operator   = "||",
  value_type = "",
  type       = "binary"
}

local op_and = {
  priority   = 9,
  operator   = "&&",
  value_type = "",
  type       = "binary"
}

local op_sum = {
  priority   = 15,
  operator   = "sum",
  value_type = "",
  type       = "nary"
}

local op_pi = {
  priority   = 14,
  operator   = "mult",
  value_type = "",
  type       = "nary"
}

local op_assignment = {
  priority   = 7,
  operator   = "=",
  value_type = "number",
  type       = "binary"
}

local exp_op = {
  priority = 13,
  type = "binary",
  operator = "**"
}

local expression = {
  r_number         = op_literal,
  r_multiplication = op_multiplication,
  r_division       = op_division,
  r_plus           = op_plus,
  r_minus          = op_minus,
  r_exp            = exp_op,
  -- -- -- r_variable       = op_variable,
  -- -- -- -- -- r_modulo         = op_modulo,
  -- r_if             = op_ternary,
  r_not            = op_unary,
  r_negative       = op_negative,
  r_ternary        = op_ternary2,
  -- -- -- r_equal          = op_equals,
  -- -- r_less_equal     = op_le,
  r_greater_equal  = op_ge,
  -- -- r_or             = op_or,
  -- -- r_and            = op_and,
  r_sum            = op_sum,
  -- -- r_pi             = op_pi,
  -- r_assignment     = op_assignment,
}


local function tlen(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
  end
  return i
end


-- This is so we get a table sorted by priority,
-- and so the table is structured 1, 2, 3, ... etc.
-- else when iterating over it with the `pairs` function
-- we get the elements in the wrong order (they are sorted alphabetically)
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


local function node_postfix (p)

  local function construct(...)
    local list = ...

    local function rec(n, t)
      if n == tlen(list) then
        return { list[n] }
      else
        t = { list[n], rec(n + 1, { t }) }
      end
      return t
    end

    return rec(1, { })
  end

  return p / function (value, ...)
    return { value, construct({ ... }) }
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
  return p / function (op, ...)
    local arglist = { }
    local arglen  = select("#", ...)

    for i = 1, arglen, 1 do
      local v = select(i, ...)
      if type(v) ~= "table" then
        arglist[i] = { v }
      else
        arglist[i] = v
      end
    end

    return { op, arglist }
  end
end

local function find_operator(t)
  local ctr = 1
  for _, v in ipairs(t) do
    if type(v) == "string" and op_map[v] ~= nil then
      return ctr
    end
    ctr = ctr + 1
  end
end

local function lassoc(p, _op)

  local function fn(left, op, right)
    if type(right) == "table" then
      if tlen(right) ~= 3 then
        -- it's not a binary operator, so left / right associativity doesn't apply
        return { left, op, right }
      end

      -- we have to take precedence into account
      if op_map[right[find_operator(right)]].priority > _op.priority then
        return { left, op, right }
      end

      return fn({ left, op, right[1] }, right[2], right[3])
    else
      if type(left) == "table" then
        left = fn(left[1], left[2], left[3])
      end

      return { left, op, right }
    end
  end

  return p / fn
end


-- Hashmap for the patterns so we don't need
-- a ton of `if - else if - else` statements
-- for the different types of operators
local patterns = {
  binary = function (operator, curr_expr, next_expr)
    local op_repr = lp.C(lp.P(operator.operator))

    local pattern = (white * next_expr * white * op_repr * white * (curr_expr + next_expr) * white)

    if operator.left_assoc then
      pattern = lassoc(pattern, operator)
    else
      pattern = lp.Ct(pattern)
    end

    return pattern
  end,

  unary_prefix = function (operator, curr_expr, next_expr)
    local op_repr = lp.C(lp.P(operator.operator))
    return node_prefix(white * (op_repr * white * (curr_expr + next_expr + white)))
  end,

  unary_postfix = function (operator, curr_expr, next_expr)
    local op_repr = lp.C(lp.P(operator.operator))

    return node_postfix(white * next_expr * white * op_repr^1 * (white + curr_expr))
  end,

  literal = function (literal)
    return value_types[literal.value_type]
  end,

  ternary = function (operator, _, expr)
    local first  = operator.operator[1]
    local second = operator.operator[2]

    first  = lp.C(lp.P(first))
    second = lp.C(lp.P(second))

    return ternary_node(
      expr * white * first * white * lp.V("axiom")
      * white * second * white * expr
    )
  end,

  nary = function (operator)
    local op_repr = lp.C(lp.P(operator.operator))

    return nary_node(
             white *
             op_repr *
             white
             * lp.P("(") * white *
             lp.V("axiom") * white * ("," * white * lp.V("axiom")) ^ 0 *
             white * lp.P(")") * white
           )
  end,
}

-- Adds the expression to the corresponding priority
-- of the expression
local function add_expr(grammar, expr, expr_ref)
  if grammar[expr_ref] == nil then
    grammar[expr_ref] = expr
  else
    grammar[expr_ref] = expr + grammar[expr_ref]
  end
  return grammar
end


-- Builds the grammar up from the bottom,
-- i.e. we start with the highest priority operators
-- and end with the lowest ones
local function build_grammar(expr)

  assert(expr ~= nil and tlen(expr) > 0, "expression cannot be null, undefined or empty")

  local grammar = { "axiom" }

  expr = sort_by_priority(expr)

  local old_priority = expr[1].priority

  local op_table = {}
  local counter = 1
  local second_counter = 0

  local curr_expr, prev_expr

  for _, v in ipairs(expr) do

    op_map[v.operator] = v

    if v.priority < old_priority then
      counter = counter + 1
      second_counter = 1
    else
      second_counter = second_counter + 1
    end

    if op_table[counter] == nil then
      op_table[counter] = { [second_counter] = v }
    else
      op_table[counter][second_counter] = v
    end

    old_priority = v.priority
  end

  curr_expr = prefix .. op_table[1][1].priority
  prev_expr = curr_expr

  local last_expr

  for i = 1, tlen(op_table), 1 do
    for j = 1, tlen(op_table[i]), 1 do
      local op = op_table[i][j]

      curr_expr = prefix .. op.priority

      local e

      if curr_expr ~= prev_expr then
        last_expr = lp.V(prev_expr)
        e = patterns[op.type](op, lp.V(curr_expr), last_expr) + lp.V(prev_expr)
      else
        e = patterns[op.type](op, lp.V(curr_expr), last_expr)
      end

      grammar = add_expr(grammar, e, prefix .. op.priority)

      prev_expr = curr_expr
    end
  end

  for k = 1, tlen(op_table), 1 do
      str = ""
      table_to_string(op_table[k])
      print(str)
  end

  grammar["prefix15"] = grammar["prefix15"] + ("(" * white * lp.V("axiom") * white * ")")
  grammar.axiom = lp.V(prefix .. op_table[tlen(op_table)][1].priority)

  return lp.P(grammar)
end


local g4 = build_grammar(expression)

local has_input = arg[2] ~= nil
if has_input then
  local result = g4:match(arg[2])

  if arg[1] and arg[1] == "lulpeg" then
    lp.pprint(g4)
  end

  str = ""
  if type(result) == "table" then
    table_to_string(result, true)
  else
    str = result
  end
  print("input: \t" .. arg[2])
  print("result:\t" .. str)
  return
end

if arg[1] and arg[1] == "lulpeg" then
  lp.pprint(g4)
end

local input = io.read()
while input ~= "d" do
  local result = g4:match(input)

  if type(result) == "table" then
    ptable(result)
  else
    print(result)
  end

  input = io.read()
end
