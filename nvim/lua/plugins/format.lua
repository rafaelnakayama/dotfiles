vim.pack.add({
	{ src = 'https://github.com/stevearc/conform.nvim' },
})

-- format on save

require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		java = { "google-java-format" },
		sql = { "sql_formatter" },
	},
	format_on_save = { timeout_ms = 2000 },
})
