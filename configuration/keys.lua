local akey = require("awful.key")
local akeyboard = require("awful.keyboard")
local abutton = require("awful.button")
local amouse = require("awful.mouse")
local atag = require("awful.tag")
local aspawn = require("awful.spawn")
local aclient = require("awful.client")
local ascreen = require("awful.screen")
local aplacement = require("awful.placement")
local alayout = require("awful.layout")
-- local env
local client = client
local screen = screen
local tostring = tostring
local modkey = modkey
local terminal = terminal
local application_launcher_cmd = application_launcher_cmd
local screenshot_cmd = screenshot_cmd
--troubleshooting
local naughty = require("naughty")

-- awesome bindings
akeyboard.append_global_keybindings({
    akey({ modkey, "Control" }, "q", awesome.quit, { description = "quit awesome" }),
    akey({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome" }),
    akey({ modkey }, "Return", function() aspawn(terminal) end, { description = "open a terminal" }),
    akey({ modkey }, "q", function() aspawn(screenshot_cmd) end, { description = "screenshoot" }),
    akey({ modkey }, "d", function() aspawn(application_launcher_cmd) end, { description = "application launcher" }),
    akey({modkey}, "v", function()

    end, {})
})

-- moving around keybindings
akeyboard.append_global_keybindings({
    akey({ modkey }, "h", function() aclient.focus.bydirection("left") end, { description = "focus client by direction left" }),
    akey({ modkey }, "j", function() aclient.focus.bydirection("down") end, { description = "focus client by direction down" }),
    akey({ modkey }, "k", function() aclient.focus.bydirection("up") end, { description = "focus client by direction up" }),
    akey({ modkey }, "l", function() aclient.focus.bydirection("right") end, { description = "focus client by direction right" }),
    --
    akey({ modkey }, "o", function() ascreen.focus_relative(1) end, { description = "focus next screen" }),
    --
    akey({ modkey, "Control" }, "Left", function() atag.viewprev(ascreen.focused()) end, { description = "focus previous tag" }),
    akey({ modkey, "Control" }, "Down", function() atag.viewprev(ascreen.focused()) end, { description = "focus previous tag" }),
    akey({ modkey, "Control" }, "Up", function() atag.viewnext(ascreen.focused()) end, { description = "focus next tag" }),
    akey({ modkey, "Control" }, "Right", function() atag.viewnext(ascreen.focused()) end, { description = "focus next tag" }),
    --
    akey({ modkey, "Shift" }, "h", function() aclient.swap.bydirection("left", client.focus) end, { description = "swap client by direction left" }),
    akey({ modkey, "Shift" }, "j", function() aclient.swap.bydirection("down", client.focus) end, { description = "swap client by direction down" }),
    akey({ modkey, "Shift" }, "k", function() aclient.swap.bydirection("up", client.focus) end, { description = "swap client by direction up" }),
    akey({ modkey, "Shift" }, "l", function() aclient.swap.bydirection("right", client.focus) end, { description = "swap client by direction right" }),
    --
    akey({ modkey }, "c", function() aclient.focus.byidx(1) end, { description = "cycle client focus" }),
})

-- window snapping
akeyboard.append_global_keybindings({
    akey({ modkey }, "Left", function()
        if client.focus.screen.selected_tag.layout == alayout.suit.floating then
            local c = client.focus
            local client_list = c.screen.clients
            local tags = c.screen.selected_tags
            local snap_left = aplacement.scale+aplacement.left+aplacement.maximize_vertically

            if #client_list == 2 then
                local snap_right = aplacement.scale+aplacement.right+aplacement.maximize_vertically
                snap_left(client_list[1], { honor_workarea = true, honor_padding = true, to_percent = 0.5 })
                snap_right(client_list[2], { honor_workarea = true, honor_padding = true, to_percent = 0.5 })
            else
                snap_left(c, { honor_workarea = true, honor_padding = true, to_percent = 0.5 })
            end
        end
    end, { description = "snap left" }),

    akey({ modkey }, "Right", function()
        if client.focus.screen.selected_tag.layout == alayout.suit.floating then
            local c = client.focus
            local client_list = c.screen.clients
            local tags = c.screen.selected_tags
            local snap_right = aplacement.scale+aplacement.right+aplacement.maximize_vertically

            if #client_list == 2 then
                local snap_left = aplacement.scale+aplacement.left+aplacement.maximize_vertically
                snap_right(client_list[1], { honor_workarea = true, honor_padding = true, to_percent = 0.5 })
                snap_left(client_list[2], { honor_workarea = true, honor_padding = true, to_percent = 0.5 })
            else
                snap_right(c, { honor_workarea = true, honor_padding = true, to_percent = 0.5 })
            end
        end
    end, { description = "snap right" }),

    akey({ modkey }, "Up", function()
        local c = client.focus

        if c.screen.selected_tag.layout == alayout.suit.floating then
            local client_list = c.screen.clients

            if #client_list == 2 then
                aplacement.maximize(client_list[1], { honor_workarea = true, honor_padding = true })
                aplacement.maximize(client_list[2], { honor_workarea = true, honor_padding = true })
            else
                aplacement.maximize(c, { honor_workarea = true, honor_padding = true })
            end
        end
    end, { description = "snap full" }),
})

-- tag stuff
akeyboard.append_global_keybindings({
    akey {
        modifiers = { modkey },
        keygroup = "numrow",
        on_press = function(index)
            local screen = ascreen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    akey {
        modifiers = { modkey, "Control" },
        keygroup = "numrow",
        on_press = function(index)
            local screen = ascreen.focused()
            local tag = screen.tags[index]
            if tag then
                atag.viewtoggle(tag)
            end
        end,
    },
    akey {
        modifiers = { modkey, "Shift" },
        keygroup = "numrow",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
})

-- mouse bindings
client.connect_signal("request::default_mousebindings", function()
    amouse.append_client_mousebindings({
        abutton({ }, 1, function (c) c:activate { context = "mouse_click" } end),
        abutton({ modkey }, 1, function (c) c:activate { context = "mouse_click", action = "mouse_move"  } end),
        abutton({ modkey }, 3, function (c) c:activate { context = "mouse_click", action = "mouse_resize"} end),
    })
end)

-- client keys
client.connect_signal("request::default_keybindings", function()
    akeyboard.append_client_keybindings({
        akey({ modkey }, "s", aclient.floating.toggle, { description = "toggle floating" }),
        akey({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen c:raise() end, { description = "toggle fullscreen" }),
        akey({ modkey }, "w", function (c) c:kill() end, { description = "close" }),
        akey({ modkey, "Shift" }, "o", function(c) c:move_to_screen() end, { description = "move client to next screen" }),
    })
end)
