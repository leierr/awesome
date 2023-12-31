local wcontainer = require("wibox.container")
local wwidget = require("wibox.widget")
local wlayout = require("wibox.layout")
local beautiful = require("beautiful")
local gshape = require("gears.shape")
local awidget = require("awful.widget")
local abutton = require("awful.button")
local aspawn = require("awful.spawn")
local gshape = require("gears.shape")
-- local env
local dpi = beautiful.xresources.apply_dpi
local mouse = mouse
-- troubleshooting
--local naughty = require("naughty")
--naughty.notification { title = "Achtung!", message = , timeout = 8 }

local w = wwidget {
    {
        {
            {
                nil,
                {
                    nil,
                    {
                        {
                            {
                                horizontal = true,
                                reverse = false,
                                base_size = dpi(22),
                                screen = "primary",
                                id = "custom_widget_systray_subwidget_systray",
                                widget = wwidget.systray,
                            },
                            halign = "center",
                            valign = "center",
                            widget = wcontainer.place
                        },
                        margins = {right = dpi(10), left = dpi(10)},
                        widget = wcontainer.margin
                    },
                    expand = "none",
                    layout = wlayout.align.horizontal
                },
                expand = "none",
                layout = wlayout.align.vertical
            },
            top = dpi(6),
            bottom = dpi(6),
            left = dpi(6),
            right = dpi(6),
            widget = wcontainer.margin,
        },
        bg = beautiful.bg2,
        shape = beautiful.panel_widget_shape,
        border_color = beautiful.bg2_border,
        border_width = dpi(1),
        widget = wcontainer.background,
    },
    layout = awidget.only_on_screen,
    id = "custom_widget_systray",
    screen = "primary",
}

return w