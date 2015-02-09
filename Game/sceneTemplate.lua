--MODULES-----------------------------------------------------------------------
--local module = require("module")
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local functions = require( "functions" )
local dbFunctions = require("dbFunctions")
local globals = require( "globals" )
--------------------------------------------------------------------------------

--VARIABLES---------------------------------------------------------------------
   --declare all local variables here

--local var = nil

--------------------------------------------------------------------------------

--FUNCTIONS---------------------------------------------------------------------
local M = {}
   --declare all scene functions here

-- M.functionName = function()
--  statement
-- end
--------------------------------------------------------------------------------

-- "scene:create()" ------------------------------------------------------------
function scene:create( event )

   local sceneGroup = self.view

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.

end
-- scene:create || end --------------------------------------------------------


-- "scene:show()" -------------------------------------------------------------
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      --Remove unused scene
      -- Example: start timers, begin animation, play audio, etc.
   end

end
-- scene:show || end ----------------------------------------------------------


-- "scene:hide()" -------------------------------------------------------------
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
-- scene:destroy || end ----------------------------------------------------------


-- scene listeners ---------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------


return scene