-- attempt 2 for part 2 day 2
local fs = require 'custom.fs'
local log = require 'custom.log'

log.debug = true
local vp = log.print

vp 'starting debug mode'

local lines = fs.readFileLines 'day2.txt'
assert(#lines == 1000, 'lines must be length 1000')

local reports = {}
for _, line in ipairs(lines) do
  local levels = vim.split(line, ' ')
  local report = {}
  for i, lvl in ipairs(levels) do
    report[i] = tonumber(lvl)
  end
  table.insert(reports, report)
end

assert(#reports == 1000, 'reports must be length 1000')

local function isOrdered(report)
  assert(#report > 1, 'report must be longer then 1')
  local isDesc = report[1] > report[2]
  for i = 1, #report - 1 do
    local curr = report[i]
    local next = report[i + 1]
    if isDesc ~= (curr > next) then
      return false, next, i + 1 -- order changed
    end
  end
  return true
end

local function hasGoodDiff(a, b)
  local diff = math.abs(a - b)
  return diff > 0 and diff < 4
end

local function isTight(report)
  for i = 1, #report - 1 do
    local curr = report[i]
    local next = report[i + 1]
    if not hasGoodDiff(curr, next) then
      return false, next, i + 1
    end
  end
  return true
end

local function isSafe2(report)
  local ord, _, _ = isOrdered(report)
  local tight, _, _ = isTight(report)
  if ord and tight then
    return true
  end
  for i, _ in ipairs(report) do
    -- lets hope I have enough memory lol
    local modReport = vim.deepcopy(report)
    table.remove(modReport, i)
    local ord2, _, _ = isOrdered(modReport)
    local tight2, _, _ = isTight(modReport)
    if ord2 and tight2 then
      return true
    end
  end
  return false
end

local safeCount = 0
for _, report in ipairs(reports) do
  if isSafe2(report) then
    safeCount = safeCount + 1
  end
end

print('safe count: ' .. safeCount)

print 'done!'
