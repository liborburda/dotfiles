-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")
-- Widget and layout library
local wibox = require("wibox")
local vicious = require("vicious")
--local xrandr = require("xrandr")

local sharedtags = require("sharedtags")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
config_dir = ("/home/libor/.config/awesome/")
theme_dir = (config_dir .. "themes/blue/")
beautiful.init(theme_dir .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
mysystemmenu = awful.menu( {
    items = {
       { "Turn off display", function () awful.util.spawn_with_shell("sleep 1; xset dpms force off") end},
       { "Lock screen", function () awful.util.spawn("i3lock -n -u -i /home/libor/.i3/bg.png -t") end},
       { "-------------",}, --separator
       { "Sleep", function () awful.util.spawn("sudo pm-suspend") end},
       { "Hibernate", function () awful.util.spawn("sudo pm-hibernate") end},
       { "-------------",},
       { "Logout", function() awesome.quit() end}
    },
    theme = {width = 150}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mysystemmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
--
-- Create a time & date widget
clocktext = wibox.widget.textbox()
vicious.register(clocktext, vicious.widgets.date, '%H:%M  %d.%m.%y', 1)
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.icon_clock)

-- Calendar
local cal = require('calendar')
cal:attach(clocktext, {font="xos4 Terminus", font_size=14})

-- Built-in calendar from awful.widget is slow as fuck
--month_calendar = awful.widget.calendar_popup.year()
--month_calendar:attach(clocktext, "tr" )

-- Separator widget
spr = wibox.widget.textbox()
spr:set_text(' | ')

sprspace = wibox.widget.textbox()
sprspace:set_text(' ')

-- Keyboard map indicator and switcher
keyboardicon = wibox.widget.imagebox()
keyboardicon:set_image(beautiful.icon_keyboard)
keyboardlayout = awful.widget.keyboardlayout()

-- Volume widget
volumeicon = wibox.widget.imagebox()
volumeicon:set_image(beautiful.icon_volume)
volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume, function(widget, args)
    local paraone = tonumber(args[1])

    if args[2] == "♩" or paraone == 0 then
        return "Mute"
    else
        return args[1] .. "%"
    end
end, 60, "Master")

volumewidget:buttons(
    awful.util.table.join(
        awful.button({ }, 4, function ()
            awful.util.spawn("amixer set Master 3%+")
            vicious.force({ volumewidget, })
        end),
        awful.button({ }, 5, function ()
            awful.util.spawn("amixer set Master 3%-")
            vicious.force({ volumewidget, })
        end)
    )
)

-- Battery widget
-- shows battery status
-- shows warning when battery status is below 15
local last_battery_check = os.time()
batteryicon = wibox.widget.imagebox()
batterywidget = wibox.widget.textbox()
vicious.register(batterywidget, vicious.widgets.bat, function(widget, args)
    if (args[1] == "+" or args[1] == "⌁" or args[1] == "↯") then
        batteryicon:set_image(beautiful.icon_ac)
    else
        batteryicon:set_image(beautiful.icon_battery_full)
        if (args[2] >= 0 and args[2] < 15) then
            if os.difftime(os.time(), last_battery_check) > 300 then
                -- if 5 minutes have elapsed since the last warning
                last_battery_check = time()
                naughty.notify{
                    text = "Huston, we have a problem",
                    title = "Battery is dying",
                    timeout = 5,
                    position = "top_right",
                    bg = "#F06060",
                    fg = "#EEE9EF",
                    width = 300,
                }

            end --end if
        end --end if
    end --end if

    return args[2] .. "%" -- returns charging and percent status
end --end function
, 10, "BAT1")

-- Wired network widget
wiredtext = wibox.widget.textbox()
wiredicon = wibox.widget.imagebox()
wiredicon:set_image(beautiful.icon_net_wired)
vicious.register(wiredicon, vicious.widgets.net, function(widget, args)
    if args["{eth0 carrier}"] == 1 then
        wiredtext:set_text("up")
    else
        wiredtext:set_text("down")
    end
end, 1)

-- wlan0 wireless network widget
wlan0text = wibox.widget.textbox()
wlan0icon = wibox.widget.imagebox()
wlan0icon:set_image(beautiful.icon_net_high)
vicious.register(wlan0icon, vicious.widgets.wifi, function(widget, args)
    if args["{ssid}"] ~= "N/A" then
        wlan0text:set_text(args["{ssid}"])
    else
        wlan0text:set_text("down")
    end
end, 1, "wlan0")
--
-- wlan1 wireless network widget
-- wlan1text = wibox.widget.textbox()
-- wlan1icon = wibox.widget.imagebox()
-- wlan1icon:set_image(beautiful.icon_net_high)
-- vicious.register(wlan1icon, vicious.widgets.wifi, function(widget, args)
--     if args["{ssid}"] ~= "N/A" then
--         wlan1text:set_text(args["{ssid}"])
--     else
--         wlan1text:set_text("down")
--     end
-- end, 1, "wlan1")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Sharedtags, similar behavior like in Spectrwm
-- requires external module 'sharedtags'
local tags = sharedtags({
    { name = " 1 ", layout = awful.layout.layouts[6] },
    { name = " 2 ", layout = awful.layout.layouts[2] },
    { name = " 3 ", layout = awful.layout.layouts[2] },
    { name = " 4 ", layout = awful.layout.layouts[2] },
    { name = " 5 ", layout = awful.layout.layouts[2] },
    { name = " 6 ", layout = awful.layout.layouts[2] },
    { name = " 7 ", layout = awful.layout.layouts[2] },
    { name = " 8 ", layout = awful.layout.layouts[2] },
    { name = " 9 ", layout = awful.layout.layouts[2] },
})

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, { awful.layout.layouts[6], awful.layout.layouts[2], awful.layout.layouts[2], awful.layout.layouts[2], awful.layout.layouts[2], awful.layout.layouts[2], awful.layout.layouts[2], awful.layout.layouts[2], awful.layout.layouts[2] })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 20 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
	    spr,
            s.mytaglist,
	    spr,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
	    spr,
	    keyboardicon,
        sprspace,
        keyboardlayout,
	    spr,
	    volumeicon,
        sprspace,
	    volumewidget,
	    spr,
	    batteryicon,
        sprspace,
	    batterywidget,
	    spr,
	    wiredicon,
        sprspace,
	    wiredtext,
	    spr,
	    wlan0icon,
        sprspace,
	    wlan0text,
	    spr,
	    -- wlan1icon,
        -- sprspace,
	    -- wlan1text,
	    -- spr,
        clockicon,
        sprspace,
        clocktext,
	    spr,
        s.mylayoutbox,
	    spr,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mysystemmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mysystemmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, ",", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,           }, ".", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    -- awful.key({ modkey }, "p", function() menubar.show() end,
    --           {description = "show the menubar", group = "launcher"})

    -- Volume Control
    awful.key({ }, "XF86AudioRaiseVolume", function ()
        awful.util.spawn("amixer set Master 3%+", false )
        vicious.force({ volumewidget, })
    end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
        awful.util.spawn("amixer set Master 3%-", false )
        vicious.force({ volumewidget, })
    end),
    awful.key({ }, "XF86AudioMute", function ()
        awful.util.spawn("amixer set Master toggle", false )
        vicious.force({ volumewidget, })
    end),

    -- MPD control
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc -h /var/lib/mpd/socket toggle") end),
    awful.key({ }, "XF86AudioStop", function () awful.util.spawn("mpc -h /var/lib/mpd/socket stop") end),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc -h /var/lib/mpd/socket next") end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc -h /var/lib/mpd/socket prev") end),

    awful.key({ modkey, }, "F8",  function () awful.util.spawn("mpc -h /var/lib/mpd/socket prev") end),
    awful.key({ modkey, }, "F9",  function () awful.util.spawn("mpc -h /var/lib/mpd/socket toggle") end),
    awful.key({ modkey, }, "F10", function () awful.util.spawn("mpc -h /var/lib/mpd/socket next") end),

    -- Calculator
    awful.key({ }, "XF86Calculator", function () awful.util.spawn("qalculate-gtk") end),

    -- Keyboard switch
    awful.key({ modkey, }, "F5", function () awful.util.spawn("setxkbmap us");
                                             awful.util.spawn("xset r rate 300 25");
                                    end,
		      {description="Set US keyboard layout", group="awesome"}),
    awful.key({ modkey, }, "F6", function () awful.util.spawn("setxkbmap cz");
                                             awful.util.spawn("xset r rate 300 25");
                                    end,
		      {description="Set CZ keyboard layout", group="awesome"}),
    -- awful.key({ modkey, }, "F6", function () awful.util.spawn("setxkbmap -layout cz -variant qwerty");
    --                                          awful.util.spawn("xset r rate 300 25");
    --                                 end,
	-- 	      {description="Set CZ keyboard layout", group="awesome"}),
    awful.key({ modkey, }, "F12", function () awful.util.spawn("i3lock -n -u -i /home/libor/.i3/bg.png -t") end),


    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 6") end),
    awful.key({ }, "XF86MonBrightnessUp",   function () awful.util.spawn("xbacklight -inc 6") end),

    -- XrandR
    awful.key({ }, "XF86Display", function () xrandr.xrandr() end),

	-- Sleep
	awful.key({ }, "XF86Sleep", function () awful.util.spawn("sudo pm-suspend") end),

    -- Touchpad
    -- awful.key({ }, "XF86TouchpadOn", function () awful.util.spawn("synclient touchpadoff=0") end),
    -- awful.key({ }, "XF86TouchpadOff", function () awful.util.spawn("synclient touchpadoff=1") end),

	-- Print Screen
	awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        -- local tag = screen.tags[i]
                        local tag = tags[i]
                        if tag then
                           -- tag:view_only()
                           sharedtags.viewonly(tag, screen)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      -- local tag = screen.tags[i]
                      local tag = tags[i]
                      if tag then
                         -- awful.tag.viewtoggle(tag)
                         sharedtags.viewtoggle(tag, screen)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          -- local tag = client.focus.screen.tags[i]
                          local tag = tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control"}, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     size_hints_honor = false,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
    { rule = { class = "mpv" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { maximized_vertical = true, maximized_horizontal = true } },
    { rule = { class = "Google-chrome" },
      properties = { border_width = 0 } },
    { rule = { class = "Vivaldi-stable" },
      properties = { border_width = 0 } },
    { rule = { class = "Qalculate-gtk" },
      properties = { floating = true } },
    { rule = { class = "qBittorrent" },
      properties = { tag = tags[" 9 "] } },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- temporary bugfix (https://github.com/awesomeWM/awesome/issues/1692)
--client.connect_signal("request::geometry", function(c)
--    if client.focus then
--        client.focus.ignore_border_width = false
--        client.focus.border_width = beautiful.border_width
--    end
--end)

-- Remove border when client is maximized
--client.connect_signal("property::maximized", function(c)
--    c.border_width = c.maximized and 0 or beautiful.border_width
--end)
-- }}}
