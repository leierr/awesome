pcall(require, "luarocks.loader")

-- must have
local awful = require("awful")
local naughty = require("naughty")

-- error handling
require("main.error-handling")

-- Set automatic dpi scaling
awful.screen.set_auto_dpi_enabled(true)

-- high quality icons
awesome.set_preferred_icon_size = 128

-- defaults
terminal = "alacritty"
modkey = "Mod4"
application_launcher_cmd = "rofi -show drun -config ~/.config/rofi/drun.rasi"
screenshot_cmd = "flameshot gui"
--
awful.util.shell = "/nix/var/nix/profiles/system/sw/bin/bash"
--
awful.mouse.snap.edge_enabled = false
awful.mouse.snap.client_enabled = false
awful.mouse.drag_to_tag.enabled = false

-- init theme
require 'beautiful'.init('~/.config/awesome/theme/init.lua')

-- configuration
require("configuration")

-- signals
require("signals")

-- ui elements
require("ui")

-- modules
require("modules")

--- garbage collection for lower memory consumption
local gtimer = require("gears.timer")
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gtimer({
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		collectgarbage("collect")
	end,
})

-- autostart applications
awful.spawn.easy_async_with_shell('pgrep nm-applet || { nm-applet & }')
awful.spawn.easy_async_with_shell('pgrep nm-applet || { flameshot & }')
awful.spawn.easy_async_with_shell('pgrep pcloud || { pcloud & }')