
require "paq" {
  "savq/paq-nvim";
--    "savq/melange";
--    "mrjones2014/lighthaus.nvim";
  "machakann/vim-sandwich";
  "bluz71/vim-nightfly-guicolors";
  "nvim-treesitter/nvim-treesitter";
  "neovim/nvim-lspconfig";
--    "williamboman/nvim-lsp-installer";
--    "williamboman/mason.nvim";
  "hrsh7th/nvim-cmp";
  "hrsh7th/cmp-nvim-lsp";
  "hrsh7th/cmp-vsnip";
  "hrsh7th/vim-vsnip";
  "hrsh7th/vim-vsnip-integ";
  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";
  {"nvim-telescope/telescope-fzf-native.nvim", run = 'make'};
  "nvim-lualine/lualine.nvim";
  "mattn/emmet-vim";
  "sbdchd/neoformat";
  "lewis6991/gitsigns.nvim";
  "rafamadriz/friendly-snippets";
  "mtikekar/nvim-send-to-term";
  "kyazdani42/nvim-web-devicons";
  "folke/trouble.nvim";
--  "folke/lsp-colors.nvim";
  {"davidgranstrom/scnvim", run = 'scnvim#install()'};
  {"glacambre/firenvim", run = 'firenvim#install(0)'};
}

require("trouble").setup { }

require'telescope'.setup{}

require('gitsigns').setup()

require'lualine'.setup{
  options = {
  icons_enabled = false,
  theme = 'nightfly',
},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp'}}},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  completion = {
    autocomplete = true
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['ö'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
--    { name = 'buffer' },
  })
})

--local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--require('lspconfig')['tsserver'].setup {
--  capabilities = capabilities
--}

-- local lsp_installer = require('nvim-lsp-installer')
-- lsp_installer.on_server_ready(function(server)
--     local opts = {}
-- 
--     -- (optional) Customize the options passed to the server
--     -- if server.name == "tsserver" then
--     --     opts.root_dir = function() ... end
--     -- end
-- 
--     -- This setup() function is exactly the same as lspconfig's setup function.
--     -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--     server:setup(opts)
-- end)

-- require("mason").setup()

require'lspconfig'.pylsp.setup{}

vim.opt.termguicolors = true
vim.cmd "colorscheme nightfly"

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "javascript", "python" },
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
--  indent = {
--    enable = true
--  }
}

vim.g.mapleader = ' '
vim.g.user_emmet_leader_key=','
vim.g.python3_host_prog='/home/n/miniconda3/envs/jupyter/bin/python'

--vim.g.vsnip_filetypes.rails=['ruby']
local set = vim.opt
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.signcolumn = "yes"

vim.cmd([[
set undofile
set expandtab
set autoindent
set hidden
]])

local map = vim.api.nvim_set_keymap
map('i', '<leader>ö', 'ö', {noremap = true})
map('n', '<leader>tf', '<cmd>Telescope find_files<cr>', {noremap = true})
map('n', '<leader>tb', '<cmd>Telescope buffers<cr>', {noremap = true})
--map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', {noremap = true})
map('n', '<leader>d', '<cmd>TroubleToggle<cr>', {noremap = true})
map('i', '<c-j>', 'vsnip#expandable() ? "<Plug>(vsnip-expand)" : "<c-j>"', {expr = true})
map('i', '<c-l>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<c-l>"', {expr = true})

map('n', '<leader>p', '<cmd>r! wl-paste -p<cr>', {noremap = true})
map('n', '<leader>b', '<cmd>bn<cr>', {noremap = true})

map('n', '<leader>w', '<cmd>w<cr>', {noremap = true})

---- vim.g.scnvim_sclang_options = {'-l', "/home/mads/.config/SuperCollider/sclang_conf_development.yaml"}
--
--vim.g.scnvim_postwin_syntax_hl = 1
--
---- scnvim neovim docs !
--vim.g.scnvim_scdoc = 1
--
---- vertical 'v' or horizontal 'h' split
--vim.g.scnvim_postwin_orientation = 'v'
--
---- position of the post window 'right' or 'left'
--vim.g.scnvim_postwin_direction = 'right'
--
---- default is half the terminal size for vertical and a third for horizontal
--vim.g.scnvim_postwin_size = 50
--
---- automatically open post window on a SuperCollider error
--vim.g.scnvim_postwin_auto_toggle = 1
--
----	-- duration of the highlight
--vim.g.scnvim_eval_flash_duration = 100
--
---- number of flashes. A value of 0 disables this feature.
--vim.g.scnvim_eval_flash_repeats = 2
--
---- set this variable if you don't want the "echo args" feature
---- vim.g.scnvim_echo_args = 0
--
---- Configure the color of the evaluation flash
--vim.cmd([[ highlight SCNvimEval guifg=black guibg=white ctermfg=black ctermbg=white ]])
--
---- Uncomment to not use default keybindings
---- vim.g.scnvim_no_mappings = 1

