-- An Identifier is a string with a particular format.
-- In our case an Identifier is a string consists of alphanumeric characters and does not start with a number.
-- Inside a collection of Identifiers you must use the same name (value) as the key of your collection
-- it allows us to don't verify the uniqueness of the id and it's faster to find it.

return function (Layer, identifier)

  local lpeg    = require "lulpeg"
  local meta    = Layer.key.meta
  local refines = Layer.key.refines
  local checks  = Layer.key.checks
  local nullary = Layer.require "cosy/formalism/operator/nullary"
  local record  = Layer.require "cosy/formalism/data.record"
  local literal = Layer.require "cosy/formalism/literal"
  local prefix  = "cosy/formalism/literal.identifier"
  

  identifier [refines] = {
    literal,
    nullary,
  }
 
  identifier.priority = math.huge 
 
  identifier [meta] [record] = {
    value = { value_type = "string" }
  }
  

  -- This function return the identiffier named (key) patt which is contained in inst
  -- or nil if it doesn't exist
  identifier [meta] .get_id = function ( inst, patt)
    local result = nil
    if inst ~= refines and inst ~= meta and getmetatable(inst) == Layer.Proxy then
      if inst [patt] ~= nil  and identifier <= inst [patt] then
        result = inst [patt]
      else
        for _,v in pairs (inst) do
          if inst ~= refines and inst ~= meta and getmetatable(inst) == Layer.Proxy then
            result = identifier[meta].get_id(v,patt)
            if result ~= nil then
             return result 
           end
          end
        end
      end
    end
    return result
  end

  identifier [meta] .parser = function (reference,instance)
    local pattern = lpeg.C ((lpeg.R "az" + lpeg.R "AZ" + "_") * (lpeg.R "az" + lpeg.R "AZ" +"."+ "_" + lpeg.R "09")^0 - (lpeg.P "true" + lpeg.P "false"))/
      function (patt)
        local layer
        local a,b = string.find(patt, "%a+%.") 
        
        if a ~= nil then
          local ref
          local last_index
          
          ref = string.sub(patt, a,b-1)
          assert(instance.name == ref,"unknown identifier : wrong instance name, expected \""..instance.name.."\" not \""..ref.."\"" )
          layer = instance
          ref = ref.."."
          for word in string.gmatch(string.sub(patt, b+1,#patt), "%a+%.") do
            ref = ref..word
            word = string.sub (word,1, #word-1)
            layer = layer[word]
            assert(layer ~= nil,"unknown identifier : wrong index \""..word.."\" in \""..ref.."\"")
          end
          last_index =string.sub(patt,#ref+1,#patt) 
          layer = layer[last_index]
          assert(layer ~= nil,"unknown identifier : wrong index \""..last_index.."\" in \""..ref.."."..last_index.."\"")
        else        
          layer = reference[meta].get_id(instance,patt)
          assert(layer~=nil,"unknown identifier by variable name")
        end
        return layer,patt
      end
    return pattern
  end

  identifier [meta] .printer = function(reference)
    return (tostring(reference.value))
  end



  identifier [checks] = {}

  identifier [checks] [prefix .. ".format"] = function (proxy)
    if type(proxy .value) == "string" then      
      local i,j = string.find(proxy .value, "%w+")
      if j == #proxy .value and i == 1 then
        if string.find(proxy .value, "%d") ~= 1 then
          return
        end
        Layer.coroutine.yield (prefix .. ".format.invalid", {
          proxy = proxy,
          key   = "value",
          expected = "First char must be a letter"
        })  
      else
        Layer.coroutine.yield (prefix .. ".format.invalid", {
          proxy = proxy,
          key   = "value",
          expected = "Only accept alphanumeric characters"
        })
      end

    end 
  end

  return identifier
end
