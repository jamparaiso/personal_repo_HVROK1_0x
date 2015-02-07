

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
	
	print("Game")
	storyboard.gotoScene( "Game", "fade", 1000 )
	
	return true	
end

	local function BackButtonEventHandler(event)
		local phase = event.phase

		if event.phase == "ended" then
		myData.playSound("tap")
			print("back button has been pressed")
			storyboard.gotoScene("scene10", "slideRight", 500)
			return true;
		end
	end

	local function MenuButtonEventHandler(event)
			local phase = event.phase

		if event.phase == "ended" then
		myData.playSound("tap")
			print("return to Menu")
			storyboard.gotoScene("Game", "fade", 100)
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

	local background = display.newImage("Images/Eight.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local background2 = display.newImage("Images/Ninth.png")
	background2.x = display.contentCenterX
	background2.y = display.contentCenterY

	local background3 = display.newImage("Images/Tenth.png")
	background3.x = display.contentCenterX
	background3.y = display.contentCenterY

	local background4 = display.newImage("Images/Eleventh11.png")
	background4.x = display.contentCenterX
	background4.y = display.contentCenterY


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

	local BackButton = widget.newButton( {
		x = 50,
		y = 290,
		width = 70,
		height = 25,
		defaultFile = "Buttons/Back.png",
		overFile = "Buttons/BackOff.png",
		onEvent = BackButtonEventHandler,
	} );

	screenGroup:insert(background)
	screenGroup:insert(background2)
	screenGroup:insert(background3)
	screenGroup:insert(background4)
	screenGroup:insert(NextButton)
	screenGroup:insert(BackButton)
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
	
	if event.phase == "will" then
	screenGroup:removeSelf()
	screenGroup = nil
	audio.stop(backgroundMusicChannel)
	storyboard.removeAll()
	elseif phase == "did" then
	
	end	
	
end

function scene:didExitScene( event )
	local screenGroup = self.view
	
	if NextButton then
		
	screenGroup:removeSelf()
	screenGroup = nil
	end
end


scene:addEventListener ( "createScene", scene )
scene:addEventListener ( "enterScene", scene )
scene:addEventListener ( "exitScene", scene )
scene:addEventListener ( "didExitScene", scene )

return scene