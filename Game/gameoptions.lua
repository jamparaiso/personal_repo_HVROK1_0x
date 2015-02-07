
local halfH = display.contentCenterY
local halfW = display.contentCenterX


local screenW = display.contentWidth
local screenH = display.contentHeight
local areaY = display.screenOriginY
local areaX = display.screenOriginX

local actualW = screenW - 2 * areaX
local actualH = screenH - 2 * areaY

local top = areaY
local bottom = screenH - areaY
local left = areaX

--local line = display.newLine(halfW,0,halfW,_H)

--module
local storyboard = require("storyboard")
local myData = require("myData")
local widget = require ( "widget" )
local scene = storyboard.newScene()

--variable declaration
--screen height and width, this was declared in myData.lua
--local _H = myData._H
---local _W = myData._W
--local _HH = myData._HH
--local _HW = myData._HW

local screenGroup

local background
local soundButtonOn
local soundButtonOff
local musicButtonOn
local musicButtonOff
local backMusic = myData.backMusic
local enableSound = myData.enableSound
local enableMusic = myData.enableMusic
local tapSoundEffect
local setBg = myData.setBg

--Sounds / Music Functions-------------------------------------------------------------
local function soundOnEvent ( event )
		local phase = event.phase
		if "ended" == phase then	
			enableSound = true
			myData.enableSound = true
			soundButtonOn.alpha = 0
			soundButtonOff.alpha =1
			myData.playSound("tap")	-- tap sound
		end			
	end
	
local function soundOffEvent (event)
		local phase = event.phase
			if "ended" == phase then
					enableSound = false
					myData.enableSound = false
					soundButtonOff.alpha = 0
					soundButtonOn.alpha =1

			end
	end
	
local function musicOnEvent (event)
		local phase = event.phase
			if "ended" == phase then
					myData.playSound("tap")	
					enableMusic = true
					myData.enableMusic = true
					myData.setBg(2,1)
					musicButtonOn.alpha = 0
					musicButtonOff.alpha = 1

			end	
	end
	
local function musicOffEvent (event)
		local phase = event.phase
			if "ended" == phase then
			audio.pause( 1 )	
			audio.pause( 2 )
			audio.pause( 3 )
					enableMusic = false
					myData.enableMusic = false
					musicButtonOff.alpha = 0
					musicButtonOn.alpha = 1

			end	
end


	
--backButtonEvent
local function backButtonReleaseHandler()
	print ( "back button is pressed" )
	myData.playSound("tap")
	storyboard.gotoScene("menu",{
			effect="slideLeft",
			time = 200,
	})
end


function scene:createScene(event)
	screenGroup = self.view

	local bgGroup = display.newGroup( )
	local uiGroup = display.newGroup()
	local buttonGroup = display.newGroup ( )

	screenGroup:insert(bgGroup)
	screenGroup:insert(uiGroup)	
	screenGroup:insert(buttonGroup)			

	local xPos = halfW
	local yPos = 0	

	
	background = display.newImageRect ( "images/bg.png", _W  , _H )
	background.x = _W*.5 ; background.y = _H*.5
	
	soundbox = display.newImageRect ( "images/options_box.png"  ,210, 120 )

	soundbox.x = halfW ; soundbox.y =yPos +150;
	

	
	bgGroup:insert(background)
	uiGroup:insert(soundbox)

		local backButton = widget.newButton( {
			-- 	id = "backButton",
			left =5,
			top = top + 8,
			--label = "Back",
			width = 55,
			height = 30,
			font = native.systemFont,
			fontSize = 18,
			labelColor = {
			default = {0,0,0},
			over = {255,255,255}
		},
			--defaultColor = {201,107,61},
			--overColor = {219,146,85},
			defaultFile = "buttons/BackPress.png",
			overFile = "buttons/BackPressed.png",
			onRelease = backButtonReleaseHandler,
		} )	

		soundButtonOn = widget.newButton 
		{
			x = soundbox.x+50,
			y = soundbox.y+20,
			width = 70,
			height = 30,
			font = native.systemFont,
			fontSize = 18,
			labelColor = {
				default = {0,0,0},
				over = {255,255,255}
			},
			--defaultColor = {201,107,61},
			--overColor = {			
			defaultFile = "images/musicOff.png",
			overFile = "images/musicOffPress.png",
	--		id = "Sound_On",
			onEvent = soundOnEvent,	
		} 
			soundButtonOn.alpha=1
			soundButtonOff = widget.newButton 
		{
			x = soundbox.x+50,
			y = soundbox.y+20,
			width = 70,
			height = 30,
			font = native.systemFont,
			fontSize = 18,
			labelColor = {
				default = {0,0,0},
				over = {255,255,255}
			},
			--defaultColor = {201,107,61},
			--overColor = {219,146,85},

			defaultFile = "images/musicOn.png",
			overFile = "images/musicOnPress.png",
	--		id = "Sound_Off",
			onEvent = soundOffEvent,		
		}
			soundButtonOff.alpha=1

			musicButtonOn = widget.newButton
		{
			x = soundButtonOn.x,
			y = soundButtonOn.y-50,
			width = 70,
			height = 30,
			font = native.systemFont,
			fontSize = 18,
			labelColor = {
				default = {0,0,0},
				over = {255,255,255}
			},
			--defaultColor = {201,107,61},
			--overColor = {219,146,85},

			defaultFile = "images/soundOff.png",
			overFile ="images/soundOffPress.png",
		--	id = "Music_On",
			onEvent = musicOnEvent,
		}

			musicButtonOn.alpha=1
			musicButtonOff = widget.newButton
		{
			x = soundButtonOn.x,
			y = soundButtonOn.y-50,
			width = 70,
			height = 30,
			font = native.systemFont,
			fontSize = 18,
			labelColor = {
				default = {0,0,0},
				over = {255,255,255}
			},
			--defaultColor = {201,107,61},
			--overColor = {219,146,85},

			defaultFile = "images/soundOn.png",
			overFile = "images/soundOnPress.png",
		--	id = "Music_Off",
			onEvent = musicOffEvent,
		}
			musicButtonOff.alpha=1
	
		
--checks if what button will be shown-----------------------------------
	local function initializeButton()
		if enableSound == true then

			soundButtonOn.alpha = 0
			soundButtonOff.alpha = 1

		elseif enableSound == false then

			soundButtonOn.alpha = 1
			soundButtonOff.alpha = 0

		end

		if enableMusic == true then

			musicButtonOn.alpha = 0
			musicButtonOff.alpha =1

		elseif enableMusic == false then

			musicButtonOn.alpha = 1
			musicButtonOff.alpha =0

		end
			print ("button initialization complete")
	end
		
		initializeButton()		

		buttonGroup:insert(soundButtonOn)
		buttonGroup:insert(soundButtonOff)
		buttonGroup:insert(musicButtonOn)
		buttonGroup:insert(musicButtonOff)
		buttonGroup:insert(backButton)	
			

end

function scene:enterScene(event)
	storyboard.removeScene("gamemenu")

			
end

function scene:exitScene(event)
	Runtime:removeEventListener( "key", onKeyEvent )
end

function scene:didExitScene(event)

end

scene:addEventListener ( "createScene", scene )
scene:addEventListener ( "enterScene", scene )
scene:addEventListener ( "exitScene", scene )
scene:addEventListener ( "didExitScene", scene )

return scene