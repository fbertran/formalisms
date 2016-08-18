return function (Layer, environment)

  local refines = Layer.key.refines
  local record = Layer.require "cosy/formalism/data.record"
  local collection = Layer.require "cosy/formalism/data.collection"

  environment [refines] = {
    record,
  }
  environment.shared  = {
    [refines] = {
      record
    }
  }
  environment.container = {
     [refines] = { 
      collection 
    }
   }

return environment

end