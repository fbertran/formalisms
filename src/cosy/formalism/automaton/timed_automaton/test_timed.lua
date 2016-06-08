local Layer = require "layeredata"

local timed_automaton = Layer.require "cosy/formalism/automaton/timed_automaton"

print(timed_automaton[meta].state_type[meta][record].initial.value_type)
