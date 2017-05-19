require "busted.runner" ()

local Layer = require "layeredata"
local refines = Layer.key.refines
local meta    = Layer.key.meta

local collection  = Layer.require "data.collection"

describe ("Formalism expression", function ()
  describe ("expression", function ()
    it ("has the right operator min - max", function ()
      local layer, ref = Layer.new {}
      local expression = Layer.require "expression"
      local addition_op = Layer.require "operator.addition"
      local literal     = Layer.require "operator.literal"

      layer [refines] = { expression }

      local r_addition = {
        [refines] = { addition_op },
        operands  = {
          [meta] = {
            [collection] = {
              value_type = ref,
            },
          },
        },
      }

      local r_literal = {
        [refines] = { literal },
        operands  = {
          [meta] = {
            [collection] = {
              value_type = "number",
            },
          },
        },
      }

      layer [meta] = {
        [expression] = {
          addition = r_addition,
          number   = r_literal,
        },
      }

      layer.operator = ref [meta] [expression] .addition

      -- fails because only one operand
      layer.operands = {
        {}, {}
      }

      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))
    end)
  end)
end)
