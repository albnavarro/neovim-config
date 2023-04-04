local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local commentstring_status_ok, ts_cm_i_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not commentstring_status_ok then
	return
end

comment.setup({
	pre_hook = ts_cm_i_comment.create_pre_hook(),
})
