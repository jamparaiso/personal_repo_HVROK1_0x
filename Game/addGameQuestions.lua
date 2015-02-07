local sqlite = require ( "sqlite3" )
local questionTable = require ( "questionTable" )

local M = {}


--populate GameQuestions in DB
local function addGameQuestions()
	local path = system.pathForFile ("Orc.sqlite",system.DocumentsDirectory)
	local db = sqlite.open(path)
	local sql
	local gameTable = {}
	gameTable = questionTable.gameQuestions
	
	print ("total gameTable: " .. #gameTable)
	
	local totalRows = 0
		for row in db:nrows("SELECT * FROM gameQuestions") do
			totalRows = totalRows +1
		end
		
	if (totalRows == 0) then
		for z=1, #gameTable do
		sql = [[
			INSERT INTO gameQuestions(questions, answer, hint, ques_no, question_category)
		VALUES (']] .. gameTable[z].questions ..
		[[',']] .. gameTable[z].answer ..		
		[[',']] .. gameTable[z].hint ..	
		[[',']] .. gameTable[z].ques_no ..	
		[[',']] .. gameTable[z].question_category ..	

		[[');]]
		db:exec(sql)
		
		end	
	end
db:close()		
end
M.addGameQuestions = addGameQuestions	



return M

