-- identifier

return function (Layer, identifier)

  local lpeg = require "lpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local literal =  Layer.require "cosy/formalism/literal"
  local record  =  Layer.require "cosy/formalism/data.record"

  identifier [refines] = {
    literal,
  }
  identifier [meta] = {
    [record] = {
      value = { value_type = false },
    },
  }

  identifier [meta][record].pattern = function (instance)
      --print ("ici"..addition_operation [meta][record].operator)

      local pattern = lpeg.C {((lpeg.R "az" + lpeg.R "AZ" + "_") * (lpeg.R "az" + lpeg.R "AZ" +"."+ "_" + lpeg.R "09")^0)/function (patt)
          local val = load ("return function (instance)  return instance"..string.sub (patt,string.find (patt,"%."), #patt).." end") ()
          val = val (instance)

          if(val) then
            identifier [meta][record].result = val
          end
        end }
      return pattern
   end
  
  return identifier
end
