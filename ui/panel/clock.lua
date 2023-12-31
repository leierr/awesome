local wcontainer = require("wibox.container")
local wwidget = require("wibox.widget")
local wlayout = require("wibox.layout")
local beautiful = require("beautiful")
local gshape = require("gears.shape")
local abutton = require("awful.button")
-- local env
local dpi = beautiful.xresources.apply_dpi
local mouse = mouse

return function()

    local w = wwidget {
        {
            {
                nil,
                {
                    nil,
                    {
                        widget = wwidget.textclock('<span weight="bold" font="'..beautiful.font..' '..dpi(12)..'" foreground="'..beautiful.fg..'">%H:%M</span>'),
                    },
                    expand = "none",
                    layout = wlayout.align.horizontal
                },
                expand = "none",
                layout = wlayout.align.vertical
            },
            left = dpi(10),
            right = dpi(10),
            widget = wcontainer.margin
        },
        id = "role_background",
        bg = beautiful.bg2,
        border_color = beautiful.bg2_border,
        border_width = dpi(1),
        shape = beautiful.panel_widget_shape,
        widget = wcontainer.background
    }

    w:add_button(
        abutton({ }, 1, function()
            w:get_children_by_id("role_background")[1].border_color = beautiful.bg
        end,
        function()
            w:get_children_by_id("role_background")[1].border_color = beautiful.bg2_border
        end)
    )
    
    w:connect_signal("mouse::enter", function(self)
        local mw = mouse.current_wibox
        self.old_cursor, self.old_wibox = mw.cursor, mw
        mw.cursor = "hand2"
    end)
    
    w:connect_signal("mouse::leave", function(self)
        if self.old_wibox then
            self.old_wibox.cursor = self.old_cursor
            self.old_wibox = nil
        end

        w:get_children_by_id("role_background")[1].border_color = beautiful.bg2_border
    end)
    
    return w

end
