
local Layer = require "layeredata"
local timed_automaton = Layer.require "cosy/formalism/automaton/timed"
local meta = Layer.key.meta
local refines = Layer.key.refines
local record = Layer.require "cosy/formalism/data.record"
local layer = Layer.new{}
layer [refines] = {timed_automaton}
layer.clocks = {x1 = {value = "x1"}, x2 = {value = "x2"}}

layer.invariants={timed_automaton [meta].guard_type.parser(timed_automaton [meta].guard_type,"~(layer.clocks.x1+3)",layer)}

io.write("resultat: ")
local op = layer.invariants[1]
--print_basic(op)

op[meta][record].printer(op)

--newline
print()

