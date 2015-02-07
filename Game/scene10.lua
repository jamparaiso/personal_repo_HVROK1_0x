

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
			storyboard.gotoScene("scene11", "fade", 500)
			return true;
		end
	end

	local function BackButtonEventHandler(event)
		local phase = event.phase

		if event.phase == "ended" then
		myData.playSound("tap")
			print("back button has been pressed")
			storyboard.gotoScene("scene9", "slideRight", 500)
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
	local sceneGroup = self.view

	local background = display.newImage("Images/Eight.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local background2 = display.newImage("Images/Ninth.png")
	background2.x = display.contentCenterX
	background2.y = display.contentCenterY


	local background3 = display.newImage("Images/Tenth10.png")
	background3.x = display.contentCenterX
	background3.y = display.contentCenterY

	local NextButton = widget.newButton( {
		x = 435,
		y = 290,
		width = 70,
		height = 25,
		defaultFile = "Buttons/Next.png",
		overFile = "Buttons/NextOff.png",
		onEvent = NextButtonEventHandler,
	} );
	

	local MenuButton = widget.newButton
	{
	x = 50,
	y = 20,
	width = 70,
	height = 25,
	defaultFile = "Buttons/Menu.png",
	overFile = "Buttons/MenuOff.png",
	onEvent = MenuButtonEventHandler,
}
	local SkipButton = widget.newButton
	{
	x = 438,
	y = 20,
	width = 70,
	height = 25,
	defaultFile = "Buttons/Skip_On.png",
	overFile = "Buttons/Skip_Off.png",
	onEvent = SkipButtonEventHandler,
}

	local BackButton = widget.newButton {
		x = 50,
		y = 290,
		width = 70,
		height = 25,
		defaultFile = "Buttons/Back.png",
		overFile = "Buttons/BackOff.png",
		onEvent = BackButtonEventHandler,
	} 
	sceneGroup:insert(background)
	sceneGroup:insert(background2)
	sceneGroup:insert(background3)
	sceneGroup:insert(NextButton)
	sceneGroup:insert(BackButton)
	sceneGroup:insert(MenuButton)
	sceneGroup:insert(SkipButton)
end
function scene:enterScene( event )
	local sceneGroup = self.view
	local phase = event.phase

end

function scene:exitScene( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
	sceneGroup:removeSelf()
	sceneGroup = nil
	audio.stop(backgroundMusicChannel)
	storyboard.removeAll()
	elseif phase == "did" then
	
	end	
	
end
function scene:didExitScene( event )
	local sceneGroup = self.view
	
	
end

scene:addEventListener ( "createScene", scene )
scene:addEventListener ( "enterScene", scene )
scene:addEventListener ( "exitScene", scene )
scene:addEventListener ( "didExitScene", scene )

return scene