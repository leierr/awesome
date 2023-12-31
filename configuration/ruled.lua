local ruled = require("ruled")
local aclient = require("awful.client")
local alayout = require("awful.layout")
local ascreen = require("awful.screen")
local aplacement = require("awful.placement")
local gshape = require("gears.shape")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- local env
local client = client

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = { },
        properties = {
            focus = aclient.focus.filter,
            raise = true,
            screen = ascreen.preferred,
            size_hints_honor = false,
            border_width = 2,
            border_color = beautiful.bg_border,
            placement = aplacement.centered+aplacement.no_offscreen,
            shape = function(cr, width, height) gshape.rounded_rect(cr, width, height, dpi(10)) end,
        },
        callback = function(c)
            local cls = client.get(c.screen)
            for _, v in pairs(cls) do
                c:swap(v)
            end

            if c.fullscreen == true and c:tags()[1].layout ~= alayout.suit.max then
                c.shape = gshape.rect
            else
                c.shape = function(cr, width, height) gshape.rounded_rect(cr, width, height, dpi(10)) end
            end

            if c:tags()[1].layout ~= alayout.suit.max then
                c.maximized = false
                c.maximized_horizontal = false
                c.maximized_vertical = false
            end
        end,
    }

    -- Floating clients.
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = { "pinentry" },
            name = {
                "Event Tester",
                "Discord Updater"
            },
            role = { "pop-up" },
            class = {
                "Arandr",
                "Blueman-manager",
            },
        },
        properties = { floating = true }
    }

    -- titlebars
    ruled.client.append_rule {
        id = "disable_titlebars",
        rule_any = {
            type = { "normal", "dialog" }
        },
        except_any = {
            name = {
                "Steam",
                "Event Tester",
                "Discord Updater",
            },
        },
        properties = { titlebars_enabled = false }
    }

    ruled.client.append_rule {
        id = "rounded_corners",
        rule_any = {
            name = { "Discord Updater" }
        },
        properties = {
            shape = function(cr, width, height) gshape.rounded_rect(cr, width, height, dpi(10)) end,
        }
    }
    
end)