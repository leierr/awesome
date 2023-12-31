local alayout = require("awful.layout")
local atag = require("awful.tag")
local aclient = require("awful.client")
local beautiful = require("beautiful")
-- local env
local tag = tag
local client = client
local dpi = beautiful.xresources.apply_dpi
-- troubleshooting
local naughty = require("naughty")
--naughty.notification { title = "Achtung!", message = , timeout = 8 }

tag.connect_signal("request::default_layouts", function()
    alayout.append_default_layouts({
        alayout.suit.tile,
        alayout.suit.max,
        alayout.suit.floating,
    })
end)

tag.connect_signal("tagged", function(t, c)
    if awesome.startup then return end

    if #t:clients() > 4 and t.layout == alayout.suit.tile then
        c.floating = true
    end
end)

tag.connect_signal("untagged", function(t, c)
    if awesome.startup then return end

    -- reset tiling
    if #t:clients() == 1 and t.layout == alayout.suit.tile then
        t.windowfact = nil
        t.master_width_factor = 0.5
        t:emit_signal("property::windowfact")
    end
end)

screen.connect_signal("request::desktop_decoration", function(s)
    --atag({ "1", "2", "3", "4", "5"}, s, alayout.layouts[1])

    -- add tags with my chosen properties
    for i = 1,5 do 
        atag.add(tostring(i), {
            layout = alayout.layouts[1],
            master_fill_policy = "expand",
            gap_single_client = true,
            gap = dpi(3),
            screen = s,
            selected = i == 1 and true or false
        })
    end
end)
