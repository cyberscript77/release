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
CyberScript By donk7413

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

print("CyberScript Initialization...")

cyberscript = { 
    description = "CyberScript",
    version = "0.16000069",
    channel = "stable",
    changelog = "",
    editorDatapackInit = false,
    cache = {},
    arrayDatapack = {},
    datapackRegistry= {}

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
    local f = io.open(filename, "r")
    if f then
        io.close(f)
        return true
    end
    return false
end

function logme(level, msg, force)
    if debugLog or (force == true) then
        local obj = {
            date = os.date('*t'),
            datestring = string.format("[%d-%02d-%02d  %02d:%02d:%02d]", os.date('*t').year, os.date('*t').month, os.date('*t').day, os.date('*t').hour, os.date('*t').min, os.date('*t').sec),
            msg = tostring(msg),
            level = level
        }

        print(obj.msg)

        if logrecordlevel == nil or (logrecordlevel and level <= logrecordlevel) then
            table.insert(logTable, obj)
            spdlog.error(obj.msg)
        end
    end
end

if file_exists("cyberscript.log") then
    io.open("cyberscript.log", "w"):close()
end

cyberscript.loader = dofile('mod/modules/loader')
cyberscript.core = dofile('mod/modules/core')

return cyberscript
