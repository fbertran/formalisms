--These lines are required to correctly run tests.
--require "busted.runner" ()

local Layer = require "cosy.formalism.layer"

--describe ("Formalism timed_automaton", function ()

  --it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/automaton/timed_automaton"
  --end)

 -- describe ("with type information", function ()

  --  it ("parse that shit BOI!!!!", function ()
      local timed_automaton = Layer.require "cosy/formalism/automaton/timed_automaton"

      local refines =  Layer.key.refines


     local layer=Layer.new {
     name="timed_automaton",
     data = {
       [refines] = {
         timed_automaton,
       }
      }
     }
--layer.invariants={}

layer.clocks.c1={value="x1"}
--print(layer.clocks.c1.value)
local op=timed_automaton.parser("INF(ADD(layer.clocks.c1,2),1)",layer)

--print(op.operands[1].operator)
print(timed_automaton.printer(op))
  


     -- Layer.Proxy.check (layer)
     -- assert.is_nil (Layer.messages (layer) ())
   -- end)
--	end)

--end)
