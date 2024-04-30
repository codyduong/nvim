local M = {}

function M.setup_default_mappings()
  -- Default mappings for normal movement keys
  local default_mappings = {
    h = "left",
    j = "down",
    k = "up",
    l = "right",
  }

  for key, command in pairs(default_mappings) do
    vim.keymap.set("n", key, command, { noremap = true })
  end
end

-- modified from:
-- https://github.com/craftzdog/dotfiles-public/blob/d1b1780b79d4b7185dc93b272137cacb0b96f62e/.config/nvim/lua/craftzdog/discipline.lua
function M.cowboy(max_count)
  max_count = max_count or 5 -- Set default max_count to 5 for demonstration
  local counts = {}
  local timers = {}
  local notifs = {}

  for _, key in ipairs { "h", "j", "k", "l" } do
    counts[key] = 0
    timers[key] = vim.loop.new_timer()

    vim.keymap.set("n", key, function()
      local count = counts[key]

      if vim.v.count > 0 then
        -- Reset count if a count is explicitly used
        counts[key] = 0
        timers[key]:stop()
        return key
      end

      if count >= max_count then
        -- defer this, otherwise buffer undo is fucked, idk
        local notify_id = notifs[key]

        vim.defer_fn(function()
          count = counts[key]
          notify_id = vim.notify("Try: " .. max_count .. key, vim.log.levels.WARN, {
            title = "Hold it Cowboy",
            icon = "🤠",
            replace = notify_id,
            hide_from_history = true,
            timeout = 1000,
            on_close = function()
              notifs[key] = nil
            end,
          })

          notifs[key] = notify_id
        end, 1)
      else
        counts[key] = count + 1
        timers[key]:stop() -- Stop previous timer if still running
        timers[key]:start(2000, 0, function()
          counts[key] = 0
        end)
        return key
      end
    end, { expr = true, silent = true })
  end
end

return M
