local Layer = require "layeredata"
local lpeg = require "lpeg"

local collection = Layer.require "data.collection"

local refines = Layer.key.refines


local value_types = {
  ["number"] = (lpeg.R("09") ^ 1 / tonumber),
  ["boolean"] = lpeg.C(lpeg.P("true") + lpeg.P("false"))
}

local addition_expression = Layer.require "expression.addition_expression"
local mul_expr = Layer.require "expression.multiplication_expression"

-- http://leafo.net/guides/parsing-expression-grammars.html
local function node(p)
  return p / function (left, op, right)
    return { op, left, right }
  end
end

local white = lpeg.S(" \t") ^ 0

--[[local function make_nodes()

  local count = 0
  local obj = { }
  obj[1] = "asdf"
  obj["asdf"] = lpeg.V("asdf")

  local expr

  for _, v in pairs(test) do
    local tab = Layer.new {}

    tab [Layer.key.refines] = { v }

    local operand = white * value_types[tab.operator.operands[collection].value_type]
    local op = white * lpeg.C(lpeg.S(tab.operator.operator))

    if factor == nil then
      factor = node(operand * op * operand + operand)
    else
      factor = node(operand * op * operand + operand)
    end

    count = count + 1

    if expr == nil then
      expr = lpeg.V(count)
    else
      expr = expr + lpeg.V(count)
    end
  end
end
]]

local tab = Layer.new {}
tab [refines] = { mul_expr }

local operand = white * value_types[tab.operator.operands[collection].value_type]
local mult = white * lpeg.C(lpeg.S(tab.operator.operator))

local tab2 = Layer.new {}
tab2 [refines] = { addition_expression }

-- operand = value_types[tab2.operator.operands[collection].value_type]
local add = white * lpeg.C(lpeg.S(tab2.operator.operator))

--[[
  input          -> exp
  exp            -> addition | multiplication | number
  addition       -> (multiplication | number) '+' exp
  multiplication -> number '*' (multiplication | number)

  This grammar has priority for multiplication
]]
local function make_nodes()
  return lpeg.P({
    "input",
    input = lpeg.V("exp") * -1,
    exp = lpeg.V("addition") + lpeg.V("addition") + operand,
    addition = node((lpeg.V("multiplication") + operand) * add * lpeg.V("exp")),
    multiplication = node(operand * mult * (lpeg.V("multiplication") + operand))
  })
end

local str = ""

local function printr(t, f)
  if f then
    str = str .. "{"
  else
    str = str .. " {"
  end
  for _, v in pairs(t) do
    if type(v) == "table" then
      printr(v, false)
    else
      str = str .. " " .. v
    end
  end
  str = str .. " }"
end

local original = "10 * 3 + 5 * 2 + 2"

printr(make_nodes():match(original), true)
print("original: " .. original)
print("parsed result: " .. str)
