local Layer   = require "layeredata"
local struct  = Layer.new { name = "structure" }
local struct2   = Layer.new { name = "model"}

local _ = Layer.reference "structure"
local root = Layer.reference (false)

struct[Layer.key.meta] = {
  structure_type = {
    __label__ = "structure",
    [Layer.key.meta] = {
      A_type = {
        name = "A",
      },
      B_type = {
        id = "B",
      },
    },
    collection = {
      [Layer.key.default] = {
        [Layer.key.refines] = {
          _ [Layer.key.meta].A_type,
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
        label = _ [Layer.key.meta].A_type.name,
      },
      -- name = "A" and label = a reference to name.

      element4 = {
        [_ [Layer.key.meta].A_type.name] = 4
      },
      -- name = "A" and a reference to name = 4.

      element5 = {
        [Layer.key.refines] = {
          _ [Layer.key.meta].B_type
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
struct2[Layer.key.meta] = {
  __label__   = "model",
  [Layer.key.refines] = {
    root[Layer.key.meta].structure_type,
  },
  [Layer.key.meta] = {
    B_type = {
      label = false,
    },
  },
  collection = {
    element6 = {
      [Layer.key.refines] = {
        m[Layer.key.meta].B_type,
      }
    }
    -- id = "B" and label = false
  },
}
print()
print(Layer.dump(Layer.flatten(struct2)))
