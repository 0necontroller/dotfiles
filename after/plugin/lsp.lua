-- =========================
-- Mason setup
-- =========================
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "gopls",
        "pyright",
        "rust_analyzer",
        "clangd",
        "html",
        "cssls",
        "ts_ls",
        "jsonls",
        "yamlls",
        "bashls",
        "dockerls",
        "tailwindcss",
        "taplo",
    }
})

-- =========================
-- CMP (completion)
-- =========================
local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_lsp.default_capabilities()

cmp.setup({
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- =========================
-- LSP keymaps (shared on_attach)
-- =========================
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

-- =========================
-- Global LSP defaults (Neovim 0.11 way)
-- =========================
vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Optional diagnostics tuning
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Enable LSP servers explicitly
vim.lsp.enable({
    "lua_ls",
    "gopls",
    "pyright",
    "rust_analyzer",
    "clangd",
    "html",
    "cssls",
    "ts_ls",
    "jsonls",
    "yamlls",
    "bashls",
    "dockerls",
    "tailwindcss",
    "taplo",
})
