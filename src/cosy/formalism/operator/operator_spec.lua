if #setmetatable ({}, { __len = function () return 1 end }) ~= 1 then
  require "compat52"
end

-- These lines are required to correctly run tests.
require "busted.runner" ()

describe ("Formalism Operator", function ()

  it ("can be loaded", function ()
    local Layer = require "layeredata"
    local _     = Layer.require "cosy/formalism/operator"
  end)
end)

describe ("Formalism Operator : operator_type", function ()
  it ("allows miss operator", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local meta    = Layer.key.meta
    local record  = Layer.require "cosy/formalism/data.record"
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = 1

    layer [meta] [record] .operator .optional = true

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("detects miss operator", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new { name = "target"}

    layer [refines] = { operator_formalism }
    layer .priority = 1

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of operator (primitive)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = 1

    layer .operator = 42

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of operator (proxy)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = 1

    layer .operator = Layer.new {}

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using good type of operator", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = 1
    layer .operator = "+"

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Operator : priority_type", function ()
  it ("allows missing priority with optional", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local meta    = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local record              = Layer.require "cosy/formalism/data.record"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer [meta] [record] .priority .optional = true
    layer .priority = nil

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("detects wrong type of priority (primitive)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = true
    layer .operator = " "

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of priority (proxy)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = Layer.new {}
    layer .operator = " "

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using good type of priority", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .priority = 42
    layer .operator = " "

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Operator : punctuators", function ()

  it ("detects wrong type of punctuators (primitive)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .punctuators .punc1 = true
    layer .operator = " "
    layer .priority = 1

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of punctuators (proxy)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    layer .punctuators .punc1 = Layer.new {}

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using good type of punctuators", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}
    local punc                = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    punc [refines] = { operator_formalism }
    punc .operator = "punc"
    punc .priority = 2

    layer .punctuators .punc1 = punc

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))   
  end)
end)

describe ("Formalism Operator : ignored_characters", function ()

  it ("detects wrong type of ignored_characters (primitive)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    layer .ignored_characters [1] = 42

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of ignored_characters (proxy)", function ()
    local Layer   = require "layeredata"
    local refines = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    layer .ignored_characters .char1 = Layer.new {}

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using good type of ignored_characters", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local operator_formalism  = Layer.require "cosy/formalism/operator" 
    local layer               = Layer.new {}
  
    layer [refines] = { operator_formalism }
    
    layer .operator = " "
    layer .priority = 1
    
    layer .ignored_characters .punc1 = " "

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Operator : operands_type", function ()

  it ("detects wrong type of operands (primitive) with primitive", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = "number"
    layer .operands .op1 = "op1"
    layer .operands .op2 = 42

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of operands (primitive) with proxy", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1
    layer [meta] .operands_type = "number"
    layer .operands .op1 = Layer.new {}
    layer .operands .op2 = 42

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)


  it ("using good type of operands (primitive)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = "number"
    layer .operands .op1 = 24
    layer .operands .op2 = 42

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("detects wrong type of operands (proxy) with primitive", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    
    layer .operator = " "
    layer .priority = 1
    
    layer [meta] .operands_type = Layer.new {}

    layer .operands .op1 = Layer.new {}
    layer .operands .op1 [refines] = { layer [meta] .operands_type }

    layer .operands .op2 = 42

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects wrong type of operands (proxy) with proxy", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"

    local layer               = Layer.new {}


    layer [refines] = { operator_formalism }
    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = Layer.new {}

    layer .operands .op1 = Layer.new {}
    layer .operands .op1 [refines] = { collection }

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using good type of operands (proxy) with proxy", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}


    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = Layer.new {}
    layer [meta] .operands_type [refines] = { collection }

    layer .operands .op1 = Layer.new {}
    layer .operands .op1 [refines] = { layer [meta] .operands_type }
    
    layer .operands .op2 = Layer.new {}
    layer .operands .op2 [refines] = { layer [meta] .operands_type }
    
    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Operator : operands_size with operands_type primitive", function ()
  it ("allows operands without minimum and maximum size", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = "number"

    layer .operands [#layer .operands+1] = 1
    layer .operands [#layer .operands+1] = 9
    layer .operands [#layer .operands+1] = 8
    layer .operands [#layer .operands+1] = 4
    layer .operands [#layer .operands+1] = 2 
    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("detects less than minimum operands (primitive)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = "number"
    layer .operands [meta] [collection] .minimum = 3

    layer .operands [#layer .operands+1] = 1
    layer .operands [#layer .operands+1] = 9

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects more than maximum operands (primitive)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = "number"
    layer .operands [meta] [collection] .maximum = 1

    layer .operands [#layer .operands+1] = 1
    layer .operands [#layer .operands+1] = 9

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using correct number of operands (primitive)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = "number"
    layer .operands [meta] [collection] .maximum = 8
    layer .operands [meta] [collection] .minimum = 2

    layer .operands [#layer .operands+1] = 1
    layer .operands [#layer .operands+1] = 9

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("using exactly the number of operands (primitive)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "

    layer .priority = 1

    layer [meta] .operands_type = "number"
    layer .operands [meta] [collection] .minimum = 2
    layer .operands [meta] [collection] .maximum = 2

    layer .operands [#layer .operands+1] = 1
    layer .operands [#layer .operands+1] = 9

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)

describe ("Formalism Operator : operands_size with operands_type proxy", function ()
  it ("allows operands without minimum and maximum size", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer [meta] .operands_type = Layer.new {}

    layer .operands [1] = Layer.new {}
    layer .operands [1] [refines] = { layer [meta] .operands_type }
    
    layer .operands [2] = Layer.new{}
    layer .operands [2] [refines] = { layer [meta] .operands_type }

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("detects less than minimum operands (proxy)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    
    layer .operator = " "
    layer .priority = 1

    layer .operands [meta] [collection] .minimum = 3

    layer [meta] .operands_type = Layer.new {}

    layer .operands [1] = Layer.new {}
    layer .operands [1] [refines] = { layer [meta] .operands_type }
    
    layer .operands [2] = Layer.new{}
    layer .operands [2] [refines] = { layer [meta] .operands_type }

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("detects more than maximum operands (proxy)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }
    
    layer .operator = " "
    layer .priority = 1

    layer .operands [meta] [collection] .maximum = 1

    layer [meta] .operands_type = Layer.new {}

    layer .operands [1] = Layer.new {}
    layer .operands [1] [refines] = { layer [meta] .operands_type }
    
    layer .operands [2] = Layer.new{}
    layer .operands [2] [refines] = { layer [meta] .operands_type }

    Layer.Proxy.check_all (layer)
    assert.is_not_nil (next (Layer.messages))
  end)

  it ("using correct number of operands (proxy)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer .operands [meta] [collection] .maximum = 8
    layer .operands [meta] [collection] .minimum = 1

    layer [meta] .operands_type = Layer.new {}

    layer .operands [1] = Layer.new {}
    layer .operands [1] [refines] = { layer [meta] .operands_type }
    
    layer .operands [2] = Layer.new{}
    layer .operands [2] [refines] = { layer [meta] .operands_type }

    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)

  it ("using exactly the number of operands (proxy)", function ()
    local Layer               = require "layeredata"
    local refines             = Layer.key.refines
    local meta                = Layer.key.meta
    local operator_formalism  = Layer.require "cosy/formalism/operator"
    local collection          = Layer.require "cosy/formalism/data.collection"
    local layer               = Layer.new {}

    layer [refines] = { operator_formalism }

    layer .operator = " "
    layer .priority = 1

    layer .operands [meta] [collection] .minimum = 2
    layer .operands [meta] [collection] .maximum = 2

    layer [meta] .operands_type = Layer.new {}

    layer .operands [1] = Layer.new {}
    layer .operands [1] [refines] = { layer [meta] .operands_type }
    
    layer .operands [2] = Layer.new{}
    layer .operands [2] [refines] = { layer [meta] .operands_type }


    Layer.Proxy.check_all (layer)
    assert.is_nil (next (Layer.messages))
  end)
end)
