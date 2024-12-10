-- Day 3 part 2
--
local fs = require 'custom.fs'

local input = fs.readFileSync 'day3.txt'

local function pop(stack)
  return table.remove(stack, #stack)
end

local function push(stack, val)
  return table.insert(stack, val)
end

local mulStack = {}

for i = 1, 20, 1 do
  local char = string.sub(input, i, i)
  if char == 'm' or char == 'u' or char == 'l' or char == '(' then
    push(mulStack, char)
  end
end
