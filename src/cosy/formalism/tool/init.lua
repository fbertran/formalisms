-- Tool
-- ====
--
-- Tools are formalisms that refine the `tool` formalism.
-- They define a `parameter_type` that all tool parameters should refine.
-- Clients use this refining to detect parameters and show them somehow
-- to the users.
--
-- A tool also defines a (textual) `description` and a `run` function,
-- that takes one parameter, a table with the following fields:
--
-- * `client`: a client to the Cosy server;
-- * `model`: the tool instance;
-- * `scheduler`: a scheduler to create (parallel) tasks, sleep, wakeup, ...

return function (Layer, tool)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local record     = Layer.require "cosy/formalism/data.record"

  local parameter_type = {
    [refines] = {
      record,
    },
    [meta] = {
      record = {
        name        = { value_type = "string" },
        description = { value_type = "string" },
        type        = nil;
        default     = nil,
      }
    }
  }

  tool [refines] = {
    record
  }

  tool [meta] = {
    parameter_type = parameter_type,
    record = {
      description = { value_type = "string"   },
      run         = { value_type = "function" },
    }
  }

end
