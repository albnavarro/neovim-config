local M = {} -- initialize an empty table (or object in JS terms)

-- Check if value is in table ( like javascript includes )
function M.has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

return M -- This line exports the table
