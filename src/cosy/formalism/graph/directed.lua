-- Directed graphs
-- ===============
--
-- A directed graph types its arrows with two properties: `input` and `output`.
-- An arrow can be of both types.
--
-- See [this article](http://link.springer.com/chapter/10.1007/3-540-45446-2_20).

return function (Layer, directed)

  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local graph = Layer.require "cosy/formalism/graph"

  directed [refines] = {
    graph
  }

  directed [meta].edge_type [meta].arrow_type = {
    [meta] = {
      record = {
        input  = {
          value_type = "boolean",
        },
        output = {
          value_type = "boolean",
        },
      },
    },
    input  = false,
    output = false,
  }

end
