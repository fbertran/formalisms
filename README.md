[![Build Status](https://travis-ci.org/CosyVerif/formalisms.svg?branch=master)](https://travis-ci.org/CosyVerif/formalisms)
[![Coverage Status](https://coveralls.io/repos/CosyVerif/formalisms/badge.svg?branch=master&service=github)](https://coveralls.io/github/CosyVerif/formalisms?branch=master)
[![Join the chat at https://gitter.im/CosyVerif/formalisms](https://badges.gitter.im/CosyVerif/formalisms.svg)](https://gitter.im/CosyVerif/formalisms?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Standard Formalisms Library for CosyVerif

This repository contains a standard library of formalisms, or pieces or
formalisms, to use within the [CosyVerif](http://cosyverif.org) platform.

## Install

CosyVerif formalisms are a set of [Lua](http://www.lua.org) modules.
It is bundled in [Luarocks](https://luarocks.org), a package manager for Lua.
To install it, first install Lua (version 5.2 or 5.3), for install using the
following commands:

```sh
  # requires the python pip command
  pip install hererocks
  hererocks my-prefix -r^ --lua=5.2
  ./my-prefix/bin/luarocks install cosy-formalisms
```

To run examples, put them in a file and launch it with:

```sh
  ./my-prefix/bin/lua my-file.lua
```
You can also run the Lua interpreter interactively (by giving it no parameter),
but remember to remove all `local` keywords from examples.

## Contributing

If you would like to create a formalism and have it included in this library,
please fork and make a pull request!

## Discussion, Bugs, ...

Please create [a new issue](https://github.com/CosyVerif/formalisms/issues/new)
if you have found a bug, or request a new feature.
For other discussions, you can use the
[gitter](https://gitter.im/CosyVerif/formalisms) chat.

## Tutorial

Let us start by creating some simple automata.
First, we have to define the formalism for automata, and then create some
models.

Almost every formalism (and model) definition starts with importing useful
modules:

```lua
local Layer   = require "layeredata"
local checks  = Layer.key.checks
local default = Layer.key.default
local labels  = Layer.key.labels
local meta    = Layer.key.meta
local refines = Layer.key.refines
```

Now, we can start the automaton definition.
It begins with creating a new `Layer` object, and giving it a unique name:

```lua
local automaton = Layer.new {
  name = "cosy.formalism.automaton",
}
```

We will also need sometimes to reference _things_ within the formalism.
To do so, we create a label and a reference (named `_`) to it:

```lua
automaton [labels] = {
  ["cosy.formalism.automaton"] = true,
}
local _ = Layer.reference "cosy.formalism.automaton"
```

Note that `labels` is a set (in the Lua programming style, i.e., a mapping
from names to `true`). It means that we can give several names to the same
formalism. In fact, this label will also be accessible from any model built
upon this formalism.

An [automaton](https://en.wikipedia.org/wiki/Automata_theory) is based on a
"usual" graph structure. But the general definition of graphs is the
hypermultigraph, a mix between
[hypergraphs](https://en.wikipedia.org/wiki/Hypergraph)
and [multigraphs](https://en.wikipedia.org/wiki/Multigraph).

Our automaton refines this general structure, by restricting the number of
vertices linked to each arc to two. _Refines_ means something like inherits
on steroids. We will learn later more on the meaning of `refines`.

```lua
local graph        = require "cosy.formalism.graph"
local binary_edges = require "cosy.formalism.graph.binary_edges"

automaton [refines] = {
  graph,
  binary_edges,
}
```

The `refines` field is a list of ancestors sorted in decreasing importance.
We also want to state that the graph is directed (each edge has an input and
an output), and has labels on vertices and edges. This can be added within
the previous definition of later as below. Not that we have also skipped storing
the imported modules in a local variable.

```lua
automaton [refines] [#automaton [refines]+1] = require "cosy.formalism.graph.directed"
automaton [refines] [#automaton [refines]+1] = require "cosy.formalism.graph.labeled.vertices"
automaton [refines] [#automaton [refines]+1] = require "cosy.formalism.graph.labeled.edges"
```

The `list [#list+1]` idiom is frequently used in Lua to add an element at the end
of a list.

In an automaton, vertices are called "states", and edges are called
"transitions". The `graph` stored its vertices in a container named `vertices`,
and its edges in a container named `edges`, both stored within the graph.
We create two new containers with names adapted to automata, and link them
to the corresponding graph containers:

```lua
automaton.vertices [refines] [#automaton.vertices [refines] + 1] = _.states
automaton.edges    [refines] [#automaton.edges    [refines] + 1] = _.transitions
```

We could also have written the alias below. However, it is not the preferred
solution. The first one creates new containers for states and transitions,
and defines the graph containers to refine them, and thus to see their contents.
The second solution simply creates aliases. It is less extensible for Formalisms
and models that will refine our `automaton`.

```lua
automaton.states      = _.vertices
automaton.transitions = _.edges
```

Now we can define what is a `state` and a `transition`. To do so, we create
two types, that are in fact prototypes for states and transitions.
As they are not instances, we put them within `automaton [meta]`. On the
contrary, all instances will be put outside the `[meta]` field.

A state is a graph vertex. It also contains some data. The labeled vertices,
that we imported earlier, defines vertices as records. We can describe their
fields within the `[meta].record` field. The `state_type` is contains an
`identifier` (a string), and two flags (`initial` and `final`). Being a
record, its instances can also contain other fields, not listed here, but
they must contain at least the three described fields.

```lua
automaton [meta].state_type = {
  [refines] = {
    _ [meta].vertex_type,
  },
  [meta] = {
    record = {
      identifier = "string",
      initial    = "boolean",
      final      = "boolean",
    }
  }
}
```

A transition is a graph edge. It is also a record that contains a letter,
that is taken from an alphabet. We describe both the type of this letter,
in `value_type` and in which container is must be in `value_container`.

```lua
automaton [meta].transition_type = {
  [refines] = {
    _ [meta].edge_type,
  },
  [meta] = {
    record = {
     letter = {
       value_type      = _.alphabet [Layer.key.meta].symbol_type,
       value_container = _.alphabet,
     },
   },
 },
}
```

The last part of the `automaton` formalism is to describe the alphabet. It is
an enumeration of symbols, so we make it refines the `enumeration` formalism.
It also defines explicitly the `symbol_type` to be strings. We also add some
symbols (`a`, `b`, `c`) by default for the example.

```lua
local enumeration  = require "cosy.formalism.data.enumeration"
automaton.alphabet = {
  [refines] = {
    enumeration,
  }
  [meta] = {
    symbol_type = "string",
  }
  a = "a",
  b = "b",
  c = "c",
}
```

Congratulations, you have just created your first formalism in CosyVerif!

## Formalism description

Contrary to usual metamodeling languages, Cosy does not use a
[class-based inheritance](https://en.wikipedia.org/wiki/Class-based_programming)
approach, but instead uses a
[prototype-based inheritance](https://en.wikipedia.org/wiki/Prototype-based_programming).

There is no strict separation between _what_ is a formalism and _what_ is
a model. Instead, they all belong to the same continuum, and their role
varies depending on the context.
