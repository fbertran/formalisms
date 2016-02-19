-- Directed graphs
-- ===============
--
-- A directed graph types its arrows with two properties: `input` and `output`.
-- An arrow can be of both types.
--
-- See [this article](http://link.springer.com/chapter/10.1007/3-540-45446-2_20).

return function (Layer, directed)

  local checks   = Layer.key.checks
  local meta     = Layer.key.meta
  local refines  = Layer.key.refines

  local record       = Layer.require "cosy/formalism/data.record"
  local graph        = Layer.require "cosy/formalism/graph"
  local binary_edges = Layer.require "cosy/formalism/graph.binary_edges"

  directed [refines] = {
    graph,
    binary_edges,
  }

  directed [meta].edge_type [meta].arrow_type = {
    [meta] = {
      [record] = {
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

  local edge_type = directed [meta].edge_type
  edge_type [checks] = {}
  edge_type [checks] [directed] = function (edge)
    local inputs  = {}
    local outputs = {}
    for _, arrow in pairs (edge.arrows) do
      if arrow.input == arrow.output then
        Layer.coroutine.yield ("directed.invalid", {
          proxy = edge,
          arrow = arrow,
        })
      end
      if arrow.input then
        inputs [#inputs+1] = arrow
      elseif arrow.output then
        outputs [#outputs+1] = arrow
      end
    end
    for _, container in ipairs { inputs, outputs } do
      if #container ~= 1 then
        Layer.coroutine.yield ("directed.invalid", {
          proxy = edge,
        })
      end
    end
  end

end
