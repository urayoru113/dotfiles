local present, colorizer = pcall(require, "colorizer")

if not present then
  return
end

local options = {}

colorizer.setup(options)
