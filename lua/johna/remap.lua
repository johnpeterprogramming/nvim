local which_key = require("which-key")
require('telescope').setup{
  defaults = {
    prompt_prefix = "",
    selection_caret = "",
  }
}

local builtin = require('telescope.builtin')

which_key.add({
    { "2O", "O<Esc>O", desc = "Write two new lines above and go into insert mode." },
    { "<C-d>", "<C-d>zz"},
    { "<C-u>", "<C-u>zz"},

    { "<leader>pv", vim.cmd.Ex, desc = "Open VIM navigation" },

    { "<leader>pf", function()
        builtin.find_files()
    end, desc = "Find Files" },

    -- Search including gitignored files, but still ignore .git and node_modules
    { '<leader>pa', function()
        builtin.find_files({
            hidden = true,
            no_ignore = true,
            file_ignore_patterns = { "^.git/", "node_modules/" }
        })
    end, desc = 'Find ALL files (smart ignore)' },

    { "<C-p>", function()
        builtin.git_files({
            show_untracked = true
        })
    end, desc = "Find Files inside Git" },

    { "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep >") })
    end, desc = "Grep String" },

    -- Undo tree - doesn't work rn
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undo tree view."},

    { "<leader>e", function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end, desc = "Show Diagnostic" },
    
    -- Clear search highlighting on Esc
    { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search highlighting" }
}) 
