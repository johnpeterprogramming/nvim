vim.cmd.colorscheme("tokyonight")

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true -- Shows relative line numbers

-- Set indentation
vim.opt.tabstop = 4         -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4      -- Number of spaces to use for autoindent
vim.opt.expandtab = true    -- Converts tabs to spaces

-- Enable case-insensitive search (unless uppercase is used)
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Enable incremental search
vim.opt.incsearch = true

-- Set clipboard to system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Show matching brackets
vim.opt.showmatch = true

-- Decrease update time for responsiveness
vim.opt.updatetime = 300

-- Disable swap files and backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Wrapping makes files look wierd and I don't like it
vim.opt.wrap = false
-- Custom key bindings
-- vim.keymap.set('n', '<leader>2O', 'O<Esc>O', { desc = 'Create two lines above' })

-- Remove automatic comments - they are driving me mad
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    -- This removes the 'o' (open) and 'r' (retro) flags from formatoptions.
    -- The 'c' (comment-auto) flag is often removed as well to prevent auto-wrapping comments.
    vim.opt_local.formatoptions:remove({ 'r', 'o', 'c' })
  end,
})

