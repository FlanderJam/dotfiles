local nnoremap = require("kevin.keymap").nnoremap

nnoremap("<leader>FD", "<cmd>Ex<CR>")


--vim.g.mapleader=' '
--function map(mode, lhs, rhs, opts)
--    local options = { noremap = true }
--    if opts then
--        options = vim.tbl_extend("force", options, opts)
--    end
--    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
--end

--map("t", "<Esc>", "<C-\\><C-n>")
