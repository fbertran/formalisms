-- These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer   = require "layeredata"
local meta    = Layer.key.meta
local refines = Layer.key.refines


describe ("Formalism literal.literal", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/literal"
  end)

  describe ("with type information", function ()

    it ("forbids a different type", function ()
      local literal = Layer.require "cosy/formalism/literal"
      local record  = Layer.require "cosy/formalism/data.record"
      local layer      = Layer.new {name = "layer"}
      
      layer [Layer.key.refines] = { literal }
      layer [Layer.key.meta] [record] .value = {value_type = "number"}
   
      layer.value = "test"

      Layer.Proxy.check_all (layer)
      assert.is_not_nil ( next ( Layer.messages ))
    end)
	end)

  describe ("test parsing", function ()
    it ("Using only nullary operators", function ()
      local literal     = Layer.require "cosy/formalism/literal"
      local number      = Layer.require "cosy/formalism/literal.number"
      local string      = Layer.require "cosy/formalism/literal.string"
      local identifier  = Layer.require "cosy/formalism/literal.identifier"
      local bool        = Layer.require "cosy/formalism/literal.bool"

      local layer, inst_number, inst_string, inst_bool, inst_identifier
      local result_inst, expression, result_print


      layer = Layer.new { name = "layer"}
      layer [refines] = { literal }

      inst_bool        = Layer.new { name = "inst_bool" }
      inst_string      = Layer.new { name = "inst_string" }
      inst_number      = Layer.new { name = "inst_number" }
      inst_identifier  = Layer.new { name = "inst_identifier" }

      inst_bool   [refines] = { layer, bool }
      inst_number [refines] = { layer, number }
      inst_string [refines] = { layer, string }

      inst_identifier [refines] = { layer, identifier}

      layer [meta] .operators [tostring(number)] = inst_number
      layer [meta] .operators [tostring(string)] = inst_string
      layer [meta] .operators [tostring(bool)]   = inst_bool
      layer [meta] .operators [tostring(identifier)]   = inst_identifier

      Layer.Proxy.check_all (layer)
      assert.is_nil (next (Layer.messages))

      expression   = "2"
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_number, "Expected an instance of ".. tostring(inst_number) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))


      expression   = "\"blablabla\""
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 

      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_string, "Expected an instance of ".. tostring(inst_string) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      layer.id1 = Layer.new { name = "id1"}
      layer.id1 [refines] = { inst_identifier }
      layer.id1 .value = "id1"

      expression   = "id1"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_identifier, "Expected an instance of ".. tostring(inst_identifier) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "true"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_bool, "Expected an instance of ".. tostring(inst_bool) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "false"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_bool, "Expected an instance of ".. tostring(inst_bool) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))
    end)
  end)

end)
