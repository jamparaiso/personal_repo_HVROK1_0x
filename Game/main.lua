
_W = display.viewableContentWidth;
_H = display.viewableContentHeight;



--modules
local storyboard=require ( "storyboard" )
local myData = require ("myData")
local widget = require ( "widget" )
local json = require("json")



local creategameQuestions = require ( "creategameQuestions" )
local addGameQuestions =require ( "addGameQuestions" )


--create game databases
creategameQuestions.creategameQuestions()

--add questions in the database
addGameQuestions.addGameQuestions()



display.setStatusBar( display.HiddenStatusBar ) 
-- myData.gameCat = "Luzon"
storyboard.gotoScene("game")


