vim.pack.add({
	{ src = 'https://github.com/tpope/vim-dadbod' },
})

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
