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
  
  Operator [refines] = { drawable }

  Operator [meta] = {
    operands_type = false,

    -- Representation of the operator : For example '+' for a binary addition
    -- By default if it's an nary operator we will add parentheses for the parsing : +(..., ..., ...)
    [record] = {
      operator = {
        value_type  = "string",
      },
      -- A number use for sorting Operators with themselves
      -- A bigger number involves a bigger priority
      priority = {
        value_type  = "number",
      },
    }
  }


  Operator .punctuators  = {
    [refines] = {
      collection,
    },

    [meta] = {
      [collection] = {
      -- not ref because we want the Formalism operator not the instance
        value_type = Operator, 
      }
    }
  }

  Operator .ignored_characters  = {
    [refines] = {
      collection,
    },

    [meta] = {
      [collection] = {
        value_type = "string",
      }
    }
  }

  Operator .operands = {
    [refines] = {
      collection,
    },

    [meta] = {
      [collection] = {
        value_type = ref [meta] .operands_type,
        minimum = false,
        maximum = false
      }
    },
  }

  Operator [meta] .printer = function (root_expression)
    for i = 1, #root_expression.operands do
      root_expression.operands [i][meta].printer(root_expression.operands [i])
      if i < #root_expression.operands then  
        io.write(root_expression.operator)
      end
    end
  end


  return Operator
end