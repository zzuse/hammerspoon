--- === SpaceNumber ===
---
--- Show current space number in the top right corner
---
--- Download: [https://github.com/zzuse/hammerspoon/tree/master/Spoons/SpaceNumber.spoon](.)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "SpaceNumber"
obj.version = "1.0"
obj.author = "zzuse"
obj.homepage = "https://github.com/zzuse/hammerspoon/tree/master/Spoons/SpaceNumber.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Internal variables
obj.canvas = nil
obj.watcher = nil
obj.showing = false

function obj:init()
    -- Create canvas for displaying the space number
    obj.canvas = hs.canvas.new({x = 0, y = 0, w = 90, h = 90})
    obj.canvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces + 
                       hs.canvas.windowBehaviors.stationary)
    obj.canvas:level(hs.canvas.windowLevels.popUpMenu)
    
    -- Add text element to canvas
    obj.canvas[1] = {
        type = "text",
        text = "",
        textFont = "Impact",
        textColor = {hex="#76d80e", alpha=0.3},
        textSize = 90,
        textAlignment = "left"
    }
    local mainScreen = hs.screen.primaryScreen()
    local mainRes = mainScreen:fullFrame()
    obj.canvas:frame({
        x = mainRes.x + mainRes.w - 90,
        y = mainRes.y + 20,
        w = 90,
        h = 90,
    })
    return self
end

function obj:updateDisplay()
    -- Get current space
    local currentSpace = hs.spaces.focusedSpace()
    
    -- Find space number in user spaces
    local spaceNumber = 0
    local userSpaces = hs.spaces.spacesForScreen()
    for i, space in ipairs(userSpaces) do
        if space == currentSpace then
            spaceNumber = i
            break
        end
    end
    
    -- Update canvas text
    obj.canvas[1].text = tostring(spaceNumber)
    -- obj.canvas:elementAttribute(1, "text", tostring(spaceNumber))
end

function obj:tick_timer_fn()
    return hs.timer.doEvery(1, function() self:updateDisplay() end)
end

function obj:toggleShow()
    if self.showing then
        -- Hide the canvas
        self.canvas:hide()
        if self.tick_timer then self.tick_timer:stop(); self.tick_timer = nil end
        -- Stop the watcher
        if self.watcher then
            self.watcher:stop()
            self.watcher = nil
        end
        self.showing = false
    else
        -- Show the canvas
        self.canvas:show()
        self.tick_timer = self:tick_timer_fn()
        -- self:updateDisplay()
        
        -- Start the watcher
        self.watcher = hs.spaces.watcher.new(function()
            self:updateDisplay()
        end)
        self.watcher:start()
        self.showing = true
    end
    
    return self
end

return obj