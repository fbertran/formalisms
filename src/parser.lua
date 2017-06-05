local lp = require("lpeg")


local literal = lp.R("09") ^ 1 / tonumber
local white = lp.S(" \t") ^ 0

local addition = white * lp.C(lp.S("+")) * white
local minus    = white * lp.C(lp.S("-")) * white
local mult     = white * lp.C(lp.S("*")) * white
local exp      = white * lp.C(lp.S("**")) * white
local b_not    = white * lp.C(lp.S("!")) * white
local b_if     = white * lp.C(lp.P("if")) * white
local b_then   = white * lp.C(lp.P("then")) * white
local b_end    = white * lp.C(lp.P("end")) * white

local function node (p)
  return p / function (left, op, right)
    return { op, left, right }
  end
end

local function ternary_node (p)
  return p / function (i, exp1, t, exp2, en)
    print (i, exp1)
    return { i, exp1, t, exp2, en }
  end
end

local g2 = lp.P({
  "input",
  input   = lp.V("if_else") + lp.V("addition") + literal,
  -- if_else = lp.C(b_if * literal * b_then * literal * b_end * literal)
  if_else  = (lp.V("addition") + white) * b_if * lp.V("input") * b_then * lp.V("input") * b_end,
  addition = (literal + white) * addition * (lp.V("addition") + lp.V("if_else"))
})

local g3 = lp.P({
  "input",
  input          = lp.V("addition") + lp.V("substraction") + lp.V("multiplication") + literal,
  addition       = node((lp.V("substraction") + lp.V("multiplication") + literal) * addition * lp.V("input")),
  substraction   = node((lp.V("multiplication") + literal) * minus * (lp.V("substraction") + lp.V("multiplication") + lp.V("addition") + literal)),
  multiplication = node(literal * mult * (lp.V("multiplication") + literal))
})

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

local original = "10 + 2 - 5"
-- print (g3:match(original))
printrec(g3:match(original))
print (original)
print (str)

-- assert(false)

local value_types = {
  ["number"]   = ((lp.R("09") ^ 1 / tonumber)),
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

local op_multiplication = {
  priority   = 11,
  operator   = "*",
  value_type = "",
  n_operands = 2,
  type       = "binary",
}

local op_literal = {
  priority   = 14,
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
  type       = "unary"
}

local expression = {
  r_number         = op_literal,
  r_plus           = op_plus,
  r_minus          = op_minus,
  r_multiplication = op_multiplication,
  r_not            = op_unary,
  r_variable       = op_variable
}


local function tlen (t)
  local i = 0
  for _ in pairs (t) do
    i = i + 1
  end
  return i
end


local function sort_by_priority (t)
  local nt = {}
  local i  = 1
  for _, v in pairs (t) do
    nt[i] = v
    i = i + 1
  end

  table.sort (nt, function(op1, op2)
      return op1.priority > op2.priority
  end)

  return nt
end


expression = sort_by_priority (expression)

for k, v in pairs (expression) do
  print (k, v.priority)
end

local patterns = {
  binary = function (operator, exp_left, exp_right, ref_name)
    local op_repr = lp.C(lp.S(operator.operator))
    return exp_left * white * op_repr * white * (lp.V(ref_name) + exp_right)
  end,
  unary_prefix = function (operator, exp_right, ref_name)
    local op_repr = lp.C(lp.S(operator.operator))
    return white * op_repr * white * (lp.V(ref_name) + exp_right)
  end,
  literal = function (literal_operator)
    return value_types[literal_operator.value_type]
  end
}


local function add_expr(grammar, expr, priority)
  if grammar[priority] == nil then
    grammar[priority] = expr
  else
    grammar[priority] = grammar[priority] + expr
  end
  return grammar
end


local function build_grammar (expr)

  local grammar = { "axiom" }

  local prior_exprs       = {}
  local prior_exprs_count = 1

  for _, v in pairs (expr) do
    local op_name     = tostring (v)
    local op_priority = v.priority
    if v.type == "literal" then
      grammar[op_name] = patterns.literal(v)
      prior_exprs[prior_exprs_count] = op_name
      prior_exprs_count = prior_exprs_count + 1
    else
      local left_expr, right_expr
      for i = 1, prior_exprs_count - 1, 1 do
        if left_expr ~= nil then
          left_expr = lp.V(prior_exprs[i]) + left_expr
        else
          left_expr = lp.V(prior_exprs[i])
        end

        if right_expr ~= nil then
          right_expr = lp.V(prior_exprs[i]) + right_expr
        else
          right_expr = lp.V(prior_exprs[i])
        end
      end

      if v.type == "binary" then
        grammar[op_name] = node(patterns.binary(v, left_expr, right_expr, op_name))
        prior_exprs[prior_exprs_count] = tostring(v)
        prior_exprs_count = prior_exprs_count + 1
      end

      if v.type == "unary" then
        grammar[op_name] = node(patterns.unary_prefix(v, right_expr, op_name))
        prior_exprs[prior_exprs_count] = op_name
        prior_exprs_count = prior_exprs_count + 1
      end
    end
  end

  for i = 1, prior_exprs_count - 1, 1 do
    if grammar.axiom == nil then
      grammar.axiom = lp.V(prior_exprs[i])
    else
      grammar.axiom = lp.V(prior_exprs[i]) + grammar.axiom
    end
  end

  return lp.P(grammar)
end

local input = io.read()
local g4 = build_grammar (expression)
while input ~= "d" do
  local result = g4:match(input)
  str = ""
  printrec(result)
  print(str)
  input = io.read()
end
