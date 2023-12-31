local alayout = require("awful.layout")
local awidget = require("awful.widget")
local gsurface = require("gears.surface")
local gshape = require("gears.shape")
local beautiful = require("beautiful")
local menubar_utils = require("menubar.utils")
-- local env
local client = client
local dpi = beautiful.xresources.apply_dpi
--troubleshooting
--local naughty = require("naughty")
--naughty.notification { title = "heo!", message = tostring(mouse.current_client.instance), timeout = 10 }

client.connect_signal("tagged", function(c, t)
    if awesome.startup then return end
    if t.layout == alayout.suit.tile and #c:tags() == 1 then
        c.maximized = false
        c.maximized_horizontal = false
        c.maximized_vertical = false
    end
end)

client.connect_signal("property::fullscreen", function(c)
    if awesome.startup then return end
    if c.fullscreen == true and c:tags()[1].layout ~= alayout.suit.max then
        c.shape = gshape.rect
    else
        c.shape = function(cr, width, height) gshape.rounded_rect(cr, width, height, dpi(10)) end
    end
end)

client.connect_signal("request::manage", function(c)
    if c.icon == nil then
        local new_ci = gsurface(menubar_utils.lookup_icon(string.lower(c.class)))
        local generic_ci = gsurface(menubar_utils.lookup_icon("gnome-windows"))
        c.icon = new_ci._native ~= nil and new_ci._native or generic_ci._native
    end
end)