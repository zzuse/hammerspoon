modalmgr_keys = modalmgr_keys or {{"alt"}, "space"}
modalmgr = hs.hotkey.modal.new(modalmgr_keys[1], modalmgr_keys[2], 'Toggle Modal Supervisor')
function modalmgr:entered()
    dock_launched = true
    modal_stat('dock',black)
    if resizeM then
        if launch_resizeM == nil then launch_resizeM = false end
        if launch_resizeM == true then resizeM:enter() end
    end
    if idle_to_which == "hide" then
        modal_show:hide()
        modal_bg:hide()
    end
end

function modalmgr:exited()
    exit_others(nil)
    dock_launched = nil
    modal_bg:hide()
    modal_show:hide()
    if idletimer ~= nil then idletimer:stop() end
    if hotkeytext then
        hotkeytext:delete()
        hotkeytext=nil
        hotkeybg:delete()
        hotkeybg=nil
    end
end
modalmgr:bind(modalmgr_keys[1], modalmgr_keys[2], "Toggle Modal Supervisor", function() modalmgr:exit() end)

if appM then
    appM_keys = appM_keys or {"alt", "A"}
    if string.len(appM_keys[2]) > 0 then
        modalmgr:bind(appM_keys[1], appM_keys[2], 'Enter Application Mode', function() exit_others(appM) appM:enter() end)
    end
end
if clipboardM then
    clipboardM_keys = clipboardM_keys or {"alt", "C"}
    if string.len(clipboardM_keys[2]) > 0 then
        modalmgr:bind(clipboardM_keys[1], clipboardM_keys[2], 'Enter Clipboard Mode', function() exit_others(clipboardM) clipboardM:enter() end)
    end
end

if resizeM then
    resizeM_keys = resizeM_keys or {"alt", "R"}
    if string.len(resizeM_keys[2]) > 0 then
        modalmgr:bind(resizeM_keys[1], resizeM_keys[2], 'Enter Resize Mode', function() exit_others(resizeM) resizeM:enter() end)
    end
end

if cheatsheetM then
    cheatsheetM_keys = cheatsheetM_keys or {"alt", "S"}
    if string.len(cheatsheetM_keys[2]) > 0 then
        modalmgr:bind(cheatsheetM_keys[1], cheatsheetM_keys[2], 'Enter Cheatsheet Mode', function() exit_others(cheatsheetM) cheatsheetM:enter() end)
    end
end

showtime_keys = showtime_keys or {{"ctrl","alt","cmd"}, "T"}
if string.len(showtime_keys[2]) > 0 then
    modalmgr:bind(showtime_keys[1], showtime_keys[2], 'Show Digital Clock', function() spoon.AClock:toggleShowPersistent() end)
end

countdown = countdown or {"alt", "T"}
if string.len(countdown[2]) > 0 then
    modalmgr:bind(countdown[1], countdown[2], 'Timer Countdown Number', function() spoon.CountDownNumber:start() end)
end

countdown_pause = countdown_pause or {"alt", "P"}
if string.len(countdown_pause[2]) > 0 then
    modalmgr:bind(countdown_pause[1], countdown_pause[2], 'Timer Countdown Number Pause', function() spoon.CountDownNumber:pauseOrResume() end)
end

text_keys = text_keys or {{"ctrl","shift"}, "E"}
if string.len(text_keys[2]) > 0 then
   modalmgr:bind(text_keys[1], text_keys[2], 'Send Text EXIT', function() SendExitTextRequest() end)
end
nohidden_keys = nohidden_keys or {{"cmd", "ctrl", "shift"}, "H"}
if string.len(nohidden_keys[2]) > 0 then
   modalmgr:bind(nohidden_keys[1], nohidden_keys[2], 'no hidden desktop', function() NoHiddenDesktop() end)
end
hidden_keys = hidden_keys or {{"ctrl","shift"}, "H"}
if string.len(hidden_keys[2]) > 0 then
   modalmgr:bind(hidden_keys[1], hidden_keys[2], 'hidden desktop', function() HiddenDesktop() end)
end

if viewM then
    viewM_keys = viewM_keys or {"alt", "V"}
    if string.len(viewM_keys[2]) > 0 then
        modalmgr:bind(viewM_keys[1], viewM_keys[2], 'Enter View Mode', function() exit_others(viewM) viewM:enter() end)
    end
end

toggleconsole_keys = toggleconsole_keys or {"alt", "Z"}
if string.len(toggleconsole_keys[2]) > 0 then
    modalmgr:bind(toggleconsole_keys[1], toggleconsole_keys[2], 'Toggle Hammerspoon Console', function() hs.toggleConsole() end)
end

reloadconfig_keys = reloadconfig_keys or {{"ctrl","alt","cmd"}, "C"}
if string.len(reloadconfig_keys[2]) > 0 then
    modalmgr:bind(reloadconfig_keys[1], reloadconfig_keys[2], 'Reload Hammerspoon Config', function() spoon.ReloadConfiguration:start() end)
end

translate_keys = translate_keys or {{"ctrl","alt","cmd"}, "D"}
if string.len(translate_keys[2]) > 0 then
    modalmgr:bind(translate_keys[1], translate_keys[2], 'DeepL Translate clipboard', function() spoon.DeepLTranslate:translateSelectionPopup() end)
end

pomodoro_start = pomodoro_start or {{"ctrl","alt","cmd"}, "S"}
if string.len(pomodoro_start[2]) > 0 then
    modalmgr:bind(pomodoro_start[1], pomodoro_start[2], 'Pomodoro Timer Start', function() spoon.Cherry:start() end)
end
pomodoro_pause = pomodoro_pause or {{"ctrl","alt","cmd"}, "P"}
if string.len(pomodoro_pause[2]) > 0 then
    modalmgr:bind(pomodoro_pause[1], pomodoro_pause[2], 'Pomodoro Timer Pause', function() spoon.Cherry:pause() end)
end
pomodoro_resume = pomodoro_resume or {{"ctrl","alt","cmd"}, "R"}
if string.len(pomodoro_resume[2]) > 0 then
    modalmgr:bind(pomodoro_resume[1], pomodoro_resume[2], 'Pomodoro Timer Resume', function() spoon.Cherry:start(true) end)
end

winhints_keys = winhints_keys or {"alt", "I"}
if string.len(winhints_keys[2]) > 0 then
    modalmgr:bind(winhints_keys[1], winhints_keys[2], 'Show Windows Hint', function() exit_others(nil) hs.hints.windowHints() end)
end

move_space1 = move_space1 or {{"shift","alt"}, "3"}
if string.len(move_space1[2]) > 0 then
    modalmgr:bind(move_space1[1], move_space1[2], 'Move window to right Space', function() winspaceM:right() end)
end

move_space2 = move_space2 or {{"shift","alt"}, "1"}
if string.len(move_space2[2]) > 0 then
    modalmgr:bind(move_space2[1], move_space2[2], 'Move window to left Space1', function() winspaceM:left() end)
end

if modalmgr then
    if launch_modalmgr == nil then launch_modalmgr = true end
    if launch_modalmgr == true then modalmgr:enter() end
end
