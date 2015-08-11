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
    --  name = {
    --     value_type      = "string", 
    --     value_container = nil,
    --   },  
    -- in `tags`.
  },
}
    
layer.__checks__ = {
  check_tags = function (proxy)
    local message = ""
    local tags = proxy.__meta__.tags
    for tag, value in Layer.pairs(tags) do
      if value["value_type"] ~= nil or value["value_container"] ~= nil then
        if proxy[tag] == nil then
          message = message .. "key " .. tostring(tag) .. " : missing. "
          
        elseif value["value_container"] ~= nil then
          local exist = false
          for k, _ in Layer.contents(value["value_container"]) do
            print (value["value_container"],k)
            if value == k then
              exist = true
              break
            end
          end
          if not exist then
            message = message .. tostring(tag) .. " value : does not exist. "
          end
        
        else
          if type(value["value_type"]) == "string" then
            if type(proxy[tag]) ~= value["value_type"] then
              message = message .. tostring(tag) .. " value : incompatible type. Waiting " .. value["value_type"] .. ", found " .. type(proxy[tag]) .. ". "
            end
          
          else --if Layer.is_reference(value["value_type"]) then
            if type(proxy[tag]) ~= "table" then 
              message = message .. tostring(tag) .. " value : incompatible types. Waiting " .. tostring(value["value_type"]) .. ", found " .. type(proxy[tag]) .. ". "
            else
              local exist = false
              for _, ref in Layer.ipairs(proxy[tag].__refines__) do
                if ref == value["value_type"] then 
                  exist = true
                  break
                end
              end
              if not exist then
                message = message .. tostring(tag) .. " value : incompatible type. Waiting " .. tostring(value["value_type"]) .. ", found " .. tostring(proxy[tag]) .. ". "
              end
            end
          end
        end
      end
    end
    
    if message ~= "" then
      return "check_tags", message
    end
  end,
}
return layer
