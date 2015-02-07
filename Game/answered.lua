print ( "Question Answered" )
local storyboard = require("storyboard");
local widget = require ( "widget" )

local myData = require("myData")
local json = require("json")
local scene = storyboard.newScene();

local enableSound = myData.enableSound
local enableMusic = myData.enableMusic

local screenGroup
local background


function scene:createScene(e)
		screenGroup = self.view

     
	local myTable = {}

		for k,v in pairs(myData.categories) do
			local gameCat = k
			local ques_no = v.ques_no


			if v.isCompleted then
				ques_no = 101
			end

			myTable[#myTable+1] = {name = string.upper(gameCat), tbl = temp, ques_no = ques_no, question_category = gameCat, isCategory = true}
		

	end

    local function onRowRender(event)
    	local id = event.row.id
    	local row = event.row

    	if row.isCategory then
	

	    	for i = 1, 3 do
    			local ques_no = myTable[id].ques_no
		    	local max = myTable[id].tbl[i].max
		    	local name = myTable[id].tbl[i].name


		    	
		    

	    	end


		else
		

	
    			for i=1,3 do	

			     
			    	local ques_no = myTable[id].ques_no
			    	local max = myTable[id].tbl[i].max
			    	local value = myTable[id].tbl[i].value
			    	local previous = myTable[id].tbl[i].previous
			    	if ques_no < max then
			    		if ques_no > previous then
				    		bar.yScale = (ques_no-previous)/value
				    		print("SCALE",bar.yScale)
				    	else
				    		bar.isVisible = false
				    	end
				    else
				    	if i == 3 then
				    		comp.alpha = 1
				    		be.alpha = 1
				    	end
			    	end

			    end
		end



    end






end

function scene:enterScene(e)
	-- storyboard.removeScene("menu")	

end


function scene:exitScene(e)

	Runtime:removeEventListener( "key", onKeyEvent )
end

function scene:didExitScene(event)
end

scene:addEventListener ( "createScene",scene);
scene:addEventListener ( "enterScene",scene);
scene:addEventListener ( "exitScene",scene);
scene:addEventListener ( "didExitScene", scene )


return scene