-- Toggle LazyDev depending on buffer directory.
-- autochdir may affect this.
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.lua",
-- 	callback = function()
-- 		-- vim.notify "~~~~~~~~~~~"
-- 		for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
-- 			-- vim.notify(dir)
-- 			for _, lazyDir in ipairs { ".config/nvim", "nvim_plugins" } do
-- 				if string.find(dir, lazyDir) then
-- 					vim.g.lazydev_enabled = true
-- 					vim.g.lua_subversion = 1
-- 					return
-- 				end
-- 			end
-- 		end
-- 		vim.g.lazydev_enabled = false
-- 		vim.lsp.config.lua = { runtime = { version = "Lua 5.4" } }
-- 		vim.g.lua_subversion = 4
-- 	end,
-- })

-- Auto split help windows vertically.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd H",
})
