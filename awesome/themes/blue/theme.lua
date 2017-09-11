---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "xos4 Terminus 10"

theme.bg_normal     = "#2b2b2b"
theme.bg_focus      = theme.bg_normal
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#d3d0c8"
theme.fg_focus      = "#6d9cbe"
theme.fg_urgent     = "#ecedee"
theme.fg_minimize   = "#ecedee"

theme.border_width  = 2 
theme.border_normal = "#444444"
theme.border_focus  = "#6d9cbe"
theme.border_marked = "#91231c"

theme.tasklist_disable_icon = true

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme_dir .. "taglist/squarefw.png"
theme.taglist_squares_unsel = theme_dir .. "taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_dir .. "icons/arrow.png"
-- theme.menu_height = 15
-- theme.menu_width  = 200

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

theme.icon_clock = theme_dir .. "icons/clock.png"
theme.icon_cpu = theme_dir .. "icons/cpu.png"
theme.icon_volume = theme_dir .. "icons/spkr_01.png"
theme.icon_volume_mute = theme_dir .. "icons/spkr_02.png"
theme.icon_battery_full = theme_dir .. "icons/bat_full.png"
theme.icon_battery_low = theme_dir .. "icons/bat_low.png"
theme.icon_ac = theme_dir .. "icons/ac.png"
theme.icon_net_high = theme_dir .. "icons/net_high.png"
theme.icon_net_medium = theme_dir .. "icons/net_medium.png"
theme.icon_net_low = theme_dir .. "icons/net_low.png"
theme.icon_net_wired = theme_dir .. "icons/net_wired.png"
theme.icon_empty = theme_dir .. "icons/empty.png"
theme.icon_usb = theme_dir .. "icons/usb.png"
theme.icon_full = theme_dir .. "icons/full.png"
theme.icon_diskette = theme_dir .. "icons/diskette.png"
theme.icon_play = theme_dir .. "icons/play.png"
theme.icon_pause = theme_dir .. "icons/pause.png"
theme.icon_next = theme_dir .. "icons/next.png"
theme.icon_prev = theme_dir .. "icons/prev.png"
theme.icon_keyboard = theme_dir .. "icons/keyboard.png"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.wallpaper = theme_dir .. "wallpaper.png"

-- You can use your own layout icons like this:
theme.layout_fairh = theme_dir .. "layouts/fairh.png"
theme.layout_fairv = theme_dir .. "layouts/fairv.png"
theme.layout_floating  = theme_dir .."layouts/floating.png"
theme.layout_magnifier = theme_dir .. "layouts/magnifier.png"
theme.layout_max = theme_dir .. "layouts/max.png"
theme.layout_fullscreen = theme_dir .. "layouts/fullscreen.png"
theme.layout_tilebottom = theme_dir .. "layouts/tilebottom.png"
theme.layout_tileleft   = theme_dir .. "layouts/tileleft.png"
theme.layout_tile = theme_dir .. "layouts/tile.png"
theme.layout_tiletop = theme_dir .. "layouts/tiletop.png"
theme.layout_spiral  = theme_dir .. "layouts/spiral.png"
theme.layout_dwindle = theme_dir .. "layouts/dwindle.png"

theme.awesome_icon = theme_dir .. "icons/arch_10x10.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
