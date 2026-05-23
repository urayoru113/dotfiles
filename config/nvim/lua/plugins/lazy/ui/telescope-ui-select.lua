return {
  "nvim-telescope/telescope-ui-select.nvim",
  lazy = true,
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    -- 載入 telescope
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          -- 這裡可以放 ui-select 的細部設定，預設空著即可
          require("telescope.themes").get_dropdown({}),
        },
      },
    })
    -- 關鍵：必須顯式載入這個擴充功能，它才會去接管系統的 vim.ui.select
    require("telescope").load_extension("ui-select")
  end,
}
