local sqlite = require ( "sqlite3" )
local myData = require ( "myData" )

local M = {}

local function loadSelectedQuestions(category)
	local path = system.pathForFile ("Orc.sqlite" , system.DocumentsDirectory)
	local db = sqlite.open(path)
	
	local myTable = {}
	local result = {}
	local sql

	local tblName	

	
local gameCat
	gameCat = myData.gameCat
	
print ( "selected cat -->"..gameCat  )
	
--	print ( "question ID ".. qID )

local ques_no = myData.categories[gameCat].ques_no
	print(ques_no)
	
	 sql = "SELECT * FROM gameQuestions WHERE question_category = '" ..gameCat.."'" .. " AND ques_no = '".. ques_no .."' ;"
	 print(sql)

for row in db:nrows(sql) do
		myTable =  row
end
	
db:close()
	
	result = myTable

	print ("query result: ", result.ques_no )
	print (myTable.img_Path)

	return result
		
	
end

M.loadSelectedQuestions = loadSelectedQuestions

return M