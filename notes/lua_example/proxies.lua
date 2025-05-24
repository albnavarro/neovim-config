-- keep a private access to original table
local my_table = {
    name = "defualt name",
    surname = "defaul surname",
}

-- Create proxy
-- __index / __newindex vengono attivati se la chiave/indice non esisitono
-- perció manteniamo la tabella proxi vuota.
local proxi_table = {}

-- create metatable
setmetatable(proxi_table, {
    -- getter
    __index = function(_, key)
        print("*access to element " .. tostring(key) .. "value is:" .. my_table[key])
        return my_table[key] -- access the original table
    end,

    -- setter
    __newindex = function(_, key, value)
        if my_table[key] == nil then
            print("invalid key")
            return
        end

        print("*update of element " .. tostring(key) .. " to " .. tostring(value))
        my_table[key] = value -- update original table
    end,
})

--
proxi_table.name = "myName"
proxi_table.surname = "mySurname"
proxi_table.other = "illegal value"
print(vim.inspect(my_table))
