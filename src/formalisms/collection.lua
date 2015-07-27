local Layer = require "layeredata"
local layer = Layer.new {
  name = "collection",
}
local model = Layer.new{ name = "test" }


-- collection formalism
-- ================
--
-- a collection is a table where keys and values are typed or contained in another container.
--
-- To do those there are 4 special keys :
-- * `key_type`        : type of keys
-- * `key_container`   : all keys must reference an element of this container
-- * `value_type`      : type of values
-- * `value_container` : all values must reference an element of this container

local root = Layer.reference(false)


layer.__meta__ = {
  key_type        = nil,
  key_container   = nil,
  value_type      = nil,
  value_container = nil,
}

layer.__checks__ = {
  -- check_element = function (proxy)
  --   local meta = proxy.__meta__
  --   -- if(#meta == 0) then
  --   --   return
  --   -- end
  --   
  --   local message = ""
  --   for key, value in Layer.pairs(proxy) do
  --     if string.match(key, '^__.+__$') == nil then
  --        print(key, value)
  --       if type(meta["value_type"]) == "string"  then
  --         if type(value) ~= meta["value_type"]  then
  --           return "check_element", tostring(key) .. " value : wrong type."
  --         end
  --         
  --       elseif type(meta["value_type"]) == "table" 
  --       and     value                   >= meta["value_type"] 
  --       then  
  --         print(type(meta["value_type"]))
  --       end
  --     end
  --   end
  --   -- for key, value in Layer.pairs(meta) do
  --   --   if(key ~= "__meta__" or key ~= "__checks__") then
  --   --   
  --   --     if( value["value_type"]      ~= nil or
  --   --         value["value_container"] ~= nil ) then
  --   --       
  --   --       if (proxy[tag] == nil) then
  --   --         message = message .. "Key '" .. tostring(tag) .. "' is missing. "
  --   --         
  --   --       elseif (value["value_type"] ~= nil and
  --   --               type(proxy[tag]) ~= type(value["value_type"])) then
  --   --         message = message .. "Type of " .. tostring(tag) .. "'s value is wrong. "
  --   --       
  --   --       elseif(value["value_container"] ~= nil) then
  --   --         for k, v in Layer.pairs(value["value_container"]) do
  --   --           print(k, v)
  --   --         end
  --   --       end
  --   --     end
  --   --   end
  --   -- end
  --   if (message ~= "") then
  --     return "check_tags", message
  --   end
  -- end
}

-- 
-- model.a = {
--   __refines__ = {
--     layer
--   },
--   b = {
--     __refines__ = {
--       root.a.__meta__.x
--     }
--   },
-- }
-- 
-- print (Layer.toyaml(Layer.flatten(model)))
-- 

return layer
