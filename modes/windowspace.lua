local hotkey = require "hs.hotkey"
local window = require "hs.window"
local hse, hsee, hst = hs.eventtap,hs.eventtap.event,hs.timer
local spaces = require "hs.spaces"

function flashScreen(screen)
   local flash=hs.canvas.new(screen:fullFrame()):appendElements({
	 action = "fill",
	 fillColor = { alpha = 0.35, red=1},
	 type = "rectangle"})
   flash:show()
   hs.timer.doAfter(.25, function () flash:delete() end)
end 

function switchSpace(skip,dir)
   for i=1,skip do
      hs.eventtap.keyStroke({"ctrl","fn"},dir,0) -- "fn" is a bugfix!
   end 
end

function getGoodFocusedWindow(nofull)
   local win = window.focusedWindow()
   if not win or not win:isStandard() then return end
   if nofull and win:isFullScreen() then return end
   return win
end 

function moveWindowOneSpace(dir,switch)
   local win = getGoodFocusedWindow(true)
   if not win then return end
   local screen=win:screen()
   local uuid=screen:getUUID()
   local userSpaces=nil
   for k,v in pairs(spaces.allSpaces()) do
      userSpaces=v
      if k==uuid then break end
   end
   if not userSpaces then return end

   for i, spc in ipairs(userSpaces) do
      if spaces.spaceType(spc)~="user" then -- skippable space
	 table.remove(userSpaces, i)
      end
   end
   if not userSpaces then return end

   local initialSpace = spaces.windowSpaces(win)
   if not initialSpace then return else initialSpace=initialSpace[1] end
   local currentCursor = hs.mouse.getRelativePosition()

   if (dir == "right" and initialSpace == userSpaces[#userSpaces]) or
      (dir == "left" and initialSpace == userSpaces[1]) then
      flashScreen(screen)   -- End of Valid Spaces
   else
      local zoomPoint = hs.geometry(win:zoomButtonRect()) 
      local safePoint = zoomPoint:move({-1,-1}).topleft
      hsee.newMouseEvent(hsee.types.leftMouseDown, safePoint):post()
      switchSpace(1, dir)
      hst.waitUntil(
	 function () return spaces.windowSpaces(win)[1]~=initialSpace end,
	 function ()
	    hsee.newMouseEvent(hsee.types.leftMouseUp, safePoint):post()
	    hs.mouse.setRelativePosition(currentCursor)
      end, 0.05)
   end
end

winspaceM = hs.hotkey.modal.new()
table.insert(modal_list, winspaceM)
function winspaceM:left() modal_stat('winspace',sandybrown) moveWindowOneSpace("left",true) end
function winspaceM:right() modal_stat('winspace',sandybrown) moveWindowOneSpace("right",true) end
