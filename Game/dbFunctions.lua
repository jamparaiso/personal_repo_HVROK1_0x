--this is where database related functions are stored

local sqlite = require("sqlite3");
local path = system.pathForFile( "db.sqlite" , system.DocumentsDirectory ); --path where the db is located
local sql = nil; --variable for sql statements


local M = {}
-- Put all functions below this line

	--handles sqlite functions
	M.DBHandler = function ( sqlStmnt, TableName )

		local db = nil;
		local result = nil;
		local code = nil;
		local message = nil;
		local sqlStmnt_ = sqlStmnt;
		local TBName = TableName;

		--opens the path and put the reference in a variable
		db = sqlite.open(path);

		--execute the sql statement
		result = db:exec(sqlStmnt_);
		code = result;

		--sql succesfully executed
		if (code == 0) then
			print( "Sqlite || " .. TBName .. " successfully created/found" )
			db:close();
			return true;
		--checks whats the error
		elseif (code == 1) then
			--"Error"
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 2) then
			--"Internal";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 5) then
			--"Busy";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 6) then
			--"Locked";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 8) then
			--"ReadOnly";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 11) then
			--"Corrupt";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 12) then
			--"NotFound";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 15) then
			--"Protocol";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 16) then
			--"Empty";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 18) then
			--"TooBig";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 19) then
			--"Constraint";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 20) then
			--"Mismatch";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 24) then
			--"Format";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		elseif (code == 25) then
			--"Range";
			message = db:errmsg();
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
			db:close();
			return false;
		else
			--"UnknownCode"
			print( "Sqlite || Unknown Error" );
			db:close();
			return false;
		end

	end


	--creates a table in the db for the player data
	M.createPlayerDBTable = function ()

		--sql statement
		sql = [[CREATE TABLE IF NOT EXISTS playerData (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			name,
			level,
			status
			);
		]];

		local r = M.DBHandler(sql,"playerData");

		return r;

	end


	M.createQuestionsDBTable = function ()
 
		sql = [[
			CREATE TABLE IF NOT EXISTS gameQuestions (
			question_ID INTEGER PRIMARY KEY AUTOINCREMENT,
			questions,
			answer,
			hint,
			ques_no INTEGER,
			question_category
			);
		]]

		local r = M.DBHandler(sql,"gameQuestions");

		return r;

	end

-----------------------------------------------------------------
return M