---@class monokai-pro.util.extra
local M = {}

---@param colors Colorscheme
function M.terminal(colors)
  -- dark
  vim.g.terminal_color_0 = colors.base.black
  vim.g.terminal_color_8 = colors.base.dimmed3

  -- light
  vim.g.terminal_color_7 = colors.base.white
  vim.g.terminal_color_15 = colors.base.white

  -- colors
  vim.g.terminal_color_1 = colors.base.red
  vim.g.terminal_color_9 = colors.base.red

  vim.g.terminal_color_2 = colors.base.green
  vim.g.terminal_color_10 = colors.base.green

  vim.g.terminal_color_3 = colors.base.yellow
  vim.g.terminal_color_11 = colors.base.yellow

  vim.g.terminal_color_4 = colors.base.blue
  vim.g.terminal_color_12 = colors.base.blue

  vim.g.terminal_color_5 = colors.base.magenta
  vim.g.terminal_color_13 = colors.base.magenta

  vim.g.terminal_color_6 = colors.base.cyan
  vim.g.terminal_color_14 = colors.base.cyan
end

-- Function to check if the system is macOS
function isMacOS()
  -- Execute the `uname` command to determine the operating system
  local handle = io.popen("uname")
  local result = handle:read("*a")
  handle:close()

  -- Check if the result matches "Darwin" (the identifier for macOS)
  return result:match("^%s*(.-)%s*$") == "Darwin"
end

-- Function to get the current macOS appearance (Light or Dark Mode)
function getMacOSAppearance()
  -- AppleScript to check the macOS appearance
  local applescript = [[
  tell application "System Events"
    tell appearance preferences
      if dark mode is true then
        return "Dark"
      else
        return "Light"
      end if
    end tell
  end tell
  ]]

  -- Execute the AppleScript using os.execute or io.popen
  local handle = io.popen('osascript -e \'' .. applescript .. '\'')
  local result = handle:read("*a")
  handle:close()

  -- Remove any trailing whitespace and return the result
  return result:match("^%s*(.-)%s*$")
end

function M.is_daytime()
  if isMacOS() then
    return getMacOSAppearance() == "Light"
  else
    local current_time = os.time()
    local current_hour = tonumber(os.date("%H", current_time))
    return current_hour >= 6 and current_hour < 18
  end
end

return M
