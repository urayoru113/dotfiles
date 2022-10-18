local present, color = pcall(require, "nvim-web-devicons")

if present == nil then
  return
end

local options = {
  color_icons = true,
  default = true
}

color.set_icon({
})

color.setup(options)
