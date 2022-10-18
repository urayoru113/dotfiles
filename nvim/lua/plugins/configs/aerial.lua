local present, aerial = pcall(require, "aerial")

if present == nil then
  return
end

local options = {}

aerial.setup(options)
