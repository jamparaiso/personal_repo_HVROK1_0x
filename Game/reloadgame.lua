local storyboard = require("storyboard");
local scene = storyboard.newScene();


function scene:createScene(e)

 
end
	

function scene:enterScene(e)
	storyboard.removeScene( "gamestart" )
	storyboard.gotoScene( "gamestart" )
end

function scene:exitScene(e)

end

function scene:didExitScene(event)

end

scene:addEventListener ( "createScene",scene);
scene:addEventListener ( "enterScene",scene);
scene:addEventListener ( "exitScene",scene);
scene:addEventListener ( "didExitScene", scene )



return scene