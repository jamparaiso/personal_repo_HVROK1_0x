
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

-----this is the background music ---- located in myData.lua
myData.setBg(2,1)
-------end


local function StartButtonEventHandler(event)
		local phase = event.phase
		if event.phase == "ended" then
		myData.playSound("tap")
		print ("Start")
		storyboard.gotoScene("scene1", "fade", 100)
		return true;
	end
end

	local function OptionButtonEventHandler(event)
		local phase = event.phase
		if event.phase == "ended" then
		myData.playSound("tap")
			print("Options")
			storyboard.gotoScene("gameoptions", "fade", 250)
			return true
		end
	end




local function quithandler(event)
	if "clicked" ==event.action then
		myData.playSound("tap")
		local i = event.index
			if i ==1 then 
				os.exit()
				native.requestExit( )
			else			
		
			end
	end
end

local function exitapp(event)	
	myData.playSound("tap")
	local alert = native.showAlert ( "Quit Game","Are you sure you want to close the application?",{"Yes","No"},quithandler)
end




function scene:createScene( event )
	screenGroup = self.view
	bgGroup = display.newGroup( )
	uiGroup = display.newGroup()

	screenGroup:insert( bgGroup)
	screenGroup:insert(uiGroup)
	

	local background = display.newImage("images/background.png")
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.width = screenW;
	background.height = screenH;


	bgGroup:insert(background)

	local gameTitle = display.newImage("images/gametitle.png")
	gameTitle.x = 250	
	gameTitle.y = 80

	local StartButton = widget.newButton
	{
		x = 240,
		y = 115,
		width = 210,
		height = 32,
		defaultFile = "buttons/start.png",
		overFile = "buttons/startoff.png",
		onEvent = StartButtonEventHandler,
	}

	local OptionsButton = widget.newButton 
	{
	x = halfW,
	y = halfH,
	width = 210,
	height = 32,
	defaultFile = "buttons/options.png",
	overFile = "buttons/optionoff.png",
	onEvent = OptionButtonEventHandler,
	}


	local ExitButton = widget.newButton
	{
	x = 240,
	y = 205,
	width = 210,
	height = 32,
	defaultFile = "buttons/exit.png",
	overFile = "buttons/exitoff.png",
	onEvent = exitapp,
}
	uiGroup:insert(gameTitle)
	uiGroup:insert(StartButton)
	uiGroup:insert(OptionsButton)
	uiGroup:insert(ExitButton)



end

function scene:enterScene( event )
	local sceneGroup = self.view
	local phase = event.phase

end

function scene:exitScene( event )
local sceneGroup = self.view
	screenGroup:removeSelf()
	screenGroup = nil
	storyboard.removeAll()

	
end

function scene:didExitScene( event )
	
	
end


scene:addEventListener ( "createScene", scene )
scene:addEventListener ( "enterScene", scene )
scene:addEventListener ( "exitScene", scene )
scene:addEventListener ( "didExitScene", scene )

return scene