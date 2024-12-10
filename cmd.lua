local cmd = { "ls", "-l" }
local opts = { text = true }
local resp = vim.system(cmd, opts):wait()

local lines = {}
for line in resp.stdout:gmatch("[^\n]+") do
	table.insert(lines, line)
end

vim.print(lines)
