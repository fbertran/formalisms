local Layer = require "layeredata"
local lpeg = require "lpeg"

local collection = Layer.require "data.collection"



local value_types = {
  ["number"] = (lpeg.R("09") ^ 1 / tonumber),
  ["boolean"] = lpeg.C(lpeg.P("true") + lpeg.P("false"))
}

local and_expression = Layer.require "expression.and_expression"
local mul_expr = Layer.require "expression.multiplication_expression"

local test = {
  and_expression,
  mul_expr
}

-- http://leafo.net/guides/parsing-expression-grammars.html
local function node(p)
  return p / function (left, op, right)
    return { op, left, right }
  end
end

local factor
local white = lpeg.S(" \t") ^ 0

local function make_nodes()

  local count = 0
  local obj = {
    "0",
  }


  for _, v in pairs(test) do
    local tab = Layer.new {}
    local expr
    tab [Layer.key.refines] = { v }

    local operand = white * value_types[tab.operator.operands[collection].value_type]
    local op = white * lpeg.C(lpeg.S(tab.operator.operator))

    if factor == nil then
      factor = node(operand * op * operand + operand)
    else
      factor = node(operand * op * operand + operand) + factor
    end

    count = count + 1

    if expr == nil then
      expr = lpeg.V(count)
    else
      expr = expr + lpeg.V(count)
    end
  end
end


make_nodes()

for _, v in pairs(factor:match("3 * 5 * 2")) do
  print(v)
end
