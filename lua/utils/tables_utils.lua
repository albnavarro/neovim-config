local M = {} -- initialize an empty table (or object in JS terms)

-- includes js equivalent
function M.has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- map js equivalent
function M.map(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

-- filter js equivalent
function M.filter(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        if f(v) then
            t[k] = v
        end
    end
    return t
end

-- get size of a table.
function M.tableSize(tbl)
    local size = 0
    for _ in pairs(tbl) do
        size = size + 1
    end

    return size
end

return M -- This line exports the table
