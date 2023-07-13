local M = {} -- initialize an empty table (or object in JS terms)

local uv = vim.loop

local function get_node_modules(root_dir, target)
	local root_node = root_dir .. target
	local stats = uv.fs_stat(root_node)
	if stats == nil then
		return ""
	else
		return root_node
	end
end
--
function M.getExePath(node_modules_target, fallbackCommand)
	local local_exe = get_node_modules(vim.fn.getcwd(), node_modules_target)
	return (local_exe ~= "") and local_exe or fallbackCommand
end

return M -- This line exports the table
