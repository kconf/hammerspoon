-- Note: Capslock bound to cmd+alt+ctrl+shift via Karabiner-elements
local hyper = {'cmd', 'option', 'ctrl', 'shift'}
local meh = {'option', 'ctrl', 'shift'}

-- Load spoons
local Install = hs.loadSpoon('SpoonInstall')
Install.use_syncinstall = true

-- Widgets
Install:andUse('Caffeine', {
    start = true,
    hotkeys = {
        toggle = { hyper, 'c' }
    }
})

Install:andUse('MouseCircle', {
    hotkeys = {
        show = { hyper, 'm' }
    }
})

Install:andUse('BingDaily', {
    start = true,
    config = {
        -- runAt = '07:00',
        uhd_resolution = true
    }
})

-- Hotkeys to switch windows using hint
hs.hints.hintChars = {'s', 'a', 'd', 'f', 'j', 'k', 'l', 'e', 'w', 'c', 'm', 'p', 'g', 'h'} 
hs.hotkey.bind(meh, 'tab', hs.hints.windowHints)

appSwitchers = {}
hs.hotkey.bind('⌥', 'tab', function()
    local app = hs.window.focusedWindow():application():name()
    if appSwitchers[app] == nil then
        local wf = hs.window.filter.new(app)
        appSwitchers[app] = hs.window.switcher.new(wf, {showTitles = false, showSelectedTitle = false})
    end
    appSwitchers[app]:next()
end)

-- Type the current clipboard, to get around web forms that don't let you paste
hs.hotkey.bind(hyper, 'v', function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- Finally, show a notification that we finished loading the config successfully
Install:andUse('FadeLogo', {
    start = true,
    config = {
        default_run = 1.0,
    },
})
