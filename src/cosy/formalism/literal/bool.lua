-- bool

return function (Layer, bool)
  
  local lpeg = require "lpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/literal"
  local operands_logical_type = Layer.require "cosy/formalism/operation/logical.operands_type"
  local operands_relational_type = Layer.require "cosy/formalism/operation/relational.operands_type"
  local boolean_operation = Layer.require "cosy/formalism/operation/boolean"
  bool [refines] = {
    literal, 
    operands_logical_type,
    operands_relational_type,
    boolean_operation,
  }
  bool [meta] = {
    [record] = {
      value = { value_type = "boolean" },
    },
  }
  bool.pattern = function ()
      --print ("ici"..addition_operation [meta][record].operator)

      local pattern = lpeg.C {(lpeg.P "true" + lpeg.P "false")/function (patt)
          --print("bool")
          local layer = Layer.new {}
          layer [refines] = {bool}
          if(patt == "true") then
            layer.value = true
          else
            layer.value = false

           bool.result = layer
          end
        end }
      return pattern
   end
  return bool
end
