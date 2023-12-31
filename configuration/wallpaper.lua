local awallpaper = require("awful.wallpaper")
local wwidget = require("wibox.widget")
local wcontainer = require("wibox.container")
local beautiful = require("beautiful")
-- local env
local screen = screen

screen.connect_signal("request::wallpaper", function(s)
    awallpaper {
        screen = s,
        widget = {
            image = beautiful.wallpaper,
            resize = true,
            upscale = true,
            downscale = true,
            horizontal_fit_policy = "fit",
            vertical_fit_policy   = "fit",
            widget = wwidget.imagebox,
        }
    }
end)