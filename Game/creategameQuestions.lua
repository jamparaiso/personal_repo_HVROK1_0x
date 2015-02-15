local sqlite =require ( "sqlite3" )		
		
local M = {}		
		
function creategameQuestions()		
	local path = system.pathForFile ("Orc.sqlite" , system.DocumentsDirectory)		
	local db = sqlite.open(path)		
 		
local sql = [[		
	CREATE TABLE IF NOT EXISTS gameQuestions (		
	question_ID INTEGER PRIMARY KEY AUTOINCREMENT,		
	questions,		
	answer,		
	hint,		
	ques_no INTEGER,		
	question_category		
	);		
	]]		
		
		
 db:exec(sql)		
 db:close()		
 print ( "successfully created creategameQuestions..." )		
end		
		
M.creategameQuestions = creategameQuestions		
		
return M		