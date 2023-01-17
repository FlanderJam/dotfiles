local nnoremap = require("flanderjam.keymap").nnoremap

-- General Remap
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>", { silent = true})
nnoremap("<leader>FD", "<cmd>Ex<CR>")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Telescope Remaps
-- nnoremap("<leader>FF", "<cmd>Telescope find_files<cr>")
-- nnoremap("<leader>FG", "<cmd>Telescope live_grep<cr>")
-- nnoremap("<leader>FB", "<cmd>Telescope buffers<cr>")
-- nnoremap("<leader>FH", "<cmd>Telescope help_tags<cr>")

