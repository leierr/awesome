local naughty = require("naughty")
local rnotification = require("ruled.notification")
local ascreen = require("awful.screen")

rnotification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    rnotification.append_rule {
        rule = { },
        properties = {
            screen = ascreen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box{ notification = n }
end)