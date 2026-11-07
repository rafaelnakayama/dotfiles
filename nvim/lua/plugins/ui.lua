vim.pack.add({
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
	{ src = 'https://github.com/folke/tokyonight.nvim' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

-- night: same tokyo night style as the terminal

vim.cmd.colorscheme("tokyonight-night")

-- no folder arrows; the open/closed folder icon already shows the state

require("nvim-tree").setup({
	renderer = { icons = { show = { folder_arrow = false } } },
})

-- one statusline for all splits; icons come from nvim-web-devicons

require("lualine").setup({
	options = {
		globalstatus = true,
		component_separators = "│",
		section_separators = "",
	},
})

require("gitsigns").setup()
