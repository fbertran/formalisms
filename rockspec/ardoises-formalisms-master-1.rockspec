package = "ardoises-formalisms"
version = "master-1"

source = {
  url = "git://github.com/ardoises/formalisms",
}

description = {
  summary     = "Ardoises: formalisms",
  detailed    = [[]],
  license     = "MIT/X11",
  maintainer  = "Alban Linard <alban@linard.fr>",
}

dependencies = {
  "layeredata",
}

modules = {
  "tool",
  "type",
  "type.check",
  "type.all_of",
  "type.one_of",
  "data.check_container",
  "data.collection",
  "data.enumeration",
  "data.polynomial",
  "data.record",
  "graph",
  "graph.directed",
  "graph.binary_edges",
  "graph.unique_edges",
  "automaton",
  "automaton.ita",
  "petrinet",
  "petrinet.pt",
  "petrinet.one_safe",
}
local sources = {}
for i = 1, #modules do
  local module = modules [i]
  sources ["ardoises.formalisms." .. module] = "src/" .. module:gsub ("%.", "/") .. ".lua"
end

build = {
  type    = "builtin",
  modules = sources,
}
