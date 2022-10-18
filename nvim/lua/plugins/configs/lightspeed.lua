local present, lightspeed = pcall(require, "lightspeed")

if present == nil then
  return
end

local options = {}

lightspeed.setup(options)

