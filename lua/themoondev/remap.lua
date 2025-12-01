-- Author: Abel Misiocha
-- Date: 2023-09-03

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "

-- Open explorer
keymap("n", "<leader>e", vim.cmd.Ex)

-- Normal --

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<leader>c", ":bdelete<CR>", opts)

-- Open local diagnostics
keymap("n", "<leader>dd", ":lua vim.diagnostic.open_float(0, {scope='line'}) <CR>", opts)
-- Yank current line diagnostic
keymap("n", "<leader>dy", function()
  local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1]-1 })
  if not vim.tbl_isempty(diags) then
    local messages = vim.tbl_map(function(d) return d.message:gsub("\n", " ") end, diags)
    local text = table.concat(messages, " | ")
    vim.fn.setreg('+', text)
    print("Yanked diagnostic: " .. text)
  end
end, opts)

-- Writting a file
keymap("n", "<leader>w", ":w<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Formating
keymap("n", "<leader>f", "<cmd> lua vim.lsp.buf.format()<CR>", opts)

-- Paste
vim.keymap.set("x", "<leader>p", [["_dP]]) -- Paste over visual selection
vim.keymap.set({"n","v"},"sp",[["+p]]) -- Paste from system clipboard

-- Copy
vim.keymap.set({"n", "v"}, "sy", [["+y]]) -- Copy to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- Copy line to system clipboard

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Renaming
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Disable mode
vim.keymap.set("n", "Q", "<nop>")
