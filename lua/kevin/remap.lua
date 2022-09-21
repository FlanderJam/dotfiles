local nnoremap = require("kevin.keymap").nnoremap

-- General Remap
nnoremap("<leader>FD", "<cmd>Ex<CR>")

-- Telescope Remaps
nnoremap("<leader>FF", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>FG", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>FB", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>FH", "<cmd>Telescope help_tags<cr>")



--vim.g.mapleader=' '
--function map(mode, lhs, rhs, opts)
--    local options = { noremap = true }
--    if opts then
--        options = vim.tbl_extend("force", options, opts)
--    end
--    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
--end

--map("t", "<Esc>", "<C-\\><C-n>")
