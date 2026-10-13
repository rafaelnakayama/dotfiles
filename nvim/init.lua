-- when running this init.lua for the first time do: 
--
--	macos:
--
-- 	'brew install ripgrep fd' 
-- 	'brew install tree-sitter-cli'

vim.opt.confirm = true
vim.opt.number = true

vim.pack.add ({

	-- nvim-tree
	
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' }, 
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
		
	-- nvim-telescope
	
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },

	-- nvim-treesitter
	
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' }
})

require("nvim-tree").setup()
require("telescope").setup()
require("nvim-treesitter").setup()
