-- run 'brew install ripgrep fd' when running this init.lua for th first time (macos).

vim.opt.confirm = true

vim.pack.add ({

	-- nvim-tree
	
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' }, 
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
		
	-- nvim-telescope
	
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' }
})

require("nvim-tree").setup()
require("telescope").setup()
