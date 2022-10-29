
local map = vim.api.nvim_set_keymap
map('n', '<leader>f', "<cmd>w<cr>ma<cmd>! blue -q %<cr><cr>l'a", {noremap = true})
