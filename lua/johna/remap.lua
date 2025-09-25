local which_key = require("which-key")
local non_lsp_mappings = {
    ["<leader>"] = {
        ["2O"] = { "O<Esc>O", "Write two new lines above and go into insert mode." },
        ["pf"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" },
        ["ps"] = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<CR>", "Grep String" },
        e = { vim.cmd.Ex, "Open file explorer" },
    --    p = { "\"_dP", "Paste without overwrite" },
    --    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
    --    s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace word under cursor" },
    --    t = { ":Today<CR>", "Open today's note" },
    },
    ["<C-p>"] = { "<cmd>lua require('telescope.builtin').git_files()<CR>", "Git Files" },
--  J = { "mzJ`z", "Join lines and keep cursor position" },
--  ["<C-d>"] = { "<C-d>zz", "Half page down and center" },
--  ["<C-u>"] = { "<C-u>zz", "Half page up and center" },
--  n = { "nzzzv", "Next search result and center" },
--  N = { "Nzzzv", "Previous search result and center" },
--  Q = { "<nop>", "Disable Ex mode" },
}
 
which_key.register(non_lsp_mappings)
