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
local client = client

return function(s)
    local my_tasklist = function(t)
        local filter_function = function(t)
            return function(c, scr)
                local ctags = c:tags()
                for _, v in ipairs(ctags) do
                    if v == t then
                        return true
                    end
                end
                return false
            end
        end

        local w = awidget.tasklist {
            screen = s,
            filter = filter_function(t),
            style = {
                fg_normal = beautiful.tasklist_fg_normal,
                bg_normal = beautiful.tasklist_bg_normal,
                fg_focus = beautiful.tasklist_fg_focus,
                bg_focus = beautiful.tasklist_bg_focus,
                fg_urgent = beautiful.tasklist_fg_urgent,
                bg_urgent = beautiful.tasklist_bg_urgent,
                fg_minimize = beautiful.tasklist_fg_minimize,
                bg_minimize = beautiful.tasklist_bg_minimize,
                bg_image_normal = beautiful.tasklist_bg_image_normal,
                bg_image_focus = beautiful.tasklist_bg_image_focus,
                bg_image_urgent = beautiful.tasklist_bg_image_urgent,
                bg_image_minimize = beautiful.tasklist_bg_image_minimize,
                disable_icon = beautiful.tasklist_disable_icon,
                icon_size = beautiful.tasklist_icon_size,
                sticky = beautiful.tasklist_sticky,
                ontop = beautiful.tasklist_ontop,
                above = beautiful.tasklist_above,
                below = beautiful.tasklist_below,
                floating = beautiful.tasklist_floating,
                maximized = beautiful.tasklist_maximized,
                maximized_horizontal = beautiful.tasklist_maximized_horizontal,
                maximized_vertical = beautiful.tasklist_maximized_vertical,
                disable_task_name = beautiful.tasklist_disable_task_name,
                font = beautiful.tasklist_font,
                align = beautiful.tasklist_align,
                font_focus = beautiful.tasklist_font_focus,
                font_minimized = beautiful.tasklist_font_minimized,
                font_urgent = beautiful.tasklist_font_urgent,
                spacing = beautiful.tasklist_spacing,
                shape = beautiful.tasklist_shape,
                shape_border_width = beautiful.tasklist_shape_border_width,
                shape_border_width_focus = beautiful.tasklist_shape_border_width_focus,
                shape_border_width_minimized = beautiful.tasklist_shape_border_width_minimized,
                shape_border_width_urgent = beautiful.tasklist_shape_border_width_urgent,
                shape_border_color = beautiful.tasklist_shape_border_color,
                shape_border_color_focus = beautiful.tasklist_shape_border_color_focus,
                shape_border_color_minimized = beautiful.tasklist_shape_border_color_minimized,
                shape_border_color_urgent = beautiful.tasklist_shape_border_color_urgent,
                shape_focus = beautiful.tasklist_shape_focus,
                shape_minimized = beautiful.tasklist_shape_minimized,
                shape_urgent = beautiful.tasklist_shape_urgent,
                minimized = beautiful.tasklist_minimized,
            },
            buttons = {
                --abutton({ }, 1, function(c)
                --    c:activate { context = "tasklist", action = "toggle_minimization" }
                --end),
            },
            layout = wlayout.fixed.horizontal(),
            widget_template = {            
                {
                    {
                        widget = awidget.clienticon,
                    },
                    top = dpi(6),
                    left = dpi(6),
                    right = dpi(6),
                    bottom = dpi(8),
                    widget = wcontainer.margin,
                },
                {
                    {
                        widget = wwidget.background,
                        --forced_width = dpi(26),
                        forced_height = dpi(3),
                        shape = gshape.rounded_bar,
                        bg = beautiful.primary,
                        id = "custom_focus_bar",
                    },
                    valign = "bottom",
                    halign = "center",
                    widget = wcontainer.place,
                },
                fill_space = false,
                layout = wlayout.stack,
                create_callback = function(self, c, index, objects)
                    self.animate = rubato.timed {
                        duration = 0.2,
                        subscribed = function(h)
                            self:get_children_by_id('custom_focus_bar')[1].forced_width = h
                        end
                    }

                    self.update = function()
                        if c.active then
                            self.animate.target = dpi(30)
                        else
                            self.animate.target = dpi(8)
                        end
                    end

                    self.update()
                end,
    
                update_callback = function(self, c, index, objects)
                    self.update()
                end,
            },
        }
    
        return w
    end

    local my_tagtasklist = awidget.taglist {
        screen = s,
        filter = awidget.taglist.filter.all,
        style = {
            fg_focus = beautiful.taglist_fg_focus,
            bg_focus = beautiful.taglist_bg_focus,
            fg_urgent = beautiful.taglist_fg_urgent,
            bg_urgent = beautiful.taglist_bg_urgent,
            bg_occupied = beautiful.taglist_bg_occupied,
            fg_occupied = beautiful.taglist_fg_occupied,
            bg_empty = beautiful.taglist_bg_empty,
            fg_empty = beautiful.taglist_fg_empty,
            bg_volatile = beautiful.taglist_bg_volatile,
            fg_volatile = beautiful.taglist_fg_volatile,
            -- A user provided image for squares. trash
            -- squares_sel = ,
            -- squares_unsel = ,
            -- squares_sel_empty = ,
            -- squares_unsel_empty = ,
            -- squares_resize = ,
            disable_icon = beautiful.taglist_disable_icon,
            font = beautiful.taglist_font,
            spacing = beautiful.taglist_spacing,
            shape = beautiful.taglist_shape,
            shape_border_width = beautiful.taglist_shape_border_width,
            shape_border_color = beautiful.taglist_shape_border_color,
            shape_empty = beautiful.taglist_shape_empty,
            shape_border_width_empty = beautiful.taglist_shape_border_width_empty,
            border_color_empty = beautiful.taglist_border_color_empty,
            shape_focus = beautiful.taglist_shape_focus,
            shape_border_width_focus = beautiful.taglist_shape_border_width_focus,
            shape_border_color_focus = beautiful.taglist_shape_border_color_focus,
            shape_urgent = beautiful.taglist_shape_urgent,
            shape_border_width_urgent = beautiful.taglist_shape_border_width_urgent,
            shape_border_color_urgent = beautiful.taglist_shape_border_color_urgent,
            shape_volatile = beautiful.taglist_shape_volatile,
            shape_border_width_volatile = beautiful.taglist_shape_border_width_volatile,
            shape_border_color_volatile = beautiful.taglist_shape_border_color_volatile,
        },
        layout = {
            buttons = {
                abutton({}, 4, function(t)
                    atag.viewprev(t.screen)
                end),
                abutton({}, 5, function(t)
                    atag.viewnext(t.screen)
                end)
            },
            layout = wlayout.fixed.horizontal,
        },
        buttons = {
            abutton({}, 1, function(t)
                t:view_only()
            end)
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = "text_role",
                            widget = wwidget.textbox,
                        },
                        margins = {right = dpi(5), left = dpi(5),},
                        widget = wcontainer.margin
                    },
                    id = "custom_taglist_container",
                    layout = wlayout.fixed.horizontal,
                },
                margins = {right = dpi(8), left = dpi(8), top = dpi(2), bottom = dpi(2),},
                widget = wcontainer.margin,
            },
            id = "background_role",
            widget = wcontainer.background,
            create_callback = function(self, tag)
                self:get_children_by_id("custom_taglist_container")[1]:add(my_tasklist(tag))
            end,
            update_callback = function(self)
            end,
        }
    }

    return my_tagtasklist
end
