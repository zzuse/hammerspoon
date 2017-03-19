local m = {}

caffeine = hs.menubar.new()
--[[   
sleepType - A string containing the type of sleep to be configured. The value should be one of:
    displayIdle - Controls whether the screen will be allowed to sleep (and also the system) if the user is idle.
    systemIdle - Controls whether the system will be allowed to sleep if the user is idle (display may still sleep).
    system - Controls whether the system will be allowed to sleep for any reason.
aValue - A boolean, true if the specified type of sleep should be prevented, false if it should be allowed
acAndBattery - A boolean, true if the sleep prevention should apply to both AC power and battery power, false if it should only apply to AC power  
--]]
modes = {'displayIdle','systemIdle','system'}

m.start = function()
    local requested_state = true
    -- defaults if not set
    if caffeine then
        caffeine:setClickCallback(caffeineClicked)
        setCaffeineDisplay(hs.caffeinate.get(modes[1]))
    end
    -- refresh on click
end

-- menu icon to access Mac's caffeine functions

function setCaffeineDisplay(state)
    local result
    if state then
        result = caffeine:setIcon("~/.hammerspoon/resources/stay-awake.pdf")
        caffeine:setTooltip("Caffeine is on - Mac won't sleep")
    else
        result = caffeine:setIcon("~/.hammerspoon/resources/can-sleep.pdf")
        caffeine:setTooltip("Caffeine is off - Mac is allowed to sleep")
    end
end

function caffeineClicked()
    new_state=hs.caffeinate.toggle(modes[1])
    setCaffeineState(new_state)
    setCaffeineDisplay(new_state)
end

function setCaffeineState(state)
    for i=1,#modes do
        hs.caffeinate.set(modes[i], state, state)
    end
end

m.stop = function()
    if caffeine then
        caffeine:delete()
        setCaffeineState(false)
    end
end

return m
