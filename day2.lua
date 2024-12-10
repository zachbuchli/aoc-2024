-- advent of code 2024 day 2
-- This project requires it be run inside nvim :)
-- Author: Zach
local fs = require("custom.fs")
local log = require("custom.log")

log.debug = true
local vp = log.print

local lines = fs.readFileLines("day2.txt")
assert(#lines == 1000, "lines must be length 1000")

local reports = {}
for _, line in ipairs(lines) do
	local levels = vim.split(line, " ")
	local report = {}
	for i, lvl in ipairs(levels) do
		report[i] = tonumber(lvl)
	end
	reports[#reports + 1] = report
end

assert(#reports == 1000, "reports must be length 1000")

vp(reports[1])
vp(reports[2])

local function isSafe(report)
	local isDescRep = report[1] > report[2]
	for i = 1, #report - 1 do
		local curr = report[i]
		local next = report[i + 1]
		local isDesc = curr > next
		if isDescRep ~= isDesc then
			vp("not in order" .. next .. vim.inspect(report))
			return false, i + 1
		end
		local diff = math.abs(next - curr)
		if diff < 1 or diff > 3 then
			vp(diff .. " out of spec " .. curr .. " " .. next .. "" .. vim.inspect(report))
			return false, i + 1
		end
	end
	return true, nil
end

local function isSafeD(report)
	local safe, nextPos = isSafe(report)
	if safe then
		return true
	else
		vp("removing " .. report[nextPos])
		table.remove(report, nextPos)
		safe, nextPos = isSafe(report)
		if safe then
			return true
		else
			vp("unsafe: " .. vim.inspect(report))
			return false
		end
	end
end

local sr = 0
for _, v in ipairs(vim.list_slice(reports, 1, 1000)) do
	if isSafeD(v) then
		sr = sr + 1
	end
end

print("safe report count: " .. sr)
print("done!")
