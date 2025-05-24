local readOnly = function(t)
    local proxy = {}

    local mt = { -- create metatable
        __index = t,
        __newindex = function()
            print("attempt to update a read-only table")
            -- error("attempt to update a read-only table", 2)
        end,
    }
    setmetatable(proxy, mt)
    return proxy
end

local my_table = readOnly({ name = "my name", surname = "my surname" })
my_table.name = "illegal"
print(my_table.name)
print(my_table.surname)
