--- === CountDown ===
---
--- Tiny countdown with visual indicator
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/CountDownNumber.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/CountDownNumber.spoon.zip)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "CountDownNumber"
obj.version = "1.0"
obj.author = "zzuseme <zzuseme@gmail.com>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.canvas = nil
obj.timer = nil

local logger = hs.logger.new("CountDownNumber","debug")
obj.logger = logger

-- Defaults
obj._attribs = {
    textFont = "Impact",
    textSize = 90,
    textColor = {hex="#76d80e", alpha=0.3},
    width = 240,
    height = 90,
    showDuration = 4,  -- seconds
    hotkey = nil,
    hotkeyMods = {},
}
for k, v in pairs(obj._attribs) do obj[k] = v end

function obj:init()
    self.logger.i('init')
    if not self.canvas then self.canvas = hs.canvas.new({x=0, y=0, w=0, h=0}) end
    self.canvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
    --- self.canvas:level(hs.canvas.windowLevels.status)
    self.canvas[1] = {
        type = "text",
        text = "",
        textFont = self.textFont,
        textSize = self.textSize,
        textColor = self.textColor,
        textAlignment = "left",
    }
    local mainScreen = hs.screen.primaryScreen()
    local mainRes = mainScreen:fullFrame()
    local frameWidth = mainRes.w
    local frameHeight = mainRes.h
    self.canvas:frame({
        x = (frameWidth / 2) - self.width / 2,
        y = (frameHeight / 2) - self.height / 2,
        w = self.width,
        h = self.height,
    })
    self._init_done = true
    return self
end

--- CountDown:startFor(minutes)
--- Method
--- Start a countdown for `minutes` minutes immediately. Calling this method again will kill the existing countdown instance.
---
--- Parameters:
---  * minutes - How many minutes

local function canvasCleanup()
    obj.logger.i('canvasCleanup')
    if obj.timer then
        obj.timer:stop()
        obj.timer = nil
    end
    obj.canvas:hide()
end

function obj:startFor(minutes)
    self.logger.i('startFor')
    if obj.timer then
        canvasCleanup()
    else
        self.canvas:show()
        local secCount = math.ceil(60*minutes)
        obj.loopCount = 0
        obj.number = secCount
        obj.timer = hs.timer.doEvery(1, function()
            obj.loopCount = obj.loopCount+1/secCount
            obj.number = obj.number - 1
            obj:setProgress(obj.loopCount, minutes, obj.number)
        end)
    end

    return self
end

--- CountDown:pauseOrResume()
--- Method
--- Pause or resume the existing countdown.
---

function obj:pauseOrResume()
    self.logger.i('Pause or Resume')
    if obj.timer then
        if obj.timer:running() then
            obj.timer:stop()
        else
            obj.timer:start()
        end
    end
end

--- CountDown:setProgress(progress)
--- Method
--- Set the progress of visual indicator to `progress`.
---
--- Parameters:
---  * progress - an number specifying the value of progress (0.0 - 1.0)

function obj:setProgress(progress, notifystr, number)
    self.logger.i("setProgress")
    if progress >= 1 then
        canvasCleanup()
        if notifystr then
            hs.notify.new({
                title = "Time(" .. notifystr .. " mins) is up!",
                informativeText = "Now is " .. os.date("%X")
            }):send()
        end
    else
        self.canvas[1].text = tostring(number)
        self.logger.i(number)
    end
end

return obj
