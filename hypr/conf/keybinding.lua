-- ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║
-- ██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝
-------------------------------------------------------------------------------

local mainMod = "SUPER"

-- Session
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("~/.config/scripts/power_menu.sh"))

-- Apps
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("ghostty -e yazi"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("ghostty -e micro"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("ghostty --title=wiremix -e wiremix"))

-- Window management
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))

-- Utilities
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o $HOME/Pictures/Screenshots"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/scripts/clipboard_launcher.sh"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("~/.config/scripts/wallpaper_select.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/scripts/wifi_menu.sh"))
hl.bind("ALT + Space", hl.dsp.exec_cmd("~/.config/scripts/app_launcher.sh"))

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move / resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
