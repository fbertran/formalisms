-- In our conception of formalisms, your final architecture may be represented by a tree with nodes and leafs.
-- Tree representation is usefull for parsing and printing a model.
-- When you create a formalism, you have to define what piece of the tree is it (node or leafs) : 
--  If it's a leaf then you are creating a Nullary operator (see nullary operator)
--  else you are creating an n-ary operator. We already provide you some n-ary operator.

-- Operator formalism works with the Operation formalism.
-- For parsing our final model, each parser function of ours operators will returns a lulpeg pattern with an instanciate function of the current operator 

return function (Layer, Operator, ref)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines
  local record      = Layer.require "cosy/formalism/data.record"
  local collection  = Layer.require "cosy/formalism/data.collection"
  local drawable    = Layer.require "cosy/formalism/drawable"
  local parsable    = Layer.require "cosy/formalism/parsable"

  Operator [refines] = { 
    drawable,
    parsable,
  }

  Operator [meta] .operands_type = false

  -- Representation of the operator : For example '+' for a binary addition
  -- By default if it's an nary operator we will add parentheses for the parsing : +(..., ..., ...)
  Operator [meta] [record] .operator = {
    value_type  = "string",
    optional    = true,
  }

  -- A number use for sorting Operators with themselves
  -- A bigger number involves a bigger priority
  Operator [meta] [record] .priority = {
    value_type  = "number",
    optional    = true,
  }


  Operator .punctuators  = {}
  Operator .punctuators [refines] = { collection }
  -- not ref because we want the Formalism operator not the instance
  Operator .punctuators [meta] [collection] .value_type = Operator


  Operator .ignored_characters  = {}
  Operator .ignored_characters [refines] = { collection }
  Operator .ignored_characters [meta] [collection] .value_type = "string"


  Operator .operands = {}
  Operator .operands [refines] = { collection }
  Operator .operands [meta] [collection] .value_type  = ref [meta] .operands_type
  Operator .operands [meta] [collection] .minimum     = false
  Operator .operands [meta] [collection] .maximum     = false

end