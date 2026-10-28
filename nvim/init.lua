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

-- space is the <leader> key used by the keymaps below

vim.g.mapleader = " "

-- telescope-fzf-native has C code that needs 'make' after every install or update

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "make" }, { cwd = ev.data.path }):wait()
		end
	end,
})

vim.pack.add ({

	-- nvim-tree
	
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' }, 
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
		
	-- nvim-telescope
	
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
	{ src = 'https://github.com/debugloop/telescope-undo.nvim' },

	-- nvim-treesitter
	
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

	-- lsp

	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- completion (1.* tags ship a prebuilt binary)

	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },

	-- formatting

	{ src = 'https://github.com/stevearc/conform.nvim' },

	-- git

	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },

	-- sql

	{ src = 'https://github.com/tpope/vim-dadbod' },

	-- colorscheme

	{ src = 'https://github.com/folke/tokyonight.nvim' }
})

-- storm: tokyo night with a lighter, bluer background than the terminal's night

vim.cmd.colorscheme("tokyonight-storm")

require("nvim-tree").setup()
require("nvim-treesitter").setup()
require("blink.cmp").setup()
require("gitsigns").setup()

-- telescope

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

telescope.setup({
	pickers = {
		find_files = {
			file_ignore_patterns = { "node_modules", "dist", ".venv", "%.git/" },
			hidden = true,
		},
	},
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-x>"] = actions.delete_buffer,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		undo = {},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("undo")
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope list keymaps" })
vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Telescope git status" })
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Telescope undo tree" })

-- format on save

require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format" },
		java = { "google-java-format" },
		sql = { "sql_formatter" },
	},
	format_on_save = { timeout_ms = 2000 },
})

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
}

-- java compiles every file in the folder so classes can see each other; .class files go to a temp dir
local function java_cmd()
	local out = vim.fn.tempname()
	return ("cd %s && javac -d %s *.java && java -cp %s %s"):format(
		vim.fn.shellescape(vim.fn.expand("%:p:h"), true), out, out, vim.fn.expand("%:t:r"))
end

vim.api.nvim_create_user_command("Run", function()
	vim.cmd("update")

	if vim.bo.filetype == "sql" then
		vim.cmd("%DB")
		return
	end

	local cmd
	if vim.bo.filetype == "java" then
		cmd = java_cmd()
	else
		local runner = runners[vim.bo.filetype]
		if not runner then
			vim.notify("no runner for filetype '" .. vim.bo.filetype .. "'", vim.log.levels.WARN)
			return
		end
		cmd = runner .. " " .. vim.fn.expand("%:S")
	end

	vim.cmd("split | terminal " .. cmd)
	vim.cmd("startinsert")
end, {})
