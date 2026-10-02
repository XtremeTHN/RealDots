local terminal = "kitty"
local file_manager = "nautilus"
local menu = "fuzzel"

local exec_cmd = hl.dsp.exec_cmd
local bind = hl.bind

bind("SUPER + T", exec_cmd(terminal))
bind("SUPER + E", exec_cmd(file_manager))
bind("SUPER + R", exec_cmd(menu))
bind("Print", exec_cmd("hyprshot -m region"))
bind("SHIFT + Print", exec_cmd("hyprshot -m window"))

-- Window behavior
local window = hl.dsp.window
bind("SUPER + V", window.float({ action = "toggle" }))
bind("SUPER + Q", window.close())
bind("SUPER + P", window.pin())

bind("SUPER + mouse:272", window.drag())
bind("SUPER + mouse:273", window.resize())

for i=1, 9 do
  bind("SUPER + SHIFT + " ..i, window.move({ workspace = i }))
  bind("SUPER + "..i, hl.dsp.focus({ workspace = i }))
end

-- Special Workspace
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))

-- Custom functions
hl.bind("SUPER + CTRL + 1", function ()
    local game_mode = (hl.get_config("animations.enabled") == false)

    if game_mode then
        hl.dispatch(hl.dsp.reload_config())
        return
    end

    hl.config({
        general = {
            gaps_in = 0, gaps_out = 0,
            border_size = 0,
        },

        animations = {
            enabled = false
        },

        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        }
    })
end)
