return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    local keys = {
      -- Append the current file to the harpoon list
      {
        "<leader>a",
        function()
          harpoon:list():add()
        end,
        desc = "Harpoon append file",
      },
      -- Toggle the beautiful, text-editable quick menu UI
      {
        "<C-e>",
        function()
          local pickers = require("telescope.pickers")
          local finders = require("telescope.finders")
          local conf = require("telescope.config").values
          local action_state = require("telescope.actions.state")

          -- Retrieve all active harpoon marks formatted for telescope results
          local function get_marks()
            local marks = {}
            for _, item in ipairs(harpoon:list().items) do
              if item and item.value ~= "" then
                table.insert(marks, item.value)
              end
            end
            return marks
          end

          -- Launch custom telescope picker with syntax-highlighted preview
          pickers
            .new({}, {
              prompt_title = "Harpoon Marks",
              initial_mode = "normal", -- Always start in normal mode for immediate navigation
              finder = finders.new_table({ results = get_marks() }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),

              attach_mappings = function(prompt_bufnr, map)
                -- Bind the 'd' key in normal mode to handle deletion smoothly
                map("n", "d", function()
                  local state = action_state.get_current_picker(prompt_bufnr)
                  local selection = state:get_selection()

                  if not selection then
                    return
                  end

                  -- Remove selected entry from the underlying harpoon JSON cache
                  local list = harpoon:list()
                  for i, item in ipairs(list.items) do
                    if item.value == selection.value then
                      list:remove_at(i)
                      break
                    end
                  end

                  -- Dynamically refresh telescope state without closing the UI window
                  state:refresh(finders.new_table({ results = get_marks() }), { reset_prompt = true })
                end)

                return true
              end,
            })
            :find()
        end,
        desc = "Harpoon toggle menu",
      },
    }

    -- Set up fast navigation keys for the first 6 files (e.g., <leader>1 to <leader>6)
    for i = 1, 6 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          harpoon:list():select(i)
        end,
        desc = "Harpoon select file " .. i,
      })
    end

    return keys
  end,
  opts = {
    settings = {
      -- Automatically save the list state when you change it or close the menu
      save_on_toggle = true,
    },
  },
}
