-- Day 3 part 1
--
local fs = require 'custom.fs'

local input = fs.readFileSync 'day3.txt'

local sum = 0
-- string pattern matching is sick in Lua.
for x, y in string.gmatch(input, 'mul%((%d+),(%d+)%)') do
  sum = sum + (x * y)
end

print('total sum:', tostring(sum))
