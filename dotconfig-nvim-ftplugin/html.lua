
local map = vim.api.nvim_set_keymap
map('n', '<leader>f', "ma<cmd>%! prettierd %<cr>'a", {noremap = true})
