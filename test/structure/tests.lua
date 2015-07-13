local Layer   = require "layeredata"
local struct  = Layer.new { name = "structure" }
local struct2   = Layer.new { name = "model"}

local _ = Layer.reference "structure"
local root = Layer.reference (false)

struct.__meta__ = {
  structure_type = {
    __label__ = "structure",
    __meta__ = {
      A_type = {
        name = "A",
      },
      B_type = {
        id = "B",
      },
    },
    collection = {
      __default__ = {
        __refines__ = {
          _.__meta__.A_type,
        },
      },
      element1 = {
        value = 3
      },
      -- name = "A" and value = 3

      element2 = {
        name = "B",
      },
      -- name = "B"

      element3 = {
        label = _.__meta__.A_type.name,
      },
      -- name = "A" and label = a reference to name.

      element4 = {
        [_.__meta__.A_type.name] = 4
      },
      -- name = "A" and a reference to name = 4.

      element5 = {
        __refines__ = {
          _.__meta__.B_type
        },
      },
      -- id = "B" and not name = "A"
    },
  },
}


print(Layer.dump(Layer.flatten(struct)))

struct2.__depends__ = {
  struct,
}

local m = Layer.reference "model"
struct2.__meta__ = {
  __label__   = "model",
  __refines__ = {
    root.__meta__.structure_type,
  },
  __meta__ = {
    B_type = {
      label = false,
    },
  },
  collection = {
    element6 = {
      __refines__ = {
        m.__meta__.B_type,
      }
    }
    -- id = "B" and label = false
  },
}
print()
print(Layer.dump(Layer.flatten(struct2)))
