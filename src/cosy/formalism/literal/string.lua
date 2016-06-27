-- string

return function (Layer, string)

  local lpeg = require "lpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local literal  =  Layer.require "cosy/formalism/literal"
 
  string [refines] = {
    literal,
  }
  string [meta] = {
    [record] = {
      value = { value_type = "string" },
    },
  }
   string.pattern = function ()
      --print ("ici"..addition_operation [meta][record].operator)
      local pattern = lpeg.C {(lpeg.P "\"" *(lpeg.R "az" + lpeg.R "AZ" + "_" + lpeg.R "09")^1 * lpeg.P "\"")/function (patt)
          --print("string")
          local layer = Layer.new{}
          layer [refines] = {string}
            layer.value = patt
            string.result = layer
        end }
      return pattern
   end
  return string
end
