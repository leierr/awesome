local wibox = require("wibox")
local beautiful = require("beautiful")
local gshape = require("gears.shape")
-- local env
local screen = screen
local dpi = beautiful.xresources.apply_dpi
-- modules
local clock_module = require(... .. ".clock")
local arch_logo = require(... .. ".arch_logo")
local tagtasklist = require(... .. ".tagtasklist")
local systray = require(... .. ".systray")
local battery = require(... .. ".battery")
-- troubleshooting
local naughty = require("naughty")
--naughty.notification { title = "Achtung!", message = , timeout = 8 }


screen.connect_signal("request::desktop_decoration", function(s)
    s.top_bar = wibox {
        height = dpi(50),
        width = s.geometry.width - 2, -- -border
        x = s.geometry.x,
        y = s.geometry.y,
        bg = beautiful.bg,
        shape = gshape.rect,
        border_width = 1,
        border_color = beautiful.bg_border,
        visible = true,
    }

    s.top_bar:struts {
        top = dpi(50) + 2 -- +border
    }

    s.top_bar:setup {
        {
            { -- top
                arch_logo(),
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal
            },
            { -- middle
                tagtasklist(s),
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal
            },
            { -- bottom
                battery,
                systray,
                clock_module(),
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal
            },
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        margins = dpi(5),
        widget = wibox.container.margin
    }

    s.top_bar:connect_signal("mouse::enter", function(self)
        systray.screen = self.screen
        systray:get_children_by_id("custom_widget_systray_subwidget_systray")[1].screen = self.screen
    end)
end)