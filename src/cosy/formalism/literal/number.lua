-- Number formalism : Representation of a primitive number in a formalism

return function (Layer, number)
  
  local lpeg = require "lulpeg"
  local meta    =  Layer.key.meta
  local refines =  Layer.key.refines
  local record  =  Layer.require "cosy/formalism/data.record"
  local nullary  =  Layer.require "cosy/formalism/operator/nullary"

  number [refines] = {
    nullary,
  }

  number [meta] [record] .value = { value_type = "number" }

  number.priority = math.huge

  number.count_id = 0 --use for debugging

  number [meta].parser = function (reference,test)
    local pattern = lpeg.R "09"^1/function (patt)
    
      print("*********** NMBER : BEFORE LAYER NEW****************")
      print(test)
      for k,v in pairs(test) do
        print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print("\n")
      end

        local layer = Layer.new ({ name = "number_"..reference.count_id}, test)
        reference.count_id=reference.count_id+1

        print("*************NMBER : AFTER LAYER NEW **************")
      for k,v in pairs(test) do
        print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print("\n")
      end

        layer [refines] = {reference}
        print("BLABLBALA")
        print(reference.priority)
        layer.value = tonumber(patt)

        print("*************NMBER : AFTER REFINE **************")
      for k,v in pairs(test) do
        print(k)
        print(v)
        for n,m in pairs(v[meta]) do
        print(n)
        print(m)
        end 
        print("\n")
      end

          return layer,patt
      end
    return pattern
  end

  number[meta].printer = function(reference)
    io.write(reference.value)
  end

  return number
end
