logme(1,"CyberScript Core Hot Reload module loaded")

function loadModule()
	
	
	actionorder = {
		"helperTitle",
		"helper",
		"name"
	}
	
	triggerorder = {
		"helperTitle",
		"help",
		"helper"
		
		
	}
	
	cyberscript.triggertemplate       = dofile("mod/data/triggertemplate.lua")
	
	
	arraytriggertemplate = {}
	for k,v in pairs(cyberscript.triggertemplate ) do 
		----logme(2,actiontemplate[i].helperTitle)
		
		for prop,value in pairs(v)do
			
			local contains = false
			for i,key in ipairs(triggerorder) do
				
				if(key == prop) then
					contains = true
				
				end
			
			end
			
			if(contains == false ) then
				
				table.insert(triggerorder,prop)
			
			end
		
		end
		
		arraytriggertemplate[v.helperTitle] = v.name
		
		
	end
	
	
	table.sort(arraytriggertemplate)
	
	
	cyberscript.actiontemplate       = dofile("mod/data/actiontemplate.lua")
	actionorder = {}
	arrayactiontemplate = {}
	for k,v in pairs(cyberscript.actiontemplate) do 
		----logme(2,actiontemplate[i].helperTitle)
		
		for prop,value in pairs(v)do
			
			local contains = false
			for i,key in ipairs(actionorder) do
				
				if(key == prop) then
					contains = true
				
				end
			
			end
			
			if(contains == false ) then
				
				table.insert(actionorder,prop)
			
			end
		
		end
		
		arrayactiontemplate[v.helperTitle] = v.name
		
		
	end
	
	table.sort(arrayactiontemplate)
	
	local sessionFile = io.open('mod/data/actiontemplate.json', 'w')

	sessionFile:write(JSON:encode_pretty(cyberscript.actiontemplate))
	sessionFile:close()


	local sessionFile = io.open('mod/data/triggertemplate.json', 'w')

	sessionFile:write(JSON:encode_pretty(cyberscript.triggertemplate))
	sessionFile:close()
	
	
	
	triggertemplate = {}
	
	triggertemplate = cyberscript.triggertemplate
	
	
	
	
	
	actiontemplate = {}
	
	actiontemplate = cyberscript.actiontemplate
	
	
	
	
	contexttemplate = {}
	local f = assert(io.open("mod/data/contexttemplate.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	contexttemplate = trydecodeJSOn(encdo, f ,"mod/data/contexttemplate.json")
	f:close()
	
	
	
	
	
	cyberscript.entitieshash       = dofile("mod/data/entitieshash.lua")
	cyberscript.entities       = dofile("mod/data/entities.lua")
	cyberscript.workspot       = dofile("mod/data/workspot.lua")
	
	cyberscript.db       = dofile("mod/modules/db.lua")
	cyberscript.modpack   = dofile("mod/modules/modpack.lua")
	cyberscript.npc      = dofile("mod/modules/npc.lua")
	cyberscript.utils    = dofile("mod/modules/utils.lua")
	cyberscript.place    = dofile("mod/modules/place.lua")
	cyberscript.relation = dofile("mod/modules/relation.lua")
	cyberscript.gang     = dofile("mod/modules/gang.lua")
	cyberscript.quest   = dofile("mod/modules/quest.lua")
	cyberscript.sound = dofile('mod/modules/sound.lua')
	cyberscript.location   = dofile("mod/modules/location.lua")
	cyberscript.housing = dofile('mod/modules/housing.lua')
	cyberscript.saves = dofile('mod/modules/saves.lua')
	cyberscript.AV = dofile('mod/modules/av.lua')
	
	QuestManager = dofile('mod/modules/quest_manager.lua')
	
	if file_exists("mod/modules/editor.lua") then
		cyberscript.editor = dofile('mod/modules/editor.lua')
		logme(1,"CyberScript : Editor Lua founded, loading editor")
	end
	
	if file_exists("editor/editor.lua") then
	
	--	cyberscript.editor2_variable = dofile('editor/editor_variable.lua')
		cyberscript.editor2 = dofile('editor/editor.lua')
		logme(1,"CyberScript : Editor 2.0 Lua founded, loading editor")
	end
	cyberscript.see = dofile('mod/modules/see.lua')
	cyberscript.scripting = dofile('mod/modules/scripting.lua')
	cyberscript.observer = dofile('mod/modules/observer_function.lua')
	cyberscript.ui = dofile('mod/modules/ui.lua')
	cyberscript.api = dofile('mod/modules/api.lua')
	cyberscript.loader = dofile('mod/modules/loader')

	--external library

	modLoaded = true
end