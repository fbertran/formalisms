local lp = require("lulpeg")

local function node (p)
  return p / function (left, op, right)
    return { op, left, right }
  end
end

local function ternary_node (p)
  return p / function (left, op1, middle, op2, right)
    return { left, op1,  middle, op2, right}
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
  type       = "unary_prefix"
}

local op_ternary = {
  priority   = 0,
  operator   = {
    "if",
    "else"
  },
  value_type = "",
  n_operands = 1,
  type       = "ternary"
}

local expression = {
  r_number         = op_literal,
  r_plus           = op_plus,
  r_minus          = op_minus,
  r_multiplication = op_multiplication,
  r_not            = op_unary,
  r_variable       = op_variable,
  r_modulo         = op_modulo,
  op_ternary       = op_ternary
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

  table.sort (nt, function (op1, op2)
      return op1.priority > op2.priority
  end)

  return nt
end


expression = sort_by_priority(expression)

local patterns = {
  binary = function (operator, around)
    local op_repr = lp.C(lp.S(operator.operator))
    return node(around * white * op_repr * white * (lp.V(operator.priority) + around))
  end,

  unary_prefix = function (operator, around)
    local op_repr = lp.C(lp.S(operator.operator))
    return node(white * op_repr * white * (lp.V(operator.priority) + around))
  end,

  literal = function (literal)
    return value_types[literal.value_type]
  end,

  ternary = function (operator, around)
    local first = operator.operator[1]
    local second = operator.operator[2]

    first  = lp.C(lp.P(first))
    second = lp.C(lp.P(second))

    return ternary_node((around + white) * white * first * white * around * white * second * white * (lp.V(operator.priority) + around))
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

local function build_grammar(expr)
  local grammar = { "axiom" }

  local prior_exprs       = {}
  local prior_exprs_count = 1

  local old_priority = expr[1].priority

  for _, v in pairs (expr) do
    local around, stop

    if v.priority == old_priority then
      stop = prior_exprs_count - 1
    else
      stop = prior_exprs_count
    end

    for i = 1, stop, 1 do
      if around ~= nil then
        around = lp.V(prior_exprs[i]) + around
      else
        around = lp.V(prior_exprs[i])
      end
    end

    grammar = add_expr(grammar, patterns[v.type](v, around), v.priority)

    if v.priority ~= old_priority then
      prior_exprs_count = prior_exprs_count + 1
    end

    prior_exprs[prior_exprs_count] = v.priority
    old_priority = v.priority
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

local input = io.read()
local g4 = build_grammar(expression)
-- lp.pprint(g4) -- doesn't work with lpeg
while input ~= "d" do
  local result = g4:match(input)
  str = ""
  printrec(result)
  print(str)
  input = io.read()
end
