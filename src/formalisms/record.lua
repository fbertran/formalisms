local Layer = require "layeredata"
local layer = Layer.new {
  name = "record",
}

-- record formalism
-- ================
--
-- a record is a table where some keys are obligated.
-- To do that we introduce the special key `tags`.

layer.__meta__ = {
  tags = {
    -- If you want a key `name` in your record you wrote this :
    name = {
       value_type      = "string", 
       value_container = nil,
     },  
    -- in `tags`.
  },
}
    
layer.__checks__ = {
  check_tags = function (proxy)
    local message = ""
    local tags = proxy.__meta__.tags
    for tag, value in Layer.pairs(tags) do
      if( value["value_type"]      ~= nil or
          value["value_container"] ~= nil ) then
        
        if (proxy[tag] == nil) then
          message = message .. "Key '" .. tostring(tag) .. "' is missing. "
          
        elseif (value["value_type"] ~= nil and
                type(proxy[tag]) ~= type(value["value_type"])) then
          message = message .. "Type of " .. tostring(tag) .. "'s value is wrong. "
        
        elseif(value["value_container"] ~= nil) then
          for k, v in Layer.pairs(value["value_container"]) do
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
