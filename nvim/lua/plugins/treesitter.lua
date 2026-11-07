vim.pack.add({
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

require("nvim-treesitter").setup()

-- highlighting

require("nvim-treesitter").install({ "python", "java", "sql" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "java", "sql" },
	callback = function() vim.treesitter.start() end,
})
