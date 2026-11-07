vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- completion (1.* tags ship a prebuilt binary)

	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
})

require("blink.cmp").setup({
	completion = { documentation = { auto_show = true } },
})

-- warnings

vim.lsp.enable({ "basedpyright", "jdtls" })
vim.diagnostic.config({ virtual_text = true })
