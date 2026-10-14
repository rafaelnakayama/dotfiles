-- when running this init.lua for the first time do: 
--
--	macos:
--
-- 	'brew install ripgrep fd' 
-- 	'brew install tree-sitter-cli'
-- 	'brew install basedpyright jdtls'
-- 	'brew install sqlcmd libpq && brew link --force libpq'

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
	
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

	-- lsp

	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- sql

	{ src = 'https://github.com/tpope/vim-dadbod' }
})

require("nvim-tree").setup()
require("telescope").setup()
require("nvim-treesitter").setup()

-- highlighting

require("nvim-treesitter").install({ "python", "java", "sql" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "java", "sql" },
	callback = function() vim.treesitter.start() end,
})

-- warnings

vim.lsp.enable({ "basedpyright", "jdtls" })
vim.diagnostic.config({ virtual_text = true })

-- :Run runs the current file; sql goes to $DATABASE_URL through vim-dadbod

local runners = {
	python = "python3",
	java = "java",
}

vim.api.nvim_create_user_command("Run", function()
	vim.cmd("update")

	if vim.bo.filetype == "sql" then
		vim.cmd("%DB")
		return
	end

	local runner = runners[vim.bo.filetype]
	if not runner then
		vim.notify("no runner for filetype '" .. vim.bo.filetype .. "'", vim.log.levels.WARN)
		return
	end

	vim.cmd("split | terminal " .. runner .. " " .. vim.fn.expand("%:S"))
	vim.cmd("startinsert")
end, {})
