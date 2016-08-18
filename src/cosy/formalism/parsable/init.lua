-- Parsable formalism reprensents formalism which needs to be printed
-- or needs to convert data (string, table, etc..) in instance of itself.

return function (Layer, parsable)
  local meta    = Layer.key.meta
  local checks  = Layer.key.checks

  --Function parser and printer are not mandatory but if they are defined they must be functions
  parsable [meta] = {}

  -- Currently we passe the current_instance in parameter because "reference" doesn't work well
  parsable [meta] .parser = function(--[[ current_instance, exp1, ...exp2  ]] )
    --[[
    local pattern = pattern/function(left_operands1_instance, left_operands1_trace, ..., patt_curr, right_operands1_instance, right_operands1_trace,)
      local layer= Layer.new {}
      local trace = concatenation of patt_curr and operands_traces
      layer [refines] = { current_instance }
      layer.operands = { operands_instances }
      
      -- Some test
      assert( test,"Error message")

      return layer,trace
      end  
    return patt_curr]]
  end

  -- Currently we passe the current_instance in parameter because "reference" doesn't work well
  parsable [meta] .printer = function(--[[current_instance]])
  -- return string
  end


  -- pattern uses if we doesn't need to generate one more time the pattern's parser
  parsable [meta] .pattern = nil

  parsable [checks] = {}
  parsable [checks] ["parser.value_type"] = function (proxy)
    if proxy [meta] ~= nil and proxy [meta] .parser ~= nil then
      if type (proxy [meta] .parser) ~= "function" then
        Layer.coroutine.yield ("parser.value_type.invalid", {
          proxy = proxy,
          key   = "parser",
          used  = type (proxy [meta] .parser),
        })
      end
    end
  end

  parsable [checks] ["printer.value_type"] = function (proxy)
    if proxy [meta] ~= nil and proxy [meta] .printer ~= nil then
      if type (proxy [meta] .printer) ~= "function" then
        Layer.coroutine.yield ("printer.value_type.invalid", {
          proxy = proxy,
          key   = "printer",
          used  = type (proxy [meta] .printer),
        })
      end
    end
  end
  
end