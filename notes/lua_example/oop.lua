-- Meta class
local Person = {}

-- Create new methods for instance
function Person:new(data)
    data = data or {}
    local name = data.name or "default name"

    -- Implement prototypes
    local o = {}

    -- self is Person becouse use of :
    ---
    --- `__index`: The indexing access operation table[key].
    --- This event happens when table is not a table or when key is not present in table.
    --- The metavalue is looked up in the metatable of table.
    -- eg: :getName() is not in person so get it from metatable ( similat ot javascritp prototypes )
    setmetatable(o, { __index = self })

    self.name = name
    return o
end

-- Methods
function Person:getName()
    print("name is:", self.name)
end

function Person:addSuffix(suffix)
    self.name = self.name .. (suffix or "")
end

-- test
local pippo = Person:new({ name = "pippo" })
pippo:addSuffix("--1")
pippo:getName()

local pluto = Person:new({ name = "pluto" })
pluto:addSuffix("--2")
pluto:getName()

local paperino = Person:new()
paperino:addSuffix("--3")
paperino:getName()
