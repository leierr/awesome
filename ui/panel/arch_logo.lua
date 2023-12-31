local wcontainer = require("wibox.container")
local wwidget = require("wibox.widget")
local beautiful = require("beautiful")
local gshape = require("gears.shape")
local abutton = require("awful.button")
local aspawn = require("awful.spawn")
-- local env
local dpi = beautiful.xresources.apply_dpi
local mouse = mouse

return function()

    local w = wwidget {
        {
            {
                id = "role_icon",
                resize = true,
                image = beautiful.arch_logo,
                stylesheet = "svg { fill: ".. beautiful.fg .."; }",
                widget = wwidget.imagebox,
            },
            top = dpi(6),
            bottom = dpi(6),
            left = dpi(10),
            right = dpi(10),
            widget = wcontainer.margin,
        },
        id = "role_background",
        bg = beautiful.bg2,
        shape = beautiful.panel_widget_shape,
        border_color = beautiful.bg2_border,
        border_width = dpi(1),
        widget = wcontainer.background,
    }

    w:add_button(
        abutton({ }, 1, function()
            w:get_children_by_id("role_background")[1].border_color = beautiful.bg
        end,
        function()
            w:get_children_by_id("role_background")[1].border_color = beautiful.bg2_border
        end)
    )

    w:add_button(
        abutton({ }, 2, function() aspawn.with_shell("systemctl poweroff") end)
    )
    
    w:connect_signal("mouse::enter", function(self)
        local mw = mouse.current_wibox
        self.old_cursor, self.old_wibox = mw.cursor, mw
        mw.cursor = "hand2"
    
        w:get_children_by_id("role_icon")[1].stylesheet = "svg { fill: ".. beautiful.primary .."; }"
    end)
    
    w:connect_signal("mouse::leave", function(self)
        if self.old_wibox then
            self.old_wibox.cursor = self.old_cursor
            self.old_wibox = nil
        end
    
        w:get_children_by_id("role_icon")[1].stylesheet = "svg { fill: ".. beautiful.fg .."; }"
        w:get_children_by_id("role_background")[1].border_color = beautiful.bg2_border
    end)
    
    return w

end