local present, lualine = pcall(require, "lualine")

if not present then
  return
end

local options = {
  sections = {
    lualine_y = {"datetime"},
    lualine_z = {"progress", "location"}
  },
  options = {
    theme = "wombat"
  }
}

lualine.setup(options)
