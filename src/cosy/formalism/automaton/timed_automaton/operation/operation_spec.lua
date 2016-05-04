-- These lines are required to correctly run tests.

if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

require "busted.runner" ()


local Layer = require "cosy.formalism.layer"
local path = "cosy/formalism/automaton/timed_automaton/"
describe ("Formalism timed_automaton.operation", function ()

  it ("can be loaded", function ()
    local _ = Layer.require (path .. "operation")
  end)

  describe ("with operator information", function ()

    it ("using the good type for operator", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local layer = Layer.new{name ="layer"}
            
      layer [refines] = {operation}
      layer.operator = "ADD"
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)


    it ("detects wrong type for operator", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local layer = Layer.new{name ="layer"}
            
      layer [refines] = {operation}
      layer.operator = 42
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)


    it ("detects wrong type for operator", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local layer = Layer.new{name ="layer"}
            
      layer [refines] = {operation}
      layer.operator = 42
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("detects missing operator", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local layer = Layer.new{name ="layer"}
      layer [refines] = {operation}
      layer.operator = nil
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)
  end)

 describe ("with operands type information", function ()

  it ("allows no operands if there is no minimum", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local layer = Layer.new{name ="layer"}
    
      layer [refines] = {operation}
      layer.operator = "ADD"

      layer[meta].operands_type = "number"

      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("using the good type for operands (primitive)", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local layer = Layer.new{name ="layer"}
            
      layer [refines] = {operation}
      layer.operator = "ADD"

      layer[meta].operands_type = "number"
      layer.operands.op1 = 1
      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end)

    it ("detects wrong type for operands (primitive)", function ()
      local operation     = Layer.require (path .."operation")
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local layer = Layer.new{name ="layer"}
            
      layer [refines] = {operation}
      layer.operator = "ADD"

      layer[meta].operands_type = "number"
      layer.operands.op1 = "lol"
      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)



  it ("using the good type for operands (formalism)", function ()
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local operation     = Layer.require (path .."operation")
      local string =  Layer.require (path .."literal.string")
      local collection = Layer.require "cosy/formalism/data.collection"
      local layer  = Layer.new{name ="layer"}

      layer [refines] = {operation}
      layer.operator  = "ADD"

      layer[meta].operands_type = string      
      
      layer.operands.op1 = {
        [refines] = {string},
        value = "test"
      }
      
      Layer.Proxy.check (layer)
      assert.is_true (layer.operands[meta][collection].value_type <= layer.operands.op1)
      assert.is_nil (Layer.messages (layer) ())
    end)

  it ("detects wrong type for operands (formalism)", function ()
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local operation     = Layer.require (path .."operation")
      local string =  Layer.require (path .."literal.string")
      local number =  Layer.require (path .."literal.number")
      local layer = Layer.new{name ="layer"}
      local collection = Layer.require "cosy/formalism/data.collection"
      
      layer [refines] = {operation}
      layer.operator  = "ADD"

      layer[meta].operands_type = string
      
      layer.operands.op1 = {
        [refines] = {number},
        value = 18
      }    

      Layer.Proxy.check (layer)
      assert.is_false (layer.operands[meta][collection].value_type <= layer.operands.op1)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

   it ("detects too many operands (reference)", function ()
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local operation     = Layer.require (path .."operation")
      local string =  Layer.require (path .."literal.string")
      local collection =  Layer.require "cosy/formalism/data.collection"


      local layer = Layer.new{name ="layer"}

      layer [refines] = {operation}
      layer.operator  = "ADD"

      layer[meta].operands_type = string
      layer.operands[meta][collection].maximum=1

      layer.operands.op1 = {
        value = "test"
      }    
      layer.operands.op2 = {
        value = "test2"
      }

      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("detects not enougth operands (reference)", function ()
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local operation     = Layer.require (path .."operation")
      local string =  Layer.require (path .."literal.string")
      local collection =  Layer.require "cosy/formalism/data.collection"

      local layer = Layer.new{name ="layer"}

      layer [refines] = {operation}
      layer.operator  = "ADD"

      layer[meta].operands_type = string
      layer.operands[meta][collection].minimum=4

      layer.operands.op1 = {
        value = "test"
      }    
      layer.operands.op2 = {
        value = "test2"
      }    

      Layer.Proxy.check (layer)
      assert.is_not_nil (Layer.messages (layer) ())
    end)

    it ("good number of operands (reference)", function ()
      local refines       = Layer.key.refines
      local meta       =  Layer.key.meta
      local operation     = Layer.require (path .."operation")
      local string =  Layer.require (path .."literal.string")
      local layer = Layer.new{name ="layer"}
      local collection =  Layer.require "cosy/formalism/data.collection"


      layer [refines] = {operation}
      layer.operator  = "ADD"

      layer[meta].operands_type = string
      
      -- ############# BEUG ##################
      layer.operands[meta][collection].minimum=1
      layer.operands[meta][collection].maximum=4
      layer.operands[1] = {
        value = "test"
      }    
      layer.operands[2] = {
        value = "test2"
      }    

      Layer.Proxy.check (layer)
      assert.is_nil (Layer.messages (layer) ())
    end) 
  end)
end)
