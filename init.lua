hs.hotkey.alertDuration=0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

white = hs.drawing.color.white
black = hs.drawing.color.black
blue = hs.drawing.color.blue
osx_red = hs.drawing.color.osx_red
osx_green = hs.drawing.color.osx_green
osx_yellow = hs.drawing.color.osx_yellow
tomato = hs.drawing.color.x11.tomato
dodgerblue = hs.drawing.color.x11.dodgerblue
firebrick = hs.drawing.color.x11.firebrick
lawngreen = hs.drawing.color.x11.lawngreen
lightseagreen = hs.drawing.color.x11.lightseagreen
purple = hs.drawing.color.x11.purple
royalblue = hs.drawing.color.x11.royalblue
sandybrown = hs.drawing.color.x11.sandybrown
black50 = {red=0,blue=0,green=0,alpha=0.5}
darkblue = {red=24/255,blue=195/255,green=145/255,alpha=1}

if hs.fs.currentDir() == nil then
    privateconf = hs.fs.pathToAbsolute('~/.hammerspoon/private/awesomeconfig.lua')
else
    if privatepath == nil then
        hs.fs.mkdir(hs.fs.currentDir()..'/private')
    end
    privateconf = hs.fs.pathToAbsolute(hs.fs.currentDir()..'/private/awesomeconfig.lua')
end
if privateconf ~= nil then
    require('private/awesomeconfig')
end

-- deprecated function show_time
function show_time()
    if not time_draw then
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local time_str = hs.styledtext.new(os.date("%H:%M"),{font={name="Impact",size=120},color=darkblue,paragraphStyle={alignment="center"}})
        local timeframe = hs.geometry.rect((mainRes.w-300)/2,(mainRes.h-200)/2,300,150)
        time_draw = hs.drawing.text(timeframe,time_str)
        time_draw:setLevel(hs.drawing.windowLevels.overlay)
        time_draw:show()
        ttimer = hs.timer.doAfter(4, function() time_draw:delete() time_draw=nil end)
    else
        time_draw:delete()
        time_draw=nil
    end
end

-- TODO hotkey_filtered[i-1].idx length calculation is not beautiful
function showavailableHotkey()
    if not hotkeytext then
        local hotkey_list=hs.hotkey.getHotkeys()
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local hkbgrect = hs.geometry.rect(mainRes.w/5,mainRes.h/5,mainRes.w/5*3,mainRes.h/5*3)
        hotkeybg = hs.drawing.rectangle(hkbgrect)
        -- hotkeybg:setStroke(false)
        hotkeybg:setFillColor({red=0,blue=0,green=0,alpha=0.5})
        hotkeybg:setRoundedRectRadii(10,10)
        hotkeybg:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeybg:setBehavior(hs.drawing.windowBehaviors.stationary)
        local hktextrect = hs.geometry.rect(hkbgrect.x+40,hkbgrect.y+30,hkbgrect.w-80,hkbgrect.h-60)
        hotkeytext = hs.drawing.text(hktextrect,"")
        hotkeytext:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeytext:setBehavior(hs.drawing.windowBehaviors.stationary)
        hotkeytext:setClickCallback(nil,function() hotkeytext:delete() hotkeytext=nil hotkeybg:delete() hotkeybg=nil end)
        hotkey_filtered = {}
        for i=1,#hotkey_list do
            if hotkey_list[i].idx ~= hotkey_list[i].msg then
                table.insert(hotkey_filtered,hotkey_list[i])
            end
        end
        local availablelen = 100
        local hkstr = ''
        for i=2,#hotkey_filtered,2 do
            local tmpstr = hotkey_filtered[i-1].msg .. hotkey_filtered[i].msg
            if string.len(tmpstr)<= availablelen then
                local tofilllen = availablelen-string.len(hotkey_filtered[i-1].msg)
                hkstr = hkstr .. hotkey_filtered[i-1].msg .. string.format('%'..tofilllen..'s',hotkey_filtered[i].msg) .. '\n'
            else
                hkstr = hkstr .. hotkey_filtered[i-1].msg .. '\n' .. hotkey_filtered[i].msg .. '\n'
            end
        end
        if math.fmod(#hotkey_filtered,2) == 1 then hkstr = hkstr .. hotkey_filtered[#hotkey_filtered].msg end
        local hkstr_styled = hs.styledtext.new(hkstr, {font={name="Courier-Bold",size=16}, color=white, paragraphStyle={lineSpacing=12.0,lineBreak='truncateMiddle'}})
        hotkeytext:setStyledText(hkstr_styled)
        hotkeybg:show()
        hotkeytext:show()
    else
        hotkeytext:delete()
        hotkeytext=nil
        hotkeybg:delete()
        hotkeybg=nil
    end
end

modal_list = {}

function modal_stat(modal, color)
    if not modal_show then
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local modal_bg_rect = hs.geometry.rect(mainRes.w-170,mainRes.h-50,170,40)
        local modal_text_rect = hs.geometry.rect(mainRes.w-170,mainRes.h-50,170,40)
        modal_bg = hs.drawing.rectangle(modal_bg_rect)
        modal_bg:setStroke(false)
        modal_bg:setFillColor(black)
        modal_bg:setRoundedRectRadii(2,2)
        modal_bg:setLevel(hs.drawing.windowLevels.status)
        modal_bg:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces+hs.drawing.windowBehaviors.stationary)
        local styledText = hs.styledtext.new("init...",{font={size=14.0,color=white},paragraphStyle={alignment="center"}})
        modal_show = hs.drawing.text(modal_text_rect,styledText)
        modal_show:setLevel(hs.drawing.windowLevels.status)
        modal_show:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces+hs.drawing.windowBehaviors.stationary)
    end
    modal_bg:show()
    modal_bg:setFillColor(color)
    modal_show:show()
    modal_text = string.upper(modal .. ' mode')
    modal_show:setText(modal_text)
end



function move_win(direction)
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    if win then
        if direction == 'up' then win:moveOneScreenNorth() end
        if direction == 'down' then win:moveOneScreenSouth() end
        if direction == 'left' then win:moveOneScreenWest() end
        if direction == 'right' then win:moveOneScreenEast() end
        if direction == 'next' then win:moveToScreen(screen:next()) end
    end
end

function resize_win(direction)
    local win = hs.window.focusedWindow()
    if win then
        local f = win:frame()
        local screen = win:screen()
        local max = screen:fullFrame()
        local stepw = max.w/30
        local steph = max.h/30
        if direction == "right" then f.w = f.w+stepw end
        if direction == "left" then f.w = f.w-stepw end
        if direction == "up" then f.h = f.h-steph end
        if direction == "down" then f.h = f.h+steph end
        if direction == "halfright" then f.x = max.w/2 f.y = 0 f.w = max.w/2 f.h = max.h end
        if direction == "halfleft" then f.x = 0 f.y = 0 f.w = max.w/2 f.h = max.h end
        if direction == "halfup" then f.x = 0 f.y = 0 f.w = max.w f.h = max.h/2 end
        if direction == "halfdown" then f.x = 0 f.y = max.h/2 f.w = max.w f.h = max.h/2 end
        if direction == "cornerNE" then f.x = max.w/2 f.y = 0 f.w = max.w/2 f.h = max.h/2 end
        if direction == "cornerSE" then f.x = max.w/2 f.y = max.h/2 f.w = max.w/2 f.h = max.h/2 end
        if direction == "cornerNW" then f.x = 0 f.y = 0 f.w = max.w/2 f.h = max.h/2 end
        if direction == "cornerSW" then f.x = 0 f.y = max.h/2 f.w = max.w/2 f.h = max.h/2 end
        if direction == "center" then f.x = (max.w-f.w)/2 f.y = (max.h-f.h)/2 end
        if direction == "fcenter" then f.x = stepw*5 f.y = steph*5 f.w = stepw*20 f.h = steph*20 end
        if direction == "fullscreen" then f = max end
        if direction == "shrink" then f.x = f.x+stepw f.y = f.y+steph f.w = f.w-(stepw*2) f.h = f.h-(steph*2) end
        if direction == "expand" then f.x = f.x-stepw f.y = f.y-steph f.w = f.w+(stepw*2) f.h = f.h+(steph*2) end
        if direction == "mright" then f.x = f.x+stepw end
        if direction == "mleft" then f.x = f.x-stepw end
        if direction == "mup" then f.y = f.y-steph end
        if direction == "mdown" then f.y = f.y+steph end
        win:setFrame(f)
    else
        hs.alert.show("No focused window!")
    end
end

function SendExitTextRequest()
    local stat, data= hs.osascript.applescript('on run {}\n tell application "Terminal"\n activate\n do script ("exit") in window 0\n end tell\n return input\n end run\n ')
end

function HiddenDesktop()
    local stat, data= hs.osascript.applescript('on run {}\n tell application "Finder"\n activate\n do shell script "chflags hidden ~/Desktop/*"\n end tell\n return input\n end run\n')
end
function NoHiddenDesktop()
    local stat, data= hs.osascript.applescript('on run {}\n tell application "Finder"\n activate\n do shell script "chflags nohidden ~/Desktop/*"\n end tell\n return input\n end run\n')
end

if not module_list then
    module_list = {
        "basicmode",
        "modes/clipshow",
    }
end

for i=1,#module_list do
    require(module_list[i])
end

function exit_others(except)
    for i = 1, #modal_list do
        if modal_list[i] ~= except then
            modal_list[i]:exit()
        end
    end
end
-- local weather = require("hs-weather")
-- weather.start()

local caff = require("modes.caffeinator")
caff.start()

if #modal_list > 0 then require("modalmgr") end

hs.loadSpoon("SpoonInstall")
hs.loadSpoon("HCalendar")
hs.loadSpoon("AClock")
spoon.AClock:toggleShowPersistent()
spoon.SpoonInstall:andUse("DeepLTranslate")
spoon.SpoonInstall:andUse("ArrangeDesktop")
spoon.SpoonInstall:andUse("WinWin")
spoon.SpoonInstall:andUse("ReloadConfiguration")
