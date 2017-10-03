local lp = require("lpeg")

return function (expression)
  -- local lp = require(req)
  local prefix = "prefix"

  -- Holds the different operators, example for an expression which has
  -- multiplication and addition:
  --
  -- op_map = {
  --  ["+binary"] = addition_operator,
  --  ["*binary"] = multiplication_operator
  -- }
  --
  -- This way we can easily retrieve properties such as the operator's priority
  local op_map = { }

  local white = lp.S(" \t\n") ^ 0

  -- patterns for primitive types (number / boolean) and variables
  local value_types = {
    number   = lp.C(lp.R("09") ^ 1), -- / tonumber),
    variable = (lp.R("az") ^ 1 * (lp.R("az") + lp.R("09")) ^ 0) / tostring,
    boolean  = (lp.P("true") + lp.P("false"))^1 / tostring,
  }


  -- utility function to get the table length
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


  local function postfix_capture(p)
    -- function to handle postfix operators when we receive them
    -- The pattern is defined as Exp * op_representation^1,
    -- which means that for an input such as "3~~" we would get
    -- a table such as { 3 ~ ~ }, whereas with this function we get
    -- { { 3 ~ } ~ }
    local function construct(list)
      local function rec(n, t)
        if n == 1 then
          return list[1]
        else
          t = { op = list[n], left = rec(n - 1, { t }) }
        end
        t.op_type = "unary_postfix"
        return t
      end

      return rec(tlen(list), { })
    end

    return p / function(...)
      return construct({ ... })
    end
  end

  local function prefix_capture (p)
    return p / function (op, right)
      return { op = op, right = right,  op_type = "unary_prefix" }
    end
  end


  local function ternary_capture (p)
    return p / function (left, op1, middle, op2, right)
      return {
        left = left,
        op1 = op1,
        middle = middle,
        op2 = op2,
        right = right,
        op_type = "ternary"
      }
    end
  end


  local function alternative_ternary_capture (p)
    return p / function (op1, left, op2, middle, op3, right)
      return {
        op = op1,
        op2 = op2,
        op3 = op3,
        left = left,
        middle = middle,
        right = right,
        op_type = "ternary_alternative"
      }
    end
  end


  local function nary_capture (p)
    return p / function (op, ...)
      local args = { ... }
      local arglist = { }
      local ctr = 1

      for _, v in ipairs(args) do
        if type(v) ~= "table" then
          arglist[ctr] = { v }
        else
          arglist[ctr] = v
        end
        ctr = ctr + 1
      end

      return { op = op, operands = arglist, op_type = "nary" }
    end
  end


  local function binary_lassoc(pattern, _op)
    -- We need to define the function here because
    -- we want to capture the '_op' variable
    local function recursion(left, op, right)
      -- second condition is to make sure that we are not "stealing"
      -- anything from operators that have the same priority but
      -- are not left associative
      if type(right) == "table" and op == _op.operator then
        if tlen(right) == 1 and type(right[1]) == "table" then -- parenthesis
          return { left = left, op = op, right = right, op_type = _op.type }
        end

        -- we have to take precedence in account,
        -- as well as if it's not a binary operator, then
        -- left associativity doesn't apply
        if
          right.op ~= nil and (
            op_map[right["op"] .. right["op_type"]].type ~= "binary" or
            op_map[right["op"] .. right["op_type"]].priority > _op.priority
          )
        then
          -- But we still have to go through the operators on the left side of
          -- the expression, to check if they are left associative, in which case
          -- we have to handle them as well.
          -- So we propagate the recursion to the left hand side as well
          if
            left.op ~= nil and
            left.op_type ~= nil and
            op_map[left.op .. left.op_type].left_assoc
          then
            left = recursion(left.left, left.op, left.right, left.op_type)
          end

          return { left = left, op = op, right = right, op_type = _op.type }
        end

        -- Recursion needed to move the operands to make the operator left-associative
        return recursion(
          {
            left = left, op = op, right = right["left"], op_type = _op.type
          },
          right["op"],
          right["right"],
          right["op_type"]
        )
      else
        if left.op_type ~= "binary" then
          -- it's not a binary operator, so left / right associativity doesn't apply
          -- This can also mean that there is a parenthesis
          return { left = left, op = op, right = right, op_type = _op.type }
        end

        if type(left) == "table" then
          left = recursion(left["left"], left["op"], left["right"], left["op_type"])
        end

        return { left = left, op = op, right = right, op_type = _op.type }
      end
    end

    return pattern / recursion
  end

  -- Hashmap for the patterns so we don't need
  -- a ton of `if - else if - else` statements
  -- for the different types of operators.
  -- the "white" you see in there is just for ignoring whitespace.
  -- Unfortunately it has to be added everywhere
  local patterns = {
    binary = function (operator, curr_expr, next_expr)
      local op_repr = lp.C(lp.P(operator.operator))

      local pattern = (white * next_expr * white * op_repr * white * (curr_expr + next_expr) * white)

      if operator.left_assoc then
        pattern = binary_lassoc(pattern, operator)
      else
        pattern = pattern / function (left, op, right)
          return { left = left, op = op, right = right, op_type = operator.type }
        end
      end

      return pattern
    end,

    unary_prefix = function (operator, curr_expr, next_expr)
      local op_repr = lp.C(lp.P(operator.operator))
      return prefix_capture(white * (op_repr * white * (curr_expr + next_expr + white)))
    end,

    unary_postfix = function (operator, curr_expr, next_expr)
      local op_repr = lp.C(lp.P(operator.operator))
      local pattern = (
        white * next_expr * white * (op_repr * white)^1
      )

      return postfix_capture(pattern)
    end,

    literal = function (literal)
      return value_types[literal.value_type]
    end,

    ternary = function (operator, curr_expr, next_expr)
      local first  = operator.operator[1]
      local second = operator.operator[2]

      first  = lp.C(lp.P(first))
      second = lp.C(lp.P(second))

      return ternary_capture(
        next_expr * white * first * white * lp.V("axiom")
        * white * second * white * (curr_expr + next_expr)
      )
    end,

    nary = function (operator)
      local op_repr = lp.C(lp.P(operator.operator))

      return nary_capture(
        white *
        op_repr *
        white
        * lp.P("(") * white *
        lp.V("axiom") * white * ("," * white * lp.V("axiom")) ^ 0 *
        white * lp.P(")") * white
      )
    end,

    ternary_alternative = function (operator)
      local first  = operator.operator
      local second = operator.operator2
      local third  = operator.operator3

      first  = lp.C(lp.P(first))
      second = lp.C(lp.P(second))
      third = lp.C(lp.P(third))



      local pattern = white * first * white *
        lp.V("axiom") * white * second * white * lp.V("axiom") * white * third * white *
        lp.V("axiom")

      return alternative_ternary_capture(pattern)
    end,
  }

  -- Adds the expression to a grammar object
  local function add_pattern(grammar, expr, level)
    if grammar[level] == nil then
      grammar[level] = expr
    else
      grammar[level] = expr + grammar[level]
    end
    return grammar
  end

  -- Builds the grammar up from the bottom,
  -- i.e. we start with the highest priority operators
  -- and end with the lowest ones
  local function build_grammar(expr)

    if (expr == nil or tlen(expr) < 1) then
      return nil
    end

    local grammar = { "axiom" }

    expr = sort_by_priority(expr)

    local old_priority = expr[1].priority
    local max_priority = old_priority

    local op_table = { }
    local counter = 1
    local second_counter = 0

    local var_op

    local curr_expr, prev_expr

    -- use ipairs to make sure we get the table
    -- elements in the right order
    for _, v in ipairs(expr) do
      if v.operator ~= nil and #v.operator > 0 and type(v.operator) ~= "table" then
        op_map[v.operator .. v.type] = v
      elseif type(v.operator) == "table" then
        local concat = ""
        for _, op_repr in ipairs(v.operator) do
          concat = concat .. op_repr
        end
        op_map[concat .. v.type] = v
      end

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

    -- Iterate over each operator,
    -- and add the resulting pattern to our grammar
    for i = 1, tlen(op_table), 1 do
      for j = 1, tlen(op_table[i]), 1 do
        local op = op_table[i][j]

        local is_var = false

        if op.type == "literal" and op.value_type == "variable" then
          var_op = op
          is_var = true
        end

        curr_expr = prefix .. op.priority

        local e

        -- Basically we don't want to insert variables in the grammar
        -- at this stage, since we cannot be sure in which order we receive the operators
        if is_var == false then
          if curr_expr ~= prev_expr then
            last_expr = lp.V(prev_expr)
            e = patterns[op.type](op, lp.V(curr_expr), last_expr) + lp.V(prev_expr)
          else
            e = patterns[op.type](op, lp.V(curr_expr), last_expr)
          end

          grammar = add_pattern(grammar, e, prefix .. op.priority)
        end

        prev_expr = curr_expr
      end
    end


    grammar[prefix .. max_priority] = grammar[prefix .. max_priority] +
      ("(" * white * lp.Ct(lp.V("axiom")) * white * ")")

    -- variable literals need to be inserted at the very end,
    -- because if there is let's say an nary operator consisting of letters
    -- (e.g. "sum") then it matches "sum" as a variable instead of as the
    -- "sum" operator
    if var_op ~= nil then
      grammar[prefix .. max_priority] = grammar[prefix .. max_priority] +
        patterns[var_op.type](var_op)
    end

    grammar.axiom = lp.V(prefix .. op_table[tlen(op_table)][1].priority)

    return lp.P(grammar)
  end

  return build_grammar(expression)
end
