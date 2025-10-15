return {
    -- Core Mason plugin provides a package manager UI/registry for LSPs, DAPs, linters, formatters
    "williamboman/mason.nvim",
    dependencies = {
        -- Automatically bridge Mason installations with lspconfig
        "williamboman/mason-lspconfig.nvim",
        -- Base LSP client configs (for backward compat with mason-lspconfig)
        "neovim/nvim-lspconfig",
        -- Ensure cmp-nvim-lsp is available before we compute capabilities
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Enhanced capabilities for nvim-cmp completion
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Common on_attach with a few handy mappings
        local on_attach = function(_, bufnr)
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, opts)
        end

        -- Initialize Mason UI/registry
        require("mason").setup()

        -- Declare servers here. They will be auto-installed and configured.
        local servers = {
            -- PHP: intelephense
            intelephense = {
                settings = {
                    intelephense = {
                        files = { maxSize = 5000000 },
                    },
                },
            },
            -- Lua
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
            -- Python
            pyright = {},
            -- JavaScript/TypeScript (use ts_ls, not deprecated tsserver)
            ts_ls = {},
            -- Go
            gopls = {},
        }

        -- Ask Mason to ensure these servers are installed
        local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
        if has_mason_lspconfig then
            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = true,
            })
        end

        -- Setup handlers: use the modern vim.lsp.config API if available (Neovim 0.11+)
        -- Otherwise fall back to require("lspconfig") for older versions
        local use_modern_api = vim.fn.has("nvim-0.11") == 1

        if use_modern_api then
            -- Modern approach: vim.lsp.config (no deprecation warning)
            for server_name, server_opts in pairs(servers) do
                local opts = vim.tbl_deep_extend("force", {}, server_opts)
                opts.capabilities = capabilities
                opts.on_attach = on_attach
                
                -- Use vim.lsp.config to configure the server
                vim.lsp.config(server_name, opts)
                vim.lsp.enable(server_name)
            end
        else
            -- Legacy approach for older Neovim versions
            local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
            if not ok_lspconfig then return end

            if has_mason_lspconfig and type(mason_lspconfig.setup_handlers) == "function" then
                mason_lspconfig.setup_handlers({
                    function(server_name)
                        local opts = servers[server_name] or {}
                        opts.capabilities = capabilities
                        opts.on_attach = on_attach
                        lspconfig[server_name].setup(opts)
                    end,
                })
            else
                -- Fallback for older mason-lspconfig without setup_handlers
                for server_name, opts in pairs(servers) do
                    opts = vim.tbl_deep_extend("force", {}, opts)
                    opts.capabilities = capabilities
                    opts.on_attach = on_attach
                    if lspconfig[server_name] then
                        lspconfig[server_name].setup(opts)
                    end
                end
            end
        end
    end,
}

