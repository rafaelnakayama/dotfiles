-- when running this init.lua for the first time do: 
--
--	macos:
--
-- 	'brew install ripgrep fd' 
-- 	'brew install tree-sitter-cli'
-- 	'brew install basedpyright jdtls'
-- 	'brew install sqlcmd libpq && brew link --force libpq'
-- 	'brew install ruff google-java-format sql-formatter'

vim.opt.confirm = true
vim.opt.number = true

-- looks, from github.com/ngscheurich/nvim-from-scratch

vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8

-- space is the <leader> key used by the keymaps in lua/

vim.g.mapleader = " "

-- each module adds its own plugins with vim.pack.add, then configures them
-- ui first so the colorscheme is set before lualine picks its theme

require("plugins.ui")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.format")
require("config.run")
