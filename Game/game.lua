
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

local storyboard = require("storyboard");
local widget = require ( "widget" )

local scene = storyboard.newScene();
local myData = require("myData")

local screenGroup
local uiGroup = display.newGroup( )
local timeGroup = display.newGroup( )
local background
local logo

local getTime

local coolTime
local timerEvent1


local onKeyEvent


--Detect the center of any resolution
--local line = display.newLine(halfW,0,halfW,_H)
local function GobackMenu(event)
	if "clicked" ==event.action then
		local i = event.index
			if i ==1 then 
				storyboard.gotoScene("gamemenu",{
					effect ="fade",
					time = 250,
			})
			end
	end
end


local function backmenu(event)	
	myData.playSound("tap")			
	local alert = native.showAlert ( "Game alert!","Are you sure you want to go back in main menu?",{"Yes","No"},GobackMenu)
end

--backButtonEvent
local function GobackMain(event)
	if "clicked" == event.action then
		local i = event.index
			if i == 1 then	
				myData.setBg(2,1)							
				storyboard.gotoScene("gamemenu",{
					effect = "fade",
					time = 250,
				})									
			end
	 end	
end		

--All categories Handler
local function gameCatHandler(event)
	local phase = event.phase
	
	if "ended" == phase then
		myData.playSound("tap")
		if myData.categories[event.target.id].ques_no == 100 then

		end
		-- print(event.target.id)	
		print("Category",myData.categories[event.target.id].ques_no)
		myData.gameCat = event.target.id
		myData.setBg(1,2)
		storyboard.gotoScene("gamestart", {
			effect = "fade",
			time = 250,
		})
	end
end	



function scene:createScene(e)
	screenGroup = self.view

	local bgGroup = display.newGroup( )
	local buttonGroup = display.newGroup ( )		
	local uiGroup = display.newGroup()

	screenGroup:insert( bgGroup)
	screenGroup:insert(uiGroup)
	screenGroup:insert(buttonGroup)
	
	background = display.newImageRect ( "images/map.png", _W  , _H )
	background.x = _W*.5 ; background.y = _H*.5	


	-- catText = display.newImageRect ( "images/cattxt.png",260, 40 )
	-- catText.x = _W*0.5 ; catText.y = 90


	bgGroup:insert(background)
	-- uiGroup:insert(catText)

	local gameComp = true

	for k, v in pairs(myData.categories) do
		print("Check",v.isCompleted)
		if not v.isCompleted then
			gameComp = false
		end
	end




	 local backMenu = widget.newButton( {
		-- 	id = "backButton",
	 	left =9,
	 	top = top + 9,
	 	--label = "Back",
		width = 50,
		height = 50,
		font = native.systemFont,
		fontSize = 18,
		labelColor = {
			default = {0,0,0},
			over = {255,255,255}
		},
		--defaultColor = {201,107,61},
		--overColor = {219,146,85},
		defaultFile = "buttons/menu.png",
		overFile = "buttons/menuoff.png",
		onRelease = backmenu,
	} )	

	 	uiGroup:insert(backMenu)	
		backMenu:addEventListener("tap",backMenu);	 		 		

 	local btnData = {
	 	{id="Luzon",x=left+45,y=top+ 110},

	}	


	for i = 1, 1 do 


	 	local btn  = widget.newButton( {
			id = btnData[i].id,
			x = 75,
			y = 50,
			width = 100,
			height = 100,
			-- font = native.systemFont,
			-- fontSize = 18,
			-- labelColor = {
			-- 	default = {0,0,0},
			-- 	over = {255,255,255}
			-- },
			defaultFile = "buttons/".. string.lower(btnData[i].id).. "press.png",
			overFile = "buttons/".. string.lower(btnData[i].id).. "pressed.png",	
			onRelease = gameCatHandler,
			} ) 		

	    btn.anchorX = 0
	  	btn.anchorY = 0	

	  	buttonGroup:insert( btn)	

	end
end

function scene:enterScene(e)
	storyboard.removeScene( "gamecategory" )	
	storyboard.removeScene( "gamemenu" )
end

function scene:exitScene(event)
	Runtime:removeEventListener( "key", onKeyEvent )
end

function scene:didExitScene(event)
	-- storyboard.removeScene("game")
	
end

scene:addEventListener ( "createScene",scene);
scene:addEventListener ( "enterScene",scene);
scene:addEventListener ( "exitScene",scene);
scene:addEventListener ( "didExitScene", scene )



return scene