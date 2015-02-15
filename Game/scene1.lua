

_W = display.viewableContentWidth;
_H = display.viewableContentHeight;


local halfH = display.contentCenterY
local halfW = display.contentCenterX


local screenW = display.contentWidth
local screenH = display.contentHeight
local areaY = display.screenOriginY
local areaX = display.screenOriginX

local actualW = screenW - 2 * areaX
local actualH = screenH - 2 * areaY

local top = areaY
local bottom = screenH 


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local myData = require("myData")
local widget = require "widget"
storyboard.removeAll()

local function NextButtonEventHandler(event)
		local phase = event.phase

		if event.phase == "ended" then
		myData.playSound("tap")
			print("next button has been pressed")
			storyboard.gotoScene("scene2", "fade", 500)
			return true;
		end
	end


	local function MenuButtonEventHandler(event)
		local phase = event.phase
		if event.phase == "ended" then
		myData.playSound("tap")
			print("return to Menu")
			storyboard.gotoScene("menu", "fade", 100)
			return true;
		end
	end
		
	local function SkipButtonEventHandler(event)
		local phase = event.phase
		if event.phase == "ended" then
		myData.playSound("tap")
			print("Skip button has been pressed")
			storyboard.gotoScene("Game", "fade")
			return true;
		end
	end
function scene:createScene( event )
	local screenGroup = self.view
	local background = display.newImage("Images/first1.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local NextButton = widget.newButton( {
		x = 435,
		y = 290,
		width = 70,
		height = 25,
		defaultFile = "Buttons/next.png",
		overFile = "Buttons/nextoff.png",
		onEvent = NextButtonEventHandler,
	} );
	

	local MenuButton = widget.newButton
	{
	x = 50,
	y = 20,
	width = 70,
	height = 25,
	defaultFile = "Buttons/menu.png",
	overFile = "Buttons/menuoff.png",
	onEvent = MenuButtonEventHandler,
}
	local SkipButton = widget.newButton
	{
	x = 438,
	y = 20,
	width = 70,
	height = 25,
	defaultFile = "Buttons/skipon.png",
	overFile = "Buttons/skipoff.png",
	onEvent = SkipButtonEventHandler,
}

	screenGroup:insert(background)
	screenGroup:insert(NextButton)
	screenGroup:insert(MenuButton)
	screenGroup:insert(SkipButton)
end

function scene:enterScene( event )
	local screenGroup = self.view
	local phase = event.phase

end

function scene:exitScene( event )
	local screenGroup = self.view
	
	local phase = event.phase
	
	screenGroup:removeSelf()
	screenGroup = nil
	audio.stop(backgroundMusicChannel)

	
end

function scene:didExitScene( event )
	
	
end


scene:addEventListener ( "createScene", scene )
scene:addEventListener ( "enterScene", scene )
scene:addEventListener ( "exitScene", scene )
scene:addEventListener ( "didExitScene", scene )

return scene