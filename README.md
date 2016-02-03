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

## Requirements

Please learn the bases of the [Lua](http://www.lua.org) language before
reading this tutorial. For instance, you can read
[Programming in Lua](http://www.lua.org/pil/contents.html) (part I should be
sufficient).

## Tutorial

Let us start by creating some simple automata.
First, we have to define the formalism for automata, and then create some
models.

Contrary to usual metamodeling languages, Cosy does not use a
[class-based inheritance](https://en.wikipedia.org/wiki/Class-based_programming)
approach, but instead uses a
[prototype-based inheritance](https://en.wikipedia.org/wiki/Prototype-based_programming).
There is no strict separation between _what_ is a formalism and _what_ is
a model. Instead, they all belong to the same continuum, and their role
varies depending on the context.

Almost every formalism (and model) definition starts with importing the
`layeredata` module (that represents and manipulates data), and import some
useful constants:

```lua
local Layer   = require "layeredata"
local checks  = Layer.key.checks
local default = Layer.key.default
local labels  = Layer.key.labels
local meta    = Layer.key.meta
local refines = Layer.key.refines
```

Now, we can start the automaton definition.
It begins with creating a new `Layer` object, and giving it a unique name.

```lua
local automaton = Layer.new {
  name = "cosy.formalism.automaton",
}
```

Layers are _really_ like [layers in digital image editing](https://en.wikipedia.org/wiki/Layers_(digital_image_editing)).
Each formalism is put in its own layer, and models are built on layers above.
It allows us to _modify_ parts of imported formalisms within a specific
model (like adding a mustache to the Mona Lisa).

We will also need sometimes to reference _things_ within the formalism.
To do so, we create a label and a reference (named `_`) to its parent,
`automaton`. This reference does not refer to a specific layer. It refers
to a _position_ (here the root of the data).

```lua
automaton [labels] = {
  ["cosy.formalism.automaton"] = true,
}
local _ = Layer.reference "cosy.formalism.automaton"
```

Note that `labels` is a set (in the Lua programming style, i.e., a mapping
from identifiers to `true`). It means that we can give several names to the same
formalism. In fact, this label will also be accessible from any model built
upon this formalism, and each one will add its own label.

An [automaton](https://en.wikipedia.org/wiki/Automata_theory) is based on a
"usual" graph structure. But the general definition of graphs is the
hypermultigraph, a rarely defined mix of
[hypergraphs](https://en.wikipedia.org/wiki/Hypergraph)
and [multigraphs](https://en.wikipedia.org/wiki/Multigraph).
The Standard Formalisms Library for CosyVerif provides a formalism for the
generic form of graphs, as well as formalisms to constrain it.

Our automaton is built over the hypermultigraph structure, with a restriction
on  the number of vertices linked to each arc.
This notion of "built above" corresponds to the `refines` constant in the code.
It is a list of ancestors, each one put in its own layer.
They are sorted in decreasing importance.

```lua
local graph        = require "cosy.formalism.graph"
local binary_edges = require "cosy.formalism.graph.binary_edges"

automaton [refines] = {
  graph,
  binary_edges,
}
```

_Refines_ means something like "inherits on steroids".
When a data is found neither in the highest layer nor in the ones below,
it is searched in _all the `refines` found from the data to the root_.
For instance, if `automaton` refines `graph`, and the data `automaton.a.b.c` is
not found, we will search for it in `graph.a.b.c`. In "usual" inheritance, we
would have looked only at `automaton.a.b`'s refines.
This behavior allows us to mix the ideas of layers and object orientation.

We also want to state that the graph is directed (each edge has an input and
an output), and has labels on vertices and edges. This can be added within
the previous `refines` definition of later as below.
Note that we have also skipped storing the imported modules in a local variable.

```lua
automaton [refines] [#automaton [refines]+1] = require "cosy.formalism.graph.directed"
automaton [refines] [#automaton [refines]+1] = require "cosy.formalism.graph.labeled.vertices"
automaton [refines] [#automaton [refines]+1] = require "cosy.formalism.graph.labeled.edges"
```

The `list [#list+1]` idiom is frequently used in Lua to add an element at the
end of a list. Arrays start at position 1 in Lua. Their size is given by the
`#` operator, and computed by finding the first natural key with no value.
It takes into account the layers and `refines` to compute this number.

In an automaton, vertices are called "states", and edges are called
"transitions". The `graph` stores its vertices in a container named `vertices`,
and its edges in a container named `edges`, both stored within the graph.
This naming difference is important as an automaton can also be manipulated
as a graph. Thus, we have to make sure that notions _and data_ of the automaton
formalisms and models are mapped to notions of the graph formalism.

The layers approach provides a simple and useful way of doing such mappings.
We juste have to create two new containers with names adapted to automata
theory, and change the `graph` containers to refine `automaton` ones.

```lua
automaton.vertices [refines] [#automaton.vertices [refines] + 1] = _.states
automaton.edges    [refines] [#automaton.edges    [refines] + 1] = _.transitions
```

Updating `graph` does not really impact it: in fact we update the `graph`
data within the `automaton` layer! This also means that if `graph` is used in
several parts of our formalism, other uses will not be affected.

We could also have created a more traditional alias as below.
However, it is not the preferred solution, because its lacks extensibility.
The "cosy way" creates new containers for states and transitions, that can
themselves be specialized, whereas the "below way" does not allow specialization
at all.

```lua
automaton.states      = _.vertices
automaton.transitions = _.edges
```

Now we can define what are states and transitions.
They are containers of data of the same type (`state_type` for `states`,
`transition_type` for `transitions`).
This is expressed by refining the `collection` formalism.
This one automatically defines several checks, for instance to verify that
all elements of the collection have a given type.
This type is given within the `[meta].collection.value_type` field,
a convention set by the `collection` formalism.

```lua
local collection = require "cosy.formalism.data.collection"
automaton.states = {
  [refines] = {
    collection,
    _ [meta].vertices,
  },
  [meta] = {
    collection = {
      value_type = _ [meta].state_type,
    }
  }
}
automaton.transitions = {
  [refines] = {
    collection,
    _ [meta].edges,
  },
  [meta] = {
    collection = {
      value_type = _ [meta].transition_type,
    }
  }
}
```

As we do not have the notions of classes and instances, "have a type" means
refining the type. For instance, all elements in `states` must refine
`_ [meta].state_type`.

Note that our containers refine `_ [meta].vertices` and `_ [meta].edges`.
This is because the `graph`formalsm defines already containers for vertices
and edges, and we would like to import what has already been defined on them.
It creates a harmless circular refinement with our previous extension of
`vertices` and `edges`. As these two containers already refine `collection`,
we could have skipped it.

Now, we still have to define the two types `state_type` and `transition_type`.
They are prototypes for state and transition instances that will be put within
the `states` and `transitions` containers.

Containers have been defined within the `automaton` object because they are
instances. But we have no way to differentiate types from instances. Thus,
a convention is to put all types and other metadata with the `[meta]` fields.

A state is a graph vertex. It also contains some data.
The labeled vertices, that we imported earlier, defines vertices as records.
We can describe their fields within the `[meta].record` field (a convention set
by the `record` formalism).
Each state contains an `identifier` (a string), and two flags
(`initial` and `final`).
Being a record, its instances are also allowed to contain other fields,
not listed here, but they must contain at least the three described fields.

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
taken from an alphabet.
We describe the type of this letter in `value_type`, and in which container it
must be stored in `value_container`.
These two attributes are used by convention by the `record` formalism.

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

The last part of the `automaton` formalism is to describe the alphabet.
It is an enumeration of symbols, so we make it refines the `enumeration`
formalism.
It also defines explicitly the `symbol_type` to be strings.

```lua
local enumeration = require "cosy.formalism.data.enumeration"
automaton.alphabet = {
  [refines] = {
    enumeration,
  }
  [meta] = {
    symbol_type = "string",
  }
}
```

Congratulations, you have just created your first formalism in CosyVerif!
Next step is to create an instance of automaton above this formalism.

***
