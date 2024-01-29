vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.nu = true --line numbers
vim.opt.relativenumber = true
vim.cmd[[set noswapfile]] --no swap prompt
vim.cmd[[set ignorecase smartcase]]
vim.cmd[[set guicursor+=n-v-c:blinkon1]]
vim.cmd[[set guicursor=n-c-i:hor30-iCursor-blinkwait300-blinkon200-blinkoff150]]
--Doesnt work for some reason because idk terminal or something
--but it makes vim background "transparent"
vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true --Use spaces over tab characters
vim.opt.smartindent = false
vim.opt.autoindent = false
vim.opt.wrap = true
vim.o.expandtab = true -- Open NeoVim In fullscreen when opened
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = false
vim.o.termguicolors = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.o.background  = "dark"
--vim.cmd[[colorscheme quiet]]
vim.opt.updatetime = 3000 -- CursorStop Updatetime

vim.opt.colorcolumn = "80"


--set system clipboard to vim
--Xserver xclip
--wayland wl-clipboard
vim.opt.clipboard = "unnamedplus"


--keymaps :h map-listing
--{'n', 'v'} --multiple modes
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>') --leader key
vim.keymap.set('n', '<F5>', ':RunCode<CR>')
vim.keymap.set('n', "<leader>f",":prettier --stdin-filepath %<CR>",  { noremap = true, silent = false})
