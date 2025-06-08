-- Toggle lua version depending on buffer directory.
-- autochdir may affect this.
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.lua',
  callback = function()
    -- vim.notify "~~~~~~~~~~~"
    for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
      -- vim.notify(dir)
      for _, lazyDir in ipairs({ '.config/nvim', 'nvim_plugins' }) do
        if string.find(dir, lazyDir) then
          -- vim.g.lazydev_enabled = true
          vim.g.lua_subversion = 1
          return
        end
      end
    end
    -- vim.g.lazydev_enabled = false
    vim.lsp.config.lua = { runtime = { version = 'Lua 5.4' } }
    vim.g.lua_subversion = 4
  end,
})

-- Auto split help windows vertically.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd H',
})

-- Auto run file when saved
local attach_to_buffer = function(output_bufnr, pattern, command)
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('RunOnSave', { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data) end
      end
      vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { 'output: ' })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

vim.api.nvim_create_user_command('AutoRunLua', function()
  local inputBuf = vim.api.nvim_buf_get_name(0)

  vim.cmd.vnew()
  local outputBuf = vim.api.nvim_get_current_buf()

  attach_to_buffer(outputBuf, '*.lua', 'lua ' .. inputBuf)

  vim.cmd.wincmd("h")
end, {})
