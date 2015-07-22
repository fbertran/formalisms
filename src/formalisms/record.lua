local Layer = require "layeredata"
local layer = Layer.new {
  name = "record",
}

-- record formalism
-- ================
--
-- a record is a table where some keys are obligated.
-- To do that we introduce the special key `__tags__`.

layer.__meta__ = {
  __tags__ = {
    -- If you want a key `name` in your record you wrote this :
    -- name = {
    --    __value_type__      = "string", 
    --    __value_container__ = nil,
    --  },  
    -- in `__tags__`.
  },
}
    
layer.__checks__ = {
  check_tags = function (proxy)
    local message = ""
    local tags = proxy.__meta__.__tags__
    for tag, value in Layer.pairs(tags) do
      if( value["__value_type__"]      ~= nil or
          value["__value_container__"] ~= nil ) then
        
        if (proxy[tag] == nil) then
          message = message .. "Key '" .. tostring(tag) .. "' is missing. "
          
        elseif (value["__value_type__"] ~= nil and
                type(proxy[tag]) ~= type(value["__value_type__"])) then
          message = message .. "Type of " .. tostring(tag) .. "'s value is wrong. "
        
        elseif(value["__value_container__"] ~= nil) then
          for k, v in Layer.pairs(value["__value_container__"]) do
            print(k, v)
          end
        end
      end
    end
    
    if (message ~= "") then
      return "check_tags", message
    end
  end,
}
return layer
