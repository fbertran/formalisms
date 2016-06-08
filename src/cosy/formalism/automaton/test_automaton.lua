local Layer = require "layeredata"
local automaton = Layer.require "cosy/formalism/automaton"
local record = Layer.require "cosy/formalism/data.record"

print(automaton[Layer.key.meta].state_type[Layer.key.meta][record].initial.value_type)
