return function (Layer, graphical)

  local meta        = Layer.key.meta
  local refines     = Layer.key.refines
  local graph       = Layer.require "graph"
  -- local interaction = Layer.require "interaction"

  graphical [refines] = {
    graph,
  }

  graphical [meta].gui = {}
  local gui = graphical [meta].gui

  graphical [meta] [gui] = {}

  graphical [meta] [gui].render = function (parameters)
    assert (type (parameters) == "table")
    local Adapter = require "ardoises.js"
    for _, url in ipairs {
      "https://d3js.org/d3.v4.min.js",
      "https://d3js.org/d3-color.v1.min.js",
      "https://d3js.org/d3-dispatch.v1.min.js",
      "https://d3js.org/d3-ease.v1.min.js",
      "https://d3js.org/d3-interpolate.v1.min.js",
      "https://d3js.org/d3-selection.v1.min.js",
      "https://d3js.org/d3-timer.v1.min.js",
      "https://d3js.org/d3-transition.v1.min.js",
      "https://d3js.org/d3-drag.v1.min.js",
      "https://d3js.org/d3-zoom.v1.min.js",
    } do
      local script = Adapter.document:createElement "script"
      script:setAttribute ("src", url)
      script:setAttribute ("type", "text/javascript")
      Adapter.document.head:appendChild (script)
    end
    local Copas    = require "copas"
    local Et       = require "etlua"
    local name     = assert (parameters.name  )
    local editor   = assert (parameters.editor)
    local layer    = assert (parameters.what  ).layer
    local target   = assert (parameters.target)
    local D3       = Adapter.window.d3
    local width    = assert (parameters.width )
    local height   = assert (parameters.height)
    local hidden   = {}
    local vertices = Adapter.js.new (Adapter.window.Array)
    local edges    = Adapter.js.new (Adapter.window.Array)
    for key, vertex in pairs (layer.vertices) do
      local data = Adapter.tojs {
        id = vertices.length,
        x  = vertex.position
         and vertex.position.x
          or 0,
        y  = vertex.position
         and vertex.position.y
          or 0,
        fx = vertex.position
         and vertex.position.x,
        fy = vertex.position
         and vertex.position.y,
      }
      hidden [data] = {
        id    = vertices.length,
        key   = key,
        proxy = vertex,
      }
      vertices [vertices.length] = data
    end
    for key, edge in pairs (layer.edges) do
      local data = Adapter.tojs {
        id = vertices.length,
        x  = 0,
        y  = 0,
      }
      hidden [data] = {
        id    = vertices.length,
        key   = key,
        proxy = edge,
      }
      vertices [vertices.length] = data
      for k, arrow in pairs (edge.arrows) do
        for i = 0, vertices.length-1 do
          local node = vertices [i]
          if arrow.vertex <= hidden [node].proxy then
            local link = Adapter.js.new (Adapter.window.Object)
            link.source = data
            link.target = node
            hidden [link] = {
              id    = edges.length,
              key   = k,
              proxy = arrow,
            }
            edges [edges.length] = link
          end
        end
      end
    end
    target.innerHTML = Et.render ([[
      <svg width="<%- width %>" height="<%- height %>" id="layer">
      </svg>
    ]], {
      width  = width,
      height = height,
    })
    local svg = D3:select "#layer"
    local g   = svg
      :append "g"
      :attr   ("class", ".ardoises-gui")
    local simulation = D3
      :forceSimulation ()
      :force ("link"  , D3:forceLink ():id (function (_, d) return d.id end))
      :force ("charge", D3:forceManyBody ())
      :force ("center", D3:forceCenter (width / 2, height / 2))
    local drag_start = function (_, vertex)
      simulation:alphaTarget (1):restart ()
      vertex.fx = vertex.x
      vertex.fy = vertex.y
    end
    local drag_drag = function (_, vertex)
      vertex.fx = D3.event.x
      vertex.fy = D3.event.y
    end
    local drag_stop = function (_, vertex)
      Copas.addthread (function ()
        print (editor:patch {
          [name] = function ()
            hidden [vertex].proxy.position = {
                x = D3.event.x,
                y = D3.event.y,
              }
          end,
        })
      end)
      vertex.fx = D3.event.x
      vertex.fy = D3.event.y
    end
    local links = g
      :selectAll ".ardoises-gui"
      :data      (edges)
      :enter     ()
      :append    "line"
      :attr      ("stroke", "white")
      :attr      ("stroke-width", 2)
    local nodes = g
      :selectAll ".ardoises-gui"
      :data   (vertices)
      :enter  ()
      :append (function (_, data)
         local proxy = hidden [data].proxy
         return proxy [meta] [gui].create {
           proxy = hidden [data],
           data  = data,
         }
       end)
      :call (D3:drag ():on ("start", drag_start):on ("drag", drag_drag):on ("end", drag_stop))
    local source_x = function (_, d) return d.source.x end
    local source_y = function (_, d) return d.source.y end
    local target_x = function (_, d) return d.target.x end
    local target_y = function (_, d) return d.target.y end
    local tick     = function ()
      links:attr ("x1", source_x)
           :attr ("y1", source_y)
           :attr ("x2", target_x)
           :attr ("y2", target_y)
      nodes:each (function (element, data)
        local proxy = hidden [data].proxy
        return proxy [meta] [gui].update {
          element = element,
          proxy   = hidden [data],
          data    = data,
        }
      end)
    end
    simulation:nodes (vertices):on ("tick", tick)
    simulation:force "link":links (edges)
    svg:call (D3:zoom ():on ("zoom", function ()
      g:attr ("transform", D3.event.transform)
    end))
    coroutine.yield ()
    simulation:stop ()
    vertices.length  = 0
    edges   .length  = 0
    target.innerHTML = [[]]
  end

  graphical [meta].vertex_type [meta] [gui] = {}

  graphical [meta].vertex_type [meta] [gui].create = function (--[[parameters]])
    local Adapter   = require "ardoises.js"
    local group     = Adapter.document:createElementNS (Adapter.window.d3.namespaces.svg, "g")
    local selection = Adapter.window.d3:select (group)
    selection
      :append "circle"
      :attr ("r", 50)
      :attr ("stroke", "white")
      :attr ("stroke-width", 3)
    return selection:node ()
  end

  graphical [meta].vertex_type [meta] [gui].update = function (parameters)
    local Adapter = require "ardoises.js"
    Adapter.window.d3
      :select (parameters.element)
      :selectAll "circle"
      :attr ("cx", parameters.data.x)
      :attr ("cy", parameters.data.y)
  end

  graphical [meta].edge_type [meta] [gui] = {}

  graphical [meta].edge_type [meta] [gui].create = function (--[[parameters]])
    local Adapter   = require "ardoises.js"
    local group     = Adapter.document:createElementNS (Adapter.window.d3.namespaces.svg, "g")
    local selection = Adapter.window.d3:select (group)
    selection
      :append "circle"
      :attr ("r", 1)
      :attr ("stroke", "white")
    return selection:node ()
  end

  graphical [meta].edge_type [meta] [gui].update = function (parameters)
    local Adapter = require "ardoises.js"
    Adapter.window.d3
      :select (parameters.element)
      :selectAll "circle"
      :attr ("cx", parameters.data.x)
      :attr ("cy", parameters.data.y)
  end

end
