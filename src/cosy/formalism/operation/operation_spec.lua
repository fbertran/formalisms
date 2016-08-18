-- These lines are required to correctly run tests.
if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()

local Layer   = require "layeredata"
local meta    = Layer.key.meta
local refines = Layer.key.refines

describe ("Formalism operation", function ()

  it ("can be loaded", function ()
    local _ = Layer.require "cosy/formalism/operation"

  end)

  describe ("test parsing", function ()

    it ("Using only nullary operators", function ()
      local operation     = Layer.require "cosy/formalism/operation"
      local number      = Layer.require "cosy/formalism/literal.number"
      local string      = Layer.require "cosy/formalism/literal.string"
      local identifier  = Layer.require "cosy/formalism/literal.identifier"
      local bool        = Layer.require "cosy/formalism/literal.bool"

      local layer, inst_number, inst_string, inst_bool, inst_identifier
      local result_inst, expression, result_print


      layer = Layer.new { name = "layer"}
      layer [refines] = { operation }

      

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

    it ("Using nullary operators and unary operators", function ()
 
      local operation   = Layer.require "cosy/formalism/operation"
      local number      = Layer.require "cosy/formalism/literal.number"
      local increment   = Layer.require "cosy/formalism/operator/arithmetic.increment"
      local not_bool    = Layer.require "cosy/formalism/operator/boolean.not"
     
      local layer, inst_number
      local inst_inc, inst_not
      local result_inst, expression, result_print

      layer = Layer.new { name = "layer"}
      layer [refines] = { operation }
      layer [meta] .operands_type = layer

      inst_number      = Layer.new { name = "inst_number" }
     
      inst_inc         = Layer.new { name = "inst_inc" }
      inst_not         = Layer.new { name = "inst_not" }

      inst_number [refines]     = { layer, number }
      inst_inc [refines] = { layer, increment}
      inst_not [refines] = { layer, not_bool}

      layer [meta] .operators [tostring(number)] = inst_number

      layer [meta] .operators [tostring(increment)] = inst_inc
      layer [meta] .operators [tostring(not_bool)]  = inst_not

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


      expression   = "2++ "
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_inc, "Expected an instance of ".. tostring(inst_inc) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "~2"
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_not, "Expected an instance of ".. tostring(inst_not) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "~2++ "
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_not, "Expected an instance of ".. tostring(inst_not) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      
    end)
      

    it ("Using nullary, unary and binary operators", function ()
 
      local operation   = Layer.require "cosy/formalism/operation"
      local number      = Layer.require "cosy/formalism/literal.number"
      local identifier  = Layer.require "cosy/formalism/literal.identifier"
      local add         = Layer.require "cosy/formalism/operator/arithmetic.addition"
      local sub         = Layer.require "cosy/formalism/operator/arithmetic.substraction"
      local mul         = Layer.require "cosy/formalism/operator/arithmetic.multiplication"
      local increment   = Layer.require "cosy/formalism/operator/arithmetic.increment"
      local not_bool    = Layer.require "cosy/formalism/operator/boolean.not"


      local layer, inst_number, inst_identifier
      local inst_inc, inst_not
      local inst_add, inst_sub, inst_mul 
      local result_inst, expression, result_print



      layer = Layer.new { name = "layer"}
      layer [refines] = { operation }
      layer [meta] .operands_type = layer
      inst_inc         = Layer.new { name = "inst_inc" }
      inst_not         = Layer.new { name = "inst_not" }
      inst_number      = Layer.new { name = "inst_number" }
      inst_identifier  = Layer.new { name = "inst_identifier" }
      inst_add         = Layer.new { name = "inst_add" }
      inst_sub         = Layer.new { name = "inst_sub" }
      inst_mul         = Layer.new { name = "inst_mul" }


      inst_number [refines]     = { layer, number }
      inst_identifier [refines] = { layer, identifier}
      inst_inc [refines] = { layer, increment}
      inst_not [refines] = { layer, not_bool}
      inst_add [refines] = { layer, add}
      inst_sub [refines] = { layer, sub}
      inst_mul [refines] = { layer, mul}

      layer [meta] .operators [tostring(number)] = inst_number
      layer [meta] .operators [tostring(identifier)]   = inst_identifier
      layer [meta] .operators [tostring(increment)] = inst_inc
      layer [meta] .operators [tostring(not_bool)]  = inst_not
      layer [meta] .operators [tostring(add)] = inst_add
      layer [meta] .operators [tostring(sub)] = inst_sub
      layer [meta] .operators [tostring(mul)] = inst_mul
     
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

      expression   = "2++ "
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_inc, "Expected an instance of ".. tostring(inst_inc) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "~2"
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_not, "Expected an instance of ".. tostring(inst_not) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))


      expression   = "~2++ "
      result_inst  = layer  [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_not, "Expected an instance of ".. tostring(inst_not) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      
      expression   = "3+4"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_add, "Expected an instance of ".. tostring(inst_add) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "6++ +4"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_add, "Expected an instance of ".. tostring(inst_add) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "7+19++ "
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_add, "Expected an instance of ".. tostring(inst_add) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "~17+19++ "
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_add, "Expected an instance of ".. tostring(inst_add) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))


      expression   = "6-id1"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_sub, "Expected an instance of ".. tostring(inst_sub) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))

      expression   = "9*10"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_mul, "Expected an instance of ".. tostring(inst_mul) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))


      expression   = "9*42++ -3+4*11+~69*15+17"
      result_inst  = layer   [meta] .parser(layer, expression, layer)
      result_print = tostring(result_inst  [meta] .printer(result_inst)) 
      Layer.Proxy.check_all (layer)
      assert(expression == result_print, "Printer different : expected "..expression.. "but have"..result_print)
      assert(result_inst[refines][1] == inst_sub, "Expected an instance of ".. tostring(inst_sub) .. " not ".. tostring(result_inst[refines][1]))
      Layer.Proxy.check_all (result_inst)
      assert.is_nil (next (Layer.messages))
    end)
  end)
end)
