--- === CountDown ===
---
--- Tiny countdown number with visual indicator
---

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
obj.lastApp = nil
obj.chooser = nil
obj.visible = false
obj.soundobj = nil

local logger = hs.logger.new("CountDownNumber","debug")
obj.logger = logger

-- Defaults
obj._attribs = {
    textFont = "Impact",
    textSize = 90,
    textColor = {hex="#76d80e", alpha=0.3},
    width = 240,
    height = 90,
    mp3 = "Spoons/CountDownNumber.spoon/hammerspoon_alert.mp3",
}
for k, v in pairs(obj._attribs) do obj[k] = v end

function obj:init()
    self.logger.i('init')
    if not self.canvas then self.canvas = hs.canvas.new({x=0, y=0, w=0, h=0}) end
    self.canvas:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
    self.canvas[1] = {
        type = "text",
        text = "",
        textFont = self.textFont,
        textSize = self.textSize,
        textColor = self.textColor,
        textAlignment = "center",
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

--- canvasCleanup()
--- Method
--- Stop a countdownNumber immediately.
---

local function canvasCleanup()
    obj.logger.i('canvasCleanup')
    if obj.timer then
        obj.timer:stop()
        obj.timer = nil
    end
    obj.canvas:hide()
end

--- CountDown:startFor(minutes)
--- Method
--- Start a countdown for `minutes` minutes immediately. Calling this method again will kill the existing countdown instance.
---
--- Parameters:
---  * minutes - How many minutes

function obj:startFor(minutes)
    self.logger.i('startFor')

    local secCount = math.ceil(60*minutes)
    obj.loopCount = 0
    obj.number = secCount
    self.canvas[1].text = tostring(obj.number)
    self.canvas:show()
    obj.timer = hs.timer.doEvery(1, function()
        obj.loopCount = obj.loopCount+1/secCount
        obj.number = obj.number - 1
        obj:setProgress(obj.loopCount, minutes, obj.number)
    end)

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
---  * notifystr- an str of competion alert
---  * number - an number specifying the value of countdown (integer)

function obj:setProgress(progress, notifystr, number)
    --- self.logger.i("setProgress")
    if progress >= 1 then
        canvasCleanup()
        if notifystr then
            hs.notify.new({
                title = "Time(" .. notifystr .. " mins) is up!",
                informativeText = "Now is " .. os.date("%X")
            }):send()
        end
        if obj.mp3 ~= nil then
            local path = hs.fs.pathToAbsolute(obj.mp3)
            self.soundobj = hs.sound.getByFile(path)
            if self.soundobj ~= nil then
                self.soundobj:volume(0.8)
                self.soundobj:stop()
                self.soundobj:play()
            else
                self.logger.i(path .. " failed to load.")
            end
        end
    else
        self.canvas[1].text = tostring(number)
        -- self.logger.i(number)
    end
end

function obj:show()
    obj.logger.i("show")
    if obj.chooser ~= nil then
        obj.lastApp = hs.application.frontmostApplication()
        obj.chooser:show()
        obj.visible = true
    end
end

function obj:hide()
    self.logger.i("hide")
    if self.chooser ~= nil then
        self.chooser:hide()
    end
end

function refocus()
    obj.logger.i("refocus")
    if obj.lastApp ~= nil then
      obj.lastApp:activate()
      obj.lastApp = nil
    end
end

function choiceCallback(choice)
    if choice ~= nil then
        obj.logger.i("choice")
        if type(tonumber(choice.text)) ~= "number" then
            choice.text = 1
        end
        refocus()
        obj.visible = false
        obj:hide()
        obj:startFor(choice.text)
    end
end

local commands = {
    {
      ['text'] = 1,
      ['subText'] = 'Create a Timer for 1 min',
    },
    {
      ['text'] = 2,
      ['subText'] = 'Create a Timer for 2 min',
    },
    {
      ['text'] = 5,
      ['subText'] = 'Create a Timer for 5 min',
    },
    {
      ['text'] = 10,
      ['subText'] = 'Create a Timer for 10 min',
    },
    {
      ['text'] = 15,
      ['subText'] = 'Create a Timer for 15 min',
    },
    {
      ['text'] = 30,
      ['subText'] = 'Create a Timer for 30 min',
    },
    {
      ['text'] = 45,
      ['subText'] = 'Create a Timer for 45 min',
    },
    {
      ['text'] = 60,
      ['subText'] = 'Create a Timer for 60 min',
    },
}

function obj:start()
    self.logger.i("start")
    if obj.timer then
        canvasCleanup()
    else
    self.chooser = hs.chooser.new(choiceCallback)
    self.chooser:width(20)
    self.chooser:enableDefaultForQuery(true)
    self.chooser:rows(#commands)
    self.chooser:choices(commands)
    self.show();
    end
end

return obj
