vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- completion (1.* tags ship a prebuilt binary)

	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
})

require("blink.cmp").setup({
	completion = { documentation = { auto_show = true } },
})

-- warnings

-- jdtls: without a build file, each folder is its own project (not the whole git repo)
vim.lsp.config("jdtls", {
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.root(fname, { "pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", "mvnw", "gradlew", "build.xml" })
			or vim.fs.dirname(fname))
	end,
})

vim.lsp.enable({ "basedpyright", "jdtls" })
vim.diagnostic.config({ virtual_text = true })
