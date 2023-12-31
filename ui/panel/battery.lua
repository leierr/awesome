local wcontainer = require("wibox.container")
local awidget = require("awful.widget")
local abutton = require("awful.button")
local atag = require("awful.tag")
local wwidget = require("wibox.widget")
local wlayout = require("wibox.layout")
local beautiful = require("beautiful")
local gshape = require("gears.shape")
local rubato = require('modules.rubato')
-- local env
local dpi = beautiful.xresources.apply_dpi

local battery = wwidget {
    id = 'custom_role_battery',
    widget = wwidget.progressbar,
    max_value = 100,
    value = 0,
    forced_width = dpi(125),
    shape = function(cr, width, height) gshape.rounded_rect(cr, width, height, dpi(5)) end,
}

local w = wwidget {
    {
        battery,
        {
            {
                id = "custom_role_icon",
                resize = true,
                image = beautiful.lightning_bolt,
                stylesheet = "svg { fill: ".. beautiful.fg .."; }",
                valign = "center",
                halign = "center",
                widget = wwidget.imagebox,
            },
            margins = dpi(3),
            widget = wcontainer.margin
        },
        layout = wlayout.stack
    },
    margins = {top = dpi(6), bottom = dpi(6), left = dpi(6), right = dpi(6)},
    widget = wcontainer.margin,
}

w.visible = false

awesome.connect_signal("signal::battery", function(value)
    if w.visible == false then
        w.visible = true
    end
    local b = battery
    b.value = value
    if value < 20 then
        b.color = beautiful.error
        b.background_color = beautiful.error .. '55'
    elseif value < 50 then
        b.color = beautiful.warn
        b.background_color = beautiful.warn .. '55'
    elseif value < 70 then
        b.color = beautiful.priority
        b.background_color = beautiful.priority .. '55'
    else
        b.color = beautiful.ok
        b.background_color = beautiful.ok .. '55'
    end
end)

return w