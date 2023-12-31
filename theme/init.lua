---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local rnotification = require("ruled.notification")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local gshape = require("gears.shape")
local config_dir = gfs.get_configuration_dir()
local themes_path = gfs.get_themes_dir()

local theme = {}

---------------------------

theme.font = "Roboto"
--
theme.primary = "#0D6CE8"
--
theme.fg = "#fefdfe"
theme.fg2 = "#CFCFCF"
theme.bg = "#0d0d0d"
theme.bg_border = "#1a1a1a"
theme.bg2 = "#242529"
theme.bg2_border = "#303135"
theme.bg3 = "#313236"
theme.bg3_border = "#363741"
--
theme.ok = "#56966e"
theme.warn = "#dcae61"
theme.error = "#c14d53"
theme.priority = "#6e95bd"
--
theme.icon_theme = "Papirus-Dark"
--
theme.wallpaper = config_dir .. "theme/assets/wallpapers/macos_style.jpg"

-- SCREEN --
---

-- ICONS --
theme.titlebar_close_focus = config_dir .. "theme/assets/svg/close_focus.svg"
theme.titlebar_maximize_focus = config_dir .. "theme/assets/svg/maximize_focus.svg"
theme.titlebar_minimize_focus = config_dir .. "theme/assets/svg/minimize_focus.svg"
theme.titlebar_close_normal = config_dir .. "theme/assets/svg/close_normal.svg"
theme.titlebar_maximize_normal = config_dir .. "theme/assets/svg/maximize_normal.svg"
theme.titlebar_minimize_normal = config_dir .. "theme/assets/svg/minimize_normal.svg"
--
theme.arch_logo = config_dir .. "theme/assets/svg/arch_logo.svg"
theme.fold_vertical = config_dir .. "theme/assets/svg/fold_vertical.svg"
theme.unfold_vertical = config_dir .. "theme/assets/svg/unfold_vertical.svg"
theme.lightning_bolt = config_dir .. "theme/assets/svg/lightning-bolt.svg"

-- Panel settings --
theme.panel_widget_shape = function(cr, w, h) gshape.rounded_rect(cr, w, h, dpi(5)) end

-- Systray --
theme.systray_icon_spacing = dpi(10) 
theme.systray_max_rows = 1 
--theme.bg_systray = "#ffff00" 

-- tasklist theme --
    theme.tasklist_disable_icon = false
    theme.tasklist_disable_task_name = false
    theme.tasklist_font = theme.font
    theme.tasklist_font_focus = theme.font
    theme.tasklist_font_minimized = theme.font
    theme.tasklist_font_urgent = theme.font
    theme.tasklist_spacing = 0

    theme.tasklist_align = nil -- "center" "left" "right"
    theme.tasklist_icon_size = nil
    theme.tasklist_sticky = nil
    theme.tasklist_ontop = nil
    theme.tasklist_above = nil
    theme.tasklist_below = nil
    theme.tasklist_floating = nil
    theme.tasklist_minimized = nil
    theme.tasklist_maximized = nil
    theme.tasklist_maximized_horizontal = nil
    theme.tasklist_maximized_vertical = nil

    -- fg -> not needed. 0 text
    theme.tasklist_fg_normal = ""
    theme.tasklist_fg_focus = ""
    theme.tasklist_fg_urgent = ""
    theme.tasklist_fg_minimize = ""
    -- bg
    theme.tasklist_bg_normal = theme.bg
    theme.tasklist_bg_focus = theme.bg2
    theme.tasklist_bg_urgent = "red"
    theme.tasklist_bg_minimize = theme.tasklist_bg_normal
    theme.tasklist_bg_image_normal = nil
    theme.tasklist_bg_image_focus = nil
    theme.tasklist_bg_image_urgent = nil
    theme.tasklist_bg_image_minimize = nil
    -- shape
    theme.tasklist_shape = gshape.rect
    theme.tasklist_shape_focus = theme.tasklist_shape
    theme.tasklist_shape_minimized = theme.tasklist_shape
    theme.tasklist_shape_urgent = theme.tasklist_shape
    theme.tasklist_shape_border_width = nil
    theme.tasklist_shape_border_width_focus = nil
    theme.tasklist_shape_border_width_minimized = nil
    theme.tasklist_shape_border_width_urgent = nil
    theme.tasklist_shape_border_color = nil
    theme.tasklist_shape_border_color_focus = nil
    theme.tasklist_shape_border_color_minimized = nil
    theme.tasklist_shape_border_color_urgent = nil

-- taglist theme --
    theme.taglist_disable_icon = true
    theme.taglist_font = theme.font.." "..dpi(13) -- default
    theme.taglist_spacing = 0 -- The spacing between tags.
    -- shape
    theme.taglist_shape = theme.panel_widget_shape
    theme.taglist_shape_empty = theme.taglist_shape
    theme.taglist_shape_focus = theme.taglist_shape
    theme.taglist_shape_urgent = theme.taglist_shape
    theme.taglist_shape_volatile = theme.taglist_shape
    -- shape | border width
    theme.taglist_shape_border_width = 0
    theme.taglist_shape_border_width_empty = theme.taglist_shape_border_width
    theme.taglist_shape_border_width_focus = dpi(1)
    theme.taglist_shape_border_width_urgent = theme.taglist_shape_border_width
    theme.taglist_shape_border_width_volatile = theme.taglist_shape_border_width
    -- shape | border color
    theme.taglist_shape_border_color = theme.bg2_border
    theme.taglist_border_color_empty = theme.taglist_shape_border_color
    theme.taglist_shape_border_color_focus = theme.taglist_shape_border_color
    theme.taglist_shape_border_color_urgent = theme.taglist_shape_border_color
    theme.taglist_shape_border_color_volatile = theme.taglist_shape_border_color
    -- fg
    theme.taglist_fg_focus = theme.fg
    theme.taglist_fg_urgent = theme.fg
    theme.taglist_fg_occupied = theme.fg
    theme.taglist_fg_empty = theme.fg
    theme.taglist_fg_volatile = "purple"
    -- bg
    theme.taglist_bg_focus = theme.bg2
    theme.taglist_bg_urgent = "red"
    theme.taglist_bg_occupied = theme.bg
    theme.taglist_bg_empty = theme.bg
    theme.taglist_bg_volatile = "purple"

-- Thrash --
theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap = dpi(0)
theme.border_width = dpi(0)
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme