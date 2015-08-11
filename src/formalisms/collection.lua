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
-- * `key_type`        : type of keys
-- * `key_container`   : all keys must reference an element of this container
-- * `value_type`      : type of values
-- * `value_container` : all values must reference an element of this container

layer.__meta__ = {
  key_type        = nil,
  key_container   = nil,
  value_type      = nil,
  value_container = nil,
}

layer.__checks__ = {
  check_collection = function (proxy)
    
    local meta = proxy.__meta__
    do
      local exist = false 
      for _ in Layer.pairs(meta) do 
        exist = true
        break
      end
      if not exist then
        return
      end
    end
    local message = ""
    for key, value in Layer.contents(proxy) do
      -- check if all values in this collection are references to an element of the container `value_container`
      if type(meta["value_container"]) == "table" then
        local exist = false
        for k, _ in Layer.contents(meta["value_container"]) do
          if value == k then
            exist = true
            break
          end
        end
        if not exist then
          message = message .. tostring(key) .. " value : does not exist. "
        end
      
      -- check if all values type are correct
      elseif meta["value_type"] ~= nil then
        if type(meta["value_type"]) == "string" then
          if type(value) ~= meta["value_type"] then
            message = message .. tostring(key) .. " value : incompatible type. Waiting " .. meta["value_type"] .. ", found " .. type(value) .. ". "
          end
        
        else --if Layer.is_reference(value["value_type"]) then
          if type(value) ~= "table" then 
            message = message .. tostring(key) .. " value : incompatible types. Waiting " .. tostring(meta["value_type"]) .. ", found " .. type(value) .. ". "
          else
            local exist = false
            for _, ref in Layer.ipairs(value.__refines__) do
              print(ref)
              if ref == meta["value_type"] then 
                exist = true
                break
              end
            end
            if not exist then
              message = message .. tostring(key) .. " value : incompatible type. Waiting " .. tostring(meta["value_type"]) .. ", found " .. tostring(value) .. ". "
            end
          end
        end
      end
      
      -- check if all keys in this collection reference an element of the container `key_container`
      if type(meta["key_container"]) == "table" then
        local exist = false
        for k, _ in Layer.contents(value["key_container"]) do
          if key == k then
            exist = true
            break
          end
        end
        if not exist then
          message = message .. tostring(key) .. " value : does not exist. "
        end
          
      -- check if all keys type are correct
      elseif meta["key_type"] ~= nil then
        if type(meta["key_type"]) == "string" then
          if type(key) ~= meta["key_type"] then
            message = message .. "key " .. tostring(key) .. " : incompatible type. Waiting " .. meta["key_type"] .. ", found " .. type(key) .. ". "
          end
        
        else --if Layer.is_reference(meta["value_type"]) then
          if type(key) ~= "table" then 
            message = message .. "key " .. tostring(key) .. " : incompatible types. Waiting " .. tostring(meta["key_type"]) .. ", found " .. type(key) .. ". "
          else
            local exist = false
            for _, ref in Layer.ipairs(key.__refines__) do
              if ref == meta["key_type"] then 
                exist = true
                break
              end
            end
            if not exist then
              message = message .. "key " .. tostring(key) .. " : incompatible type. Waiting " .. tostring(meta["key_type"]) .. ", found " .. tostring(key) .. ". "
            end
          end
        end
      end
    end
      
    if message ~= "" then
      return "check_collection", message
    end
  end
}

return layer
