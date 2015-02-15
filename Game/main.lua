--hides the status bar on iOS devices
display.setStatusBar( display.HiddenStatusBar );

--device width // this is a global variable
_W = display.viewableContentWidth;
--devices height // this is a global variable
_H = display.viewableContentHeight;

--modules
--local composer = require("composer");
local myData = require ("myData");
local dbFunctions = require("dbFunctions");
local globals = require("globals")
local storyboard = require("storyboard")

--creates database for player data
--dbFunctions.createPlayerDBTable();
--creates database for game questions
--dbFunctions.createQuestionsDBTable();

local creategameQuestions = require ( "creategameQuestions" )
local addGameQuestions =require ( "addGameQuestions" )


--create game databases
creategameQuestions.creategameQuestions()

--add questions in the database
addGameQuestions.addGameQuestions()

myData.gameCat = "Luzon"
storyboard.gotoScene("menu")


