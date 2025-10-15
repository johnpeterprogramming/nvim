return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        -- let cmp enhance LSP capabilities
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- intelephense setup
        vim.lsp.config("intelephense", {
            cmd = { "intelephense", "--stdio" },
            filetypes = { "php" },
            root_markers = { "composer.json", ".git" },
            capabilities = capabilities, 
            settings = {
                intelephense = {
                    files = { maxSize = 5000000 },
                },
            },
            on_attach = function(client, bufnr)
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                -- I copied these from gemini
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>gr', vim.lsp.buf.rename, opts)
                -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            end,
        })

        vim.lsp.enable("intelephense")
    end,
}

