local Layer = require "layeredata"
local layer = Layer.new {
  name = "collection",
}

-- collection formalism
-- ================
--
-- a collection is a table where keys and values are typed or contained in another container.
--
-- To do those there are 4 special keys :
-- * `__key_type__`        : type of keys
-- * `__key_container__`   : all keys must reference an element of this container
-- * `__value_type__`      : type of values
-- * `__value_container__` : all values must reference an element of this container


layer.__meta__ = {
  __key_type__        = nil,
  __key_container__   = nil,
  __value_type__      = nil,
  __value_container__ = nil,
}

layer.__checks__ = {
-- check_element = function (proxy)
--   -- test si tout est nil
--   local message = ""
--   local meta = proxy.__meta__
--   for key, value in Layer.pairs(meta) do
--     if(key ~= "__meta__" or key ~= "__checks__") then
--     
--       if( value["__value_type__"]      ~= nil or
--           value["__value_container__"] ~= nil ) then
--         
--         if (proxy[tag] == nil) then
--           message = message .. "Key '" .. tostring(tag) .. "' is missing. "
--           
--         elseif (value["__value_type__"] ~= nil and
--                 type(proxy[tag]) ~= type(value["__value_type__"])) then
--           message = message .. "Type of " .. tostring(tag) .. "'s value is wrong. "
--         
--         elseif(value["__value_container__"] ~= nil) then
--           for k, v in Layer.pairs(value["__value_container__"]) do
--             print(k, v)
--           end
--         end
--       end
--     end
--   end
--   if (message ~= "") then
--     return "check_tags", message
--   end
-- end
}
return layer
