-- define a local table to store all references to functions/variables
--this will serve as Global Variable since its not good to use Global variables directly bcos of memory leaks and will make the system slower

local M = {}

local _W = display.viewableContentWidth --dynamic screen width getter
M._W = _W

local _H = display.viewableContentHeight --dynamic screen height getter
M._H = _H

local _HW = _W/2 --half of screen width
M._HW = _HW

local _HH = _H/2 -- half of screen height
M._HH = _HH

local halfW = display.contentCenterX
local halfH = display.contentCenterY

 M.totalHP = 3


local screenW = display.contentWidth
local screenH = display.contentHeight
local areaY = display.screenOriginY
local areaX = display.screenOriginX

local actualW = screenW - 2 * areaX
local actualH = screenH - 2 * areaY

local top = areaY
local bottom = screenH - areaY
local left = areaX

--local selectedLevel = nil
--M.selectedLevel = selectedLevel

--local qID = nil
--M.qID = qID
-------------------------------------------------------------------------------------
local enableSound = true
M.enableSound = enableSound

local enableMusic = true
M.enableMusic = enableMusic




local sounds = {
   
}

--audio.loadStream() — reads in small chunks of an audio file over the course of its duration. It should be used for longer audio tracks like background music. 
--Note that streamed files may have a slightly higher latency cost and CPU cost than files loaded with audio.loadSound().
audio.reserveChannels(4)
M.bg1 = audio.loadStream ( "sound/backMusic.mp3" ) -- game music
M.bg2 = audio.loadStream ( "sound/questionsound.mp3" ) -- question music

audio.play( M.bg1,{loops=-1,channel=1})
audio.pause(1)

audio.play( M.bg2,{loops=-1,channel=2})
audio.pause(2)

audio.setVolume( 1, {loops=-1,channel=2 } )  --set the volume level of channel 1 to 50%


--audio.loadSound() — loads an entire sound into memory. It should be used for shorter audio files that may be used repeatedly throughout the app.
sounds.tap =  audio.loadSound ( "sound/tapsound.mp3") --global tapsound
audio.setVolume( 0.3)  

sounds.letter = audio.loadSound( "sound/letterTap.wav")

sounds.letter2 = audio.loadSound("sound/letterTap2.wav" )

sounds.success1 = audio.loadSound("sound/success.wav" )

sounds.success2 = audio.loadSound("sound/success2.wav")

sounds.coindrop = audio.loadSound("sound/coindrop.mp3")

sounds.wrongSound1 = audio.loadSound("sound/wrong.mp3")

sounds.wrongSound2 = audio.loadSound("sound/wrong2.mp3")

sounds.achiveSound = audio.loadSound( "sound/achieve.mp3")

sounds.spinsound = audio.loadStream("sound/spinWheel.mp3")
audio.play( sounds.spinsound,{loops=-1,channel=3})

audio.pause(3)

sounds.clocksound = audio.loadStream("sound/ticking.wav")
audio.play( sounds.clocksound,{loops=-1,channel=4})

audio.pause(4)

-- audio.play(sounds.letter )

function M.playSound(name)
   if M.enableSound then
      audio.play(sounds[name] )
   end
end

function M.setBg(value1,value2)
   if M.enableMusic then
      audio.pause( value1 )
   -- -- audio.rewind({channe2 = value2}) 
      audio.resume(value2)
   
   end

end


local json = require( "json")

local filename = "data.json"

function M.save()
local value = {coins = M.coins, categories = M.categories, timeStamp=M.timeStamp}
   local path = system.pathForFile( filename, system.DocumentsDirectory )
   local file = io.open(path, "w")
   if ( file ) then
      local contents =json.encode(value)
      file:write( contents )
      io.close( file )
      return true
   else
      print( "Error: could not read ",filename, "." )
      return false
   end
end

function M.load()
   local path = system.pathForFile( filename, system.DocumentsDirectory )
   local contents = ""
   local file = io.open( path, "r" )
   if ( file ) then
      -- read all contents of file into a string
      local contents = file:read( "*a" )
      --local value = tonumber(contents);
      local value = json.decode( contents)
      io.close( file )
      return value
   else
      -- print( "Error: could not read values from ", filename, "." )
   end
   return nil
end


--======= 12hrs = 43200 seconds
--======= 6hrs = 21600 seconds

------------default time spin 12hrs------------
M.timeStamp = os.time() - 43200

--player default coin

M.coins = 150
M.hint = 40
M.score = 0

--Determine how many questions by categories has answered

M.categories ={
	Luzon = {ques_no = 1 , hintTrivia = false , hintLetter = {},isCompleted =false},
}

M.letterhint = {
   
}

-- local x = {}

-- x["name"] = "ronel john"
-- x.name

-- local gameCat = "History"
-- M.categories[gameCat].ques_no


--print(M.categories.History.ques_no)

local tbl = M.load (filename) 
if tbl then 
   M.coins  = tbl.coins 
   M.categories = tbl.categories

end


function M.update (value, target, data)
   print("myData.update")
   local gameCat = M.gameCat

   if gameCat then
      if M.categories[gameCat].isCompleted then
         value = 0 ------------if the category iscompleted no coin added
      end
   end
   
      if M.coins < 999999999 then
         -- M.coins > 999,999,999
         M.coins = M.coins + value

         if M.coins > 999999999 then
            M.coins = 999999999 
         end
      end
   -- print(M.categories[gameCat],gameCat )

   if target == "question" then
      M.categories[gameCat].ques_no = M.categories[gameCat].ques_no + 1--------------------------if answer is correct go to next question
      
      if M.categories[gameCat].ques_no > 100 then -------------------------------Each Categories answered 100 correct questions , question will go 
         M.categories[gameCat].isCompleted = true --------------------------------back again in ques 1 but no game hint' no additional coins, no fb sharing----
         M.categories[gameCat].ques_no = 1
      end

   elseif target == "hintLetter" then
      M.categories[M.gameCat].hintLetter = data
   elseif target == "hintTrivia" then
      M.categories[M.gameCat].hintTrivia = data
   end
   M.save()
end 

-- Finally, return the table to be used locally elsewhere
return M