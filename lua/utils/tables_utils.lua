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

-- filter js equivalent in format key, value
function M.filter(tbl, f)
    local t = {}
    for k, v in pairs(tbl) do
        if f(v) then
            t[k] = v
        end
    end
    return t
end

-- find js equivalent in format key, value
-- Returns only first value
function M.find(tbl, f)
    local result = nil

    for _, v in pairs(tbl) do
        if f(v) and result == nil then
            result = v
        end
    end

    return result
end

-- get size of a table.
function M.tableSize(tbl)
    local size = 0
    for _ in pairs(tbl) do
        size = size + 1
    end

    return size
end

---Reduces an array
function M.reduce(list, fn, init)
    local acc = init
    local index = 0

    for k, v in ipairs(list) do
        if 1 == k and not init then
            acc = v
        else
            acc = fn(acc, v, index)
        end
        index = index + 1
    end
    return acc
end

return M -- This line exports the table
