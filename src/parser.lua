local lp = require "lpeg"
local prefix = "prefix"

local op_map = { }

local str = ""
local function table_to_string (t, f, print_keys)
  if f then
    str = str .. "{"
  else
    str = str .. " {"
  end
  if type(t) == "table" then
    for k, v in pairs(t) do
      if type(v) == "table" then
        str = str .. " " .. k .. ": "
        table_to_string(v, false, print_keys)
      else
        if print_keys then
          str = str .. " ".. k .. ": " .. tostring(v) .. ", "
        else
          str = str .. " " .. tostring(v)
        end
      end
    end
  else
    str = str .. t
  end
  str = str .. " }"
end

local function ptable(t)
  str = ""
  table_to_string(t, true, true)
  print(str)
end


local white = lp.S(" \t") ^ 0

local value_types = {
  ["number"]   = lp.C(lp.R("09") ^ 1), -- / tonumber),
  ["variable"] = (lp.R("az") ^ 1 * (lp.R("az") + lp.R("09")) ^ 0) / tostring,
  ["boolean"]  = lp.C(lp.P("true") + lp.P("false")),
}

return function (expression)
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
    local nt = { }
    local i  = 1

    for _, v in pairs(t) do
      nt[i] = v
      i = i + 1
    end

    table.sort(nt, function (op1, op2)
      return op1.priority > op2.priority
    end)

    return nt
  end

  local function node_postfix(p)
    local function construct(...)
      local list = ...
      local function rec(n, t)
        if n == 1 then
          return list[1]
        else
          t = { op = list[n], left = rec(n - 1, { t }) }
        end
        t.op_type = "postfix"
        return t
      end

      return rec(tlen(list), { })
    end
    return p / function(...)
      return construct({ ... })
    end
  end

  local function node_prefix (p)
    return p / function (op, right)
      return { op = op, right = right,  op_type = "prefix" }
    end
  end


  local function ternary_node (p)
    return p / function (left, op1, middle, op2, right)
      return { left = left, op1 = op1, middle = middle, op2 = op2, right = right, op_type = "ternary"}
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

      return { op = op, operands = arglist, op_type = "nary" }
    end
  end

  local function find_operator(t)
    ptable(t)
    local ctr = 1
    for _, v in ipairs(t) do
      print(v)
      if type(v) == "string" and op_map[v] ~= nil then
        return ctr
      end
      ctr = ctr + 1
    end
  end

  local function lassoc(p, _op)

    local function fn(left, op, right)
      -- second condition is to make sure that we are not "stealing"
      -- anything from operators that have the same priority but
      -- are not left associative
      if type(right) == "table" and op == _op.operator then
        if tlen(right) ~= 4 then
          -- it's not a binary operator, so left / right associativity doesn't apply
          -- This can also mean that there is a parenthesis
          return { left = left, op = op, right = right, op_type = _op.type }
        end

        -- we have to take precedence into account
        -- if op_map[right[find_operator(right)]].priority > _op.priority then
        if op_map[right["op"]].priority > _op.priority then
          return { left = left, op = op, right = right, op_type = _op.type }
        end

        -- Recursion needed to move the operands to make the operator left-associative
        return fn(
          {
            left = left, op = op, right = right["left"], op_type = _op.type
          },
          right["op"],
          right["right"]
        )
      else
        if type(left) == "table" then
          if tlen(left) ~= 4 then
            -- it's not a binary operator, so left / right associativity doesn't apply
            -- This can also mean that there is a parenthesis
            return { left = left, op = op, right = right, op_type = _op.type }
          end
          left = fn(left["left"], left["op"], left["right"])
        end

        return { left = left, op = op, right = right, op_type = _op.type }
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
        pattern = pattern / function (left, op, right)
          return { left = left, op = op, right = right, op_type = operator.type }
        end
      end

      return pattern
    end,

    unary_prefix = function (operator, curr_expr, next_expr)
      local op_repr = lp.C(lp.P(operator.operator))
      return node_prefix(white * (op_repr * white * (curr_expr + next_expr + white)))
    end,

    unary_postfix = function (operator, curr_expr, next_expr)
      local op_repr = lp.C(lp.P(operator.operator))

      return node_postfix(white * next_expr * white * (op_repr * white)^1 * (white + curr_expr))
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

    if (expr == nil or tlen(expr) < 0) then
      return nil
    end

    local grammar = { "axiom" }

    expr = sort_by_priority(expr)

    local old_priority = expr[1].priority

    local op_table = { }
    local counter = 1
    local second_counter = 0

    local curr_expr, prev_expr

    -- use ipairs to make sure we get the table
    -- elements in the right order
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

    -- initialization with first operator
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

    -- for k = 1, tlen(op_table), 1 do
    --     str = ""
    --     table_to_string(op_table[k], true, true)
    --     print(str)
    -- end

    grammar["prefix15"] = grammar["prefix15"] + ("(" * white * lp.Ct(lp.V("axiom")) * white * ")")
    grammar.axiom = lp.V(prefix .. op_table[tlen(op_table)][1].priority)

    return lp.P(grammar)
  end
  return build_grammar(expression)
end
