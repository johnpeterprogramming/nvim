local which_key = require("which-key")
which_key.add({
    { "2O", "O<Esc>O", desc = "Write two new lines above and go into insert mode." },
    { "<leader>pv", vim.cmd.Ex, desc = "Open file explorer" },
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", desc = "Find Files" },
    { "<leader>fg", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<CR>", desc = "Grep String" },
    { "<leader>e",
        function()
        vim.diagnostic.open_float(nil, { focusable = false })
        end,
        desc = "Show Diagnostic",
    },
})

--  I can add these later when I understand what they do
--
    --    p = { "\"_dP", "Paste without overwrite" },
    --    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
    --    s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and replace word under cursor" },
    --    t = { ":Today<CR>", "Open today's note" },
--  J = { "mzJ`z", "Join lines and keep cursor position" },
--  ["<C-d>"] = { "<C-d>zz", "Half page down and center" },
--  ["<C-u>"] = { "<C-u>zz", "Half page up and center" },
--  n = { "nzzzv", "Next search result and center" },
--  N = { "Nzzzv", "Previous search result and center" },
--  Q = { "<nop>", "Disable Ex mode" },

