--[[
	
	
	
	_____      _               _____           _       _   
	/ ____|    | |             / ____|         (_)     | |  
	| |    _   _| |__   ___ _ _| (___   ___ _ __ _ _ __ | |_ 
	| |   | | | | '_ \ / _ \ '__\___ \ / __| '__| | '_ \| __|
	| |___| |_| | |_) |  __/ |  ____) | (__| |  | | |_) | |_ 
	\_____\__, |_.__/ \___|_| |_____/ \___|_|  |_| .__/ \__|
	__/ |                                 | |        
	|___/                                  |_|        
	
	
	
	
	-- ------------------------------------------------------------------
	-- -------------------------------How It Works-------------------------------
	-- ------------------------------------------------------------------
	CyberScript By RedRockStudio
	
	
	How the mod works :
	
	An player import scripts at JSON format. At mod init, we read theses Json and turn them into lua tables. 
	
	an script ususally contains 
	-Trigger and trigger requirement : when and how the script should be performed
	-Actions list : what the script do.
	
	at every OnUpdate, the mod will check the available script that can be perform by checking trigger and requirement
	
	when trigger and requirement are meet, the Script Execution Engine (SEE) will store the action list in an thread and will perform it at next OnUpdate.
	
	At every On refresh, the mod will call refresh() function that contains 2 functions stored in scripting.lua :
	CompileCachedThread()
	ScriptExecutionEngine()
	
	theses functions manage the Script Execution Engine (SEE) that will actions list from scripting.lua.
	
	Depending of the executed action, the thread can have several sub thread or make an new other thread.
	
]]--

-- -------------------------------------------------------------------------------------
-----------------------------Init and Imperative functions------------------------------
-- -------------------------------------------------------------------------------------

print("CyberScript Initialisation...")

cyberscript = { 
	description = "CyberScript",
		version = "0.16000069",
		channel = "stable",
		changelog =""
		
	}

GameController = {}

currentSave = {}

logTable = {}
logLevel = 1
logFilter = ""
debugLog = false

function dofile (filename)
      local f = assert(loadfile(filename))
      return f()
    end
	
	
function file_exists(filename)
	local f = io.open(filename,"r")
	if f then
		io.close(f)
		return true
	end
	return false
end


function logme(level,msg) 
	
	local obj = {}
	obj.date = os.date('*t')
	obj.datestring = "["..obj.date.year.."-"..obj.date.month.."-"..obj.date.day.."  "..obj.date.hour.." : "..obj.date.min .." : "..obj.date.sec.."]"
	obj.msg = tostring(msg)
	obj.level = level
	
	if(level == 1) then
		print(obj.msg)
		
		
	end
	
	if logrecordlevel == nil or (logrecordlevel ~= nil and level <= logrecordlevel )then
		table.insert(logTable,obj)
		spdlog.error(obj.msg)
	end 
end


	
if file_exists("cyberscript.log") then
	io.open("cyberscript.log", "w")
end

cyberscript.core = dofile('modules/core')



function loadModule()
	
	
	
	

	
	
	
	

	cyberscript.db       = dofile("modules/db.lua")
	cyberscript.modpack   = dofile("modules/modpack.lua")
	cyberscript.npc      = dofile("modules/npc.lua")
	cyberscript.utils    = dofile("modules/utils.lua")
	cyberscript.place    = dofile("modules/place.lua")
	cyberscript.relation = dofile("modules/relation.lua")
	cyberscript.gang     = dofile("modules/gang.lua")
	cyberscript.quest   = dofile("modules/quest.lua")
	cyberscript.location   = dofile("modules/location.lua")
	cyberscript.housing = dofile('modules/housing.lua')
	cyberscript.saves = dofile('modules/saves.lua')
	cyberscript.AV = dofile('modules/av.lua')
	cyberscript.editor = dofile('modules/editor.lua')
	cyberscript.see = dofile('modules/see.lua')
	cyberscript.scripting = dofile('modules/scripting.lua')
	cyberscript.observer = dofile('modules/observer_function.lua')
	cyberscript.ui = dofile('modules/ui.lua')
	cyberscript.api = dofile('modules/api.lua')
	
	--external library

	modLoaded = true
end



return cyberscript