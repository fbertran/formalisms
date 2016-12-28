# Standard Formalisms Library for CosyVerif

This repository contains a standard library of formalisms, or pieces or
formalisms, to use within the [CosyVerif](http://cosyverif.org) platform.

## Install

CosyVerif formalisms are a set of [Lua](http://www.lua.org) modules.
It is bundled in [Luarocks](https://luarocks.org), a package manager for Lua.
To install it, first install Lua (version 5.2 or 5.3), for instance using the
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

Almost every formalism (and model) definition is a single function that takes
as parameters:

* a `Layer` module (used to represent and manipulates data);
* a second parameter representing the formalism or model to describe in this
  file; you should name this parameter with a meaningful name, like `automaton`
  in this tutorial;
* a third parameter representing a *reference* to the root of this formalism
  or model.

The function to define should return the formalism or model, but this `return`
can be omitted for convenience.
This convention allows to load formalisms and models either locally or from
a remote Cosy server.

```lua
return function (Layer, automaton, ref)
  ...
end
```

The second argument of this function, `automaton`, is an already created
new `Layer` object, with a unique name following the convention
`user/project/resource`.
For tests, a special loader is used, that converts the name to a standard
Lua module name, for instance `user.project.resource`, using
[Lua `require` conventions](http://www.lua.org/pil/8.1.html).
It allows to automatically load formalism and model dependencies in the `Layer`
module.

Layers are _really_ like [layers in digital image editing](https://en.wikipedia.org/wiki/Layers_(digital_image_editing)).
Each formalism is put in its own layer, and models are built on layers above.
It allows us to _modify_ parts of imported formalisms within a specific
model (like adding a mustache to the Mona Lisa).

We will also need sometimes to reference _things_ within the formalism.
Do not reference things using a syntax like `something = automaton.some.thing`.
The layer system **requires** that you use instead the `ref` parameter:
`something = ref.some.thing`.
This is mandatory to handle correctly inheritance between formalisms and models.

You can also create references yourself using the following syntax.

```lua
local myref = Layer.reference (automaton)
```

We begin filling the main function with the import of some useful constants:

```lua
local checks   = Layer.key.checks
local defaults = Layer.key.defaults
local meta     = Layer.key.meta
local refines  = Layer.key.refines
```

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
local graph        = Layer.require "graph"
local binary_edges = Layer.require "graph.binary_edges"

automaton [refines] = {
  graph,
  binary_edges,
  ...
}
```

Please not that we have used `Layer.require` instead of `require` to import
the dependencies. This is required to allow loading from a Cosy server as well
as from the filesystem.

_Refines_ means something like "inherits on steroids".
When a data is found neither in the highest layer nor in the ones below,
it is searched in _all the `refines` found from the data to the root_.
For instance, if `automaton` refines `graph`, and the data `automaton.a.b.c` is
not found, we will search for it in `graph.a.b.c`. In "usual" inheritance, we
would have looked only at `automaton.a.b`'s refines.
This behavior allows us to mix the ideas of layers and object orientation.

We also want to state that the graph is directed (each edge has an input and
an output), and has labels on vertices and edges. This can be added within
the previous `refines` definition as below.

```lua
local directed         = Layer.require "graph.directed"
local labeled_vertices = Layer.require "graph.labeled.vertices"
local labeled_edges    = Layer.require "graph.labeled.edges"

automaton [refines] = {
  graph,
  binary_edges,
  directed,
  labeled_vertices,
  labeled_edges,
}
```

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
automaton.vertices [refines] = { ref.states }
automaton.edges    [refines] = { ref.transitions }
```

Updating `vertices` and `edges` does not really impact the `graph` formalism:
we update the `graph` data within the `automaton` layer.
This also means that if `graph` is used in several parts of our formalism,
other uses will not be affected.

We could also have created a more traditional alias as below.
However, it is not the preferred solution, because its lacks extensibility.
The "cosy way" creates new containers for states and transitions, that can
themselves be specialized, whereas the "below way" does not allow specialization
at all.

```lua
automaton.states      = ref.vertices
automaton.transitions = ref.edges
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
local collection = Layer.require "data.collection"
automaton.states = {
  [refines] = {
    collection,
  },
  [meta] = {
    [refines] = {
      ref [meta].vertices [meta],
    },
    collection = {
      value_type = ref [meta].state_type,
    }
  }
}
automaton.transitions = {
  [refines] = {
    collection,
  },
  [meta] = {
    [refines] = {
      ref [meta].edges [meta],
    },
    collection = {
      value_type = ref [meta].transition_type,
    }
  }
}
```

As we do not have the notions of classes and instances, "have a type" means
refining the type. For instance, all elements in `states` must refine
`ref [meta].state_type`.

Note that the `[meta]` part of our containers refine `ref [meta].vertices[meta]`
and `ref [meta].edges[meta]`.
This is because the `graph` formalism defines already containers for vertices
and edges, and we would like to import what has already been defined on them.

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
    ref [meta].vertex_type,
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
    ref [meta].edge_type,
  },
  [meta] = {
    record = {
     letter = {
       value_type      = ref.alphabet [Layer.key.meta].symbol_type,
       value_container = ref.alphabet,
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
local enumeration = Layer.require "data.enumeration"
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

  # aHR0cHM6Ly9naXRodWIuY29tL29yZ3MvYXJkb2lzZXM=
