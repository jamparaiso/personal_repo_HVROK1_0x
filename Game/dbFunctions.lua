--this is where database related functions are stored

local sqlite = require("sqlite3");
local path = system.pathForFile( "db.sqlite" , system.DocumentsDirectory );
local db = nil; --variable for db operation
local dbErrmsg = nil; --variable for sql error msg
local sql = nil; --variable for sql statements
local result = nil; --variable for db operation result

local M = {}
-- Put all functions below this line

	--handles sqlite error
	M.DBErrorHandler = function ( errCode, errmsg, sqlStmnt )
		local code = errCode;
		local sqlStmnt_ = sqlStmnt;
		local message = errmsg;

		--checks whats the error
		if (code == 1) then
			--"Error"
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 2) then
			--"Internal";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 5) then
			--"Busy";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 6) then
			--"Locked";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 8) then
			--"ReadOnly";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );	
		elseif (code == 11) then
			--"Corrupt";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 12) then
			--"NotFound";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 15) then
			--"Protocol";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 16) then
			--"Empty";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 18) then
			--"TooBig";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 19) then
			--"Constraint";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 20) then
			--"Mismatch";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 24) then
			--"Format";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		elseif (code == 25) then
			--"Range";
			print( "Sqlite || Error Code: " .. code .. " " .. message  );
		else
			--"UnknownCode"
			print( "Sqlite || Unknown Error" );
		end
	end

	--creates a table in the db for the player data
	M.createPlayerDBTable = function ()
		--opens the path and put the reference in a variable
		db = sqlite.open(path);
		--sql statement
		sql = [[CREATE TABLE IF NOT EXISTS playerData (
			id INTEGER PRIMARY KEY,
			name,
			level,
			status
			);
		]];
		--execute the sql statement
		result = db:exec(sql);

			if (result == 0) then
				message = "Sqlite || playerData table successfully created/found";
				print( message );
				db:close();
			else
				dbErrmsg = db:errmsg()
				M.DBErrorHandler (result,dbErrmsg,sql);
			end
	end

return M