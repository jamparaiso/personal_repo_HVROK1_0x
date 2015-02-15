
print ("gamecategory module-----------------------------------------")

local sprite = require ("SpearSprite")
local storyboard = require("storyboard");
local widget = require ( "widget" )
-- local backMusic = require ( "backMusic" )
local myData = require("myData")
local getQuestions = require ( "getQuestions" )
local scene = storyboard.newScene();
local physics = require("physics")
physics.start()
physics.setGravity( 0, 4 )
-- math.randomseed(os.time())
local backMusic = myData.backMusic
local enableSound = myData.enableSound
local enableMusic = myData.enableMusic
local tapSoundEffect
-----------------------------------------------------------------------------variable declaration----------------------------------------------------------------------------
-----------------------------------------------------------------------------screen height and width, this was declared in myData.lua-------------------------------------------
local halfW = display.contentCenterX
local halfH = display.contentCenterY


local screenW = display.contentWidth
local screenH = display.contentHeight
local areaY = display.screenOriginY
local areaX = display.screenOriginX

local actualW = screenW - 2 * areaX
local actualH = screenH - 2 * areaY

local top = areaY
local bottom = screenH - areaY
local left = areaX
local right = screenW - areaX

--local screenGroup
local buttonGroup = display.newGroup ( )
local background
local coins
local hintButton
local selected_category

local answer
local answerOrig

local name = {}
local lettergroup
local slotgroup

local ques_no
local questions
local arr_str = {}

local hintTrivia
local hintLetter = {}
local gameData = {}

local slot
local slot1
local letter 
local selectletter
local txtdiff
local gameComp

local isComplete


local function onConfirmBack(event)
	if "clicked" == event.action then
		local i = event.index
			if i == 1 then	
				myData.setBg(2,1)	
				audio.play( myData.bg2,{loop=-1})			
				storyboard.gotoScene("menu",{
					effect = "fade",
					time = 250,
				})							
			end
	end	
end		

local function GobackMenu(event)
	myData.playSound("tap")	
	local alert = native.showAlert ( "Quit Game","Are you sure you want to go back in menu?",{"Yes","No"},onConfirmBack)
end

local function backButtonReleaseHandler(event)
	local phase = event.phase
		if phase == "ended" then	
			myData.playSound("tap")			
			GobackCat()
		end
end	


------------------------------------------------------------------------------------end of function------------------------------------------------------------------
local heartStorage = {}

local function hpDisplayer(varIndex)

	-- print(varIndex)
	--local heartStorage[varIndex] = display.newImage("images/Heart.png")
	
	-- heartStorage[varIndex].x = display.contentCenterX + 110
	-- heartStorage[varIndex].y = display.contentCenterY
	-- bgGroup:insert(heartStorage[varIndex])
	-- print(heartStorage[1])
	-- for x=1, #heartStorage do
	-- 	print(heartStorage[x])
	-- end
end


function scene:createScene(e)

	screenGroup = self.view

	bgGroup = display.newGroup( )
	slotgroup=display.newGroup( )
	lettergroup=display.newGroup( )
	imagegroup = display.newGroup( )
	uiGroup = display.newGroup()
	quesGroup = display.newGroup( )	
	displayGroup = display.newGroup( )
	spriteGroup = display.newGroup()


-----------------------------------------------------------add all images to a group, by doing this it easy to remove them from the memory------------------------------------
	screenGroup:insert( bgGroup)
	screenGroup:insert( slotgroup )
	screenGroup:insert( lettergroup )
	screenGroup:insert(quesGroup)			
	screenGroup:insert(uiGroup)	
	screenGroup:insert(imagegroup)				
	screenGroup:insert(displayGroup)	
	screenGroup:insert(spriteGroup)
-- ------------------------------------------------------------end of screenGroup------------------------------------------------
	local Background1 = display.newImage("images/stone.png")
		Background1.x = 200
		Background1.y = 271
		bgGroup:insert(Background1)

	local background = display.newImage("images/background1.png")
		background.x = display.contentCenterX
		background.y = 110
		background:scale(1.1,0.9)
		bgGroup:insert(background)

	local ground = display.newImage("images/ground.png", screenW, 82)
		ground.anchorX = 0
		ground.anchorY = 2
		ground.x, ground.y = -200, 663

	physics.addBody( ground, "static", {friction = 0.3})

	bgGroup:insert(ground)
------------------------------------------------Heart Hp-----------------------------------
	local pos = 0;
-- display heart
	local totalHp = tonumber( myData.totalHP)
	print( totalHp )
	for j=1,totalHp do
		-- tmpVarHeart = "heart_"..j
		
		-- hpDisplayer(j)


	local tmpVarHeart = display.newImage("images/heart.png")
	table.insert(heartStorage,tmpVarHeart)
	
	heartStorage[j].x = 33 + pos
	heartStorage[j].y = 150
	heartStorage[j]:scale(.2,.2)
	bgGroup:insert(heartStorage[j])
	pos = pos + 20


	end
-- end of heart

	----------------------------------------------Potions-------------------------------------------
local letterpotion = display.newImage("images/letterpots.png")
		letterpotion.x = 50
		letterpotion.y = 290
		letterpotion:scale(.2,.2)
		imagegroup:insert(letterpotion)

local hppotion = display.newImage("images/hppots.png")
		hppotion.x = 20
		hppotion.y = 289
		hppotion:scale(.2,.2)
		imagegroup:insert(hppotion)
-----------------------------------------------Buttons------------------------------------------------
	local GiveUpButton = widget.newButton
	{
	width = 80,
	height = 20,
	x = halfW+195,
	y = halfH+140,
	defaultFile = "buttons/giveupon.png",
	overFile = "buttons/giveupoff.png",
	}

	local MenuButton = widget.newButton
	{
	x = 438,
	y = 20,
	width = 70,
	height = 25,
	defaultFile = "buttons/menu.png",
	overFile = "buttons/menuoff.png",
	onEvent = GobackMenu,
	}

	bgGroup:insert(GiveUpButton)
	bgGroup:insert(MenuButton)

----------------------------------------Sprites------------------------------------------
local w,h = display.contentWidth, display.contentHeight
	local Spear2 = display.newImage( "Sprites/Spear2.png" )
	local Spear = display.newImage( "Sprites/Spear.png" )
	Spear.id ="Spear"
	Spear2.id ="Spear2"
	Spear2.alpha = 0
	local w,h = display.contentWidth, display.contentHeight
	local orc = display.newImage("Sprites/Orc1.png")
	local orc2 = display.newImage("Sprites/Orc2.png")
    orc2.id="Orc2"
	orc2.alpha = 0
	orc.id="Orc"

			--transition.fadeIn( Spear2,{time=1500,delay=0, x=(400),y=(500)})
			--transition.fadeOut( Spear2,{time=1500, delay=3000,x=(-0),y=(500)})
			--transition.fadeOut( Spear, {time=1500, x=(400),y=(500)} )
			--transition.fadeIn( Spear, { time=1500, delay=3000, x=(0),y=(500)})
			--transition.fadeOut(orc,{time=1500, delay =3000, x=(1000),y=(500)})

	Spear2:translate( 0, 0)
	Spear:translate( 50, 210)

	orc:translate(410, 210)
	orc2:translate(410,210)

	spriteGroup:insert(Spear)
	spriteGroup:insert(Spear2)
	spriteGroup:insert(orc)
	spriteGroup:insert(orc2)
----------------------------loadSelectedQuestion from SqliteDB
	gameData = getQuestions.loadSelectedQuestions(selected_category)	
	questions = (gameData["questions"])
	answer = string.lower(gameData["answer"])
	answerOrig = answer

	local quesPos = halfW
	local value = actualW - quesPos -10
	local border = 5

	local options = {

		text= questions,
		x = 0,
		y = 0,
		width = value - border*2,
		font = native.systemFont,
		fontSize = 16,

	}


	local gameQuestion1 = display.newText(questions, 0,0, native.systemFont, 18)
	gameQuestion1:setFillColor(0)

	print("TEST",gameData ["answer"])

	gameQuestion1.x = halfW ;  gameQuestion1.y = halfH - 100

 	quesGroup:insert(gameQuestion1)    


	----getting the lenght of answer and --generate random letter--*************************************************
	local s = answer --answer

	local len = string.len(answer)
	local str 
	local j

	for j=1,len do
		str = s:sub(j,j)
		arr_str[j]= str	
	end


	hintLetter = myData.categories[myData.gameCat].hintLetter

		for i = 1, #arr_str do
			local j = math.random( 1,#arr_str)
			arr_str[i], arr_str[j] = arr_str[j], arr_str[i]

			if not hintLetter[i] then hintLetter[i] = " " end
		end

	local max = #arr_str
	local rowMax = max
	local gap = 25
	local xPos = halfW - (rowMax/2*29) + 25
	local yPos = bottom - 18
	local startpos = xPos
	

	for i=1, #arr_str do
		
		slot = display.newImageRect( "images/bg_slot.png", 23, 23 )
		slot.x = xPos; slot.y = yPos -30
		slotgroup:insert( slot )

		slot1 = display.newImageRect( "images/bg_slot.png", 23, 23 )
		slot1.x = xPos; slot1.y = yPos 
		slotgroup:insert( slot1)

		print("ERROR",arr_str[i])
		letter = display.newImageRect("letters/uc/".. arr_str[i] ..".png",23,23)	
		letter.name = arr_str[i] 
		letter.x = xPos; letter.y = yPos
		letter.idBg = i
		lettergroup:insert( letter)

		xPos = xPos + gap

local function showAnim( )

	print("success")
		myData.playSound("success1")	

		local choice
		local comment
		local comment1
		local comment5


		displayGroup.y = halfH
		displayGroup.x = halfW


		print("TESTING", gameData['ques_no'] )

 
		
end




local function answered(str, coinsreward)

	if str then
			achieveGroup = display.newGroup( )
			screenGroup:insert( achieveGroup)


				showAnim()

		end	

		
		myData.update(coinsreward, "question")
		hintLetter = {}
		hintTrivia = false
		
		myData.update (0,"hintLetter",hintLetter)
		myData.update (0,"hintTrivia",hintTrivia)	
	
end

-------------------------------------Submit Button----------------------
local function SubmitButtonEventHandler(event)
	local phase = event.phase

	if event.phase == "ended" then
	---------------------------------------------------------Determine if correct answer and gain coins-------------------------------------------------------------------

local function checkAns()
    local str = ""
    local count = 0


    for i = 1 , rowMax do
    	if name[i] then
    		str = str..name[i]
    		count = count + 1
    	end
    end		    
    -- print(str, #name)		
	if str == answer then
		local gameComp = true

		for k, v in pairs(myData.categories) do
			print("Check",v.isCompleted)
			if not v.isCompleted then
				gameComp = false
			end
		end

		print("gameComp",gameComp)

		if gameComp or myData.categories[myData.gameCat].isCompleted then
			answered(nil,0)
			-- elseif gameData['ques_no'] ==30 then
			-- 	myData.playSound("achiveSound")
			-- elseif gameData['ques_no'] ==60 then
			-- 	myData.playSound("achiveSound")
		
			-- elseif gameData['ques_no'] ==100 then
			-- 	myData.playSound("achiveSound")
			
		else
			answered(nil,0)
		end

		if gameData['ques_no'] == 100 then
			myData.playSound("letter")	
			storyboard.gotoScene( "game")
			else
			storyboard.gotoScene( "reloadgame")
		end

		-- showAnim()
	else
---------------------------------------------------------------if the answer is wrong then code below----------------------------------			
				print("fail",answer,str)
				if count == #arr_str then
					local j = math.random( 1,2 )
					myData.playSound("wrongSound"..j)	

					local translistener = function ( )
						storyboard.gotoScene( "reloadgame")
					end
					if (myData.totalHP ~= 0) then
						myData.totalHP = myData.totalHP - 1
					end
					transition.to( orc, {x=20, y=210 , onComplete = translistener} )
					--transition.to( orc2, {x=20, y=210, onComplete = translistener} )

					




					-- native.showAlert( "Game Alert!", "Sorry Try Again",{ "Ok" }, function() end)
				end				
					
			end

		end
		checkAns() 
	end
end


	local SubmitButton = widget.newButton
	{
	width = 80,
	height = 20,
	x = halfW+195,
	y = halfH+115,
	defaultFile = "buttons/submitbuttonon.png",
	overFile = "buttons/submitbuttonoff.png",
	onEvent = SubmitButtonEventHandler,
	}
	bgGroup:insert(SubmitButton)

---------------------------------------------------------------------------------------END------------------------------------------------------------------
		function selectletter(letter,char,isHinted)
		
	    local index=1
	    	for i =1 , #arr_str do 
	    		if not name[i] then
	    			index = i
	    			break
	    		end
	    	end
	    	if char then
	    		index = char
	    	end
	    	if isHinted then letter.isHinted = true
			   letter:setFillColor(.1, 1, 0)
	    	end
	        letter.y = letter.y - 30
	        letter.x = startpos + (index -1)* 25 
---------------------------------------------------------------------------------kung ung letter is hinted na nd na sya ulit babalik sa dati pag reload ng game
			for i=1, lettergroup.numChildren do
				if lettergroup[i].isSelected and lettergroup[i].x == letter.x and not lettergroup[i].isHinted then
					lettergroup[i].y = lettergroup[i].y + 25
					lettergroup[i].isSelected = false
					lettergroup[i].x = startpos + (lettergroup[i].idBg-1) *25
					name[lettergroup[i].idAns]= nil
				end
			end


	        letter.isSelected = true
	        letter.idAns = index
	    	name[index] = letter.name
	    	
			print("\n\nSelect Letter",letter.name,#name)
			for i=1, #name do
				print(i,name[i])
			end
		end

		---position for correct letter--------------------------------------------------------------------------------------
		local function listener(event)
		    local letter = event.target
			-- myData.playSound("letter2")	
		    if not letter.isSelected then
		    	myData.playSound("letter2")	
				selectletter(letter)  
		    elseif not letter.isHinted then
		    	myData.playSound("letter")	
		        letter.y = 302--letter.y + 25
		        letter.isSelected = false
		        letter.x = startpos + (letter.idBg-1) *25
		        name[letter.idAns]= nil
		        print("removed",letter.idAns,#name,name[1],letter.x,letter.y)
		    end


		   -- print(name)
		   return true
		end

		    letter.isSelected = false
		    letter:addEventListener("tap",listener)
	end
	

------------------------------------------------------Hint Letter
	--for i=1, #hintLetter do
		--if hintLetter[i] ~= " " then
			--for j=1, lettergroup.numChildren do
				--if lettergroup[j].name == hintLetter[i] and not lettergroup[j].isSelected then
					--answerOrig = string.gsub( answerOrig, lettergroup[j].name, " ", 1 )
					--selectletter(lettergroup[j],i,true)
					--break
				--end
			--end
		--end
	--end	   
	      
	    -- displayVal() -- display player data in scene



 


end


function scene:enterScene(e)
	storyboard.removeScene( "reloadgame" )
	storyboard.removeScene( "game" )

end


function scene:exitScene(e)

end

function scene:didExitScene(event)
	--storyboard.purgeScene( "gamecategory" )
end

scene:addEventListener ( "createScene",scene);
scene:addEventListener ( "enterScene",scene);
scene:addEventListener ( "exitScene",scene);
scene:addEventListener ( "didExitScene", scene )



return scene