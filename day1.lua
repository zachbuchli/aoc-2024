-- advent of code 2024 day 1
-- This project requires it be run inside nvim :)
-- Author: Zach
local fs = require("custom.fs")

local lines = fs.readFileLines("day1.txt")

assert(#lines == 1000, "length doesnt match")

local rhs = {}
local lhs = {}
for k, v in ipairs(lines) do
	local pair = vim.split(v, "   ")
	rhs[k] = tonumber(pair[2])
	lhs[k] = tonumber(pair[1])
end

assert(#rhs == 1000, "rhs size mismatch")
assert(#lhs == 1000, "lhs mismatch")
assert(lhs[1000] == 61539, "rhs bad parse")
assert(rhs[1000] == 20843, "lhs bad parse")

-- these sort in place
table.sort(rhs)
table.sort(lhs)

local total_distance = 0
for i = 1, #rhs do
	local diff = math.abs(rhs[i] - lhs[i])
	total_distance = total_distance + diff
end

print("total distance: " .. total_distance)

local function occurances(list, val)
	local count = 0
	for i = 1, #list do
		if list[i] == val then
			count = count + 1
		end
	end
	return count
end

local sim_score = 0
for i = 1, #lhs do
	local count = occurances(rhs, lhs[i])
	sim_score = sim_score + (lhs[i] * count)
end

print("sim score: " .. sim_score)
print("done!")
