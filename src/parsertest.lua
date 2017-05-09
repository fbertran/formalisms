local Layer = require "layeredata"
local lpeg = require "lpeg"

local collection = Layer.require "data.collection"

local refines = Layer.key.refines


-- the / operator is overloaded by lpeg
-- it creates a function capture,
-- i.e. captures the match and passes it to the function as argument
-- the ^ operator is used as
-- "^ n" -> the pattern has to appear n or more times
local value_types = {
  ["number"] = ((lpeg.R("09") ^ 1 / tonumber) + (lpeg.R("az") ^ 1 / tostring)),
  ["boolean"] = (lpeg.R("09") ^ 1 / tonumber + lpeg.R("az") ^ 1 / tostring)
}

local addition_expression = Layer.require "expression.addition_expression"
local mul_expr = Layer.require "expression.multiplication_expression"
local and_expr = Layer.require "expression.and_expression"

-- http://leafo.net/guides/parsing-expression-grammars.html
-- requires at least a pattern like one * two * three
-- it's like a factory
local function node(p)
  return p / function (left, op, right)
    return { op, left, right }
  end
end

-- whitespace can occur 0 or more times
-- it is not captured when matched so it is thrown away
local white = lpeg.S(" \t") ^ 0

local tab = Layer.new {}

tab [refines] = { mul_expr }

local operand = white * value_types[tab.operator.operands[collection].value_type]
local mult = white * lpeg.C(lpeg.S(tab.operator.operator))

local tab2 = Layer.new {}
tab2 [refines] = { addition_expression }

local add = white * lpeg.C(lpeg.S(tab2.operator.operator))

local and_layer = Layer.new {}

and_layer [refines] = { and_expr }

local my_and = white * lpeg.C(lpeg.S(and_expr.operator.operator))

--[[
  Example grammar (just testing)

  input          -> exp
  exp            -> addition | multiplication | and | number
  addition       -> (multiplication | and | number) '+' exp
  multiplication -> (and | number) '*' (multiplication | exp)
  and_bool       -> number '^' (and | number)
  number         -> [0-9]+

  This grammar has priorities that go bool -> mult -> addition
]]
local function make_grammar()
  return lpeg.P({
    "input",
    input          = lpeg.V("exp"),
    exp            = lpeg.V("addition") + lpeg.V("multiplication") + lpeg.V("and_bool") + operand,
    addition       = node((lpeg.V("multiplication") + lpeg.V("and_bool") + operand) * add * lpeg.V("exp")),
    multiplication = node((lpeg.V("and_bool") + operand) * mult * (lpeg.V("multiplication") + operand)),
    and_bool       = node(operand * my_and * (lpeg.V("and_bool") + operand))
  })
end

local str = ""

local function printrec(t, f)
  if f then
    str = str .. "{"
  else
    str = str .. " {"
  end
  for _, v in pairs(t) do
    if type(v) == "table" then
      printrec(v, false)
    else
      str = str .. " " .. v
    end
  end
  str = str .. " }"
end

local original = "10 * true ^ false ^ 5 * 2 + 2"
local parsed_result = make_grammar():match(original)

printrec(parsed_result, true)
print("original: " .. original)
print("parsed result: " .. str)
--[[
  prints

  original: 10 * true ^ false ^ 5 * 2 + 2
  parsed result: { + { * 10 { * { ^ true { ^ false 5 } } 2 } } 2 }
]]
