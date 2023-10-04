logme(3,"CyberScript Studio : module loaded")


local editor = {}
editor.editorfunction={}

scripttemplate = {}
local f = assert(io.open("editor/scripttemplate.json"))

lines = f:read("*a")

encdo = lines
scripttemplate = trydecodeJSOn(encdo, f ,"editor/scripttemplate.json")
f:close()

editor.fact= dofile("mod/data/factdump.lua")
--print("editor.fact  "..#editor.fact  )
local currentindex = 1
editor.migrationscript = {} 
editortrigger = nil
editoraction = nil

editor.user_template = {}

for i,v in ipairs(datapackObjectType) do
	editor.user_template[v] = {}
	if(file_exists("editor/script_migration/"..v..".json"))then
		editor.migrationscript[v] = {}
		
		local f = assert(io.open("editor/script_migration/"..v..".json"))
		
		lines = f:read("*a")
		
		encdo = lines
		f:close()
		editor.migrationscript[v] = trydecodeJSOn(encdo, f ,"editor/script_migration/"..v..".json")
	end
end

local reader = dir("editor/user_template")
if(reader ~= nil) then
	for i=1, #reader do 
		if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
			
			local foo = io.open("editor/user_template/"..reader[i].name)
			local lines = foo:read("*a")
			if(lines ~= "") then
				local jsonf = trydecodeJSOn(lines,foo,"editor/user_template/"..reader[i].name)
				
				
				
				editor.user_template[jsonf.type][jsonf.tag] = jsonf
				
			end
			foo:close()
		end
	end
end




function initEditorDatapack()
	local namespace = "editor"
	arrayDatapack[namespace] = {}
	arrayDatapack[namespace].enabled = true
	arrayDatapack[namespace].metadata = {}
	arrayDatapack[namespace].metadata.name = "Editor"
	arrayDatapack[namespace].metadata.desc = "Editor"
	arrayDatapack[namespace].metadata.author = "CyberScript"
	arrayDatapack[namespace].metadata.file = "editor"
	arrayDatapack[namespace].metadata.tag = "editor"
	arrayDatapack[namespace].metadata.version = cyberscript.version
	arrayDatapack[namespace].metadata.flags = {"compile","essential"}
	
	
	for i=1,#datapackObjectType do
		arrayDatapack[namespace][datapackObjectType[i]] = {}
	end
	--print("Editor : Datapack init success")
	cyberscript.editorDatapackInit = true
end




--Manager Function

function toggleEditorUI(windows)
	
	editorUIManager[windows] = not editorUIManager[windows]
	
end



function scriptWindowsManager()
	
	for types,values in pairs(currentScript) do
		
		for k,v in pairs(values) do
			editor.scriptWindows(k,v)
		end
	end
	
	
	for k,v in pairs(currentJson) do
		editor.JsonEditor(k,v)
	end
	
	
end

--Main Windows

function editor.editorWindows()
	
	
	
	if(cyberscript.editorDatapackInit == false) then
		initEditorDatapack()
	end
	
	
	ImGui.SetNextWindowPos(1000, 0, ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 200, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("Cyberscript Studio V."..editorversion), true, ImGuiWindowFlags.MenuBar)
	
	
	if ImGui.BeginMenuBar() then
		
		if ImGui.MenuItem("Project") then
			
			
			toggleEditorUI("datapackscriptmanager")
			
		end	
		
		if ImGui.BeginMenu("Scripting") then
			if ImGui.MenuItem("Script") then
				
				toggleEditorUI("loadScriptSelector")
				
				
			end	
			
			if ImGui.MenuItem("Trigger Tester") then
				
				toggleEditorUI("triggerTester")
				
				
			end	
			
			if ImGui.MenuItem("Action Tester") then
				
				toggleEditorUI("actionTester")
				
				
			end	
			ImGui.EndMenu()
		end	
		
		
		if ImGui.BeginMenu("World") then
			
			
			
			if ImGui.MenuItem("Entity Manager")  then
				
				toggleEditorUI("entityInspector")
				
			end
			
			
			if ImGui.MenuItem("Camera Manager")  then
				toggleEditorUI("cameraInspector")
			end
			
			
			if ImGui.MenuItem("Mappin Manager")  then
				
				toggleEditorUI("mappinInspector")
				
			end
			
			if ImGui.MenuItem("Time Manager")  then
				toggleEditorUI("timecontrol")
			end
			
			if ImGui.MenuItem("Player Position and Player Camera")  then
				toggleEditorUI("playerposition")
			end
			
			if ImGui.MenuItem("TP to Custom MapPin") then
				
				if(ActivecustomMappin ~= nil) then
					
					local pos = ActivecustomMappin:GetWorldPosition()
					TeleportPlayerToPosition(pos.x,pos.y,pos.z)
				end
			end
			ImGui.EndMenu()
		end	
		
		if ImGui.BeginMenu("Tools") then
			
			if ImGui.MenuItem("Script Execution Engine Viewer")  then
				
				toggleEditorUI("seeView")
				
			end
			
			if ImGui.MenuItem("Current CyberScript Quest Viewer")  then
				
				toggleEditorUI("currentQuestView")
				
			end
			
			if ImGui.MenuItem("Current Bounty Viewer")  then
				
				toggleEditorUI("currentBountyView")
				
			end
			
			if ImGui.MenuItem("Variable Editor")  then
				
				toggleEditorUI("variableEditor")
				
			end
			
			if ImGui.MenuItem("Color Picker")  then
				
				toggleEditorUI("colorPicker")
				
			end
			
			if ImGui.MenuItem("Custom Sound Tester")  then
				
				toggleEditorUI("customsoundtester")
				
			end
			
			if ImGui.MenuItem("Custom Radio Tester")  then
				
				toggleEditorUI("customradiotester")
				
			end
			
			if ImGui.MenuItem("AMM Decor Template Converter")  then
				
				toggleEditorUI("ammdecorconvert")
				
			end
			
			if ImGui.MenuItem("Fact Checker")  then
				
				toggleEditorUI("factcheck")
				
			end
			
			if ImGui.MenuItem("AI Tester")  then
				
				toggleEditorUI("aiTester")
				
			end
			
			if ImGui.MenuItem("Performance Checker")  then
				
				toggleEditorUI("perfTester")
				
			end
			
			ImGui.EndMenu()
		end
		
		if ImGui.BeginMenu("Mods") then
			
			if ImGui.MenuItem("Cyberscript Mod Manager")  then
				
				toggleEditorUI("datapackmanager")
				
			end
			
			if ImGui.MenuItem("Hot Reload CyberScript and Studio mods")  then
				
				loadModule()
				
			end
			
			if ImGui.MenuItem("Hot Reload Studio Variable (You will loose current unsaved items !!)")  then
				
				cyberscript.editor2_variable = dofile('editor/editor_variable.lua')
				
			end
			
			if ImGui.MenuItem("Data Browser")  then
				
				toggleEditorUI("moddata")
				
			end
			
			if ImGui.MenuItem("Log Browser")  then
				
				toggleEditorUI("modLog")
				
			end
			
			if ImGui.MenuItem("Dev Zone")  then
				
				toggleEditorUI("devZone")
				
			end
			
			if ImGui.MenuItem("Donk Zone")  then
				
				toggleEditorUI("donkView")
				
			end
			
			ImGui.EndMenu()
		end
		
		if ImGui.MenuItem("Windows Manager") then
			
			toggleEditorUI("windowsmanager")
			
			
		end
		
		
		ImGui.EndMenuBar()
	end
	
	ImGui.Text("Usefuls Links : ")
	ImGui.Text("Nexus link : ") ImGui.SameLine() editortext = ImGui.InputText("##nexuslink", "https://www.nexusmods.com/cyberpunk2077/mods/6475", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	ImGui.Text("Support the mod <3")
	
	ImGui.Text("Patreon link : ") ImGui.SameLine() editortext =ImGui.InputText("##patreonlink", "https://www.patreon.com/Cyberscript77", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	
	
	ImGui.End()
	
	ImGui.PopStyleVar(2)
	
	
	
	
	
	
	
	
	
	
	
end

function teleportentityinspector(entityinspector,obj,enti)
	
	local poss = Vector4.new( entityinspector.teleport.x, entityinspector.teleport.y,  entityinspector.teleport.z,1)
	
	
	local angless = EulerAngles.new(entityinspector.teleport.roll, entityinspector.teleport.pitch,  entityinspector.teleport.yaw)
	
	if obj.isitem == nil or obj.isitem == false then
		
		if obj.isWorkspot == false or obj.isWorkspot == nil then
			local teleportCmd = NewObject('handle:AITeleportCommand')
			teleportCmd.position = poss
			teleportCmd.rotation = entityinspector.teleport.yaw
			teleportCmd.doNavTest = false
			
			enti:GetAIControllerComponent():SendCommand(teleportCmd)
			else
			--print("mark1")
			Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(obj.id), poss,  angless)
		end
		
		else
		
		if obj.id then
			
			local id = obj.id
			local testitem = Game.FindEntityByID(id)
			if(testitem ~= nil) then 
				testitem:GetEntity():Destroy()
				
				
				
				local transform = Game.GetPlayer():GetWorldTransform()
				
				transform:SetPosition(poss)
				transform:SetOrientationEuler(angless)
				obj.id = exEntitySpawner.Spawn(objs.tweak, transform)
				
				
				
				
				
				
				else
				local success, message = pcall(function ()
					Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(objs.id), poss,  angless)
					
				end)
				if success == false then
					--print(message)
				end
			end
			else 
			--print("noID")	
		end
		
	end
	
end

function editor.newScriptSelector()
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(300, 300, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("New script"), true, ImGuiWindowFlags.MenuBar)
	if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
		toggleEditorUI("newScriptSelector")
	end
	ImGui.EndMenuBar()
	end
	
	if ImGui.BeginCombo(getLang("Type :"), newscript.type) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for k,v in ipairs(datapackObjectType) do
			
			
			if ImGui.Selectable(v, false) then
				
				
				newscript.type = v
				ImGui.SetItemDefaultFocus()
			end
			
			
			
			
		end
		
		
		ImGui.EndCombo()
	end
	
	newscript.tag = ImGui.InputText(getLang("Tag :"), newscript.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	if(newscript.tag ~= "" and newscript.type ~= "") then
		if ImGui.Button("Create")  then
			
			if(currentScript[newscript.type] == nil or currentScript[newscript.type][newscript.tag] == nil) then
				local obj = {}
				obj.scripttype = newscript.type
				obj.new = true
				
				if(currentScript[newscript.type] == nil) then
					currentScript[newscript.type] = {}
				end
				
				currentScript[newscript.type][newscript.tag] = obj
				
				toggleEditorUI("newScriptSelector")
			end
		end
		else
		ImGui.Text("You must choose a Type and put a tag for create a script")
	end
	
	
	
	
	ImGui.End()
	
	
	
	
	
	ImGui.PopStyleVar(2)
	
	
end

function editor.windowsmanager()
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 600, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("Editor Windows Manager"), true, ImGuiWindowFlags.MenuBar)
	
	
	if ImGui.BeginMenuBar() then
		
		
		
		
		if ImGui.MenuItem("Close") then
			toggleEditorUI("windowsmanager")
		end
		
		ImGui.EndMenuBar()
	end
	
	
	if ImGui.BeginChild("Opened scripts Windows ", 500, 600, true, ImGuiWindowFlags.NoMove) then
		
		ImGui.Text("Opened Scripts :")
		
		for types,values in pairs(currentScript) do
			
			for k,v in pairs(values) do
				if ImGui.TreeNode(v.scripttype.." :"..k) then
					
					
					
					if ImGui.Button("Focus") then
						
						ImGui.SetWindowFocus(v.scripttype.." :"..k)
						
					end
					
					ImGui.SameLine()
					
					if ImGui.Button("Close (without saving)") then
						
						currentScript[types][k] = nil
						
					end
					
					ImGui.Spacing()
					
					if ImGui.Button("Reduce") then
						
						ImGui.SetWindowCollapsed(v.scripttype.." :"..k,true)
						
					end
					
					ImGui.SameLine()
					
					if ImGui.Button("Expand") then
						
						ImGui.SetWindowCollapsed(v.scripttype.." :"..k,false)
						
					end
					
					
					ImGui.TreePop()
				end
			end
		end
		
		ImGui.Separator()
		
		ImGui.Text("Opened editor windows :")
		
		for k,v in pairs(editorUIManager) do
			
			if(v == true and k ~= "editorWindows") then
				if ImGui.TreeNode(editorUIManagerName[k]) then
					
					
					if ImGui.Button("Focus") then
						
						ImGui.SetWindowFocus(editorUIManagerName[k])
						
					end
					
					ImGui.SameLine()
					
					if ImGui.Button("Close") then
						
						toggleEditorUI(k)
						
					end
					
					ImGui.Spacing()
					
					if ImGui.Button("Reduce") then
						
						ImGui.SetWindowCollapsed(editorUIManagerName[k],true)
						
					end
					
					ImGui.SameLine()
					
					if ImGui.Button("Expand") then
						
						ImGui.SetWindowCollapsed(editorUIManagerName[k],false)
						
					end
					
					
					ImGui.TreePop()
				end
			end
		end
		
		
		
		
		
		
		
		
		
		ImGui.EndChild()
	end
	
	
	
	
	
	
	ImGui.End()
	
	
	ImGui.PopStyleVar(2)
	
end

function editor.loadScriptSelector()
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 600, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("Script Browser"), true, ImGuiWindowFlags.MenuBar)
	if ImGui.BeginMenuBar() then
		
		
		if ImGui.MenuItem("New script")  then
			
			toggleEditorUI("newScriptSelector")
			
		end
		
		
		if ImGui.MenuItem("Datapack Building")  then
			
			toggleEditorUI("datapackbuilding")
			
		end
		
		
		if ImGui.MenuItem("Close") then
			toggleEditorUI("loadScriptSelector")
		end
		
		ImGui.EndMenuBar()
	end
	
	assetbrowsersearch = ImGui.InputText(getLang("Filter"), assetbrowsersearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Spacing()
	if ImGui.BeginChild("Existing scripts", 500, 600, true, ImGuiWindowFlags.NoMove) then
		showScriptArray(cyberscript.cache["mission"], "mission",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["interact"], "interact",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["choice"], "choice",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["place"], "place",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["fixer"], "fixer",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["scene"], "scene",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["hud"], "hud",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["faction"], "faction",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["poi"], "poi",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["event"], "event",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["codex"], "codex",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["webpage"], "webpage",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["email"], "email",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["functions"], "function",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["housing"], "housing",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["help"], "help",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["interfaces"], "interface",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["npc"], "npc",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["phone_dialog"], "phone conversation",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["shard"], "shard",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["node"], "node",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["lang"], "lang",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["path"], "path",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["circuit"], "circuit",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["radio"], "radio",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["sound"], "sound",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["texture"], "texture",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["corpo"], "corpo",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["setting"], "setting",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["housing_template"], "housingtemplate",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["character"], "characterarchive",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["quickhack"], "quickhack",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["garage"], "garage",assetbrowsersearch,currentproject)
		showScriptArray(displayHUD, "display hud",assetbrowsersearch,currentproject)
		ImGui.EndChild()
	end
	
	
	
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
end


function editor.loadProjectScriptSelector()
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 600, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("Project Browser"), true, ImGuiWindowFlags.MenuBar)
	
	ImGui.Text("Datapack Info :")
	arrayDatapack[currentproject].metadata.name = ImGui.InputText(getLang("editor_Name"), arrayDatapack[currentproject].metadata.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	arrayDatapack[currentproject].metadata.desc = ImGui.InputText(getLang("editor_desc"), arrayDatapack[currentproject].metadata.desc, 500, ImGuiInputTextFlags.AutoSelectAll)
	arrayDatapack[currentproject].metadata.author = ImGui.InputText(getLang("editor_Build_Author"), arrayDatapack[currentproject].metadata.author, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	arrayDatapack[currentproject].metadata.tag = ImGui.InputText(getLang("editor_tag"), arrayDatapack[currentproject].metadata.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	arrayDatapack[currentproject].metadata.version = ImGui.InputText(getLang("editor_Build_Version"), arrayDatapack[currentproject].metadata.version, 100 , ImGuiInputTextFlags.AutoSelectAll)
	
	editor.listStringNode(getLang("editor_Build_Flags"),getLang("editor_Build_Flags_msg"),arrayDatapack[currentproject].metadata,"flags",false)
	
	if ImGui.Button("Update info to json") then
		
		local obj =  deepcopy(arrayDatapack[currentproject].metadata,nil)
		obj.file = obj.tag..".zip"
		local file = assert(io.open("datapack/"..currentproject.."/desc.json", "w"))
		local stringg = JSON:encode_pretty(obj)
		
		file:write(stringg)
		file:close()
	end
	ImGui.Separator()
	arrayDatapack[currentproject].enabled, pressed = ImGui.Checkbox("Enabled", arrayDatapack[currentproject].enabled)
	
	if(pressed) then
		
		if(v.enabled == true) then
			EnableDatapack(currentproject)
			
			else
			DisableDatapack(currentproject)
			LoadDataPackCache()
			
			
		end
		
	end
	ImGui.Separator()			
	
	if ImGui.Button("Reload Cache") then
		LoadDataPackCacheSingle(currentproject)
		
	end
	ImGui.SameLine()
	if ImGui.Button("Update Cache") then
		local enabled = arrayDatapack[currentproject].enabled
		loadDatapackObject(currentproject)
		arrayDatapack[currentproject].enabled = enabled
		arrayDatapack[currentproject].state = nil
		logme(1,getLang("datapack_updated_01")..currentproject..getLang("datapack_updated_02"),true)
		arrayDatapack[currentproject].cachedata={}
		arrayDatapack[currentproject].cachedata.CacheVersion=cacheVersion
		arrayDatapack[currentproject].cachedata.modVersion=cyberscript.version
		exportCompiledDatapackFolder(currentproject,"Updated cache")
		LoadDataPackCacheSingle(currentproject)
		
		
	end
	ImGui.SameLine()
	if ImGui.Button("Recreate Cache") then
		
		ImportDataPackFolder(currentproject)
		exportCompiledDatapackFolder(currentproject,"From Editor")
		LoadDataPackCacheSingle(currentproject)
		
	end
	
	
	ImGui.Separator()
	
	
	if ImGui.BeginMenuBar() then
		
		
		if ImGui.MenuItem("New script")  then
			
			toggleEditorUI("newScriptSelector")
			
		end
		
		
		
		if ImGui.MenuItem("Close") then
			toggleEditorUI("loadProjectScriptSelector")
			
		end
		
		ImGui.EndMenuBar()
	end
	
	if(arrayDatapack[currentproject].enabled) then
		assetbrowsersearch = ImGui.InputText(getLang("Filter"), assetbrowsersearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Spacing()
		if ImGui.BeginChild("Existing scripts", 500, 600, true, ImGuiWindowFlags.NoMove) then
			showScriptArray(cyberscript.cache["mission"], "mission",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["interact"], "interact",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["choice"], "choice",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["place"], "place",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["fixer"], "fixer",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["scene"], "scene",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["hud"], "hud",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["faction"], "faction",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["poi"], "poi",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["event"], "event",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["codex"], "codex",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["webpage"], "webpage",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["email"], "email",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["functions"], "function",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["housing"], "housing",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["help"], "help",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["interfaces"], "interface",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["npc"], "npc",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["phone_dialog"], "phone conversation",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["shard"], "shard",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["node"], "node",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["lang"], "lang",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["path"], "path",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["circuit"], "circuit",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["radio"], "radio",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["sound"], "sound",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["texture"], "texture",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["corpo"], "corpo",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["setting"], "setting",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["housing_template"], "housingtemplate",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["character"], "characterarchive",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["quickhack"], "quickhack",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["garage"], "garage",assetbrowsersearch,currentproject)
			showScriptArray(displayHUD, "display hud",assetbrowsersearch,currentproject)
			showScriptArray(cyberscript.cache["ai"], "ai",assetbrowsersearch,currentproject)
			ImGui.EndChild()
		end
		
		
		else
		
		ImGui.Text("Enable the project for see items")
	end
	
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
end

function editor.datapackscriptmanager()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Project Windows"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("datapackscriptmanager")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result =  pcall(function()
			
			if currentproject~= nil then ImGui.Text("Current Loaded Project : "..currentproject)end
			if ImGui.TreeNode("Mods") then
				
				for k,v in pairs(arrayDatapack) do
					if( k ~= "editor" and k ~= "cyberscript") then
						if ImGui.TreeNode(k) then
							
							ImGui.Text("Tag".." : "..tostring(v.metadata.tag))
							ImGui.Text("Name".." : "..tostring(v.metadata.name))
							ImGui.Text("Author".." : "..tostring(v.metadata.author))
							ImGui.Text("Version".." : "..tostring(v.metadata.version))
							ImGui.Text("Desc".." : "..tostring(v.metadata.desc))
							ImGui.Text("Flags :")
							for i,flag in ipairs(v.metadata.flags) do
								ImGui.Text(flag)
							end
							
							
							if ImGui.Button("Open this project") then
								
								currentproject = k
								toggleEditorUI("loadProjectScriptSelector")
							end
							
							if ImGui.Button("Unload this project") then
								
								currentproject = nil
								
							end
							
							ImGui.TreePop()
						end
					end
				end
				ImGui.TreePop()
			end
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
		
	end
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
	
end

function editor.loadScriptSelector()
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 600, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("Script Browser"), true, ImGuiWindowFlags.MenuBar)
	if ImGui.BeginMenuBar() then
		
		
		if ImGui.MenuItem("New script")  then
			
			toggleEditorUI("newScriptSelector")
			
		end
		
		
		if ImGui.MenuItem("Datapack Building")  then
			
			toggleEditorUI("datapackbuilding")
			
		end
		
		
		if ImGui.MenuItem("Close") then
			toggleEditorUI("loadScriptSelector")
		end
		
		ImGui.EndMenuBar()
	end
	
	assetbrowsersearch = ImGui.InputText(getLang("Filter"), assetbrowsersearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Spacing()
	if ImGui.BeginChild("Existing scripts", 500, 600, true, ImGuiWindowFlags.NoMove) then
		showScriptArray(cyberscript.cache["mission"], "mission",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["interact"], "interact",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["choice"], "choice",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["place"], "place",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["fixer"], "fixer",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["scene"], "scene",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["hud"], "hud",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["faction"], "faction",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["poi"], "poi",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["event"], "event",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["codex"], "codex",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["webpage"], "webpage",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["email"], "email",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["functions"], "function",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["housing"], "housing",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["help"], "help",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["interfaces"], "interface",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["npc"], "npc",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["phone_dialog"], "phone conversation",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["shard"], "shard",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["node"], "node",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["lang"], "lang",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["path"], "path",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["circuit"], "circuit",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["radio"], "radio",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["sound"], "sound",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["texture"], "texture",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["corpo"], "corpo",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["setting"], "setting",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["housing_template"], "housingtemplate",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["character"], "characterarchive",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["quickhack"], "quickhack",assetbrowsersearch,currentproject)
		showScriptArray(cyberscript.cache["garage"], "garage",assetbrowsersearch,currentproject)
		showScriptArray(displayHUD, "display hud",assetbrowsersearch,currentproject)
		ImGui.EndChild()
	end
	
	
	
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
end


function editor.scriptWindows(tag,script)
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(1200, 500, ImGuiCond.Once) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang(script.scripttype.." :"..tag), true, ImGuiWindowFlags.MenuBar)
	
	
	
	ImGui.Text("Type : "..script.scripttype)
	local flags = ImGuiTabBarFlags.Reorderable + ImGuiTabBarFlags.AutoSelectNewTabs
	if ImGui.BeginTabBar("EditorTabs", flags) then
		
		ImGui.PushStyleColor(ImGuiCol.Tab, 0.889, 0.589, 0.589, 0.4)
		ImGui.PushStyleColor(ImGuiCol.TabActive,   0.889, 0.589, 0.589, 0.6)
		ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
		--main
		if ImGui.BeginTabItem(tag) then
			ImGui.PopStyleColor(1)
			
			editor.editorfunction[script.scripttype](script,tag,script.scripttype)
			ImGui.EndTabItem()
		end
		ImGui.PopStyleColor(1)
		ImGui.PopStyleColor(1)
		
		--specific
		if(script.scripttype == "mission") then
			
			
			
			
			for k,v in pairs(currentObjective) do
				if(v.contextscript == tag) then
					editor.objectives(k,v)
				end
			end
			
			
		end
		
		if(script.scripttype == "place") then
			
			
			
			
			for k,v in pairs(currentPlacesRooms) do
				if(v.contextscript == tag) then
					editor.rooms(k,v)
				end
			end
			
			
			
			for k,v in pairs(currentItems) do
				if(v.contextscript == tag) then
					editor.items(k,v)
				end
			end
			
			
			
		end
		
		if(script.scripttype == "housing") then
			
			
			
			
			
			
			
			for k,v in pairs(currentItems) do
				if(v.contextscript == tag) then
					editor.items(k,v)
				end
			end
			
			
			
		end
		
		if(script.scripttype == "housing_template") then
			
			
			
			
			
			
			
			for k,v in pairs(currentItems) do
				if(v.contextscript == tag) then
					editor.items(k,v)
				end
			end
			
			
			
		end
		
		if(script.scripttype == "choice") then
			
			
			
			
			for k,v in pairs(currentDialogOptions) do
				if(v.contextscript == tag) then
					editor.dialogoptions(k,v)
				end
			end
			
			
		end
		
		if(script.scripttype == "interfaces") then
			
			
			
			
			for k,v in pairs(currentInterfaceControl) do
				if(v.contextscript == tag) then
					editor.uicontrols(k,v)
				end
			end
			
			
		end
		
		if(script.scripttype == "phone_dialog") then
			
			
			
			
			for k,v in pairs(currentPhoneConversationeditor) do
				if(v.contextscript == tag) then
					editor.phoneconversation(k,v)
				end
			end
			
			for k,v in pairs(currentPhoneConversationMessage) do
				if(v.contextscript == tag) then
					editor.phoneconversationmessage(k,v)
				end
			end
			
			
			for k,v in pairs(currentPhoneConversationMessageChoice) do
				if(v.contextscript == tag) then
					editor.phoneconversationmessagechoice(k,v)
				end
			end
			
			
			
		end
		
		
		--action,trigger,context
		for k,v in pairs(currentAction) do
			
			if(v.contextscript == tag) then
				editor.actions(k,v)
			end
		end
		
		for k,v in pairs(currentTrigger) do
			if(v.contextscript == tag) then
				editor.triggers(k,v)
			end
		end
		
		
		for k,v in pairs(currentContext) do
			
			if(v.contextscript == tag) then
				editor.contexts(k,v)
			end
		end
		
		
		for k,v in pairs(currentContextProp) do
			if(v.contextscript == tag) then
				editor.contextprops(k,v)
			end
		end
		
		for k,v in pairs(currentContextPropValue) do
			if(v.contextscript == tag) then
				editor.contextpropvalues(k,v)
			end
		end
		
		
		
		
		
		
		
		
		
		
		ImGui.EndTabBar()
	end
	
	
	
	ImGui.End()
	
	
	
	
	
	ImGui.PopStyleVar(2)
	
	
	
	
end

function editor.ammdecorconvert()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	ImGui.Begin(getLang("AMM Decor Template Converter"), true, ImGuiWindowFlags.MenuBar) 
	
	if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
		toggleEditorUI("ammdecorconvert")
	end
	ImGui.EndMenuBar()
	end
	
	ImGui.Text("This tool convert your amm decor template into cyberscript housing script.")
	local status, result =  pcall(function()
		
		if ImGui.TreeNode("Availables Templates") then
			local reader = dir("editor/ammtemplate")
			if(reader ~= nil) then
				
				for i=1, #reader do 
					
					
					if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
						
						if ImGui.TreeNode(reader[i].name) then
							
							
							
							
							if ImGui.Button("Convert") then
								
								local value = ""
								local f = io.open("editor/ammtemplate/"..reader[i].name)
								local lines = f:read("*a")
								if(lines ~= "") then
									value = trydecodeJSOn(lines,f,"editor/ammtemplate/"..reader[i].name)
									
								end
								f:close()
								if(value ~= "") then
									local statutfile = true
									
									local newobj = {}
									newobj.target = value.props[1].tag
									newobj.trigger = {}
									newobj.tag = reader[i].name:gsub(".json", "")
									newobj.trigger.auto = {}
									newobj.trigger.auto.name = "auto"
									newobj.requirement = {}
									local requirement = { "auto" }
									
									table.insert(newobj.requirement,requirement)
									
									newobj.items = {}
									newobj.gameid = "fb721b23723385bfd5cb959ad14961d6"
									
									
									for i,prop in ipairs(value.props) do
										
										
										
										local csprop = {}
										csprop.HouseTag = prop.tag
										
										
										local testtt = amm_entities[prop.entity_id]
										if(testttt ~= nil) then
											
											csprop.Tag = amm_entities[prop.entity_id].entity_path
											csprop.Id = prop.tag.."_"..amm_entities[prop.entity_id].entity_path.."_"..prop.uid
											
											else
											
											csprop.Tag = prop.tag
											csprop.Id = prop.tag.."_".."unknown".."_"..prop.uid
											
										end
										csprop.Title = prop.name
										csprop.ItemPath = prop.template_path
										csprop.appearance = prop.app
										
										local pos = loadstring("return "..prop.pos, '')()
										
										csprop.X = pos.x
										csprop.Y = pos.y
										csprop.Z = pos.z
										
										csprop.Yaw = pos.yaw
										csprop.Pitch = pos.pitch
										csprop.Roll = pos.roll
										csprop.gameid = "fb721b23723385bfd5cb959ad14961d6"
										csprop.scale =loadstring("return "..prop.scale, '')()
										
										
										for y,light in ipairs(value.lights) do
											
											if(light.uid == prop.uid) then
												
												csprop.color = loadstring("return "..light.color, '')() 
												csprop.angles = loadstring("return "..light.angles, '')() 
												
												
												
												csprop.radius = light.radius
												csprop.intensity = light.intensity
												
												
											end
											
										end
										
										
										
										table.insert(newobj.items,csprop)
										
									end
									
									
									
									cyberscript.cache["housing"][newobj.tag] = {}
									cyberscript.cache["housing"][newobj.tag].data = newobj
									cyberscript.cache["housing"][newobj.tag].file = "editor"
									cyberscript.cache["housing"][newobj.tag].datapack = "editor"
									cyberscript.cache["housing"][newobj.tag].scripttype = "housing"
								end
								
							end
							
							
							ImGui.TreePop()
						end
						
					end
					
					
					
				end
			end
			ImGui.TreePop()
		end
		
		
		
	end)
	
	if status == false then
		
		
		logme(10,result)
		spdlog.error(result)
	end
	
	
	
	
	
	
	
	
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
end


function editor.moddata()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Mod Data"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("moddata")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result =  pcall(function()
			
			if ImGui.TreeNode("Group") then
				for k,v in pairs(cyberscript.GroupManager) do
					
					local group = v
					if ImGui.TreeNode(group.tag) then
						
						ImGui.Text("Tag : "..group.tag)
						
						ImGui.Text("Entities : "..#group.entities)
						
						ImGui.TreePop()
					end
				end
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Current loaded Interface") then
				for k,v in pairs(currentInterfaceWidget) do
					
					local group = v
					
					if ImGui.TreeNode(k) then
						
						ImGui.Text("Tag : "..k)
						
						ImGui.Text("Controls : "..#group.controls)
						
						if ImGui.Button("Unload") then
							currentInterfaceWidget[k] = nil
						end
						
						
						ImGui.TreePop()
					end
					
					
					
				end
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			if ImGui.TreeNode("Entities") then
				for k,v in pairs(cyberscript.EntityManager) do
					
					local enti = v
					if ImGui.TreeNode(k) then
						
						for key,prop in pairs(enti) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end
						if((k ~= "last_spawned") and (k ~= "last_killed") and (k ~= "lookatentity")) then
							if ImGui.Button("Despawn") then
								
								despawnEntity(k)
								
								
							end
						end
						ImGui.TreePop()
					end
				end
				
				if ImGui.Button("Despawn ALL")  then
					
					despawnAll()
				end
				
				
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Mappin") then
				for k,v in pairs(mappinManager) do
					
					
					if ImGui.TreeNode(k) then
						
						for key,prop in pairs(v) do
							
							if(type(prop) ~= "table") then
								ImGui.Text(key.." : "..tostring(prop))
								else
								
								--ImGui.Text(key.." : "..tostring(dump(prop)))
								
							end
						end
						if ImGui.Button("Despawn") then
							
							deleteMappinByTag(k)
							
							
						end
						if ImGui.Button("Teleport At")  then
							
							
							
							TeleportPlayerToPosition(v.position.x,v.position.y,v.position.z)
							
							
						end
						
						ImGui.TreePop()
					end
				end
				
				
				if ImGui.Button("Despawn ALL")  then
					for k,v in pairs(mappinManager) do
						deleteMappinByTag(k)
					end
				end
				
				
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Items Spawned") then
				for i,v in ipairs(currentItemSpawned) do
					
					local enti = v
					if ImGui.TreeNode(enti.tag) then
						
						for key,prop in pairs(enti) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end
						
						ImGui.TreePop()
					end
				end
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Setting") then
				for k,v in pairs(currentSave.arrayUserSetting) do
					
					
					if ImGui.TreeNode(k) then
						
						ImGui.Text("Value : "..tostring(v))
						
						ImGui.TreePop()
					end
				end
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Interact Group") then
				for k,v in ipairs(currentInteractGroup) do
					
					local enti = v
					ImGui.Text(v)
				end
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.Button("Refresh Interact Group")  then
				
				getInteractGroup()
			end
			
			
			showArray(displayHUD, "display hud")
			if ImGui.Button("Refresh Displayed HUD")  then
				
				loadHUD()
			end
			ImGui.Separator()
			ImGui.Text("Possible Interact : "..#possibleInteract)
			ImGui.Text("Possible Interact Display : "..#possibleInteractDisplay)
			ImGui.Separator()
			
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
		
	end
	
	
	
	
	ImGui.End()
	
	ImGui.PopStyleVar(2)
	
	
end

function editor.customsoundtester()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Custom Sound Tester"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("customsoundtester")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result =  pcall(function()
			ImGui.Text("Current timestamp : "..os.time(os.date("!*t")))
			if ImGui.TreeNode("Current Loaded Sounds") then
				for k,v in pairs(cyberscript.soundmanager) do
					
					local enti = v
					if ImGui.TreeNode(k) then
						
						for key,prop in pairs(enti) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end
						
						
						if ImGui.Button("Stop") then
							
							Stop(k)
							
							
						end
						
						ImGui.TreePop()
					end
				end
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Custom Sounds") then
				for k,v in pairs(cyberscript.cache["sound"]) do
					
					local enti = v
					if ImGui.TreeNode(k) then
						
						for key,prop in pairs(enti) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end
						
						
						if ImGui.Button("Play") then
							
							PlaySound(v.data,false,false)
							
						end
						ImGui.SameLine()
						if ImGui.Button("Stop") then
							
							Stop(k)
							
							
						end
						
						ImGui.TreePop()
					end
				end
				ImGui.TreePop()
			end
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
		
	end
	
	
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
end


function editor.customradiotester()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Custom Radio Tester"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("customradiotester")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result =  pcall(function()
			
			if ImGui.TreeNode("Current Loaded Radio") then
				
				if(currentRadio ~= nil) then
					
					
					
					
					local enti = currentRadio
					if ImGui.TreeNode(k) then
						
						for key,prop in pairs(enti) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end
						
						
						if ImGui.Button("Next") then
							if(currentRadio.playedmusic ~= "" and currentRadio.playedmusic ~= nil) then
								
								Stop(currentRadio.playedmusic)
								
							end
							
						end
						ImGui.SameLine()
						if ImGui.Button("Stop Radio") then
							if(currentRadio.playedmusic ~= "" and currentRadio.playedmusic ~= nil) then
								
								Stop(currentRadio.playedmusic)
								currentRadio = nil
							end
							
							
						end
						
						ImGui.TreePop()
					end
					
					
					
				end
				
				ImGui.TreePop()
			end
			
			ImGui.Separator()
			
			if ImGui.TreeNode("Custom Radios") then
				for k,v in pairs(cyberscript.cache["radio"]) do
					
					local enti = v
					if ImGui.TreeNode(k) then
						
						for key,prop in pairs(enti) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end
						
						
						if ImGui.Button("Play") then
							
							currentRadio = v
							
							
						end
						
						
						ImGui.TreePop()
					end
				end
				ImGui.TreePop()
			end
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
		
	end
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
	
end

function editor.datapackmanager()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("CS Mod Manager"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("datapackmanager")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result =  pcall(function()
			
			if ImGui.TreeNode("Mods") then
				
				for k,v in pairs(arrayDatapack) do
					if ImGui.TreeNode(k) then
						
						ImGui.Text("Tag".." : "..tostring(v.metadata.tag))
						ImGui.Text("Name".." : "..tostring(v.metadata.name))
						ImGui.Text("Author".." : "..tostring(v.metadata.author))
						ImGui.Text("Version".." : "..tostring(v.metadata.version))
						ImGui.Text("Desc".." : "..tostring(v.metadata.desc))
						ImGui.Text("Flags :")
						for i,flag in ipairs(v.metadata.flags) do
							ImGui.Text(flag)
						end
						
						v.enabled, pressed = ImGui.Checkbox("Enabled", v.enabled)
						
						if(pressed) then
							
							if(v.enabled == true) then
								EnableDatapack(k)
								LoadDataPackCacheSingle(k)
								else
								DisableDatapack(k)
								
								LoadDataPackCache()
								
							end
							
						end
						
						if ImGui.Button("Reload Cache") then
							LoadDataPackCacheSingle(k)
							
						end
						ImGui.SameLine()
						if ImGui.Button("Update Cache") then
							local enabled = arrayDatapack[k].enabled
							loadDatapackObject(k)
							arrayDatapack[k].enabled = enabled
							arrayDatapack[k].state = nil
							logme(1,getLang("datapack_updated_01")..k..getLang("datapack_updated_02"),true)
							arrayDatapack[k].cachedata={}
							arrayDatapack[k].cachedata.CacheVersion=cacheVersion
							arrayDatapack[k].cachedata.modVersion=cyberscript.version
							exportCompiledDatapackFolder(k,"Updated cache")
							LoadDataPackCacheSingle(k)
							
							
						end
						ImGui.SameLine()
						if ImGui.Button("Recreate Cache") then
							
							ImportDataPackFolder(k)
							exportCompiledDatapackFolder(k,"From Editor")
							LoadDataPackCacheSingle(k)
							
						end
						
						ImGui.TreePop()
					end
				end
				
				ImGui.TreePop()
			end
			
			if ImGui.Button("Reload Cache") then
				CheckandUpdateDatapack()
				
			end
			if ImGui.Button("Recreate Cache") then
				ImportDataPack()
				CheckandUpdateDatapack()
				LoadDataPackCache()
				
			end
			
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
		
	end
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
	
end

function editor.seeView()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Script Execution Engine"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("seeView")
		end
		ImGui.EndMenuBar()
		end
		
		ImGui.TextColored(0.79, 0.40, 0.29, 1, "tick is .."..tostring(tick))
		ImGui.TextColored(0.79, 0.40, 0.29, 1, "Current Controller is .."..tostring(currentController))
		--	ImGui.TextColored(0.79, 0.40, 0.29, 1, "garbage size is .."..tostring(collectgarbage("count")))
		if ImGui.TreeNode("Direct Execution registry") then
			for k,v in pairs(directWorkerTable) do
				
				
				if ImGui.TreeNode(k) then
					
					ImGui.Text("Tag : "..v.tag)
					
					ImGui.Text("Actions : "..#v.actionlist)
					
					if ImGui.Button("Unsubscribe") then
						directWorkerTable[k] = nil
					end
					
					ImGui.TreePop()
				end
			end
			ImGui.TreePop()
		end
		
		ImGui.Separator()
		
		if ImGui.TreeNode("Direct Action Execution registry") then
			for k,v in pairs(directActionsWorkerTable) do
				
				
				if ImGui.TreeNode(k) then
					
					ImGui.Text("Tag : "..v.tag)
					
					ImGui.Text("Actions : "..#v.actionlist)
					
					if ImGui.Button("Unsubscribe") then
						directActionsWorkerTable[k] = nil
					end
					
					ImGui.TreePop()
				end
			end
			ImGui.TreePop()
		end
		
		ImGui.Separator()
		
		if ImGui.Button("Toggle automatic thread running") then
			autoScript = not autoScript
		end
		ImGui.Text("Automatic Mode : "..tostring(autoScript))
		
		ImGui.Separator()
		
		if ImGui.Button("Force LUA exception if script get error") then
			forcecrashSEE = not forcecrashSEE
		end
		ImGui.Text("Force LUA exception : "..tostring(forcecrashSEE))
		
		if ImGui.Button("Reset pending actions (Script)") then
			workerTable = {}
			despawnAll()
		end
		ImGui.Spacing()
		ImGui.Spacing()
		
		if ImGui.Button("Manual script Step") then
			CompileCachedThread()
			ScriptExecutionEngine()
		end
		
		-- local status, result =  pcall(function()
		for k,v in pairs(workerTable) do 
			
			if ImGui.TreeNode("Name : "..k) then
				
				local tag = k
				ImGui.Text("Started At : "..workerTable[k].started_at)
				ImGui.Text("Last Update : "..workerTable[k].last_update)
				local index = workerTable[k]["index"]
				
				local list = workerTable[k]["action"]
				
				local parent = workerTable[k]["parent"]
				
				local source = workerTable[k]["source"]
				
				local pending = workerTable[k]["pending"]
				
				local started = workerTable[k]["started"]
				
				local disabled = workerTable[k]["disabled"]
				
				local quest = workerTable[k]["quest"]
				
				local executortag = workerTable[k]["executortag"]
				ImGui.Text("index : "..index)
				ImGui.Text("list : "..#list)
				ImGui.Text("parent : "..parent)
				ImGui.Text("source : "..source)
				ImGui.Text("pending : "..tostring(pending))
				ImGui.Text("started : "..tostring(started))
				ImGui.Text("disabled : "..tostring(disabled))
				
				if quest ~= nil then
					ImGui.Text("quest : "..tostring(quest))
				end
				ImGui.Text("Executor Tag : "..executortag)
				if(list[index] ~= nil) then
					ImGui.Text("Current Action : "..list[index].name)
				end
				ImGui.TreePop()
			end
			ImGui.SameLine()
			if ImGui.Button("Clear") then
				workerTable[k] = nil
				
			end
			ImGui.SameLine()
			if ImGui.Button("dump") then
				local sessionFile = io.open(k..".json", 'w')
				
				sessionFile:write(JSON:encode_pretty(workerTable[k]["action"]))
				sessionFile:close()
				
			end
		end
		-- end)
		
		-- if status == false then
		
		
		-- logme(1,result)
		-- spdlog.error(result)
		-- end
		
		
		
	end
	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
end


function editor.donkView()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Donk space"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("donkView")
		end
		ImGui.EndMenuBar()
		end
		
		
	end
	
	if ImGui.Button("observerthread "..tostring(observerthread))  then
		
		observerthread = not observerthread
		
	end
	
	if ImGui.Button("mainrefresh "..tostring(mainrefresh))  then
		
		mainrefresh = not mainrefresh
		
	end
	
	if ImGui.Button("seerefresh "..tostring(seerefresh))  then
		
		seerefresh = not seerefresh
		
	end
	
	if ImGui.Button("mainrefreshstep1 "..tostring(mainrefreshstep1))  then
		
		mainrefreshstep1 = not mainrefreshstep1
		
	end
	
	if ImGui.Button("mainrefreshstep2 "..tostring(mainrefreshstep2))  then
		
		mainrefreshstep2 = not mainrefreshstep2
		
	end
	if ImGui.Button("mainrefreshstep3 "..tostring(mainrefreshstep3))  then
		
		mainrefreshstep3 = not mainrefreshstep3
		
	end
	
	if ImGui.Button("mainrefreshstep4 "..tostring(mainrefreshstep4))  then
		
		mainrefreshstep4 = not mainrefreshstep4
		
	end
	
	if ImGui.Button("mainrefreshstep5 "..tostring(mainrefreshstep5))  then
		
		mainrefreshstep5 = not mainrefreshstep5
		
	end
	
	if ImGui.Button("moddisabled "..tostring(moddisabled))  then
		
		moddisabled = not moddisabled
		
	end
	if ImGui.Button("Setup AI ")  then
		if(ScheduleChatCompletionRequest ~= null) then
			ScheduleChatCompletionRequest({{"User", ""}});
			else
			print("ai not found")
		end
	end
	if ImGui.Button("test AI ")  then
		if(ScheduleChatCompletionRequest ~= null) then
			ScheduleChatCompletionRequest({
				{"User", "You are in cyberpunk 2077 world. I'm acting as V and you as bartender in Lizzie's bar in Kabuki. You know last news about gangs and street rumors. Act normally but bored "},
				{"User", "What's happen in kabuki ?"}
			});
			else
			print("ai not found")
		end
	end
	
	if ImGui.Button("Get AI ")  then
		
		print(GetLastAnswerContent());
		
	end
	
	
	
	
	if ImGui.Button("tesxxxt "..tostring(moddisabled))  then
		
		Game.GetDynamicEntitySystem():DeleteTagged("CyberScript")
		despawnAll()
		setNewFixersPoint()
		
	end
	if testcoef == nil then testcoef = 1 end
	testcoef = ImGui.SliderFloat("##testcoef", testcoef, -100, 100, "%.3f Rotation (YAW)")	
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
end

function editor.aiTester()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Ai Tester"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("aiTester")
		end
		ImGui.EndMenuBar()
		end
		
		
	end
	aiContext =  ImGui.InputTextMultiline("ai Context", aiContext, 50000)
	
	aiAsk =  ImGui.InputTextMultiline("ai Ask", aiAsk, 50000)
	
	aiAnswer =  ImGui.InputTextMultiline("ai Answer", aiAnswer, 5000000)
	
	if ImGui.Button("Set context only")  then
		
		if(ScheduleChatCompletionRequest ~= null) then
			ScheduleChatCompletionRequest({
				{"System", aiContext},
				{"User", "Generate me content"}
			});
			--print("Context send")
			aiAnswer = "Loading..."
			else
			aiAnswer = "ai not found"
		end
		
	end
	
	if ImGui.Button("Set context")  then
		
		if(ScheduleChatCompletionRequest ~= null) then
			ScheduleChatCompletionRequest({
				{"System", aiContext},
				
			});
			--print("Context send")
			aiAnswer = "Loading..."
			else
			aiAnswer = "ai not found"
		end
		
	end
	
	if ImGui.Button("Ask")  then
		
		if(ScheduleChatCompletionRequest ~= null) then
			ScheduleChatCompletionRequest({
				{"System", aiContext},
				{"User", aiAsk},
				{"User", "Answer me in json into a field named 'answer' then give me potential questions from V based on your last answer into array in the same JSON into a field name questions."}
				
			});
			--print("Question send")
			aiAnswer = "Loading..."
			else
			aiAnswer = "ai not found"
		end
		
	end
	if ImGui.Button("Ask without using context (already define somewhere)")  then
		
		if(ScheduleChatCompletionRequest ~= null) then
			ScheduleChatCompletionRequest({
				
				{"User", aiAsk}
				
			});
			--print("Question send")
			aiAnswer = "Loading..."
			else
			aiAnswer = "ai not found"
		end
		
	end
	if ImGui.Button("Ask something new from AI Item")  then
		local action = {}
		action.name = "ask_ai_from_item_with_value"
		action.tag = aiContext
		action.value = aiAsk
		aiAnswer = "Loading..."
		executeAction(action,"editor_output","",1,"interact","see_engine")
		--print("Question send")
	end
	
	
	ImGui.End()
	ImGui.PopStyleVar(2)
	
	
end


function editor.perfTester()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	if ImGui.Begin(getLang("Performance Tester"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("perfTester")
		end
		ImGui.EndMenuBar()
		end
		
		ImGui.Text("SEE refresh Thread : "..tostring(seerefresh))
		ImGui.Text("Mod Variable Thread : "..tostring(refreshModVariabletg))
		ImGui.Text("UI Widget Thread : "..tostring(mainrefreshstep1))
		ImGui.Text("Lookat targeting and vehicle targeting Thread : "..tostring(mainrefreshstep2))
		ImGui.Text("POI correction Thread : "..tostring(mainrefreshstep3))
		ImGui.Text("Ambush and Timer Thread : "..tostring(mainrefreshstep4))
		ImGui.Text("RefreshPOI, Bounty, HUD, Entity Despawn, Sound Manager Thread : "..tostring(mainrefreshstep5))
		ImGui.Text("Event, NPC, Fixer and Ai Handler Thread : "..tostring(mainrefreshstep6))
		ImGui.Text("Radio Thread : "..tostring(mainrefreshstep7))
		ImGui.Text("despawn current star Thread : "..tostring(mainrefreshstep8))
		ImGui.Text("Main Thread : "..tostring(mainrefresh))
		
		
		if ImGui.Button("Toggle Main Thread")  then
			
			mainrefresh = not mainrefresh
			
		end
		
		if ImGui.Button("Toggle SEE refresh Thread")  then
			
			seerefresh = not seerefresh
			
		end
		
		if ImGui.Button("Toggle Mod Variable refresh")  then
			
			refreshModVariabletg = not refreshModVariabletg
			
		end
		
		if ImGui.Button("Toggle UI Widget refresh Thread")  then
			
			mainrefreshstep1 = not mainrefreshstep1
			
		end
		
		if ImGui.Button("Toggle Lookat targeting and vehicle targeting Thread")  then
			
			mainrefreshstep2 = not mainrefreshstep2
			
		end
		
		if ImGui.Button("Toggle POI correction thread")  then
			
			mainrefreshstep3 = not mainrefreshstep3
			
		end
		
		if ImGui.Button("Toggle Ambush and Timer Thread")  then
			
			mainrefreshstep4 = not mainrefreshstep4
			
		end
		
		if ImGui.Button("Toggle RefreshPOI, Bounty, HUD, Entity Despawn, Sound Manager Thread ")  then
			
			mainrefreshstep5 = not mainrefreshstep5
			
		end
		
		if ImGui.Button("Toggle Event, NPC, Fixer and Ai Handler Thread")  then
			
			mainrefreshstep6 = not mainrefreshstep6
			
		end
		
		if ImGui.Button("Toggle Radio thread")  then
			
			mainrefreshstep7 = not mainrefreshstep7
			
		end
		
		if ImGui.Button("Toggle despawn current star thread")  then
			
			mainrefreshstep8 = not mainrefreshstep8
			
		end
		
	end
	
	ImGui.End()
	ImGui.PopStyleVar(2)
end

function editor.datapackbuilding()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Datapack Building", true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			toggleEditorUI("datapackbuilding")
		end
		ImGui.EndMenuBar()
		end
		ImGui.Text("Wiki Link : ")
		editortext = ImGui.InputText("##wikilink1", "https://cyberscript77.github.io/wiki/#/create-an-datapack-folder", 5000, ImGuiInputTextFlags.ReadOnly) 
		editortext = ImGui.InputText("##wikilink2", "https://cyberscript77.github.io/wiki/#/share-your-datapack", 5000, ImGuiInputTextFlags.ReadOnly) 
		
		ImGui.Separator()
		ImGui.Text("Datapack Info :")
		myDatapack.name = ImGui.InputText(getLang("editor_Name"), myDatapack.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
		myDatapack.desc = ImGui.InputText(getLang("editor_desc"), myDatapack.desc, 500, ImGuiInputTextFlags.AutoSelectAll)
		myDatapack.author = ImGui.InputText(getLang("editor_Build_Author"), myDatapack.author, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		myDatapack.tag = ImGui.InputText(getLang("editor_tag"), myDatapack.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		myDatapack.version = ImGui.InputText(getLang("editor_Build_Version"), myDatapack.version, 100 , ImGuiInputTextFlags.AutoSelectAll)
		
		editor.listStringNode(getLang("editor_Build_Flags"),getLang("editor_Build_Flags_msg"),myDatapack,"flags",false)
		if ImGui.TreeNode("Editor Contents") then
			for k,v in pairs(arrayDatapack["editor"]) do
				if ImGui.TreeNode(k) then
					
					
					
					for tag,script in pairs(v) do
						
						
						ImGui.Text(tag)
					end
					
					
					
					ImGui.TreePop()
				end
				
				
			end
			ImGui.TreePop()
		end
		
		ImGui.Separator()
		ImGui.Text("Builder Output : ")
		ImGui.Text(datapackmsg)
		
		ImGui.Separator()
		
		if ImGui.Button("Build Datapack !") then
			local success,messgae = pcall(function()
				for k,v in pairs(arrayDatapack["editor"]) do
					
					if(type(v) == "table") then
						for tag,script in pairs(v) do
							local obj =  deepcopy(v,nil)
							local folder = k
							
							if(k == "functions") then folder = "function" end
							
							if(k ~= "metadata" and k ~= "cachedata" and k ~= "enabled") then
								local file = assert(io.open("editor/output/bin/x64/plugins/cyber_engine_tweaks/mods/cyberscript/datapack/editor/"..folder.."/"..tag..".json", "w"))
								local stringg = JSON:encode_pretty(obj)
								
								file:write(stringg)
								file:close()
								
							end
						end
					end
					
					
				end
				
				local obj =  deepcopy(myDatapack,nil)
				obj.file = obj.tag..".zip"
				local file = assert(io.open("editor/output/bin/x64/plugins/cyber_engine_tweaks/mods/cyberscript/datapack/editor/desc.json", "w"))
				local stringg = JSON:encode_pretty(obj)
				
				file:write(stringg)
				file:close()
			end)
			
			if success == false then
				
				datapackmsg = message
				
				else
				
				datapackmsg = "Datapack Builded !"
				Cron.After(5, function()
					datapackmsg = ""
				end)
			end
			
			
		end
		
		ImGui.Separator()
		
		ImGui.Text("Output Path : ") ImGui.SameLine() editortext = ImGui.InputText("##mydatapack", "(cyberscript folder)\\editor\\output\\bin\\x64\\plugins\\cyber_engine_tweaks\\mods\\cyberscript\\datapack\\editor", 1000, ImGuiInputTextFlags.ReadOnly)
		ImGui.Text("Zip Instructions : \n 1 - Copy bin folder that is in (cyberscript folder)\\editor\\output. \n 2 - Rename bin\\x64\\plugins\\cyber_engine_tweaks\\mods\\cyberscript\\datapack\\editor folder to the tag of your datapack. \n 3 - Zip it ! \n 4 - Share it !")
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
end


function editor.factcheck()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Fact Check"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("factcheck")
		end
		ImGui.EndMenuBar()
		end
		factsearch  = ImGui.InputText("Search", factsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
		factresult = ImGui.InputText("Fact Result", factresult, 5000, ImGuiInputTextFlags.AutoSelectAll)
		local status, result =  pcall(function()
			
			if ImGui.TreeNode("Fact") then
				for k,v in ipairs(editor.fact) do
					local result = tostring(Game.GetQuestsSystem():GetFactStr(v))
					if((factsearch == "" or string.find(v,factsearch))) then
						if ((factresult == "" or tostring(factresult) == result)) then
							ImGui.InputText("##"..v, v, 5000, ImGuiInputTextFlags.ReadOnly) ImGui.SameLine() ImGui.Text(" : "..tostring(result))
						end
					end
				end
				ImGui.TreePop()
			end
			
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
		
	end
	
	
	
	
	ImGui.End()
	
	ImGui.PopStyleVar(2)
	
	
end


function editor.currentQuestView()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Current CS Quest Viewer"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("currentQuestView")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result = pcall(function()
			
			if currentQuest ~= nil then
				ImGui.Text("QuestManager.IsTrackingObjective : "..tostring(QuestManager.IsTrackingObjective()))
				ImGui.Text("title : "..currentQuest.title)
				ImGui.Text("completedobjective : "..completedobjective)
				ImGui.Text("totalobjectivenotoptionnal : "..totalobjectivenotoptionnal)
				
				ImGui.Text("content : "..currentQuest.content)
				ImGui.Text("tag : "..currentQuest.tag)
				ImGui.Text("recommandedlevel : "..currentQuest.recommandedlevel)
				ImGui.Text("questtype : "..currentQuest.questtype)
				ImGui.Text("district : "..currentQuest.district)
				ImGui.Text("isNPCD : "..tostring(currentQuest.isNPCD))
				ImGui.Text("recurrent : "..tostring(currentQuest.recurrent))
				ImGui.Text("State : "..tostring(getScoreKey(currentQuest.tag,"Score")))
				for k,v in pairs(currentQuest.trigger_condition) do
					ImGui.Text(v.name)
				end
				
				if ImGui.TreeNode("trigger_action") then
					for i=1, #currentQuest.trigger_action do
						ImGui.Text(currentQuest.trigger_action[i].name)
					end
					ImGui.TreePop()
				end
				
				if ImGui.TreeNode("objectives") then
					for i=1, #currentQuest.objectives do
						
						local objective = currentQuest.objectives[i]
						
						if ImGui.TreeNode(objective.title.." ( "..objective.tag.." )") then
							ImGui.Text("state : "..tostring(QuestManager.GetObjectiveState(objective.tag).state))
							ImGui.Text("isoptionnal : "..tostring(objective.isoptionnal))
							ImGui.Text("isActive : "..tostring(QuestManager.GetObjectiveState(objective.tag).isActive))
							ImGui.Text("isComplete : "..tostring(QuestManager.GetObjectiveState(objective.tag).isComplete))
							ImGui.Text("isTracked : "..tostring(QuestManager.GetObjectiveState(objective.tag).isTracked))
							ImGui.TreePop()
						end
					end
					ImGui.TreePop()
				end
				else
				ImGui.Text("No current Quest")
			end
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.currentBountyView()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Current Bounty Viewer"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("currentBountyView")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result = pcall(function()
			
			if currentScannerItem ~= nil then
				ImGui.Text("primaryname : "..currentScannerItem.primaryname)
				ImGui.Text("secondaryname : "..currentScannerItem.secondaryname)
				ImGui.Text("entityname : "..currentScannerItem.entityname)
				ImGui.Text("level : "..tostring(currentScannerItem.level))
				ImGui.Text("rarity : "..tostring(currentScannerItem.rarity))
				ImGui.Text("attitude : "..tostring(currentScannerItem.attitude))
				ImGui.Text("Desc : "..currentScannerItem.text)
				if currentScannerItem.bounty ~= nil then
					
					ImGui.Text("reward : "..tostring(currentScannerItem.bounty.reward))
					ImGui.Text("streetreward : "..tostring(currentScannerItem.bounty.streetreward))
					ImGui.Text("danger : "..tostring(currentScannerItem.bounty.danger))
					ImGui.Text("issuedby : "..tostring(currentScannerItem.bounty.issuedby))
					
					
					for i,v in ipairs(currentScannerItem.bounty.transgressions) do
						ImGui.Text(v)
					end
					
					for i,v in ipairs(currentScannerItem.bounty.customtransgressions) do
						ImGui.Text(v)
					end
				end
				
				else
				ImGui.Text("No current Bounty")
			end
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.devZone()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Dev Zone"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("devZone")
		end
		ImGui.EndMenuBar()
		end
		
		local status, result =  pcall(function()
			
			if ImGui.Button("Dump Currentsave data")  then
				
				local sessionFile = io.open('currentsave.txt', 'w')
				sessionFile:write(dump(currentSave))
				sessionFile:close()
			end
			
			
			if ImGui.Button("Dump arrayDatapack data")  then
				
				local sessionFile = io.open('arrayDatapack.lua', 'w')
				sessionFile:write(JSON:encode_pretty(arrayDatapack))
				sessionFile:close()
			end
			
			if ImGui.Button("Dump HUD key")  then
				
				local sessionFile = io.open('displayHUD.txt', 'w')
				for k,v in pairs(displayHUD) do
					sessionFile:write(k, "\n")
				end
				sessionFile:close()
			end
			
			
			if ImGui.Button("Dump Variable table")  then
				
				local sessionFile = io.open('variableboard.txt', 'w')
				sessionFile:write(dump(currentSave.Variable))
				sessionFile:close()
				
			end
			
			if ImGui.Button("Naked Player")  then
				
				local player = Game.GetPlayer()
				
				if player:IsNaked() == false then
					Game.UnequipItem('Face', 0)
					Game.UnequipItem('Feet', 0)
					Game.UnequipItem('Head', 0)
					Game.UnequipItem('Legs', 0)
					Game.UnequipItem('OuterChest', 0)
					Game.UnequipItem('Outfit', 0)
					Game.UnequipItem('InnerChest', 0)
				end
				
				
				
				local ts = Game.GetTransactionSystem()
				
				local itemID = ItemID.FromTDBID('Items.Underwear_Basic_01_Top')
				local attachmentSlot = "AttachmentSlots.UnderwearBottom"
				itemID = ItemID.FromTDBID('Items.Underwear_Basic_01_Bottom')
				
				
				if not ts:HasItem(Game.GetPlayer(), itemID) then
					ts:GiveItem(Game.GetPlayer(), itemID, 1)
				end
				
				Game.UnequipItem("UnderwearBottom", 0)
				
				
				
				
			end
			if ImGui.Button("Make EntityList")  then
				----print(dump(entityListJson))
				for i,entity in ipairs(entityListJson) do
					
					entityListJson[i].entity_id = TweakDBID.new(entity.entity_tweak).hash
					
					
				end
				
				local hashList = {}
				
				for i,entity in ipairs(entityListJson) do
					
					
					
					hashList[tostring(entity.entity_id)] = entity
					
					
				end
				
				local sessionFile = io.open('mod/data/entities.lua', 'w')
				sessionFile:write('return ')
				sessionFile:write(exportDatapackArray(entityListJson))
				sessionFile:close()
				
				local sessionFile = io.open('mod/data/entitieshash.lua', 'w')
				sessionFile:write('return ')
				sessionFile:write(exportDatapackArray(hashList))
				sessionFile:close()
				
				local sessionFile = io.open('mod/data/workspot.lua', 'w')
				sessionFile:write('return ')
				sessionFile:write(exportDatapackArray(anim_rigs_list))
				sessionFile:close()
				
			end
			if ImGui.Button("test ent widget")  then
				
				local pos = Game.GetPlayer():GetWorldPosition()
				spawnWidgetEnt("widgetEntity", pos.x, pos.y ,pos.z)
				
				
				
				
			end
			
			if ImGui.Button("test apply interface")  then
				
				local widget = cyberscript.EntityManager["widgetEntity"]
				if(cyberscript.cache["interfaces"]["test"] ~= nil) then
					
					cyberscript.EntityManager["widgetEntity"].interface = "test"
					cyberscript.EntityManager["widgetEntity"].widget :RemoveAllChildren()
					makeCustomInterface(cyberscript.EntityManager["widgetEntity"].widget,cyberscript.cache["interfaces"]["test"].data)
					
					else
					--print("no apply")
					-- --print(tostring(GameDump(displayHUD[action.parent])))
					-- --print(tostring(dump(cyberscript.cache["interfaces"][action.tag])))
					
				end
				
				
				
				
			end
			
			if ImGui.Button("test weather")  then
				local RainEvent = RainEvent.new()
				RainEvent.rainIntensity  =  0
				Game.GetPlayer():QueueEvent(RainEvent)
				
				
			end
			if ImGui.Button("test AMM")  then
				if GetMod('AppearanceMenuMod') then 
					local testamm =  GetMod("AppearanceMenuMod")
					if(testamm.API ~= nil) then
						
						--print("Cyberscript : AMM Version founded : "..AMMversion)
						else
						
						--print(getLang("ammoutdated"))
					end
					else 
					--print(getLang("ammnotfound"))
					
				end
			end
			
			if ImGui.Button("Dump POI table")  then
				
				local sessionFile = io.open('poi_type.json', 'w')
				sessionFile:write(JSON:encode_pretty(poi_type))
				sessionFile:close()
				
				local sessionFile = io.open('poi_subdistrict.json', 'w')
				sessionFile:write(JSON:encode_pretty(poi_subdistrict))
				sessionFile:close()
				
				local sessionFile = io.open('poi_district.json', 'w')
				sessionFile:write(JSON:encode_pretty(poi_district))
				sessionFile:close()
				
				local sessionFile = io.open('poi_tag.json', 'w')
				sessionFile:write(JSON:encode_pretty(poi_tag))
				sessionFile:close()
				
			end
			
			if ImGui.Button("clear spawntablecount")  then
				
				spawntablecount {}
			end
			
			if ImGui.Button("show cachedespawn")  then
				
				--print(dump(cachedespawn))
			end
			
			if ImGui.Button("Hot Reload")  then
				
				loadModule()
			end
			
			if ImGui.Button("Close Popup")  then
				UIPopupsManager.ClosePopup()
				
			end
			
			
			if ImGui.Button("hash")  then
				--print(TweakDB:GetFlat('Character.Judy.entityTemplatePath').hash)
				
			end
			
			if ImGui.Button("Refresh template from JSON")  then
				local newactiontemp = {}
				
				local f2 = assert(io.open("data/actiontemplate.json"))
				
				lines = f2:read("*a")
				
				encdo = lines
				
				actiontemplate = {}
				
				actiontemplate = trydecodeJSOn(encdo, f2,"data/actiontemplate.json")
				
				
				f2:close()
				
				
				for i,v in ipairs(actiontemplate) do
					newactiontemp[v.name] = v
					
					
					
				end
				local sessionFile = io.open('data/actiontemplate.lua', 'w')
				sessionFile:write('return ')
				sessionFile:write(exportDatapackArray(newactiontemp))
				sessionFile:close()
				
				
				
				
				
				local f = assert(io.open("data/triggertemplate.json"))
				
				lines = f:read("*a")
				
				encdo = lines
				f:close()
				triggertemplate = {}
				
				triggertemplate = trydecodeJSOn(encdo, f ,"data/triggertemplate.json")
				
				
				local newtriggertemp = {}
				for i,v in ipairs(triggertemplate) do
					newtriggertemp[v.name] = v
					
					
					
				end
				local sessionFile = io.open('data/triggertemplate.lua', 'w')
				sessionFile:write('return ')
				sessionFile:write(exportDatapackArray(newtriggertemp))
				sessionFile:close()
				
			end
			
			
			if ImGui.Button("Refresh JSON from LUA")  then
				
				local sessionFile = io.open('data/actiontemplate.json', 'w')
				
				sessionFile:write(JSON:encode_pretty(cyberscript.actiontemplate))
				sessionFile:close()
				
				
				local sessionFile = io.open('data/triggertemplate.json', 'w')
				
				sessionFile:write(JSON:encode_pretty(cyberscript.triggertemplate))
				sessionFile:close()
				
			end
			
			if ImGui.Button("test")  then
				local npcSpec =  DynamicEntitySpec.new()
				npcSpec.recordID = "Character.Judy"
				npcSpec.appearanceName = "random"
				npcSpec.position = Game.GetPlayer():GetWorldPosition()
				npcSpec.orientation = Game.GetPlayer():GetWorldOrientation()
				npcSpec.persistState = true;
				npcSpec.persistSpawn = true;
				npcSpec.tags = {"CyberScript"}
				judy = Game.GetDynamicEntitySystem():CreateEntity(npcSpec)
				
			end
			
			if ImGui.Button("test2")  then
				
				Game.GetDynamicEntitySystem():DeleteEntity(judy)
				
			end
			
			
			if ImGui.Button("test3")  then
				
				local storedentity =  Game.GetDynamicEntitySystem():GetTaggedIDs("CyberScript")
				--print("storedentity"..dump(storedentity))
				for i,entid in ipairs(storedentity) do
					
					local tags = Game.GetDynamicEntitySystem():GetTags(entid)
					--print("tags"..dump(tags))
					
					local tagsString = {}
					
					for k,v in ipairs(tags) do
						
						--print("vs"..Game.NameToString(v))
						table.insert(tagsString,Game.NameToString(v))
						
					end
					--print("tagsString"..dump(tagsString))
					local cstag = ""
					
					if(table_contains(tagsString,"CyberScript.NPC")) then
						for i,atg in ipairs(tagsString) do
							if(string.match(atg,"CyberScript.NPC.")) then
								local tagsplit = split(atg, ".")
								cstag = tagsplit[3]
							end
						end
					end
					
					if(table_contains(tagsString,"CyberScript.Vehicle")) then
						for i,atg in ipairs(tagsString) do
							if(string.match(atg,"CyberScript.Vehicle.")) then
								local tagsplit = split(atg, ".")
								cstag = tagsplit[3]
							end
						end
					end
					
					if(cstag ~= "")then
						
						local entity = {}
						entity.id = entid
						entity.spawntimespan = os.time(os.date("!*t"))+0
						entity.despawntimespan = os.time(os.date("!*t"))+0
						entity.tag = cstag
						entity.isitem = false
						entity.tweak = cyberscript.entitieshash[tostring(Game.FindEntityByID(entid):GetRecordID().hash)].entity_tweak
						--print("tweak"..entity.tweak)
						entity.isprevention = false
						entity.iscodeware = true
						entity.persistState = true
						entity.persistSpawn = true
						entity.alwaysSpawned = true
						entity.spawnInView = true
						entity.scriptlevel = 0
						
						entity.isMP = false
						
						local npgc = getNPCByTweakId(entity.tweak)
						if(npgc ~= nil) then
							entity.name = npgc.Names
							else
							entity.name = cstag
						end
						
						cyberscript.EntityManager[cstag]=entity
					end
					
				end
				
			end
		end)
		if status == false then
			
			
			logme(1,result)
			spdlog.error(result)
		end
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.actionTester()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Action Tester"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Close") then
				toggleEditorUI("actionTester")
			end
			
			ImGui.EndMenuBar()
		end
		
		local flags = ImGuiTabBarFlags.Reorderable + ImGuiTabBarFlags.AutoSelectNewTabs
		
		if ImGui.BeginTabBar("EditorTabs", flags) then
			if editoraction == nil then
				
				editoraction = {}
				editoraction.parenttag = "editor_tester"
				editoraction.parent = nil
				editoraction.key = nil
				editoraction.contextscript = "test"
				editoraction.index = 1
				
				editoraction.action = {}
				editoraction.action.name = "nothing"
				
				currentAction["test_actions"] = editoraction
			end
			
			
			editor.actions("test_actions",currentAction["test_actions"])
			ImGui.EndTabBar()
		end
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end


function editor.triggerTester()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Trigger Tester"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then 
			
			if ImGui.MenuItem("Close") then
				toggleEditorUI("triggerTester")
			end
			
			
			
			ImGui.EndMenuBar()
		end
		
		local flags = ImGuiTabBarFlags.Reorderable + ImGuiTabBarFlags.AutoSelectNewTabs
		
		if ImGui.BeginTabBar("EditorTabs", flags) then
			
			if editortrigger == nil then
				
				editortrigger = {}
				editortrigger.parenttag = "editor_tester"
				editortrigger.parent = nil
				editortrigger.key = nil
				editortrigger.contextscript = "test"
				editortrigger.index = 1
				editortrigger.name = "test_trigger"
				editortrigger.newname = "test_trigger"
				editortrigger.trigger = {}
				editortrigger.trigger.name = "auto"
				currentTrigger["test_trigger"] = editortrigger
			end
			
			
			editor.triggers("test_trigger",currentTrigger["test_trigger"])
			
			
			ImGui.EndTabBar()
		end
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.modLog()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Mod Log"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("modLog")
		end
		ImGui.EndMenuBar()
		end
		local status, result = pcall(function()
			
			
			logrecordlevel = ImGui.InputInt(getLang("Record at Log Level"), logrecordlevel, 1,10, ImGuiInputTextFlags.None)
			ImGui.Spacing()
			
			logLevel = ImGui.InputInt(getLang("Log Level"), logLevel, 1,10, ImGuiInputTextFlags.None)
			ImGui.Spacing()
			logFilter = ImGui.InputText(getLang("Log Filter"), logFilter, 5000, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Spacing()
			if ImGui.Button("Clear log and log file") then
				logTable = {}
				logf:close()
				io.open("cyberscript.log", "w"):close()
				logf = io.open("cyberscript.log", "a")
			end
			ImGui.Spacing()
			ImGui.Separator()
			ImGui.Spacing()
			
			
			ImGui.BeginChild("log", 1500, 600)
			
			for i,v in ipairs(logTable) do
				if(v.level <= logLevel and (logFilter == nil or logFilter == "" or (logFilter ~= nil and logFilter ~= "" and string.match(v.msg, logFilter)))) then
					ImGui.Text("[Level:"..v.level.."]"..v.datestring..":"..v.msg)
				end
			end
			
			ImGui.EndChild()
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.colorPicker()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Color Picker"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("colorPicker")
		end
		ImGui.EndMenuBar()
		end
		local status, result = pcall(function()
			
			currentcolorTable = ImGui.ColorPicker4("Edit color", currentcolorTable, ImGuiColorEditFlags.DisplayRGB)
			
			currentcolorRGB.red = math.floor(currentcolorTable[1]*255)
			currentcolorRGB.green = math.floor(currentcolorTable[2]*255)
			currentcolorRGB.blue = math.floor(currentcolorTable[3]*255)
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.variableEditor()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Variable Editor"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("variableEditor")
		end
		ImGui.EndMenuBar()
		end
		local status, result = pcall(function()
			
			
			ImGui.Text("Add an new variable : ")
			ImGui.Spacing()
			editorCurrentVariable = ImGui.InputText(getLang("Variable"), editorCurrentVariable, 5000, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Spacing()
			editorCurrentVariableKey = ImGui.InputText(getLang("Key"), editorCurrentVariableKey, 5000, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Spacing()
			editorCurrentVariableValue = ImGui.InputText("Value",editorCurrentVariableValue, 5000, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Spacing()
			
			if ImGui.Button(getLang("Add Variable")) then
				
				
				if(currentSave.Variable[editorCurrentVariable] == nil) then currentSave.Variable[editorCurrentVariable] = {} end
				currentSave.Variable[editorCurrentVariable][editorCurrentVariableKey] = editorCurrentVariableValue
				
				
			end
			
			
			
			ImGui.Spacing()
			
			
			ImGui.Separator()
			
			editorCurrentVariableSearch = ImGui.InputText(getLang("Search Variable"), editorCurrentVariableSearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
			editorCurrentVariableKeySearch = ImGui.InputText(getLang("Search Key"), editorCurrentVariableKeySearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.Spacing()
			
			
			ImGui.Separator()
			
			local index = 1
			for variabletag,variable in pairs(currentSave.Variable) do
				index = index+1
				if (editorCurrentVariableSearch == "" or (editorCurrentVariableSearch ~= "" and (string.match(variabletag,editorCurrentVariableSearch)))) then
					if ImGui.TreeNode(variabletag.."##"..index)  then
						for key,value in pairs (variable) do
							
							if (editorCurrentVariableKeySearch == "" or (editorCurrentVariableKeySearch ~= "" and (string.match(key,editorCurrentVariableKeySearch)))) then
								
								if ImGui.TreeNode(key)  then
									
									if(type(value) == "string") then
										currentSave.Variable[variabletag][key] = ImGui.InputText("##("..type(value)..") "..variabletag..key,value, 5000, ImGuiInputTextFlags.AutoSelectAll)
									end
									if(type(value) == "number") then
										currentSave.Variable[variabletag][key] = ImGui.InputFloat("##("..type(value)..") "..variabletag..key,value, 1, 10,"%.2f", ImGuiInputTextFlags.None)
									end
									if(type(value) == "boolean") then
										currentSave.Variable[variabletag][key] = ImGui.Checkbox("##("..type(value)..") "..variabletag..key, currentSave.Variable[variabletag][key])
									end
									if(type(value) == "table") then
										ImGui.Text("It's an object, can't be edit like this :( ")
										ImGui.SameLine()
										if ImGui.Button(getLang("Dump in log and console")) then
											
											
											
											--print("Editor Variable Dump for "..variabletag.." "..key.." : "..dump(currentSave.Variable[variabletag][key]))
											spdlog.error("Editor Variable Dump for "..variabletag.." "..key.." : "..dump(currentSave.Variable[variabletag][key]))
											
											
										end
									end
									if(type(value) == "userdata") then
										ImGui.Text("It's an Game Object, can't be edit like this :( ")
										ImGui.SameLine()
										if ImGui.Button(getLang("Dump in log and console")) then
											
											
											
											--print("Editor Variable Game Dump for "..variabletag.." "..key.." : "..GameDump(currentSave.Variable[variabletag][key]))
											spdlog.error("Editor Variable Game Dump for "..variabletag.." "..key.." : "..GameDump(currentSave.Variable[variabletag][key]))
											
											
										end
									end
									
									if ImGui.Button(getLang("editor_reset")) then
										
										
										
										currentSave.Variable[variabletag][key] = nil
										
										
									end
									ImGui.TreePop()
								end
								
							end
						end
						ImGui.TreePop()
					end
				end		
			end
			
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.playerposition()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Player Position and Camera"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("playerposition")
		end
		ImGui.EndMenuBar()
		end
		local status, result = pcall(function()
			
			
			
			camstep =  ImGui.DragFloat("##camstep", camstep, 0.1, 0.1, 10, "%.3f Camera Step")
			
			
			if ImGui.Button("Toggle V Head") then
				
				local isFemale = GetPlayerGender()
				if isFemale == "_Female" then gender = 'Wa' else gender = 'Ma' end
				local headItem = string.format("Items.CharacterCustomization%sHead", gender)
				local ts = Game.GetTransactionSystem()
				local gameItemID = GetSingleton('gameItemID')
				local tdbid = TweakDBID.new(headItem)
				local itemID = gameItemID:FromTDBID(tdbid)
				
				
				if(toggleVHeadEnabled) then
					Cron.Every(0.001, { tick = 1 }, function(timer)
						
						timer.tick = timer.tick + 1
						
						if timer.tick > 20 then
							Cron.Halt(timer)
						end
						
						Cron.After(0.01, function()
							ts:RemoveItemFromSlot(Game.GetPlayer(), TweakDBID.new('AttachmentSlots.TppHead'), true, true, true)
						end)
						
						Cron.After(0.1, function()
							Game.EquipItemOnPlayer(headItem, "TppHead")
						end)
					end)
					
					toggleVHeadEnabled = false
					
					else
					
					if ts:GetItemInSlot(Game.GetPlayer(), TweakDBID.new("AttachmentSlots.TppHead")) ~= nil then
						ts:RemoveItemFromSlot(Game.GetPlayer(), TweakDBID.new('AttachmentSlots.TppHead'), true, true, true)
						Game.EquipItemOnPlayer("Items.PlayerFppHead", "TppHead")
					end
					toggleVHeadEnabled = true
				end
				
				
			end
			
			
			editorView.x,change = ImGui.DragFloat("##editorViewx", editorView.x, camstep, -9999, 9999, "%.3f Camera Side")
			if change then
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(editorView.x, editorView.y, editorView.z, 1.0))
			end
			
			editorView.y,change = ImGui.DragFloat("##editorViewy", editorView.y, camstep, -9999, 9999, "%.3f Camera Depth")
			if change then
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(editorView.x, editorView.y, editorView.z, 1.0))
			end
			
			editorView.z,change = ImGui.DragFloat("##editorViewz", editorView.z, camstep, -9999, 9999, "%.3f Camera Height")
			if change then
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(editorView.x, editorView.y, editorView.z, 1.0))
			end
			if ImGui.Button("Reset Camera")then
				
				
				local fppComp = Game.GetPlayer():GetFPPCameraComponent()
				fppComp:SetLocalPosition(Vector4:new(0, 0, 0, 1.0))
			end
			
			if ImGui.Button("View Change Camera Position Action as JSON")then
				
				
				local obj = deepcopy(cyberscript.actiontemplate["change_camera_position"], nil)
				
				obj.x = editorView.x
				obj.y = editorView.y
				obj.z = editorView.z
				
				
				
				currentOutput = JSON:encode_pretty(obj)
				
				toggleEditorUI("JsonActionOutput")
			end
			ImGui.SameLine()
			if ImGui.Button("Copy Change Camera Position To Action Clipboard")then
				
				local obj = deepcopy(cyberscript.actiontemplate["change_camera_position"], nil)
				
				obj.x = editorView.x
				obj.y = editorView.y
				obj.z = editorView.z
				
				
				
				
				clipboard["action"] = deepcopy(obj)
				
			end
			
			
			
			ImGui.Text(getLang("editor_Setting_PlayerPosition"))
			curPos.x,change2 = ImGui.DragFloat("##curPosx", curPos.x, camstep, -9999, 9999, "%.3f Player Pos X")
			if change2 then
				teleportTo(Game.GetPlayer(), curPos, 1,true)
			end
			
			curPos.y,change2 = ImGui.DragFloat("##curPosy", curPos.y, camstep, -9999, 9999, "%.3f Player Pos Y")
			if change2 then
				teleportTo(Game.GetPlayer(), curPos, 1,true)
			end
			
			curPos.z,change2 = ImGui.DragFloat("##curPosz", curPos.z, camstep, -9999, 9999, "%.3f Player Pos Z")
			if change2 then
				teleportTo(Game.GetPlayer(), curPos, 1,true)
			end
			
			
			if ImGui.Button("View Teleport Player Action as JSON")then
				
				
				local obj = deepcopy(cyberscript.actiontemplate["teleport_player"], nil)
				
				obj.x = curPos.x
				obj.y = curPos.y
				obj.z = curPos.z
				
				
				
				currentOutput = JSON:encode_pretty(obj)
				
				toggleEditorUI("JsonActionOutput")
			end
			ImGui.SameLine()
			if ImGui.Button("Copy Teleport Player Action To Action Clipboard")then
				
				local obj = deepcopy(cyberscript.actiontemplate["teleport_player"], nil)
				
				obj.x = curPos.x
				obj.y = curPos.y
				obj.z = curPos.z
				
				
				
				
				clipboard["action"] = deepcopy(obj)
				
			end
			
			
			
			if ImGui.Button("TP to Custom MapPin") then
				
				if(ActivecustomMappin ~= nil) then
					
					local pos = ActivecustomMappin:GetWorldPosition()
					TeleportPlayerToPosition(pos.x,pos.y,pos.z)
				end
			end
			pox = ImGui.InputInt("X", pox)
			poy = ImGui.InputInt("Y", poy)
			poz = ImGui.InputInt("Z", poz)
			
			if ImGui.Button("TP to XYZ") then
				TeleportPlayerToPosition(pox,poy,poz)
			end
			
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.timecontrol()
	
	
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(600, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	
	if ImGui.Begin(getLang("Time Manager"), true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			toggleEditorUI("timecontrol")
		end
		ImGui.EndMenuBar()
		end
		local status, result = pcall(function()
			
			ImGui.Text("Current Time")
			editortimehour,change = ImGui.SliderInt("Hour", editortimehour , 0, 23)
			if change then
				setGameTime(editortimehour,editortimeminute)
			end
			
			editortimeminute,change = ImGui.SliderInt("Minute", editortimeminute ,0, 60)
			if change then
				setGameTime(editortimehour,editortimeminute)
			end
			
			
			
			if ImGui.Button(getLang("Sync From Current Time")) then
				
				local gameTime = Game.GetTimeSystem():GetGameTime()
				
				
				local temp = {}
				temp.hour = GetSingleton('GameTime'):Hours(gameTime)
				temp.min = GetSingleton('GameTime'):Minutes(gameTime)
				temp.sec = GetSingleton('GameTime'):Seconds(gameTime)
				temp.day = GetSingleton('GameTime'):Days(gameTime)
				editortimehour = temp.hour
				editortimeminute = temp.min
				
				
				
			end
			
			
			if ImGui.Button("View Set Time Action as JSON")then
				
				
				local obj = deepcopy(cyberscript.actiontemplate["set_time"], nil)
				
				obj.hour = editortimehour
				obj.minute = editortimeminute
				
				
				
				
				currentOutput = JSON:encode_pretty(obj)
				
				toggleEditorUI("JsonActionOutput")
			end
			ImGui.SameLine()
			if ImGui.Button("Copy Set Time To Action Clipboard")then
				
				local obj = deepcopy(cyberscript.actiontemplate["set_time"], nil)
				
				obj.hour = editortimehour
				obj.minute = editortimeminute
				
				
				
				
				clipboard["action"] = deepcopy(obj)
				
			end
			
			
			
			
			
			
			ImGui.Separator()
			
			
			ImGui.Text("Time Dilatation")
			editortimedilatationignoreplayer = ImGui.Checkbox(getLang("Ignore Time Dilatation on Player"), editortimedilatationignoreplayer)
			
			
			
			editortimedilatation,change = ImGui.DragFloat("##editortimedilatation", editortimedilatation, 0.0000000000001, 0, 1, "%.13f Time Dilatation")
			if change then
				local times = Game.GetTimeSystem()
				times:SetIgnoreTimeDilationOnLocalPlayerZero(editortimedilatationignoreplayer)
				Game.SetTimeDilation(editortimedilatation)
			end
			
			if ImGui.Button(getLang("Unfreeze Time")) then
				
				
				
				local times = Game.GetTimeSystem()
				times:SetIgnoreTimeDilationOnLocalPlayerZero(editortimedilatationignoreplayer)
				Game.SetTimeDilation(0)
				editortimedilatation = 0
				
			end
			
			if ImGui.Button(getLang("Freeze Time")) then
				
				local times = Game.GetTimeSystem()
				times:SetIgnoreTimeDilationOnLocalPlayerZero(editortimedilatationignoreplayer)
				Game.SetTimeDilation(0.0000000000001)
				editortimedilatation = 0.0000000000001
				
			end
			
			
			if ImGui.Button("View Set Time Dilatation Action as JSON")then
				
				
				local obj = deepcopy(cyberscript.actiontemplate["set_timedilation"], nil)
				
				obj.value = editortimedilatation
				
				
				
				
				currentOutput = JSON:encode_pretty(obj)
				
				toggleEditorUI("JsonActionOutput")
			end
			ImGui.SameLine()
			if ImGui.Button("Copy Set Time Dilatation Action To Action Clipboard")then
				
				local obj = deepcopy(cyberscript.actiontemplate["set_timedilation"], nil)
				obj.value = editortimedilatation
				
				
				
				clipboard["action"] = deepcopy(obj)
				
			end
			
			
		end)
		
		if status == false then
			
			
			logme(10,result)
			spdlog.error(result)
		end
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.newSpawn()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Spawn entities", true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			toggleEditorUI("newSpawn")
		end
		ImGui.EndMenuBar()
		end
		
		
		
		newentity.tag = ImGui.InputText(getLang("Tag :"), newentity.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		if checkentry == nil then checkentry = false end
		checkentry = ImGui.Checkbox("Write direct entry", checkentry)
		
		if(checkentry == false) then
			newentity.search = ImGui.InputText("Search", newentity.search, 5000, ImGuiInputTextFlags.AutoSelectAll)
			if ImGui.BeginCombo("##My Combo Box", newentity.tweak) then -- Remove the ## if you'd like for the title to display above combo box
				
				for i,items in ipairs(cyberscript.entities) do
					
					if(
						
						newentity.search == "" or
						string.match(items.entity_tweak, newentity.search) or
						string.match(items.entity_name, newentity.search) or
						string.match(items.entity_entname, newentity.search) or
						string.match(items.entity_entpath, newentity.search)
						
						
						
					)then 
					
					
					
					if ImGui.Selectable(items.entity_tweak) then
						
						newentity.tweak = items.entity_tweak
						
						ImGui.SetItemDefaultFocus()
					end
					
					end
					
				end
				
				ImGui.EndCombo()
			end
			
			else
			
			newentity.tweak= ImGui.InputText("Entry", newentity.tweak, 5000, ImGuiInputTextFlags.AutoSelectAll)
		end
		
		
		if(newentity.tag ~= "" and newentity.tweak ~= "") then
			if ImGui.Button("Spawn")then
				local pos = Game.GetPlayer():GetWorldPosition()
				local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
				local bool = string.match(newentity.tweak, ".ent") == nil
				local isitem = string.match(newentity.tweak, ".ent") ~= nil
				spawnNPC(newentity.tweak,"", newentity.tag, pos.x, pos.y ,pos.z, 99, bool, false, nil, isitem, nil,600,true,false,false,false,true)
				
			end
			else
			ImGui.Text("You must choose a tweak and put a tag for spawn an entity")
		end
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
end

function editor.newSpawnVehicle()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Spawn vehicles", true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			toggleEditorUI("newSpawnVehicle")
		end
		ImGui.EndMenuBar()
		end
		
		
		newentity.tag = ImGui.InputText(getLang("Tag :"), newentity.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		if checkentry == nil then checkentry = false end
		checkentry = ImGui.Checkbox("Write direct entry", checkentry)
		
		if(checkentry == false) then
			newentity.search = ImGui.InputText("Search", newentity.search, 5000, ImGuiInputTextFlags.AutoSelectAll)
			if ImGui.BeginCombo("##My Combo Box", newentity.tweak) then -- Remove the ## if you'd like for the title to display above combo box
				
				for i,items in ipairs(arrayVehicles) do
					
					if(
						
						newentity.search == "" or
						string.match(items, newentity.search)
						
						
					)then 
					
					
					
					if ImGui.Selectable(items) then
						
						newentity.tweak = items
						
						ImGui.SetItemDefaultFocus()
					end
					
					end
					
				end
				
				ImGui.EndCombo()
			end
			
			
			else
			
			newentity.tweak= ImGui.InputText("Entry", newentity.tweak, 5000, ImGuiInputTextFlags.AutoSelectAll)
		end
		
		
		if(newentity.tag ~= "" and newentity.tweak ~= "") then
			if ImGui.Button("Spawn")then
				local pos = Game.GetPlayer():GetWorldPosition()
				
				spawnVehicleV2(newentity.tweak, "", newentity.tag, pos.x, pos.y ,pos.z, 99, 3 ,false,false,false,false, nil, 0,false,300)
			end
			else
			ImGui.Text("You must choose a tweak and put a tag for spawn an entity")
		end
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
end

function editor.newCameraSpawn()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Spawn camera", true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			toggleEditorUI("newCameraSpawn")
		end
		ImGui.EndMenuBar()
		end
		
		
		newentity.tag = ImGui.InputText(getLang("Tag :"), newentity.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if(newentity.tag ~= "" ) then
			if ImGui.Button("Spawn")then
				local pos = Game.GetPlayer():GetWorldPosition()
				local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
				
				spawnCamera(newentity.tag,pos,false,angles)
				table.insert(cameraManager,newentity.tag)
				toggleEditorUI("newCameraSpawn")
			end
			else
			ImGui.Text("You must choose a tweak and put a tag for spawn an entity")
		end
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
end


function editor.cameraInspector()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Camera Inspector", true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("New Camera") then
				toggleEditorUI("newCameraSpawn")
			end
			
			if ImGui.MenuItem("Close") then
				toggleEditorUI("cameraInspector")
			end
			
			ImGui.EndMenuBar()
		end
		
		
		
		
		if ImGui.BeginCombo(getLang("Select an entity"), camerainspectortag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in pairs(cyberscript.EntityManager) do
				if(v.surveillance ~= nil) then
					
					if ImGui.Selectable(v.tag) then
						
						
						camerainspectortag = v.tag
						
						ImGui.SetItemDefaultFocus()
					end
					
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		
		
		
		
		local obj = getEntityFromManager(camerainspectortag)
		
		if(obj.id ~= nil) then
			
			camerainspector[camerainspectortag] = {}
			
			
			
			if ImGui.Button(getLang("editor_Setting_Camera_lookat"), 100, 0) then
				
				
				enableCamera(camerainspectortag)
				
				
				
			end
			if ImGui.Button(getLang("Exit Camera"), 100, 0) then
				
				
				stopCamera(camerainspectortag)
				
				
				
			end
			
			
			
			
			local entity = obj.id
			local enti = Game.FindEntityByID(obj.id)
			if ImGui.Button("Despawn") then
				despawnEntity(camerainspectortag)
				cameraManager[camerainspectorindex] = nil
				camerainspectortag = ""
				camerainspectorindex = 1
				
				
			end
			if(enti ~= nil) then
				if(camerainspector[camerainspectortag].x == 0 or camerainspector[camerainspectortag].x == nil) then
					local entpos = enti:GetWorldPosition()
					camerainspector[camerainspectortag].x = entpos.x
					camerainspector[camerainspectortag].y = entpos.y
					camerainspector[camerainspectortag].z = entpos.z
					
					
					local entangle = GetSingleton('Quaternion'):ToEulerAngles(enti:GetWorldOrientation())
					camerainspector[camerainspectortag].yaw = entangle.yaw
					camerainspector[camerainspectortag].pitch = entangle.pitch
					camerainspector[camerainspectortag].roll = entangle.roll
					camerainspector[camerainspectortag].posstep = 0.1
					camerainspector[camerainspectortag].rotstep = 0.01
					
					
					camerainspector[camerainspectortag].record = {}
					camerainspector[camerainspectortag].doRecord = false
					camerainspector[camerainspectortag].playtick = 1
					camerainspector[camerainspectortag].playingmovement = false
				end
				
				
				
				if ImGui.Button("View as spawn_camera Json action")  then
					
					local obj = {}
					obj.name = "spawn_camera"
					obj.tag = camerainspectortag
					obj.surveillance = false
					obj.x = camerainspector[camerainspectortag].x
					obj.y = camerainspector[camerainspectortag].y
					obj.z = camerainspector[camerainspectortag].z
					obj.yaw = camerainspector[camerainspectortag].yaw
					obj.pitch = camerainspector[camerainspectortag].pitch
					obj.roll = camerainspector[camerainspectortag].roll
					obj.position_poi_from_position_x= 0
					obj.position_poi_from_position_y = 0
					obj.position_poi_from_position_z= 0
					obj.position_poi_type= 1
					obj.position_tag= "judy01"
					obj.position_way= "normal"
					obj.position_distance= 5
					obj.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
					obj.position_house_tag= "playerhouse01"
					obj.position_change_helper= "Write 'current' in obj.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in obj.position_poi_district you will get the current district \n if you write 'current in obj.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in obj.position_poi_subdistrict or obj.position_poi_district you will get an 'random' value"
					obj.position_node_usegameplay= false
					obj.position_house_way_helper= "default||enter||exit"
					obj.position_house_way= "default"
					obj.position_poi_use_location_tag= false
					obj.position_lookatdistance= 0
					obj.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
					obj.position_way_helper= "normal||behind||forward"
					obj.position_range= 50
					obj.position_poi_district= ""
					obj.position_poi_subdistrict= ""
					obj.position_poi_is_for_car= false
					obj.position_poi_from_position= false
					obj.position_poi_search= "type|subdistrict|district|tag"
					obj.position_poi_searchdistance= "near|far|random"
					obj.position= "at"
					
					currentOutput = JSON:encode_pretty(obj)
					
					toggleEditorUI("JsonActionOutput")
					
				end
				ImGui.SameLine()
				if ImGui.Button("Copy spawn_camera To Action Clipboard") then
					local obj = {}
					obj.name = "spawn_camera"
					obj.tag = camerainspectortag
					obj.surveillance = false
					obj.x = camerainspector[camerainspectortag].x
					obj.y = camerainspector[camerainspectortag].y
					obj.z = camerainspector[camerainspectortag].z
					obj.yaw = camerainspector[camerainspectortag].yaw
					obj.pitch = camerainspector[camerainspectortag].pitch
					obj.roll = camerainspector[camerainspectortag].roll
					obj.position_poi_from_position_x= 0
					obj.position_poi_from_position_y = 0
					obj.position_poi_from_position_z= 0
					obj.position_poi_type= 1
					obj.position_tag= "judy01"
					obj.position_way= "normal"
					obj.position_distance= 5
					obj.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
					obj.position_house_tag= "playerhouse01"
					obj.position_change_helper= "Write 'current' in obj.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in obj.position_poi_district you will get the current district \n if you write 'current in obj.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in obj.position_poi_subdistrict or obj.position_poi_district you will get an 'random' value"
					obj.position_node_usegameplay= false
					obj.position_house_way_helper= "default||enter||exit"
					obj.position_house_way= "default"
					obj.position_poi_use_location_tag= false
					obj.position_lookatdistance= 0
					obj.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
					obj.position_way_helper= "normal||behind||forward"
					obj.position_range= 50
					obj.position_poi_district= ""
					obj.position_poi_subdistrict= ""
					obj.position_poi_is_for_car= false
					obj.position_poi_from_position= false
					obj.position_poi_search= "type|subdistrict|district|tag"
					obj.position_poi_searchdistance= "near|far|random"
					obj.position= "at"
					clipboard["action"] = deepcopy(obj)
					
				end
				
				if ImGui.Button("View as move_camera Json action")  then
					
					local obj = {}
					obj.name = "move_camera"
					obj.tag = camerainspectortag
					
					obj.x = camerainspector[camerainspectortag].x
					obj.y = camerainspector[camerainspectortag].y
					obj.z = camerainspector[camerainspectortag].z
					obj.yaw = camerainspector[camerainspectortag].yaw
					obj.pitch = camerainspector[camerainspectortag].pitch
					obj.roll = camerainspector[camerainspectortag].roll
					obj.position_poi_from_position_x= 0
					obj.position_poi_from_position_y = 0
					obj.position_poi_from_position_z= 0
					obj.position_poi_type= 1
					obj.position_tag= "judy01"
					obj.position_way= "normal"
					obj.position_distance= 5
					obj.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
					obj.position_house_tag= "playerhouse01"
					obj.position_change_helper= "Write 'current' in obj.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in obj.position_poi_district you will get the current district \n if you write 'current in obj.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in obj.position_poi_subdistrict or obj.position_poi_district you will get an 'random' value"
					obj.position_node_usegameplay= false
					obj.position_house_way_helper= "default||enter||exit"
					obj.position_house_way= "default"
					obj.position_poi_use_location_tag= false
					obj.position_lookatdistance= 0
					obj.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
					obj.position_way_helper= "normal||behind||forward"
					obj.position_range= 50
					obj.position_poi_district= ""
					obj.position_poi_subdistrict= ""
					obj.position_poi_is_for_car= false
					obj.position_poi_from_position= false
					obj.position_poi_search= "type|subdistrict|district|tag"
					obj.position_poi_searchdistance= "near|far|random"
					obj.position= "at"
					
					currentOutput = JSON:encode_pretty(obj)
					
					toggleEditorUI("JsonActionOutput")
					
				end
				ImGui.SameLine()
				if ImGui.Button("Copy move_camera To Action Clipboard") then
					local obj = {}
					obj.name = "move_camera"
					obj.tag = camerainspectortag
					
					obj.x = camerainspector[camerainspectortag].x
					obj.y = camerainspector[camerainspectortag].y
					obj.z = camerainspector[camerainspectortag].z
					obj.yaw = camerainspector[camerainspectortag].yaw
					obj.pitch = camerainspector[camerainspectortag].pitch
					obj.roll = camerainspector[camerainspectortag].roll
					obj.position_poi_from_position_x= 0
					obj.position_poi_from_position_y = 0
					obj.position_poi_from_position_z= 0
					obj.position_poi_type= 1
					obj.position_tag= "judy01"
					obj.position_way= "normal"
					obj.position_distance= 5
					obj.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
					obj.position_house_tag= "playerhouse01"
					obj.position_change_helper= "Write 'current' in obj.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in obj.position_poi_district you will get the current district \n if you write 'current in obj.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in obj.position_poi_subdistrict or obj.position_poi_district you will get an 'random' value"
					obj.position_node_usegameplay= false
					obj.position_house_way_helper= "default||enter||exit"
					obj.position_house_way= "default"
					obj.position_poi_use_location_tag= false
					obj.position_lookatdistance= 0
					obj.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
					obj.position_way_helper= "normal||behind||forward"
					obj.position_range= 50
					obj.position_poi_district= ""
					obj.position_poi_subdistrict= ""
					obj.position_poi_is_for_car= false
					obj.position_poi_from_position= false
					obj.position_poi_search= "type|subdistrict|district|tag"
					obj.position_poi_searchdistance= "near|far|random"
					obj.position= "at"
					clipboard["action"] = deepcopy(obj)
					
				end
				
				if ImGui.Button("View Despawn Action as JSON ") then
					local obj = deepcopy(cyberscript.actiontemplate["despawn_entity"], nil)
					obj.tag = camerainspectortag
					currentOutput = JSON:encode_pretty(obj)
					
					toggleEditorUI("JsonActionOutput")
				end
				ImGui.SameLine()
				if ImGui.Button("Copy Despawn Action To Action Clipboard")then
					local obj = deepcopy(cyberscript.actiontemplate["despawn_entity"], nil)
					obj.tag = camerainspectortag
					
					
					clipboard["action"] = deepcopy(obj)
					
				end
				
				
				
				-- Functions
				if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
					
					if ImGui.BeginTabItem(getLang("Position and Movement")) then
						if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
							
							
							if ImGui.BeginTabItem(getLang("Position")) then
								
								
								camerainspector[camerainspectortag].posstep =  ImGui.DragFloat("##post", camerainspector[camerainspectortag].posstep, 0.1, 0.1, 10, "%.3f Position Step")
								camerainspector[camerainspectortag].rotstep =  ImGui.DragFloat("##rost", camerainspector[camerainspectortag].rotstep, 0.01, 0.01, 0.01, "%.3f Rotation Step")
								
								
								
								camerainspector[camerainspectortag].x,camerainspector[camerainspectortag].change =  ImGui.DragFloat("##x", camerainspector[camerainspectortag].x, posstep, -9999, 9999, "%.3f X")
								if camerainspector[camerainspectortag].change then
									local poss = Vector4.new( camerainspector[camerainspectortag].x, camerainspector[camerainspectortag].y,  camerainspector[camerainspectortag].z,1)
									
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									
									
									moveCamera(camerainspectortag,poss,angless)
								end
								
								camerainspector[camerainspectortag].y,camerainspector[camerainspectortag].change = ImGui.DragFloat("##y", camerainspector[camerainspectortag].y, posstep, -9999, 9999, "%.3f Y")
								if camerainspector[camerainspectortag].change then
									local poss = Vector4.new( camerainspector[camerainspectortag].x, camerainspector[camerainspectortag].y,  camerainspector[camerainspectortag].z,1)
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									
									
									
									moveCamera(camerainspectortag,poss,angless)
								end
								
								
								camerainspector[camerainspectortag].z,camerainspector[camerainspectortag].change = ImGui.DragFloat("##z", camerainspector[camerainspectortag].z, posstep, -9999, 9999, "%.3f Z")
								if camerainspector[camerainspectortag].change then
									local poss = Vector4.new( camerainspector[camerainspectortag].x, camerainspector[camerainspectortag].y,  camerainspector[camerainspectortag].z,1)
									
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									
									
									moveCamera(camerainspectortag,poss,angless)
								end
								
								
								
								
								camerainspector[camerainspectortag].yaw,camerainspector[camerainspectortag].change =  ImGui.DragFloat("##yaw", camerainspector[camerainspectortag].yaw, rotstep, -9999, 9999, "%.4f YAW")
								if camerainspector[camerainspectortag].change then
									local poss = Vector4.new( camerainspector[camerainspectortag].x, camerainspector[camerainspectortag].y,  camerainspector[camerainspectortag].z,1)
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									
									moveCamera(camerainspectortag,poss,angless)
								end
								
								
								camerainspector[camerainspectortag].pitch,camerainspector[camerainspectortag].change = ImGui.DragFloat("##pitch", camerainspector[camerainspectortag].pitch, rotstep, -9999, 9999, "%.3f PITCH")
								if camerainspector[camerainspectortag].change then
									local poss = Vector4.new( camerainspector[camerainspectortag].x, camerainspector[camerainspectortag].y,  camerainspector[camerainspectortag].z,1)
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									
									moveCamera(camerainspectortag,poss,angless)
								end
								camerainspector[camerainspectortag].roll,camerainspector[camerainspectortag].change = ImGui.DragFloat("##roll", camerainspector[camerainspectortag].roll, rotstep, -9999, 9999, "%.3f ROLL")
								
								
								
								
								if camerainspector[camerainspectortag].change then
									local poss = Vector4.new( camerainspector[camerainspectortag].x, camerainspector[camerainspectortag].y,  camerainspector[camerainspectortag].z,1)
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									moveCamera(camerainspectortag,poss,angless)
								end
								
								
								
								
								if ImGui.Button("Copy Player's XYZ", 300, 0) then
									
									local vec4 = Game.GetPlayer():GetWorldPosition()
									vec4.z = vec4.z+1.5
									camerainspector[camerainspectortag].x = vec4.x
									camerainspector[camerainspectortag].y = vec4.y
									camerainspector[camerainspectortag].z = vec4.z
									
									local angless = {}
									angless.roll = camerainspector[camerainspectortag].roll
									angless.pitch = camerainspector[camerainspectortag].pitch
									angless.yaw = camerainspector[camerainspectortag].yaw
									
									moveCamera(camerainspectortag,vec4,angless)
									
								end
								
								
								
								
								
								
								
								
								
								ImGui.EndTabItem()
								
							end
							
							
							
							ImGui.EndTabBar()
						end
						
						
						
						
						ImGui.EndTabItem()
					end
					
					
					
					
					ImGui.EndTabItem()
				end
				
				ImGui.EndTabBar()
			end
			
			
			else
			
			if ImGui.Button("Despawn") then
				--print(dump(cameraManager))
				--print(camerainspectorindex)
				cameraManager[camerainspectorindex] = nil
				camerainspectortag = ""
				camerainspectorindex = 1
			end
			
			
			
		end		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
end

function editor.newMappinSpawn()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Spawn mappin", true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			toggleEditorUI("newCameraSpawn")
		end
		ImGui.EndMenuBar()
		end
		
		
		newentity.tag = ImGui.InputText(getLang("Tag :"), newentity.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if(newentity.tag ~= "" ) then
			if ImGui.Button("Spawn")then
				local pos = Game.GetPlayer():GetWorldPosition()
				local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
				
				registerMappin(pos.x,pos.y,pos.z,newentity.tag,"ExclamationMarkVariant",true,true,"",nil,newentity.tag,"My mappin editor desc",nil,nil,0)
				
				toggleEditorUI("newMappinSpawn")
			end
			else
			ImGui.Text("You must choose a tweak and put a tag for spawn an entity")
		end
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
end


function editor.mappinInspector()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Mappin Inspector", true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("New Mappin") then
				toggleEditorUI("newMappinSpawn")
			end
			
			if ImGui.MenuItem("Close") then
				toggleEditorUI("mappinInspector")
			end
			
			if ImGui.MenuItem("reset table") then
				mappinManager ={}
			end
			
			
			ImGui.EndMenuBar()
		end
		
		
		if(not isEmpty(mappinManager)) then
			
			if ImGui.BeginCombo(getLang("Select an mappin"), "") then -- Remove the ## if you'd like for the title to display above combo box
				
				
				
				for k,v in pairs(mappinManager) do
					
					
					if ImGui.Selectable(k) then
						
						
						mappininspectortag = k
						
						ImGui.SetItemDefaultFocus()
					end
					
					
					
					
				end
				
				
				ImGui.EndCombo()
			end
			
			
			
			
			
			
			
			local obj = mappinManager[mappininspectortag]
			
			if(obj ~= nil and obj.id ~= nil) then
				
				
				if mappininspector[mappininspectortag] == nil then mappininspector[mappininspectortag] = {} end
				
				
				
				if ImGui.Button(getLang("Teleport to"), 100, 0) then
					
					
					local pos = mappinManager[mappininspectortag].position
					TeleportPlayerToPosition(pos.x,pos.y,pos.z)
					
					
					
				end
				
				
				
				
				
				
				
				if(obj.id ~= nil) then
					if ImGui.Button("Despawn") then
					deleteMappinByTag(mappininspectortag)
					
					
					mappininspectortag = ""
					
					
					
				end
					if(mappininspector[mappininspectortag].x == nil) then
						--print("tot")
						mappininspector[mappininspectortag].x = mappinManager[mappininspectortag].position.x
						mappininspector[mappininspectortag].y = mappinManager[mappininspectortag].position.y
						mappininspector[mappininspectortag].z = mappinManager[mappininspectortag].position.z
						
						mappininspector[mappininspectortag].typemap = mappinManager[mappininspectortag].variant
						mappininspector[mappininspectortag].wall = mappinManager[mappininspectortag].wall
						mappininspector[mappininspectortag].range = mappinManager[mappininspectortag].range
						mappininspector[mappininspectortag].desc = mappinManager[mappininspectortag].desc
						mappininspector[mappininspectortag].active = mappinManager[mappininspectortag].active
						mappininspector[mappininspectortag].icon = mappinManager[mappininspectortag].style.icon
						mappininspector[mappininspectortag].color = mappinManager[mappininspectortag].style.color
						mappininspector[mappininspectortag].title = mappinManager[mappininspectortag].title
						
					end
					
					
					
					if ImGui.Button("View as spawn_camera Json action")  then
						
						local objs = deepcopy(cyberscript.actiontemplate["set_mappin"], nil)
						
						objs.tag = mappininspectortag
						objs.x = mappinManager[mappininspectortag].position.x
						objs.y = mappinManager[mappininspectortag].position.y
						objs.z = mappinManager[mappininspectortag].position.z
						
						objs.typemap = mappinManager[mappininspectortag].variant
						objs.wall = mappinManager[mappininspectortag].wall
						objs.range = mappinManager[mappininspectortag].range
						objs.desc = mappinManager[mappininspectortag].desc
						objs.active = mappinManager[mappininspectortag].variant
						objs.icon = mappinManager[mappininspectortag].style.icon
						objs.color = mappinManager[mappininspectortag].style.color
						objs.title = mappinManager[mappininspectortag].title
						
						
						
						
						currentOutput = JSON:encode_pretty(objs)
						
						toggleEditorUI("JsonActionOutput")
						
					end
					ImGui.SameLine()
					if ImGui.Button("Copy spawn_camera To Action Clipboard") then
						local objs = deepcopy(cyberscript.actiontemplate["set_mappin"], nil)
						
						objs.tag = mappininspectortag
						objs.x = mappinManager[mappininspectortag].position.x
						objs.y = mappinManager[mappininspectortag].position.y
						objs.z = mappinManager[mappininspectortag].position.z
						
						objs.typemap = mappinManager[mappininspectortag].variant
						objs.wall = mappinManager[mappininspectortag].wall
						objs.range = mappinManager[mappininspectortag].range
						objs.desc = mappinManager[mappininspectortag].desc
						objs.active = mappinManager[mappininspectortag].active
						objs.icon = mappinManager[mappininspectortag].style.icon
						objs.color = mappinManager[mappininspectortag].style.color
						objs.title = mappinManager[mappininspectortag].title
						objs.group = mappinManager[mappininspectortag].group
						clipboard["action"] = deepcopy(objs)
						
					end
					
					
					if ImGui.Button("View Despawn Action as JSON ") then
						local objs = deepcopy(cyberscript.actiontemplate["delete_mappin"], nil)
						objs.tag = mappininspectortag
						currentOutput = JSON:encode_pretty(objs)
						
						toggleEditorUI("JsonActionOutput")
					end
					ImGui.SameLine()
					if ImGui.Button("Copy Despawn Action To Action Clipboard")then
						local objs = deepcopy(cyberscript.actiontemplate["delete_mappin"], nil)
						objs.tag = mappininspectortag
						
						
						clipboard["action"] = deepcopy(objs)
						
					end
					
					
					
					-- Functions
					if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
						
						if ImGui.BeginTabItem(getLang("Position and Movement")) then
							if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
								
								
								if ImGui.BeginTabItem(getLang("Position")) then
									
									
									mappininspector[mappininspectortag].posstep =  ImGui.DragFloat("##post", mappininspector[mappininspectortag].posstep, 0.1, 0.1, 10, "%.3f Position Step")
									
									
									
									mappininspector[mappininspectortag].x,mappininspector[mappininspectortag].change =  ImGui.DragFloat("##x", mappininspector[mappininspectortag].x, posstep, -9999, 9999, "%.3f X")
									if mappininspector[mappininspectortag].change then
										local poss = Vector4.new( mappininspector[mappininspectortag].x, mappininspector[mappininspectortag].y,  mappininspector[mappininspectortag].z,1)
										
										
										editMappin(poss.x,poss.y,poss.z,mappininspectortag,mappininspector[mappininspectortag].typemap,mappininspector[mappininspectortag].active,mappininspector[mappininspectortag].group,nil,mappininspector[mappininspectortag].title,mappininspector[mappininspectortag].desc,mappininspector[mappininspectortag].color,mappininspector[mappininspectortag].icon,mappininspector[mappininspectortag].range)
										
										
									end
									
									mappininspector[mappininspectortag].y,mappininspector[mappininspectortag].change = ImGui.DragFloat("##y", mappininspector[mappininspectortag].y, posstep, -9999, 9999, "%.3f Y")
									if mappininspector[mappininspectortag].change then
										local poss = Vector4.new( mappininspector[mappininspectortag].x, mappininspector[mappininspectortag].y,  mappininspector[mappininspectortag].z,1)
										
										
										editMappin(poss.x,poss.y,poss.z,mappininspectortag,mappininspector[mappininspectortag].typemap,mappininspector[mappininspectortag].active,mappininspector[mappininspectortag].group,nil,mappininspector[mappininspectortag].title,mappininspector[mappininspectortag].desc,mappininspector[mappininspectortag].color,mappininspector[mappininspectortag].icon,mappininspector[mappininspectortag].range)
										
									end
									
									
									mappininspector[mappininspectortag].z,mappininspector[mappininspectortag].change = ImGui.DragFloat("##z", mappininspector[mappininspectortag].z, posstep, -9999, 9999, "%.3f Z")
									if mappininspector[mappininspectortag].change then
										local poss = Vector4.new( mappininspector[mappininspectortag].x, mappininspector[mappininspectortag].y,  mappininspector[mappininspectortag].z,1)
										
										
										
										editMappin(poss.x,poss.y,poss.z,mappininspectortag,mappininspector[mappininspectortag].typemap,mappininspector[mappininspectortag].active,mappininspector[mappininspectortag].group,nil,mappininspector[mappininspectortag].title,mappininspector[mappininspectortag].desc,mappininspector[mappininspectortag].color,mappininspector[mappininspectortag].icon,mappininspector[mappininspectortag].range)
										
									end
									
									
									mappininspector[mappininspectortag].range,mappininspector[mappininspectortag].change = ImGui.DragFloat("##range", mappininspector[mappininspectortag].range, posstep, -9999, 9999, "%.3f Range")
									if mappininspector[mappininspectortag].change then
										local poss = Vector4.new( mappininspector[mappininspectortag].x, mappininspector[mappininspectortag].y,  mappininspector[mappininspectortag].z,1)
										
										
										
										editMappin(poss.x,poss.y,poss.z,mappininspectortag,mappininspector[mappininspectortag].typemap,mappininspector[mappininspectortag].active,mappininspector[mappininspectortag].group,nil,mappininspector[mappininspectortag].title,mappininspector[mappininspectortag].desc,mappininspector[mappininspectortag].color,mappininspector[mappininspectortag].icon,mappininspector[mappininspectortag].range)
										
									end
									
									
									
									
									
									
									
									if ImGui.Button("Copy Player's XYZ", 300, 0) then
										
										local vec4 = Game.GetPlayer():GetWorldPosition()
										
										mappininspector[mappininspectortag].x = vec4.x
										mappininspector[mappininspectortag].y = vec4.y
										mappininspector[mappininspectortag].z = vec4.z
										
										
										editMappin(vec4.x,vec4.y,vec4.z,mappininspectortag,mappininspector[mappininspectortag].typemap,mappininspector[mappininspectortag].active,mappininspector[mappininspectortag].group,nil,mappininspector[mappininspectortag].title,mappininspector[mappininspectortag].desc,mappininspector[mappininspectortag].color,mappininspector[mappininspectortag].icon,mappininspector[mappininspectortag].range)
										
										
									end
									
									
									ImGui.Text("Type of Mappin : ") 
									ImGui.SameLine()
									if ImGui.BeginCombo("##mappinTypeEnum", mappininspector[mappininspectortag]["typemap"]) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										for i,v in ipairs(mappinTypeEnum) do
											
											if ImGui.Selectable(v, (mappininspector[mappininspectortag]["typemap"] == v)) then
												
												
												mappininspector[mappininspectortag]["typemap"] = v
												
												
												ImGui.SetItemDefaultFocus()
											end
											
											
										end
										
										ImGui.EndCombo()
									end
									
									ImGui.Spacing()
									
									ImGui.Text("Active ? ") 
									ImGui.SameLine()
									mappininspector[mappininspectortag]["active"] =ImGui.Checkbox("##active", mappininspector[mappininspectortag]["active"])
									
									ImGui.Spacing()
									
									
									ImGui.Text("Group : ") 
									ImGui.SameLine()
									mappininspector[mappininspectortag]["mapgroup"] = ImGui.InputText("##mapgroup", mappininspector[mappininspectortag]["mapgroup"], 5000, ImGuiInputTextFlags.None)
									
									ImGui.Spacing()
									
									ImGui.Text("Title : ") 
									ImGui.SameLine()
									mappininspector[mappininspectortag]["title"] = ImGui.InputText("##title", mappininspector[mappininspectortag]["title"], 5000, ImGuiInputTextFlags.None)
									
									ImGui.Spacing()
									
									ImGui.Text("Description : ") 
									ImGui.SameLine()
									mappininspector[mappininspectortag]["desc"] = ImGui.InputText("##desc", mappininspector[mappininspectortag]["desc"], 5000, ImGuiInputTextFlags.None)
									
									ImGui.Spacing()
									
									editoriconsearch = ImGui.InputText(getLang("Icon Choice Filter"), editoriconsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
									if ImGui.BeginCombo("Icon :", "") then
										
										
										for i,v in ipairs(choiceIconList) do
											if (editoriconsearch == "" or (editoriconsearch ~= "" and (string.match(string.lower(v),editoriconsearch)))) then
												if ImGui.Selectable(v, (mappininspector[mappininspectortag].icon == v)) then
													mappininspector[mappininspectortag].icon = v
													
													
													
													ImGui.SetItemDefaultFocus()
												end
												
											end
										end
										
										ImGui.EndCombo()
									end
									
									ImGui.Text("Style : ")
									if(mappininspector[mappininspectortag].color ~= nil and mappininspector[mappininspectortag].color.red ~= nil and mappininspector[mappininspectortag].color.green ~= nil and mappininspector[mappininspectortag].color.blue ~= nil ) then
										
										ImGui.PushStyleColor(ImGuiCol.Text,round((mappininspector[mappininspectortag].color.red/255),8), round((mappininspector[mappininspectortag].color.green/255),8), round((mappininspector[mappininspectortag].color.blue/255),8), 1)
										
										ImGui.Text("Current Color")
										
										ImGui.PopStyleColor(1)
										
										
										ImGui.Text("Red : ".. mappininspector[mappininspectortag].color.red)
										ImGui.Text("Green : ".. mappininspector[mappininspectortag].color.green)
										ImGui.Text("Blue : ".. mappininspector[mappininspectortag].color.blue)
										else
										
										ImGui.Text("No current Style defined ")
										
									end
									
									if ImGui.Button("Open Color Picker") then
										toggleEditorUI("colorPicker")
									end
									
									ImGui.SameLine()
									
									if ImGui.Button("Copy RGB from Color Picker") then
										mappininspector[mappininspectortag].color = {}
										mappininspector[mappininspectortag].color.red = currentcolorRGB.red 
										mappininspector[mappininspectortag].color.green = currentcolorRGB.green
										mappininspector[mappininspectortag].color.blue = currentcolorRGB.blue
										--print(dump(mappininspector[mappininspectortag].color))
									end
									
									if ImGui.Button("Remove Color") then
										mappininspector[mappininspectortag].color = nil
									end
									
									
									
									ImGui.Separator()
									if ImGui.Button("Update", 300, 0) then
										
										
										editMappin(mappininspector[mappininspectortag].x,mappininspector[mappininspectortag].y,mappininspector[mappininspectortag].z,mappininspectortag,mappininspector[mappininspectortag].typemap,mappininspector[mappininspectortag].active,mappininspector[mappininspectortag].group,nil,mappininspector[mappininspectortag].title,mappininspector[mappininspectortag].desc,mappininspector[mappininspectortag].color,mappininspector[mappininspectortag].icon,mappininspector[mappininspectortag].range)
										
										
									end
									
									
									
									
									
									ImGui.EndTabItem()
									
								end
								
								
								
								ImGui.EndTabBar()
							end
							
							
							
							
							ImGui.EndTabItem()
						end
						
						
						
						
						ImGui.EndTabItem()
					end
					
					ImGui.EndTabBar()
				end
				
				
				else
				
				if ImGui.Button("Despawn") then
					
					
					
					
					
					mappininspectortag = ""
					
				end
				
				
				
			end		
			
			
			
		end
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
end


function editor.entityInspector()
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(500, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Entity Inspector", true, ImGuiWindowFlags.MenuBar) then
		
		if ImGui.BeginMenuBar() then 
			
			if ImGui.MenuItem("Close") then
				toggleEditorUI("entityInspector")
			end
			
			
			if ImGui.MenuItem("Spawn Entity")  then
				
				toggleEditorUI("newSpawn")
				
			end
			
			if ImGui.MenuItem("Spawn Vehicle")  then
				
				toggleEditorUI("newSpawnVehicle")
				
			end
			
			ImGui.EndMenuBar()
		end
		
		
		
		
		if ImGui.BeginCombo(getLang("Select an entity"), entityinspectortag) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for k,v in pairs(cyberscript.EntityManager) do
				
				
				if ImGui.Selectable(k, false) then
					
					
					entityinspectortag = k
					ImGui.SetItemDefaultFocus()
				end
				
				
				
				
			end
			
			
			ImGui.EndCombo()
		end
		
		
		
		
		
		
		
		local obj = getEntityFromManager(entityinspectortag)
		
		if(obj.id ~= nil) then
			
			
			
			
			local entity = obj.id
			local enti = Game.FindEntityByID(obj.id)
			
			if(	entityinspector[entityinspectortag] == nil or entityinspector[entityinspectortag].teleport == nil) then
				entityinspector[entityinspectortag] = {}
				local entpos = enti:GetWorldPosition()
				entityinspector[entityinspectortag].teleport = {}
				entityinspector[entityinspectortag].teleport.x = entpos.x
				entityinspector[entityinspectortag].teleport.y = entpos.y
				entityinspector[entityinspectortag].teleport.z = entpos.z
				
				
				entityinspector[entityinspectortag].move = {}
				entityinspector[entityinspectortag].move.x = entpos.x
				entityinspector[entityinspectortag].move.y = entpos.y
				entityinspector[entityinspectortag].move.z = entpos.z
				
				local entangle = GetSingleton('Quaternion'):ToEulerAngles(enti:GetWorldOrientation())
				entityinspector[entityinspectortag].teleport.yaw = entangle.yaw
				entityinspector[entityinspectortag].teleport.pitch = entangle.pitch
				entityinspector[entityinspectortag].teleport.roll = entangle.roll
				entityinspector[entityinspectortag].teleport.posstep = 0.1
				entityinspector[entityinspectortag].teleport.rotstep = 0.01
				
				entityinspector[entityinspectortag].move.yaw = entangle.yaw
				entityinspector[entityinspectortag].move.pitch = entangle.pitch
				entityinspector[entityinspectortag].move.roll = entangle.roll
				entityinspector[entityinspectortag].move.posstep = 0.1
				entityinspector[entityinspectortag].move.rotstep = 0.01
				
				
				entityinspector[entityinspectortag].record = {}
				entityinspector[entityinspectortag].doRecord = false
				entityinspector[entityinspectortag].playtick = 1
				entityinspector[entityinspectortag].playingmovement = false
				--print("test")
			end
			
			if ImGui.Button("Despawn") then
				despawnEntity(entityinspectortag)
			end
			ImGui.Separator()
			ImGui.Text("Script helper :")
			if ImGui.Button("View Spawn Action as JSON")then
				local pos = enti:GetWorldPosition()
				local angle = enti:GetWorldOrientation():ToEulerAngles()
				local objs = {}
				if enti:IsVehicle() then
					objs = deepcopy(cyberscript.actiontemplate["spawn_vehicule_v2"], nil)
					else
					objs = deepcopy(cyberscript.actiontemplate["spawn_npc"], nil)
					objs.yaw = angle.yaw
					objs.pitch = angle.pitch
					objs.roll = angle.roll
				end
				
				objs.tag = entityinspectortag
				objs.source_tag = obj.tweak
				
				objs.x = pos.x
				objs.y = pos.y
				objs.z = pos.z
				
				
				
				currentOutput = JSON:encode_pretty(objs)
				
				toggleEditorUI("JsonActionOutput")
			end
			ImGui.SameLine()
			if ImGui.Button("Copy Spawn Action To Action Clipboard")then
				local pos = enti:GetWorldPosition()
				local angle = enti:GetWorldOrientation():ToEulerAngles()
				local objs = {}
				if enti:IsVehicle() then
					objs = deepcopy(cyberscript.actiontemplate["spawn_vehicule_v2"], nil)
					else
					objs = deepcopy(cyberscript.actiontemplate["spawn_npc"], nil)
					objs.yaw = angle.yaw
					objs.pitch = angle.pitch
					objs.roll = angle.roll
				end
				objs.tag = entityinspectortag
				objs.source_tag = obj.tweak
				objs.x = pos.x
				objs.y = pos.y
				objs.z = pos.z
				
				
				clipboard["action"] = deepcopy(objs)
				
			end
			
			if ImGui.Button("View Despawn Action as JSON ") then
				local objs = deepcopy(cyberscript.actiontemplate["despawn_entity"], nil)
				objs.tag = entityinspectortag
				currentOutput = JSON:encode_pretty(objs)
				
				toggleEditorUI("JsonActionOutput")
			end
			ImGui.SameLine()
			if ImGui.Button("Copy Despawn Action To Action Clipboard")then
				local objs = deepcopy(cyberscript.actiontemplate["despawn_entity"], nil)
				objs.tag = entityinspectortag
				
				
				clipboard["action"] = deepcopy(objs)
				
			end
			ImGui.Separator()
			local res,messg = pcall(function()
				
				-- Functions
				if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
					
					if ImGui.BeginTabItem(getLang("Info")) and enti ~= nil then
						
						
						IGE.DrawNodeTree("GetEntityID", "entEntityID", enti:GetEntityID(), 
						function(entEntityID) entEntityIDDraw(enti) end)
						
						
						
						if enti:IsPlayer() then
							IGE.DisplayObjectArray("GetPlayerCurrentWorkspotTags", "CName", enti:GetPlayerCurrentWorkspotTags(),
							function(key, value) CNameDraw("Tag", value) end)
						end
						
						if enti:IsVehicle() then
							ImGui.Text("Entity is an vehicle")
							ImGui.Spacing()
							ImGui.Text("Available Seats Slot: ")
							
							local seatstable = GetSeats(enti)
							
							if #seatstable > 0 then
								for i=1, #seatstable do 
									ImGui.Text(seatstable[i])
									ImGui.Spacing()
								end
							end
							else
							ImGui.Text("Entity is not an vehicule")
							ImGui.Spacing()
						end
						
						
						
						if obj.id ~= nil then
							ImGui.Text("This entity has been registered as Entity in CyberScript with tag "..obj.tag)
							ImGui.Spacing()
							
							ImGui.Text("This entity has been registered as AV ?"..tostring(obj.isAV))
							ImGui.Spacing()
							if ImGui.Button("dump") then
								--logme(10,tostring(dump(obj)))
							end
							local group = getEntityGroupfromEntityTag(obj.tag)
							
							if group ~= nil then
								ImGui.Text("This entity has been registered in the Group "..group.tag)
							end
						end
						
					
						test = ImGui.InputText(getLang("Current appearance :"), NameToString(enti:GetCurrentAppearanceName()), 5000, ImGuiInputTextFlags.AutoSelectAll)
						
						entityinputappearance = ImGui.InputText(getLang("Set assppearance :"), entityinputappearance, 5000, ImGuiInputTextFlags.AutoSelectAll)
						if ImGui.Button("Set appearance")then
							setAppearance(enti,entityinputappearance)
						end
						
						CNameDraw("GetCurrentContext", enti:GetCurrentContext())
						CNameDraw("GetDisplayName", Game.NameToString(enti:GetDisplayName()))
						
						
						pcall(function()
							ImGui.Text("GetTweakDBDisplayName: "..enti:GetTweakDBDisplayName(true))
							ImGui.Text("GetTweakDBFullDisplayName:"..enti:GetTweakDBFullDisplayName(true))
							ImGui.Text("GetAttitudeGroup:"..Game.NameToString(enti:GetAttitudeAgent():GetAttitudeGroup()))
							
							
						end)
						
						IGE.DisplayVector4("GetWorldPosition", enti:GetWorldPosition())
						IGE.ObjectToText("GetWorldOrientation", enti:GetWorldOrientation())
						IGE.DisplayVector4("GetWorldForward", enti:GetWorldForward())
						
						IGE.DisplayVector4("GetWorldRight", enti:GetWorldRight())
						IGE.DisplayVector4("GetWorldUp", enti:GetWorldUp())
						IGE.ObjectToText("GetWorldYaw", enti:GetWorldYaw())
						-- IGE.ObjectToText("IsAttached", entity:IsAttached()) -- Good way to tell if object has been deleted!
						-- IGE.ObjectToText("IsControlledByAnotherClient", entity:IsControlledByAnotherClient())
						-- IGE.ObjectToText("IsControlledByAnyPeer", entity:IsControlledByAnyPeer())
						-- IGE.ObjectToText("IsControlledBylocalPeer", entity:IsControlledBylocalPeer())
						-- IGE.ObjectToText("ShouldEnableRemoteLayer", entity:ShouldEnableRemoteLayer())
						-- IGE.ObjectToText("HasDirectActionsActive", entity:HasDirectActionsActive())
						-- IGE.ObjectToText("CanRevealRemoteActionsWheel", entity:CanRevealRemoteActionsWheel())
						-- IGE.ObjectToText("ShouldRegisterToHUD", entity:ShouldRegisterToHUD())
						-- IGE.ObjectToText("GetIsIconic", entity:GetIsIconic())
						-- IGE.ObjectToText("GetContentScale", entity:GetContentScale())
						-- IGE.ObjectToText("IsExplosive", entity:IsExplosive())
						-- IGE.ObjectToText("IsFastTravelPoint", entity:IsFastTravelPoint())
						-- IGE.ObjectToText("HasAnySlaveDevices", entity:HasAnySlaveDevices())
						-- IGE.ObjectToText("IsBodyDisposalPossible", entity:IsBodyDisposalPossible())
						-- IGE.ObjectToText("IsReplicated", entity:IsReplicated())
						
						
						ImGui.Unindent()
						
						
						
						ImGui.EndTabItem()
					end
					
					if enti ~= nil and enti:IsVehicle() then
						if ImGui.BeginTabItem(getLang("Teleport and Move")) then
							
							if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
								
								
								if ImGui.BeginTabItem(getLang("Teleport")) then
									
									
									entityinspector[entityinspectortag].teleport.posstep =  ImGui.DragFloat("##post", entityinspector[entityinspectortag].teleport.posstep, 0.1, 0.1, 10, "%.3f Position Step")
									entityinspector[entityinspectortag].teleport.rotstep =  ImGui.DragFloat("##rost", entityinspector[entityinspectortag].teleport.rotstep, 0.01, 0.01, 0.01, "%.3f Rotation Step")
									
									
									
									entityinspector[entityinspectortag].teleport.x,entityinspector[entityinspectortag].change =  ImGui.DragFloat("##x", entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.posstep, -9999, 9999, "%.3f X")
									if entityinspector[entityinspectortag].change then
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
									end
									
									
									entityinspector[entityinspectortag].teleport.y,entityinspector[entityinspectortag].change = ImGui.DragFloat("##y", entityinspector[entityinspectortag].teleport.y, entityinspector[entityinspectortag].teleport.posstep, -9999, 9999, "%.3f Y")
									if entityinspector[entityinspectortag].change then
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
									end
									entityinspector[entityinspectortag].teleport.z,entityinspector[entityinspectortag].change = ImGui.DragFloat("##z", entityinspector[entityinspectortag].teleport.z, entityinspector[entityinspectortag].teleport.posstep, -9999, 9999, "%.3f Z")
									if entityinspector[entityinspectortag].change then
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
									end
									
									
									entityinspector[entityinspectortag].teleport.yaw,entityinspector[entityinspectortag].change =  ImGui.DragFloat("##yaw", entityinspector[entityinspectortag].teleport.yaw, entityinspector[entityinspectortag].teleport.rotstep, -9999, 9999, "%.4f YAW")
									if entityinspector[entityinspectortag].change then
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
									end
									entityinspector[entityinspectortag].teleport.pitch,entityinspector[entityinspectortag].change = ImGui.DragFloat("##pitch", entityinspector[entityinspectortag].teleport.pitch, entityinspector[entityinspectortag].teleport.rotstep, -9999, 9999, "%.3f PITCH")
									if entityinspector[entityinspectortag].change then
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
									end
									entityinspector[entityinspectortag].teleport.roll,entityinspector[entityinspectortag].change = ImGui.DragFloat("##roll", entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.rotstep, -9999, 9999, "%.3f ROLL")
									if entityinspector[entityinspectortag].change then
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
									end
									
									
									if ImGui.Button("Copy Player's XYZ", 300, 0) then
										
										local vec4 = Game.GetPlayer():GetWorldPosition()
										entityinspector[entityinspectortag].teleport.x = vec4.x
										entityinspector[entityinspectortag].teleport.y = vec4.y
										entityinspector[entityinspectortag].teleport.z = vec4.z
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										Game.GetTeleportationFacility():Teleport(enti, Vector4.new(poss.x, poss.y, poss.z,1), angless)
										
									end
									
									
									if ImGui.Button("View as JSON action")  then
										
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										
										local objs = {}
										objs.name = "teleport"
										objs.tag = entityinspectortag
										objs.group = false
										
										objs.position_poi_from_position_x= 0
										objs.position_poi_from_position_y = 0
										objs.position_poi_from_position_z= 0
										objs.position_poi_type= 1
										objs.position_tag= "judy01"
										objs.position_way= "normal"
										objs.position_distance= 5
										objs.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
										objs.position_house_tag= "playerhouse01"
										objs.position_change_helper= "Write 'current' in objs.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in objs.position_poi_district you will get the current district \n if you write 'current in objs.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in objs.position_poi_subdistrict or objs.position_poi_district you will get an 'random' value"
										objs.position_node_usegameplay= false
										objs.position_house_way_helper= "default||enter||exit"
										objs.position_house_way= "default"
										objs.position_poi_use_location_tag= false
										objs.position_lookatdistance= 0
										objs.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
										objs.position_way_helper= "normal||behind||forward"
										objs.position_range= 50
										objs.position_poi_district= ""
										objs.position_poi_subdistrict= ""
										objs.position_poi_is_for_car= false
										objs.position_poi_from_position= false
										objs.position_poi_search= "type|subdistrict|district|tag"
										objs.position_poi_searchdistance= "near|far|random"
										objs.position= "at"
										
										
										objs.x = poss.x
										objs.y =  poss.y
										objs.z = poss.z
										
										
										
										objs.roll = angless.roll
										objs.pitch =  angless.pitch
										objs.yaw = angless.yaw
										
										
										
										
										
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
										
									end
									
									if ImGui.Button("Copy To Action Clipboard") then
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										
										local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
										
										local objs = {}
										objs.name = "teleport"
										objs.tag = entityinspectortag
										objs.group = false
										
										objs.position_poi_from_position_x= 0
										objs.position_poi_from_position_y = 0
										objs.position_poi_from_position_z= 0
										objs.position_poi_type= 1
										objs.position_tag= "judy01"
										objs.position_way= "normal"
										objs.position_distance= 5
										objs.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
										objs.position_house_tag= "playerhouse01"
										objs.position_change_helper= "Write 'current' in objs.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in objs.position_poi_district you will get the current district \n if you write 'current in objs.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in objs.position_poi_subdistrict or objs.position_poi_district you will get an 'random' value"
										objs.position_node_usegameplay= false
										objs.position_house_way_helper= "default||enter||exit"
										objs.position_house_way= "default"
										objs.position_poi_use_location_tag= false
										objs.position_lookatdistance= 0
										objs.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
										objs.position_way_helper= "normal||behind||forward"
										objs.position_range= 50
										objs.position_poi_district= ""
										objs.position_poi_subdistrict= ""
										objs.position_poi_is_for_car= false
										objs.position_poi_from_position= false
										objs.position_poi_search= "type|subdistrict|district|tag"
										objs.position_poi_searchdistance= "near|far|random"
										objs.position= "at"
										
										
										objs.x = poss.x
										objs.y =  poss.y
										objs.z = poss.z
										
										
										
										objs.roll = angless.roll
										objs.pitch =  angless.pitch
										objs.yaw = angless.yaw
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									if ImGui.Button(getLang("Teleport to"), 100, 0) then
										
										
										local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
										
										TeleportPlayerToPosition(poss.x,poss.y,poss.z)
										
										
										
									end
									
									
									ImGui.EndTabItem()
									
								end
								
								
								if ImGui.BeginTabItem(getLang("Move")) then
									
									if entityinspector[entityinspectortag].move == nil then entityinspector[entityinspectortag].move = "#hey_gle_dataterm_04" end
									if entityinspector[entityinspectortag].movename == nil then entityinspector[entityinspectortag].movename = "El Coyote Cojo" end
									
									
									ImGui.Text("Move to Fast Travel Point : ") 
									ImGui.SameLine()
									if ImGui.BeginCombo("##fasttrabvel", entityinspector[entityinspectortag].movename) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										for i,v in ipairs(mappedFastTravelPoint) do
											
											if ImGui.Selectable(v.name, (entityinspector[entityinspectortag].movename == v.name)) then
												
												
												entityinspector[entityinspectortag].move = v.markerref
												entityinspector[entityinspectortag].movename = v.name
												
												
												ImGui.SetItemDefaultFocus()
											end
											
											
										end
										
										ImGui.EndCombo()
									end
									
									
									
									
									
									if ImGui.Button("Move to ", 300, 0) then
										
										
										
										if(enti ~= nil) then
											local markerref = nil
											local position = nil
											for i=1, #mappedFastTravelPoint do
												local point = mappedFastTravelPoint[i]
												if(point.markerref == entityinspector[entityinspectortag].move) then
													markerref = point.markerrefdata
													position = point.position
												end
												if(markerref ~= nil) then
													--print(markerref)
													cyberscript.EntityManager[entityinspectortag].destination =position
													VehicleGoToGameNode(entityinspectortag, markerref, 300, false, false, true)
													break
												end
											end
										end
										
									end
									
									if ImGui.Button("View as JSON action")  then
										
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_go_to_fasttravel_point"], nil)
										
										
										objs.tag = entityinspectortag
										objs.destination =entityinspector[entityinspectortag].move
										objs.greenlight = false
										objs.needdriver = false
										objs.usetraffic = true
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
										
									end
									
									if ImGui.Button("Copy To Action Clipboard") then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_go_to_fasttravel_point"], nil)
										
										
										objs.tag = entityinspectortag
										objs.destination =entityinspector[entityinspectortag].move
										objs.greenlight = false
										objs.needdriver = false
										objs.usetraffic = true
										
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									
									
									
									
									ImGui.EndTabItem()
								end
								
								
								if ImGui.BeginTabItem(getLang("Follow")) then
									
									
									
									ImGui.Text("Follow Entity : ") 
									ImGui.SameLine()
									if ImGui.BeginCombo("##floowentity", entityinspector[entityinspectortag].follow) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										for k,v in pairs(cyberscript.EntityManager) do
											
											
											if ImGui.Selectable(k, false) then
												
												
												entityinspector[entityinspectortag].follow = k
												ImGui.SetItemDefaultFocus()
											end
											
											
											
											
										end
										
										ImGui.EndCombo()
										
									end
									
									
									
									
									if ImGui.Button("Follow !", 300, 0) then
										
										
										
										VehicleFollowEntity(entityinspectortag, entityinspector[entityinspectortag].follow)
									end
									
									if ImGui.Button("View as JSON action")  then
										
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_follow_entity"], nil)
										
										
										objs.vehicle = entityinspectortag
										objs.tag =entityinspector[entityinspectortag].follow
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
										
									end
									
									if ImGui.Button("Copy To Action Clipboard") then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_follow_entity"], nil)
										
										
										objs.vehicle = entityinspectortag
										objs.tag =entityinspector[entityinspectortag].follow
										
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									
									
									
									
									ImGui.EndTabItem()
								end
								
								
								
								ImGui.EndTabBar()
							end
							
							
							
							
							ImGui.EndTabItem()
						end
						
						if ImGui.BeginTabItem(getLang("Vehicle States")) then
							if ImGui.BeginTabBar("InspectorTabs2", ImGuiTabBarFlags.NoTooltip) then
								
								if ImGui.BeginTabItem(getLang("Main")) then
									
									
									
									
									ImGui.Text("Main : ") 
									if ImGui.Button("Detach all parts")then
										
										VehicleDetachAll(entityinspectortag)
									end
									ImGui.SameLine()
									if ImGui.Button("View Detach All Parts Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_detach_all_part"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Detach All Parts Action to Action Clipboard")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_detach_all_part"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										clipboard["action"] = deepcopy(objs)
									end
									
									if ImGui.Button("Explode")then
										
										VehicleDestroy(entityinspectortag)
									end
									ImGui.SameLine()
									if ImGui.Button("View Explode Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_explose"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Explode Action to Action Clipboard")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_explose"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										clipboard["action"] = deepcopy(objs)
									end
									
									
									if ImGui.Button("Repair")then
										
										VehicleRepair(entityinspectortag)
									end
									ImGui.SameLine()
									if ImGui.Button("View Repair Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_repair"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Repair Action to Action Clipboard")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_repair"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										clipboard["action"] = deepcopy(objs)
									end
									
									
									if ImGui.Button("Honk & Flash")then
										
										VehicleHonkFlash(entityinspectortag)
									end
									ImGui.SameLine()
									if ImGui.Button("View Honk & Flash Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_honk_and_flash"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Honk & Flash Action to Action Clipboard")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_honk_and_flash"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										clipboard["action"] = deepcopy(objs)
									end
									
									
									if ImGui.Button("Reset")then
										
										VehicleReset(entityinspectortag)
									end
									ImGui.SameLine()
									if ImGui.Button("View Reset Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_reset"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Reset Action to Action Clipboard")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_reset"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										clipboard["action"] = deepcopy(objs)
									end
									
									
									if ImGui.Button("Invincible")then
										
										VehicleSetInvincible(entityinspectortag)
									end
									ImGui.SameLine()
									if ImGui.Button("View Invincible Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_set_invincible"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Invincible Action to Action Clipboard")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_set_invincible"], nil)
										
										
										objs.tag = entityinspectortag
										
										
										
										clipboard["action"] = deepcopy(objs)
									end
									
									
									
									ImGui.EndTabItem()
									
								end
								
								
								if ImGui.BeginTabItem(getLang("Doors")) then
									
									
									
									if(entityinspector[entityinspectortag].doors == nil) then entityinspector[entityinspectortag].doors="open"end
									ImGui.Text("Doors : ") 
									ImGui.SameLine()
									if ImGui.BeginCombo("##statutEffect", entityinspector[entityinspectortag].doors) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										if ImGui.Selectable("open", (entityinspector[entityinspectortag].doors == "open")) then
											
											
											entityinspector[entityinspectortag].doors = "open"
											
											VehicleDoors(entityinspectortag,"open")
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										if ImGui.Selectable("close", (entityinspector[entityinspectortag].doors == "close")) then
											
											
											entityinspector[entityinspectortag].doors = "close"
											
											VehicleDoors(entityinspectortag,"close")
											
											ImGui.SetItemDefaultFocus()
										end
										
										if ImGui.Selectable("lock", (entityinspector[entityinspectortag].doors == "lock")) then
											
											
											entityinspector[entityinspectortag].doors = "lock"
											
											VehicleDoors(entityinspectortag,"lock")
											
											ImGui.SetItemDefaultFocus()
										end
										
										if ImGui.Selectable("unlock", (entityinspector[entityinspectortag].doors == "unlock")) then
											
											
											entityinspector[entityinspectortag].doors = "unlock"
											
											VehicleDoors(entityinspectortag,"unlock")
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										
										ImGui.EndCombo()
									end
									
									
									if ImGui.Button("View Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_doors"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].doors
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Action To Action Clipboard")then
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_doors"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].doors
										
										
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									
									ImGui.EndTabItem()
									
								end
								
								
								
								if ImGui.BeginTabItem(getLang("Windows")) then
									
									
									
									if(entityinspector[entityinspectortag].windows == nil) then entityinspector[entityinspectortag].windows="open"end
									ImGui.Text("Windows : ") 
									ImGui.SameLine()
									if ImGui.BeginCombo("##statutEffect", entityinspector[entityinspectortag].windows) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										if ImGui.Selectable("open", (entityinspector[entityinspectortag].windows == "open")) then
											
											
											entityinspector[entityinspectortag].windows = "open"
											
											VehicleWindows(entityinspectortag,"open")
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										if ImGui.Selectable("close", (entityinspector[entityinspectortag].windows == "close")) then
											
											
											entityinspector[entityinspectortag].windows = "close"
											
											VehicleWindows(entityinspectortag,"close")
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										
										
										
										ImGui.EndCombo()
									end
									
									
									if ImGui.Button("View Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_windows"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].windows
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Action To Action Clipboard")then
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_windows"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].windows
										
										
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									
									ImGui.EndTabItem()
									
								end
								
								
								if ImGui.BeginTabItem(getLang("Light")) then
									
									
									
									if(entityinspector[entityinspectortag].lights == nil) then entityinspector[entityinspectortag].lights=0 end
									if(entityinspector[entityinspectortag].lightsname == nil) then entityinspector[entityinspectortag].lightsname="Off" end
									ImGui.Text("Light : ") 
									
									if ImGui.BeginCombo("##lighteffect",entityinspector[entityinspectortag].lightsname) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										if ImGui.Selectable("Off", (entityinspector[entityinspectortag].lights == 0)) then
											
											
											entityinspector[entityinspectortag].lights = 0
											entityinspector[entityinspectortag].lightsname = "Off"
											VehicleLights(entityinspectortag,0)
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										if ImGui.Selectable("On", (entityinspector[entityinspectortag].lights == 1)) then
											
											
											entityinspector[entityinspectortag].lights = 1
											entityinspector[entityinspectortag].lightsname = "On"
											VehicleLights(entityinspectortag,1)
											
											ImGui.SetItemDefaultFocus()
										end
										
										if ImGui.Selectable("High Beams", (entityinspector[entityinspectortag].lights ==  2)) then
											
											
											entityinspector[entityinspectortag].lights = 2
											entityinspector[entityinspectortag].lightsname = "High Beams"
											VehicleLights(entityinspectortag,2)
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										
										
										
										ImGui.EndCombo()
									end
									
									
									if ImGui.Button("View Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_light"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].lights
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Action To Action Clipboard")then
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_light"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].lights
										
										
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									
									ImGui.EndTabItem()
									
								end
								
								
								if ImGui.BeginTabItem(getLang("Engine")) then
									
									
									
									if(entityinspector[entityinspectortag].engine == nil) then entityinspector[entityinspectortag].engine="off"end
									ImGui.Text("Engine : ") 
									ImGui.SameLine()
									if ImGui.BeginCombo("##statutEffect", entityinspector[entityinspectortag].engine) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										if ImGui.Selectable("off", (entityinspector[entityinspectortag].engine == "off")) then
											
											
											entityinspector[entityinspectortag].engine = "off"
											
											VehicleEngine(entityinspectortag,"off")
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										if ImGui.Selectable("on", (entityinspector[entityinspectortag].engine == "on")) then
											
											
											entityinspector[entityinspectortag].engine = "on"
											
											VehicleEngine(entityinspectortag,"on")
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										
										ImGui.EndCombo()
									end
									
									
									if ImGui.Button("View Action as JSON")then
										
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_engine"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].engine
										
										
										currentOutput = JSON:encode_pretty(objs)
										
										toggleEditorUI("JsonActionOutput")
									end
									ImGui.SameLine()
									if ImGui.Button("Copy Action To Action Clipboard")then
										local objs = deepcopy(cyberscript.actiontemplate["vehicle_change_engine"], nil)
										
										
										objs.tag = entityinspectortag
										objs.value = entityinspector[entityinspectortag].engine
										
										
										
										clipboard["action"] = deepcopy(objs)
										
									end
									
									
									ImGui.EndTabItem()
									
								end
								
								if ImGui.BeginTabItem(getLang("Radio")) then
									
									
									
									
									
									if ImGui.Button("View Action as JSON")then
										enti:PlayGivenStation()
									end
									
									
									ImGui.EndTabItem()
									
								end
								
								
								ImGui.EndTabBar()
							end
							
							
							
							
							ImGui.EndTabItem()
						end
						
						if ImGui.BeginTabItem(getLang("Seat")) then
							
							ImGui.Text("Available Seats Slot: ")
							
							local seatstable = GetSeats(enti)
							
							if #seatstable > 0 then
								for i=1, #seatstable do 
									ImGui.Text(seatstable[i])
									
								end
							end
							ImGui.Separator()
							ImGui.Text("Entity Seat: ") 
							
							if ImGui.BeginCombo("##seatEntity", entityinspector[entityinspectortag].seatentity) then -- Remove the ## if you'd like for the title to display above combo box
								for k,v in pairs(cyberscript.EntityManager) do
									
									
									if ImGui.Selectable(k, false) then
										
										
										entityinspector[entityinspectortag].seatentity = k
										ImGui.SetItemDefaultFocus()
									end
									
									
									
									
									
								end
								ImGui.EndCombo()
							end
							if ImGui.BeginCombo("##seat", entityinspector[entityinspectortag].seat) then -- Remove the ## if you'd like for the title to display above combo box
								for k,v in ipairs(seatstable) do
									
									
									if ImGui.Selectable(v, false) then
										
										
										entityinspector[entityinspectortag].seat = v
										ImGui.SetItemDefaultFocus()
									end
									
									
									
									
									
								end
								ImGui.EndCombo()
							end
							
							
							
							
							
							if ImGui.Button("Seat !", 300, 0) then
								
								
								
								SetSeat(entityinspector[entityinspectortag].seatentity, entityinspectortag, false, entityinspector[entityinspectortag].seat)
							end
							ImGui.SameLine()
							if ImGui.Button("View Seat Action as JSON action")  then
								
								
								local objs = deepcopy(cyberscript.actiontemplate["entity_set_seat"], nil)
								
								
								objs.vehicle = entityinspectortag
								objs.tag =entityinspector[entityinspectortag].seatentity
								objs.seat = entityinspector[entityinspectortag].seat
								objs.waitforsit = true
								
								currentOutput = JSON:encode_pretty(objs)
								
								toggleEditorUI("JsonActionOutput")
								
							end
							ImGui.SameLine()
							if ImGui.Button("Copy Seat Action  To Action Clipboard") then
								
								local objs = deepcopy(cyberscript.actiontemplate["vehicle_follow_entity"], nil)
								
								
								objs.vehicle = entityinspectortag
								objs.tag =entityinspector[entityinspectortag].seatentity
								objs.seat = entityinspector[entityinspectortag].seat
								objs.waitforsit = true
								
								
								clipboard["action"] = deepcopy(objs)
								
							end
							
							
							
							
							
							if ImGui.Button("Unseat !", 300, 0) then
								
								
								
								UnsetSeat(entityinspector[entityinspectortag].seatentity,  false, entityinspector[entityinspectortag].seat)
							end
							ImGui.SameLine()
							if ImGui.Button("View Unseat Action as JSON action")  then
								
								
								local objs = deepcopy(cyberscript.actiontemplate["entity_unset_seat"], nil)
								
								
								
								objs.tag =entityinspector[entityinspectortag].seatentity
								objs.seat = entityinspector[entityinspectortag].seat
								objs.waitforsit = true
								
								currentOutput = JSON:encode_pretty(objs)
								
								toggleEditorUI("JsonActionOutput")
								
							end
							ImGui.SameLine()
							if ImGui.Button("Copy Unseat Action To Action Clipboard") then
								
								local objs = deepcopy(cyberscript.actiontemplate["entity_unset_seat"], nil)
								
								
								
								objs.tag =entityinspector[entityinspectortag].seatentity
								objs.seat = entityinspector[entityinspectortag].seat
								objs.waitforsit = true
								
								
								clipboard["action"] = deepcopy(objs)
								
							end
							
							
							ImGui.EndTabItem()
						end
						
						
						else
						if enti ~= nil then
							if ImGui.BeginTabItem(getLang("Teleport and Move")) then
								
								if ImGui.BeginTabBar("InspectorTabs", ImGuiTabBarFlags.NoTooltip) then
									
									
									if ImGui.BeginTabItem(getLang("Teleport")) then
										
										
										entityinspector[entityinspectortag].teleport.posstep =  ImGui.DragFloat("##post", entityinspector[entityinspectortag].teleport.posstep, 0.1, 0.1, 10, "%.3f Position Step")
										entityinspector[entityinspectortag].teleport.rotstep =  ImGui.DragFloat("##rost", entityinspector[entityinspectortag].teleport.rotstep, 0.01, 0.01, 0.01, "%.3f Rotation Step")
										
										
										
										entityinspector[entityinspectortag].teleport.x,entityinspector[entityinspectortag].change =  ImGui.DragFloat("##x", entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.posstep, -9999, 9999, "%.3f X")
										if entityinspector[entityinspectortag].change then teleportentityinspector(entityinspector[entityinspectortag],obj,enti) end
										
										
										entityinspector[entityinspectortag].teleport.y,entityinspector[entityinspectortag].change = ImGui.DragFloat("##y", entityinspector[entityinspectortag].teleport.y, entityinspector[entityinspectortag].teleport.posstep, -9999, 9999, "%.3f Y")
										if entityinspector[entityinspectortag].change then teleportentityinspector(entityinspector[entityinspectortag],obj,enti) end
										
										entityinspector[entityinspectortag].teleport.z,entityinspector[entityinspectortag].change = ImGui.DragFloat("##z", entityinspector[entityinspectortag].teleport.z, entityinspector[entityinspectortag].teleport.posstep, -9999, 9999, "%.3f Z")
										if entityinspector[entityinspectortag].change then teleportentityinspector(entityinspector[entityinspectortag],obj,enti) end
										
										entityinspector[entityinspectortag].teleport.yaw,entityinspector[entityinspectortag].change =  ImGui.SliderFloat("##yawsss", entityinspector[entityinspectortag].teleport.yaw, -180, 180, "%.3f Rotation (YAW)")	
										if entityinspector[entityinspectortag].change then teleportentityinspector(entityinspector[entityinspectortag],obj,enti) end
										
										if obj.isitem == true then
											entityinspector[entityinspectortag].teleport.pitch,entityinspector[entityinspectortag].change = ImGui.DragFloat("##pitch", entityinspector[entityinspectortag].teleport.pitch, entityinspector[entityinspectortag].teleport.rotstep, -9999, 9999, "%.3f PITCH")
											if entityinspector[entityinspectortag].change then teleportentityinspector(entityinspector[entityinspectortag],obj,enti) end
											
											entityinspector[entityinspectortag].teleport.roll,entityinspector[entityinspectortag].change = ImGui.DragFloat("##roll", entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.rotstep, -9999, 9999, "%.3f ROLL")
											if entityinspector[entityinspectortag].change then teleportentityinspector(entityinspector[entityinspectortag],obj,enti) end
										end
										if ImGui.Button("Copy Player's XYZ", 300, 0) then
											
											local vec4 = Game.GetPlayer():GetWorldPosition()
											entityinspector[entityinspectortag].teleport.x = vec4.x
											entityinspector[entityinspectortag].teleport.y = vec4.y
											entityinspector[entityinspectortag].teleport.z = vec4.z
											
											local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
											
											
											
											
											if obj.isitem == nil or obj.isitem == false then
												
												if obj.isWorkspot == false then
													local teleportCmd = NewObject('handle:AITeleportCommand')
													teleportCmd.position = poss
													teleportCmd.rotation = angless
													teleportCmd.doNavTest = false
													
													enti:GetAIControllerComponent():SendCommand(teleportCmd)
													
													else
													
													Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(obj.id), poss,  angless)
													
													
												end
												
												else
												
												if obj.id then
													
													local id = obj.id
													local testitem = Game.FindEntityByID(id)
													if(testitem ~= nil) then 
														testitem:GetEntity():Destroy()
														
														
														
														local transform = Game.GetPlayer():GetWorldTransform()
														
														transform:SetPosition(poss)
														transform:SetOrientationEuler(angless)
														obj.id = exEntitySpawner.Spawn(obj.tweak, transform)
														
														
														
														
														
														
														else
														local success, message = pcall(function ()
															Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(obj.id), poss,  angless)
															--print("tp")	
														end)
														if success == false then
															--print(message)
														end
													end
													else 
													--print("noID")	
												end
												
											end
										end
										if ImGui.Button("Sync Current Position", 300, 0) then
											
											local vec4 = enti:GetWorldPosition()
											entityinspector[entityinspectortag].teleport.x = vec4.x
											entityinspector[entityinspectortag].teleport.y = vec4.y
											entityinspector[entityinspectortag].teleport.z = vec4.z
											
											
										end
										if ImGui.Button(getLang("Teleport to"), 100, 0) then
											
											
											local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
											
											TeleportPlayerToPosition(poss.x,poss.y,poss.z)
											
											
											
										end
										if ImGui.Button("View as JSON action")  then
											
											
											local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
											
											local objs = {}
											objs.name = "teleport"
											objs.tag = entityinspectortag
											objs.group = false
											
											objs.position_poi_from_position_x= 0
											objs.position_poi_from_position_y = 0
											objs.position_poi_from_position_z= 0
											objs.position_poi_type= 1
											objs.position_tag= "judy01"
											objs.position_way= "normal"
											objs.position_distance= 5
											objs.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
											objs.position_house_tag= "playerhouse01"
											objs.position_change_helper= "Write 'current' in objs.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in objs.position_poi_district you will get the current district \n if you write 'current in objs.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in objs.position_poi_subdistrict or objs.position_poi_district you will get an 'random' value"
											objs.position_node_usegameplay= false
											objs.position_house_way_helper= "default||enter||exit"
											objs.position_house_way= "default"
											objs.position_poi_use_location_tag= false
											objs.position_lookatdistance= 0
											objs.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
											objs.position_way_helper= "normal||behind||forward"
											objs.position_range= 50
											objs.position_poi_district= ""
											objs.position_poi_subdistrict= ""
											objs.position_poi_is_for_car= false
											objs.position_poi_from_position= false
											objs.position_poi_search= "type|subdistrict|district|tag"
											objs.position_poi_searchdistance= "near|far|random"
											objs.position= "at"
											
											
											objs.x = poss.x
											objs.y =  poss.y
											objs.z = poss.z
											
											
											
											objs.roll = angless.roll
											objs.pitch =  angless.pitch
											objs.yaw = angless.yaw
											
											
											
											
											
											
											
											
											currentOutput = JSON:encode_pretty(objs)
											
											toggleEditorUI("JsonActionOutput")
											
										end
										
										if ImGui.Button("Copy To Action Clipboard") then
											
											local poss = Vector4.new( entityinspector[entityinspectortag].teleport.x, entityinspector[entityinspectortag].teleport.y,  entityinspector[entityinspectortag].teleport.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].teleport.roll, entityinspector[entityinspectortag].teleport.pitch,  entityinspector[entityinspectortag].teleport.yaw)
											
											
											local objs = {}
											objs.name = "teleport"
											objs.tag = entityinspectortag
											objs.group = false
											
											objs.position_poi_from_position_x= 0
											objs.position_poi_from_position_y = 0
											objs.position_poi_from_position_z= 0
											objs.position_poi_type= 1
											objs.position_tag= "judy01"
											objs.position_way= "normal"
											objs.position_distance= 5
											objs.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
											objs.position_house_tag= "playerhouse01"
											objs.position_change_helper= "Write 'current' in objs.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in objs.position_poi_district you will get the current district \n if you write 'current in objs.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in objs.position_poi_subdistrict or objs.position_poi_district you will get an 'random' value"
											objs.position_node_usegameplay= false
											objs.position_house_way_helper= "default||enter||exit"
											objs.position_house_way= "default"
											objs.position_poi_use_location_tag= false
											objs.position_lookatdistance= 0
											objs.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
											objs.position_way_helper= "normal||behind||forward"
											objs.position_range= 50
											objs.position_poi_district= ""
											objs.position_poi_subdistrict= ""
											objs.position_poi_is_for_car= false
											objs.position_poi_from_position= false
											objs.position_poi_search= "type|subdistrict|district|tag"
											objs.position_poi_searchdistance= "near|far|random"
											objs.position= "at"
											
											
											objs.x = poss.x
											objs.y =  poss.y
											objs.z = poss.z
											
											
											
											objs.roll = angless.roll
											objs.pitch =  angless.pitch
											objs.yaw = angless.yaw
											
											clipboard["action"] = deepcopy(objs)
											
										end
										
										
										
										ImGui.EndTabItem()
										
									end
									
									
									if ImGui.BeginTabItem(getLang("Move")) then
										entityinspector[entityinspectortag].move.posstep =  ImGui.DragFloat("##post", entityinspector[entityinspectortag].move.posstep, 0.1, 0.1, 10, "%.3f Position Step")
										entityinspector[entityinspectortag].move.rotstep =  ImGui.DragFloat("##rost", entityinspector[entityinspectortag].move.rotstep, 0.01, 0.01, 0.01, "%.3f Rotation Step")
										
										
										
										entityinspector[entityinspectortag].move.x,entityinspector[entityinspectortag].change =  ImGui.DragFloat("##xmove", entityinspector[entityinspectortag].move.x, entityinspector[entityinspectortag].move.posstep, -9999, 9999, "%.3f X")
										
										
										entityinspector[entityinspectortag].move.y,entityinspector[entityinspectortag].change = ImGui.DragFloat("##y", entityinspector[entityinspectortag].move.y, entityinspector[entityinspectortag].move.posstep, -9999, 9999, "%.3f Y")
										
										
										entityinspector[entityinspectortag].move.z,entityinspector[entityinspectortag].change = ImGui.DragFloat("##z", entityinspector[entityinspectortag].move.z, entityinspector[entityinspectortag].move.posstep, -9999, 9999, "%.3f Z")
										
										
										
										
										
										entityinspector[entityinspectortag].move.yaw,entityinspector[entityinspectortag].change =  ImGui.DragFloat("##yaw", entityinspector[entityinspectortag].move.yaw, entityinspector[entityinspectortag].move.rotstep, -9999, 9999, "%.4f YAW")
										
										
										entityinspector[entityinspectortag].move.pitch,entityinspector[entityinspectortag].change = ImGui.DragFloat("##pitch", entityinspector[entityinspectortag].move.pitch, entityinspector[entityinspectortag].move.rotstep, -9999, 9999, "%.3f PITCH")
										
										entityinspector[entityinspectortag].move.roll,entityinspector[entityinspectortag].change = ImGui.DragFloat("##roll", entityinspector[entityinspectortag].move.roll, entityinspector[entityinspectortag].move.rotstep, -9999, 9999, "%.3f ROLL")
										
										
										
										
										
										
										
										
										
										if ImGui.Button("Copy Player's XYZ", 300, 0) then
											
											local vec4 = Game.GetPlayer():GetWorldPosition()
											entityinspector[entityinspectortag].move.x = vec4.x
											entityinspector[entityinspectortag].move.y = vec4.y
											entityinspector[entityinspectortag].move.z = vec4.z
											
											local poss = Vector4.new( entityinspector[entityinspectortag].move.x, entityinspector[entityinspectortag].move.y,  entityinspector[entityinspectortag].move.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].move.roll, entityinspector[entityinspectortag].move.pitch,  entityinspector[entityinspectortag].move.yaw)
											
											
											
											
										end
										
										
										
										
										
										
										if ImGui.Button("Move to ", 300, 0) then
											
											
											local poss = Vector4.new( entityinspector[entityinspectortag].move.x, entityinspector[entityinspectortag].move.y,  entityinspector[entityinspectortag].move.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].move.roll, entityinspector[entityinspectortag].move.pitch,  entityinspector[entityinspectortag].move.yaw)
											
											
											MoveTo(enti, poss,nil, nil, nil)
											
										end
										
										if ImGui.Button("View as JSON action")  then
											
											
											local poss = Vector4.new( entityinspector[entityinspectortag].move.x, entityinspector[entityinspectortag].move.y,  entityinspector[entityinspectortag].move.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].move.roll, entityinspector[entityinspectortag].move.pitch,  entityinspector[entityinspectortag].move.yaw)
											
											
											local objs = {}
											objs.name = "move"
											objs.tag = entityinspectortag
											objs.move =  "Walk"
											objs.group = false
											
											objs.position_poi_from_position_x= 0
											objs.position_poi_from_position_y = 0
											objs.position_poi_from_position_z= 0
											objs.position_poi_type= 1
											objs.position_tag= "judy01"
											objs.position_way= "normal"
											objs.position_distance= 5
											objs.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
											objs.position_house_tag= "playerhouse01"
											objs.position_change_helper= "Write 'current' in objs.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in objs.position_poi_district you will get the current district \n if you write 'current in objs.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in objs.position_poi_subdistrict or objs.position_poi_district you will get an 'random' value"
											objs.position_node_usegameplay= false
											objs.position_house_way_helper= "default||enter||exit"
											objs.position_house_way= "default"
											objs.position_poi_use_location_tag= false
											objs.position_lookatdistance= 0
											objs.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
											objs.position_way_helper= "normal||behind||forward"
											objs.position_range= 50
											objs.position_poi_district= ""
											objs.position_poi_subdistrict= ""
											objs.position_poi_is_for_car= false
											objs.position_poi_from_position= false
											objs.position_poi_search= "type|subdistrict|district|tag"
											objs.position_poi_searchdistance= "near|far|random"
											objs.position= "at"
											
											
											objs.x = poss.x
											objs.y =  poss.y
											objs.z = poss.z
											
											
											
											objs.roll = angless.roll
											objs.pitch =  angless.pitch
											objs.yaw = angless.yaw
											
											objs.moveV2 =  false
											objs.distance =  0
											objs.distancetolerance = 0
											objs.ignorenavigation =  true
											objs.stoponobstacle = false
											objs.outofway = false
											
											
											
											
											
											
											
											
											
											
											currentOutput = JSON:encode_pretty(objs)
											
											toggleEditorUI("JsonActionOutput")
											
										end
										
										if ImGui.Button("Copy To Action Clipboard") then
											
											local poss = Vector4.new( entityinspector[entityinspectortag].move.x, entityinspector[entityinspectortag].move.y,  entityinspector[entityinspectortag].move.z,1)
											
											
											local angless = EulerAngles.new(entityinspector[entityinspectortag].move.roll, entityinspector[entityinspectortag].move.pitch,  entityinspector[entityinspectortag].move.yaw)
											
											
											local objs = {}
											objs.name = "move"
											objs.tag = entityinspectortag
											objs.move =  "Walk"
											
											
											objs.position_poi_from_position_x= 0
											objs.position_poi_from_position_y = 0
											objs.position_poi_from_position_z= 0
											objs.position_poi_type= 1
											objs.position_tag= "judy01"
											objs.position_way= "normal"
											objs.position_distance= 5
											objs.position_helper= "at||relative_to_entity||node||player_look_at||poi||mappin||fasttravel||custom_place||custom_room"
											objs.position_house_tag= "playerhouse01"
											objs.position_change_helper= "Write 'current' in objs.position_tag for get current nodemappin fasttravel custom_place or custom_room. \n For poi if you write 'current' in objs.position_poi_district you will get the current district \n if you write 'current in objs.position_poi_subdistrict you will get the current subdistrict. \n also if you write 'random' in objs.position_poi_subdistrict or objs.position_poi_district you will get an 'random' value"
											objs.position_node_usegameplay= false
											objs.position_house_way_helper= "default||enter||exit"
											objs.position_house_way= "default"
											objs.position_poi_use_location_tag= false
											objs.position_lookatdistance= 0
											objs.position_tag_helper= "judy01||playerhouse01||playerhouse_bed||"
											objs.position_way_helper= "normal||behind||forward"
											objs.position_range= 50
											objs.position_poi_district= ""
											objs.position_poi_subdistrict= ""
											objs.position_poi_is_for_car= false
											objs.position_poi_from_position= false
											objs.position_poi_search= "type|subdistrict|district|tag"
											objs.position_poi_searchdistance= "near|far|random"
											objs.position= "at"
											
											
											objs.x = poss.x
											objs.y =  poss.y
											objs.z = poss.z
											
											
											
											objs.roll = angless.roll
											objs.pitch =  angless.pitch
											objs.yaw = angless.yaw
											
											objs.moveV2 =  false
											objs.distance =  0
											objs.distancetolerance = 0
											objs.ignorenavigation =  true
											objs.stoponobstacle = false
											objs.outofway = false
											
											clipboard["action"] = deepcopy(objs)
											
										end
										
										
										
										
										
										ImGui.EndTabItem()
									end
									
									
									
									ImGui.EndTabBar()
								end
								
								
								
								
								ImGui.EndTabItem()
							end
							
							if ImGui.BeginTabItem(getLang("Facial Expression and Voice")) then
								if ImGui.BeginTabBar("InspectorTabs2", ImGuiTabBarFlags.NoTooltip) then
									
									
									if ImGui.BeginTabItem(getLang("Facial Expression")) then
										
										
										
										if(entityinspector[entityinspectortag].facial == nil) then entityinspector[entityinspectortag].facial="Neutral"end
										ImGui.Text("Expressions : ") 
										ImGui.SameLine()
										if ImGui.BeginCombo("##statutEffect", entityinspector[entityinspectortag].facial) then -- Remove the ## if you'd like for the title to display above combo box
											
											
											
											for i,v in ipairs(reactionlist) do
												
												if ImGui.Selectable(v.name, (entityinspector[entityinspectortag].facial == v.name)) then
													
													
													entityinspector[entityinspectortag].facial = v.name
													
													makeFacial(entityinspectortag,v)
													
													ImGui.SetItemDefaultFocus()
												end
												
												
											end
											
											ImGui.EndCombo()
										end
										
										if ImGui.Button("Reset Facial")then
											
											local objs = getEntityFromManager(entityinspectortag)
											local enti = Game.FindEntityByID(objs.id)
											if(enti ~= nil) then
												resetFacial(enti)
											end
										end
										
										if ImGui.Button("View Action as JSON")then
											
											local objs = deepcopy(cyberscript.actiontemplate["play_entity_facial"], nil)
											
											
											objs.tag = entityinspectortag
											objs.value = entityinspector[entityinspectortag].facial
											
											
											currentOutput = JSON:encode_pretty(objs)
											
											toggleEditorUI("JsonActionOutput")
										end
										ImGui.SameLine()
										if ImGui.Button("Copy Action To Action Clipboard")then
											local objs = deepcopy(cyberscript.actiontemplate["play_entity_facial"], nil)
											
											
											objs.tag = entityinspectortag
											objs.value = entityinspector[entityinspectortag].facial
											
											
											
											clipboard["action"] = deepcopy(objs)
											
										end
										
										
										ImGui.EndTabItem()
										
									end
									
									
									if ImGui.BeginTabItem(getLang("Voice")) then
										if selectedvoice == nil then selectedvoice = true end
										if(entityinspector[entityinspectortag].voice == nil) then entityinspector[entityinspectortag].voice="greeting"end
										if(entityinspector[entityinspectortag].voicename == nil) then entityinspector[entityinspectortag].voicename="Greet V"end
										
										ImGui.Text("Voices : ") 
										
										
										
										ImGui.Text("Selected : "..entityinspector[entityinspectortag].voicename) 
										
										if(selectedvoice == true) then 
											
											if ImGui.BeginCombo("##voicecombo","") then -- Remove the ## if you'd like for the title to display above combo box
												
												
												
												for k,v in pairs(editorvoice) do
													
													if ImGui.Selectable(k) then
														
														
														entityinspector[entityinspectortag].voicename = k
														entityinspector[entityinspectortag].voice = v
														
														if(enti ~= nil) then
															talk(enti,v)
															
															selectedvoice = false
															
															Cron.After(5, function()
																
																selectedvoice = true
																
															end)
															
														end
														
														ImGui.SetItemDefaultFocus()
													end
													
													
												end
												
												ImGui.EndCombo()
											end
											
											else
											
											ImGui.Text("Currently Playing : "..entityinspector[entityinspectortag].voicename) 
											
										end
										
										
										if ImGui.Button("View Action as JSON")then
											
											local objs = deepcopy(cyberscript.actiontemplate["play_entity_voice"], nil)
											
											
											objs.tag = entityinspectortag
											objs.value = entityinspector[entityinspectortag].voice
											
											
											currentOutput = JSON:encode_pretty(objs)
											
											toggleEditorUI("JsonActionOutput")
										end
										ImGui.SameLine()
										if ImGui.Button("Copy Action To Action Clipboard")then
											local objs = deepcopy(cyberscript.actiontemplate["play_entity_voice"], nil)
											
											
											objs.tag = entityinspectortag
											objs.value = entityinspector[entityinspectortag].voice
											
											
											
											clipboard["action"] = deepcopy(objs)
											
										end
										
										
										ImGui.EndTabItem()
										
									end
									
									
									
									ImGui.EndTabBar()
								end
								
								
								
								
								ImGui.EndTabItem()
							end
							
							if ImGui.BeginTabItem(getLang("Time Dilatation")) then
								
								ImGui.Text("Time Dilatation")
								editortimedilatationignoreplayer = ImGui.Checkbox(getLang("Ignore Time Dilatation on Player"), editortimedilatationignoreplayer)
								
								
								
								editortimedilatation,change = ImGui.SliderFloat("##editortimedilatation", editortimedilatation, 0.011, 10, "%.3f Entity Time Dilatation")
								if change then
									
									if enti ~= nil then
										
										TimeDilationHelper.SetIndividualTimeDilation(enti, "see_engine", editortimedilatation, 99999, "", "");
										
									end
								end
								
								if ImGui.Button(getLang("Unfreeze Entity")) then
									
									
									if enti ~= nil then
										
										TimeDilationHelper.SetIndividualTimeDilation(enti, "see_engine", 1, 1, "", "");
										editortimedilatation = 1
										
									end
									
									
								end
								
								if ImGui.Button(getLang("Freeze Entity")) then
									
									
									
									if enti ~= nil then
										
										TimeDilationHelper.SetIndividualTimeDilation(enti, "see_engine", 0, 99999, "", "");
										editortimedilatation = 0.00000001
										
									end
									
								end
								
								if ImGui.Button("View Set Entity Time Dilatation Action as JSON")then
									local pos = enti:GetWorldPosition()
									
									
									local objs = deepcopy(cyberscript.actiontemplate["set_timedilation_for_entity"], nil)
									
									objs.tag = entityinspectortag
									objs.value = editortimedilatation
									
									
									currentOutput = JSON:encode_pretty(objs)
									
									toggleEditorUI("JsonActionOutput")
								end
								ImGui.SameLine()
								if ImGui.Button("Copy Set Entity Time Dilatation Action To Action Clipboard")then
									local pos = enti:GetWorldPosition()
									
									
									local objs = deepcopy(cyberscript.actiontemplate["set_timedilation_for_entity"], nil)
									
									objs.tag = entityinspectortag
									objs.value = editortimedilatation
									
									
									
									clipboard["action"] = deepcopy(objs)
									
								end
								
								if ImGui.Button("View Unset Entity Time Dilatation Action as JSON")then
									local pos = enti:GetWorldPosition()
									
									
									local objs = deepcopy(cyberscript.actiontemplate["unset_timedilation_for_entity"], nil)
									
									objs.tag = entityinspectortag
									
									
									
									currentOutput = JSON:encode_pretty(objs)
									
									toggleEditorUI("JsonActionOutput")
								end
								ImGui.SameLine()
								if ImGui.Button("Copy Unset Entity Time Dilatation Action To Action Clipboard")then
									local pos = enti:GetWorldPosition()
									
									
									local objs = deepcopy(cyberscript.actiontemplate["unset_timedilation_for_entity"], nil)
									
									objs.tag = entityinspectortag
									
									
									
									
									clipboard["action"] = deepcopy(objs)
									
								end
								
								if ImGui.Button("View Despawn Action as JSON ") then
									local objs = deepcopy(cyberscript.actiontemplate["despawn_entity"], nil)
									objs.tag = entityinspectortag
									currentOutput = JSON:encode_pretty(objs)
									
									toggleEditorUI("JsonActionOutput")
								end
								
								
								
								ImGui.EndTabItem()
								
								
							end
							
							if ImGui.BeginTabItem(getLang("Animation")) then
								
								local result,msg = pcall(function() enti:GetRecordID() end)
								
								
								if(result == true and enti:GetRecordID().hash ~= nil and cyberscript.entitieshash[tostring(enti:GetRecordID().hash)] ~= nil) then
									
									local entity = cyberscript.entitieshash[tostring(enti:GetRecordID().hash)]
									
									
									if(entity ~= nil) then
										ImGui.Text(entity.entity_name)
										
										
										if ImGui.Button("Stop Animation") then
											
											stopWorkSpotAnims(entityinspectortag)
										end
										
										if ImGui.Button("Jump in workspot") then
											
											local obj = getEntityFromManager(entityinspectortag)
											local enti = Game.FindEntityByID(obj.id)
											
											
											if(enti ~= nil) then
												
												
												
												local spawnTransform = enti:GetWorldTransform()
												spawnTransform:SetPosition(enti:GetWorldPosition())
												local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
												if(entitytag == "player")then
													spawnTransform:SetOrientationEuler(EulerAngles.new(0, 0, angles.yaw-180))
													else
													spawnTransform:SetOrientationEuler(EulerAngles.new(0, 0, angles.yaw))
													
												end
												
												if(angle ~= nil) then
													spawnTransform:SetOrientationEuler(EulerAngles.new(angle.roll, angle.pitch, angle.yaw))
												end
												
												
												local NPC = exEntitySpawner.Spawn("base\\cyberscript\\entity\\workspot_anim.ent", spawnTransform, '')
												------print("Spawned "..entname)
												Cron.Every(0.1, {tick = 1}, function(timer)
													local ent = Game.FindEntityByID(NPC)
													if ent then
														-- stand_wall_lean180__rh_phone__ow__01
														
														Game.GetWorkspotSystem():PlayInDeviceSimple(ent, enti, true, "cyberscript_workspot_base")
														
														if(NPC ~= nil) then
															local entity = {}
															entity.id = NPC
															entity.iscodeware = false
															local tag = entitytag.."_workspot"
															cyberscript.EntityManager[entitytag].workspot = tag
															entity.tag =tag
															entity.tweak = anim_cname
															entity.isprevention = false
															entity.scriptlevel = 0
															entity.name = tag
															entity.isMP = false
															entity.isWorkspot = true
															entity.workspottag = workspot
															entity.spawntimespan = os.time(os.date("!*t"))+0
															entity.despawntimespan = os.time(os.date("!*t"))+600
															cyberscript.EntityManager[tag]=entity
															
														end
														
														
														
														Cron.Halt(timer)
													end
												end)
												
											end
											
										end
										
										animsearch  = ImGui.InputText("Search", animsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
										
										if(entity.entity_name ~= "Player_Puppet_Base") then
											
											if ImGui.BeginChild("Available Anims", 490, 250, true, ImGuiWindowFlags.NoMove) then
												
												for k,workspot in pairs(cyberscript.workspot) do
													
													
													
													if(workspot[entity.entity_entrigs] ~= nil and #workspot[entity.entity_entrigs] > 0) then
														if ImGui.TreeNode(k) then
															
															
															
															for i,anims in ipairs(workspot[entity.entity_entrigs]) do
																if(animsearch == "" or animsearch == nil) or ((animsearch ~= "" or animsearch ~= nil) and string.match(anims, animsearch)) then
																	
																	
																	
																	if ImGui.TreeNode(anims) then
																		
																		if ImGui.Button("Play")  then
																			
																			
																			
																			spawnCustomAnimationWorkspot(entityinspectortag,"base\\cyberscript\\entity\\workspot_anim.ent",anims,k,true,true)
																			
																			
																		end
																		ImGui.SameLine()
																		if ImGui.Button("View as JSON action")  then
																			
																			local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																			
																			
																			objs.tag = entityinspectortag
																			objs.anim = anims
																			objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																			objs.workspot = k
																			
																			
																			
																			currentOutput = JSON:encode_pretty(objs)
																			
																			toggleEditorUI("JsonActionOutput")
																			
																		end
																		ImGui.SameLine()
																		if ImGui.Button("Copy To Action Clipboard") then
																			local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																			
																			objs.name = "play_custom_anim_entity"
																			objs.tag = entityinspectortag
																			objs.anim = anims
																			objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																			objs.workspot = k
																			
																			clipboard["action"] = deepcopy(objs)
																			
																		end
																		
																		ImGui.TreePop()
																	end
																	
																	
																end
															end
															
															
															
															
															ImGui.TreePop()
														end
														
														
													end
												end
												
												ImGui.EndChild()
												
											end
											
											else
											
											
											if ImGui.BeginChild("Available Anims", 490, 250, true, ImGuiWindowFlags.NoMove) then
												ImGui.Text("Main anims")
												for k,workspot in pairs(cyberscript.workspot) do
													
													
													
													if(workspot["base\\characters\\entities\\player\\player_man_skeleton.rig"] ~= nil and #workspot["base\\characters\\entities\\player\\player_man_skeleton.rig"] > 0) then
														if ImGui.TreeNode("(player)"..k) then
															
															
															
															for i,anims in ipairs(workspot["base\\characters\\entities\\player\\player_man_skeleton.rig"]) do
																if(animsearch == "" or animsearch == nil) or ((animsearch ~= "" or animsearch ~= nil) and string.match(anims, animsearch)) then
																	
																	
																	
																	if ImGui.TreeNode(anims) then
																		
																		if ImGui.Button("Play")  then
																			
																			
																			
																			spawnCustomAnimationWorkspot(entityinspectortag,"base\\cyberscript\\entity\\workspot_anim.ent",anims,k,true,true)
																			
																			
																		end
																		ImGui.SameLine()
																		if ImGui.Button("View as JSON action")  then
																			
																			local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																			
																			
																			objs.tag = entityinspectortag
																			objs.anim = anims
																			objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																			objs.workspot = k
																			
																			currentOutput = JSON:encode_pretty(objs)
																			
																			toggleEditorUI("JsonActionOutput")
																			
																		end
																		ImGui.SameLine()
																		if ImGui.Button("Copy To Action Clipboard") then
																			local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																			
																			
																			objs.tag = entityinspectortag
																			objs.anim = anims
																			objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																			objs.workspot = k
																			
																			clipboard["action"] = deepcopy(objs)
																			
																		end
																		
																		ImGui.TreePop()
																	end
																	
																	
																end
															end
															
															
															
															
															ImGui.TreePop()
														end
														
														
													end
													
													
													
													
												end
												
												if(GetPlayerGender() == "female") then
													ImGui.Text("Female anims")
													for k,workspot in pairs(cyberscript.workspot) do
														
														
														
														
														
														
														if(workspot["base\\characters\\entities\\player\\player_woman_skeleton.rig"] ~= nil and #workspot["base\\characters\\entities\\player\\player_woman_skeleton.rig"] > 0) then
															if ImGui.TreeNode("(female_player)"..k) then
																
																
																
																for i,anims in ipairs(workspot["base\\characters\\entities\\player\\player_woman_skeleton.rig"]) do
																	if(animsearch == "" or animsearch == nil) or ((animsearch ~= "" or anim ~= nil) and string.match(anims, animsearch)) then
																		
																		
																		
																		if ImGui.TreeNode(anims) then
																			
																			if ImGui.Button("Play")  then
																				
																				
																				
																				spawnCustomAnimationWorkspot(entityinspectortag,"base\\cyberscript\\entity\\workspot_anim.ent",anims,k,true,true)
																				
																				
																			end
																			ImGui.SameLine()
																			if ImGui.Button("View as JSON action")  then
																				
																				local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																				
																				
																				objs.tag = entityinspectortag
																				objs.anim = anims
																				objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																				objs.workspot = k
																				
																				currentOutput = JSON:encode_pretty(objs)
																				
																				toggleEditorUI("JsonActionOutput")
																				
																			end
																			ImGui.SameLine()
																			if ImGui.Button("Copy To Action Clipboard") then
																				local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																				
																				objs.tag = entityinspectortag
																				objs.anim = anims
																				objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																				objs.workspot = k
																				
																				clipboard["action"] = deepcopy(objs)
																				
																			end
																			
																			ImGui.TreePop()
																		end
																		
																		
																	end
																end
																
																
																
																
																ImGui.TreePop()
															end
															
															
														end
														
														--end
														
													end
												end
												ImGui.EndChild()
												
											end
											
											
										end
										
									end
									else
									
									if(result == false and cyberscript.entitieshash[tostring(TweakDBID.new(obj.tweak).hash)] ~= nil) then
										
										local entity = cyberscript.entitieshash[tostring(TweakDBID.new(obj.tweak).hash)]
										
										
										if(entity ~= nil) then
											ImGui.Text(entity.entity_name)
											animsearch  = ImGui.InputText("Search", animsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
											if ImGui.BeginChild("Available Anims", 490, 250, true, ImGuiWindowFlags.NoMove) then
												
												for k,workspot in pairs(cyberscript.workspot) do
													
													
													
													if(workspot[entity.entity_entrigs] ~= nil and #workspot[entity.entity_entrigs] > 0) then
														if ImGui.TreeNode(k) then
															
															
															
															for i,anims in ipairs(workspot[entity.entity_entrigs]) do
																if(animsearch == "" or animsearch == nil) or ((animsearch ~= "" or animsearch ~= nil) and string.match(anims, animsearch)) then
																	
																	
																	if ImGui.TreeNode(anims) then
																		
																		if ImGui.Button("Play")  then
																			
																			
																			spawnCustomAnimationWorkspot(entityinspectortag,"base\\cyberscript\\entity\\workspot_anim.ent",anims,k,true,true)
																			
																		end
																		ImGui.SameLine()
																		if ImGui.Button("View as JSON action")  then
																			
																			local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																			
																			objs.tag = entityinspectortag
																			objs.anim = anims
																			objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																			objs.workspot = k
																			
																			currentOutput = JSON:encode_pretty(objs)
																			
																			toggleEditorUI("JsonActionOutput")
																			
																		end
																		ImGui.SameLine()
																		if ImGui.Button("Copy To Action Clipboard") then
																			local objs = deepcopy(cyberscript.actiontemplate["play_custom_anim_entity"], nil)
																			
																			objs.tag = entityinspectortag
																			objs.anim = anims
																			objs.ent = "base\\cyberscript\\entity\\workspot_anim.ent"
																			objs.workspot = k
																			
																			clipboard["action"] = deepcopy(objs)
																			
																		end
																		
																	end
																	ImGui.TreePop()
																end
																
																
															end
															ImGui.TreePop()
														end
														
														
														
														
														
													end
													
													
												end
												ImGui.EndChild()
											end
											
											
											
										end
										
									end
									
								end
								
								
								
								
								ImGui.EndTabItem()
								
							end
							if ImGui.BeginTabItem(getLang("Debug")) then
								
								
								if ImGui.Button("Debug test ") then
									enti:SetDetectionPercentage(0)
								end
								
								
								
								ImGui.EndTabItem()
								
								
							end
							
						end
						
					end
					ImGui.EndTabBar()
					
				end
				
			end)
			
			if(res == false) then spdlog.error(messg) end
			
		end		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
end

function editor.entityInspectorplayPath(enti,tag)
	
	if(entityinspector[tag].playtick <= #entityinspector[tag].record) then
		
		local rot = EulerAngles.new(entityinspector[tag].record[entityinspector[tag].playtick].roll, entityinspector[tag].record[entityinspector[tag].playtick].pitch,  entityinspector[tag].record[entityinspector[tag].playtick].yaw)
		
		local pos = Vector4.new(entityinspector[tag].record[entityinspector[tag].playtick].x, entityinspector[tag].record[entityinspector[tag].playtick].y, entityinspector[tag].record[entityinspector[tag].playtick].z,1)			
		
		local teleportCmd = NewObject('handle:AITeleportCommand')
		teleportCmd.position = pos
		teleportCmd.rotation = entityinspector[tag].record[entityinspector[tag].playtick].yaw
		teleportCmd.doNavTest = false
		
		enti:GetAIControllerComponent():SendCommand(teleportCmd)
		
		
		-- if(editorPathTarget == Game.GetPlayer())then
		-- Game.GetPlayer():GetFPPCameraComponent().pitchMin = rot.pitch - 0.01
		-- Game.GetPlayer():GetFPPCameraComponent().pitchMax = rot.pitch
		-- Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(rot.roll, 0, 0)))
		-- end
		
		entityinspector[tag].playtick = entityinspector[tag].playtick + 1
		else
		entityinspector[tag].playingmovement = false
		entityinspector[tag].playtick = 1
		local rot = EulerAngles.new(entityinspector[tag].record[entityinspector[tag].playtick].roll, entityinspector[tag].record[entityinspector[tag].playtick].pitch,  entityinspector[tag].record[entityinspector[tag].playtick].yaw)
		
		
		local pos = Vector4.new(entityinspector[tag].record[entityinspector[tag].playtick].x, entityinspector[tag].record[entityinspector[tag].playtick].y, entityinspector[tag].record[entityinspector[tag].playtick].z,1)			
		
		local teleportCmd = NewObject('handle:AITeleportCommand')
		teleportCmd.position = pos
		teleportCmd.rotation = entityinspector[tag].record[entityinspector[tag].playtick].yaw
		teleportCmd.doNavTest = false
		
		enti:GetAIControllerComponent():SendCommand(teleportCmd)
		
	end
	
end

function editor.JsonActionOutput()
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(1200, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Json Output", true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			toggleEditorUI("JsonActionOutput")
			
		end
		ImGui.EndMenuBar()
		end
		
		
		local jsonvalue = ImGui.InputTextMultiline("Content", currentOutput, 99999 , 1000, 400, ImGuiInputTextFlags.None)
		
		
		if ImGui.Button("Test Action") then
			
			local action = json.decode(jsonvalue)
			executeAction(action,"editor_output","",1,"interact","see_engine")
			local status, retval = pcall(executeAction,action,"editor_output","",1,"interact","see_engine")
			
			
			
			if status == false then
				
				
				logme(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((action))).." tag "..action.name.." parent ".."".." index "..1)
				spdlog.error(getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((action))).." tag "..action.name.." parent ".."".." index "..1)
				--Game.GetPlayer():SetWarningMessage("CyberScript Scripting error, check the log for more detail")
				
			end
			
		end
		
		
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

function editor.JsonEditor(tag,scriptjson)
	
	
	
	
	ImGui.SetNextWindowPos(math.random(150,600),math.random(150,600), ImGuiCond.Once) -- set window position x, y
	ImGui.SetNextWindowSize(1200, 500, ImGuiCond.Appearing) -- set window size w, h
	
	ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 8)
	ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 7)
	
	
	if ImGui.Begin("Json View : "..tag, true, ImGuiWindowFlags.MenuBar) then
		if ImGui.BeginMenuBar() then if ImGui.MenuItem("Close") then
			
			currentJson[tag] = nil
			
		end
		ImGui.EndMenuBar()
		end
		editor_json_tag = ImGui.InputText("Filename", editor_json_tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Spacing()
		
		local jsonvalue = ImGui.InputTextMultiline("Content", scriptjson, 99999 , 1000, 400, ImGuiInputTextFlags.None)
		
		
		
		
		
		
		
		
		
		
	end
	
	
	
	
	ImGui.End() 
	ImGui.PopStyleVar(2)
	
	
end

--triggers actions context windows

--actions windows
function editor.actions(tag,item)
	
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.715, 0.310, 0, 0.7)
	ImGui.PushStyleColor(ImGuiCol.TabActive,  0.715, 0.310, 0, 1)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Action: "..tag.."("..item.index..")") then
		ImGui.PopStyleColor(1)
		
		if item.parent ~= nil then
			if ImGui.BeginMenuBar()  then 
				if ImGui.MenuItem("Save")  then
					
					item.parent[item.key][item.index] = item.action
					
				end
				if ImGui.MenuItem("Save&Close") then
					
					item.parent[item.key][item.index] = item.action
					currentAction[tag] = nil
				end
				
				
				ImGui.EndMenuBar()
			end
		end
		
		if ImGui.BeginMenuBar() then 
			
			if ImGui.MenuItem("Close") then
				
				currentAction[tag] = nil
				
			end
			if ImGui.MenuItem("Test it !") then
				local actiontemp = {}
				table.insert(actiontemp,item.action)
				
				runActionList(actiontemp, "editor_test", "interact",false,"nothing",false)
				editor_check_action_test = true
			end
			
			
			
			if editor_check_action_test then
				if ImGui.MenuItem("Clean the tested stuff (need to be out of an car)") then
					
					workerTable = {}
					despawnAll()
					
				end
			end
			
			if ImGui.MenuItem("Copy To Action Clipboard") then
				
				clipboard["action"] = deepcopy(item.action)
				
			end
			if(clipboard["action"] ~= nil) then
				if ImGui.MenuItem("Paste from Action Clipboard") then
					
					item.action = deepcopy(clipboard["action"])
					
				end
				if ImGui.MenuItem("Clear Action Clipboard") then
					
					clipboard["action"] = nil
					
				end
			end
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.action)
					
					
				end
				
				
				
			end
			
			
			ImGui.EndMenuBar()
		end
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/scripting-basics", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		
		if ImGui.BeginChild("part1", 850, 495,true) then
			
			
			editor.actionFactory(item.action,tag,item.contextscript)
			
			
			
			
			ImGui.EndChild()
		end
		ImGui.SameLine()
		if ImGui.BeginChild("part2", 600, 495,true) then
			
			ImGui.Text("Help : ")
			
			ImGui.Text(splitByChunk(getLang(item.action.helper),85))
			
			
			ImGui.EndChild()
		end
		
		
		ImGui.EndTabItem()
		
	end
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
	
	
	
end
function editor.actionNode(title,obj,key,parenttag,contextscript)
	ImGui.BeginGroup()
	if ImGui.TreeNode(title) then
		
		
		
		if obj[key] == nil then obj[key] = {} end
		if( #obj[key] > 0) then
			
			
			for i = 1, #obj[key] do 
				--print(dump(obj[key][i]))
				if ImGui.TreeNode(obj[key][i].name.." ("..tostring(i)..")"..tostring(obj[key][i].comment)) then
					if ImGui.Button("Edit", 50, 0) then
						local objact = {}
						
						objact.parenttag = parenttag
						objact.parent = obj
						objact.key = key
						objact.index = i
						objact.contextscript = contextscript
						if(cyberscript.actiontemplate[obj[key][i].name] ~= nil) then
							
							objact.action = deepcopy(cyberscript.actiontemplate[obj[key][i].name],nil) 
							
							for k,v in pairs(obj[key][i]) do
								if(k ~= "helper" and k ~= "helperTitle" and k ~= "name") then
									objact.action[k] = v
								end
							end
							
							else 
							
							objact.action = deepcopy(obj[key][i],nil)
							objact.action.helper = obj[key][i].name
							objact.action.helperTitle = obj[key][i].name
							
						end
						
						
						
						
						
						currentAction[parenttag.."_"..obj[key][i].name.." ("..tostring(i)..")"] = objact
						
					end
					
					ImGui.SameLine()
					if currentAction[parenttag.."_"..obj[key][i].name.." ("..tostring(i)..")"] == nil then
						if ImGui.Button("Delete##"..obj[key][i].name.." ("..tostring(i)..")", 50, 0) then
							
							table.remove(obj[key],i)
							
						end
						
						
						if ImGui.Button("Up##"..obj[key][i].name.." ("..tostring(i)..")", 50, 0) then
							
							local copy = deepcopy(obj[key][i],nil)
							
							table.remove(obj[key],i)
							table.insert(obj[key], i-1, copy)
							
							
							
						end
						
						ImGui.SameLine()
						
						if ImGui.Button("Down##"..obj[key][i].name.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj[key][i],nil)
							
							table.remove(obj[key],i)
							table.insert(obj[key], i+1, copy)
							
							
							
						end
						
						if ImGui.Button("First##"..obj[key][i].name.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj[key][i],nil)
							table.remove(obj[key],i)
							
							table.insert(obj[key], 1, copy)
							
							
						end
						
						ImGui.SameLine()
						
						if ImGui.Button("Last##"..obj[key][i].name.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj[key][i],nil)
							
							table.remove(obj[key],i)
							table.insert(obj[key], #obj[key], copy)
							
							
							
						end
						
						
						currentindex = ImGui.InputInt("Index##"..obj[key][i].name.." ("..tostring(i)..")", currentindex, 1,10, ImGuiInputTextFlags.None)
						
						ImGui.SameLine()
						
						if ImGui.Button("Apply new index##"..obj[key][i].name.." ("..tostring(i)..")", 110, 0) then
							
							local copy = deepcopy(obj[key][i],nil)
							table.remove(obj[key],i)
							
							table.insert(obj[key], currentindex, copy)
							
						end
						
						
						if ImGui.Button("Duplicate to End##"..obj[key][i].name.." ("..tostring(i)..")", 200, 0) then
							
							local copy = deepcopy(obj[key][i],nil)
							
							
							table.insert(obj[key], copy)
							
						end
						
						
						
						ImGui.SameLine()
						
						
						if ImGui.Button("Test it !##"..obj[key][i].name.." ("..tostring(i)..")", 110, 0) then
							
							local actiontemp = {}
							table.insert(actiontemp,deepcopy(obj[key][i],nil))
							
							runActionList(actiontemp, "editor_test", "interact",false,"nothing",false)
							editor_check_action_test = true
							
							
							
						end
						
						
						if ImGui.Button("Copy To Action Clipboard") then
							
							clipboard["action"] = deepcopy(obj[key][i])
							
						end
						
						
						else
						ImGui.Text("Currently opened in editor")
					end
					
					
					
					ImGui.TreePop()
				end
				
				
			end
		end
		
		if ImGui.Button("Add new action", 200, 0) then
			
			local objact = {}
			objact.parenttag = parenttag
			objact.parent = obj
			objact.key = key
			objact.contextscript = contextscript
			objact.index = 1
			if(#obj[key] > 0) then objact.index = #obj[key]+1 end
			
			objact.action = deepcopy(cyberscript.actiontemplate["nothing"],nil)
			
			
			
			currentAction[parenttag.."_action_new"] = objact
		end
		ImGui.SameLine()
		if ImGui.Button("Test the action list") then
			
			runActionList(obj[key], parenttag,"interact",false,"player")
			
		end
		if ImGui.Button("Copy the action list") then
			
			currentactionlist = deepcopy(obj[key],nil)
			
		end
		
		if ImGui.Button("Paste the action list") then
			
			if(#currentactionlist > 0) then
				obj[key] = currentactionlist
			end
			
		end
		
		if(clipboard["action"] ~= nil) then
			if ImGui.Button("Paste from Action Clipboard") then
				
				local objact = {}
				objact.parenttag = parenttag
				objact.parent = obj
				objact.key = key
				objact.contextscript = contextscript
				objact.index = 1
				if(#obj[key] > 0) then objact.index = #obj[key]+1 end
				
				objact.action = deepcopy(clipboard["action"])
				
				
				
				currentAction[parenttag.."_action_new"] = objact
				
				
			end
			
		end
		
		ImGui.TreePop()
	end
	ImGui.EndGroup()
	
	
	
	
end
function editor.actionFactory(entity,tag,contextscript)
	ImGui.Text("Choose an action : ")
	ImGui.Spacing()
	if(currentAction[tag].action.helperTitle == nil) then currentAction[tag].action.helperTitle = "Nothing" end
	editoractionsearch = ImGui.InputText(getLang("Filter"), editoractionsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Spacing()
	if ImGui.BeginCombo("##My Combo Box", currentAction[tag].action["helperTitle"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		for k, option in orderedPairs(arrayactiontemplate) do
			
			if (editoractionsearch == "" or (editoractionsearch ~= "" and (string.match(string.lower(k),editoractionsearch)))) then
				
				if ImGui.Selectable(k,currentAction[tag].action["helperTitle"] == k) then
					
					
					
					currentAction[tag].action = deepcopy(cyberscript.actiontemplate[option],nil)
					
					ImGui.SetItemDefaultFocus()
				end
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	if(entity.context == nil) then
		
		if ImGui.Button("Add Context (Optionnal)", 300, 0) then
			entity.context = {}
		end
		
		else
		editor.contextNode("Context",entity,"context",tag,contextscript)
	end
	
	if(entity.triggers == nil) then
		
		if ImGui.Button("Add trigger (Optionnal)", 300, 0) then
			entity.triggers = {}
			entity.requirement = {}
		end
		
		else
		
		editor.triggerNode(getLang("Action Triggers"),entity,"triggers",tag,contextscript)
		editor.requirementNode(getLang("Action requirement"),entity,"requirement","triggers",tag)
	end
	
	if(entity.output == nil) then
		
		if ImGui.Button("Add CET Output (Optionnal)", 300, 0) then
			entity.output = true
			
		end
		
		
	end
	
	if(entity.comment == nil) then
		
		if ImGui.Button("Add comment (Optionnal)", 300, 0) then
			entity.comment = ""
			
		end
		
		
	end
	
	local list = {}
	if(entity ~= nil and entity.name ~= nil) then
		
		
		ImGui.Text("Selected : "..entity["name"])
		
		ImGui.Spacing()
		
		if(
			entity["name"] ~= "spawn_vehicule_v2" and
			entity["name"] ~= "spawn_npc" and
			entity["name"] ~= "move" and
			entity["name"] ~= "teleport" and
			entity["name"] ~= "spawn_item" and
			entity["name"] ~= "spawn_camera" and
			entity["name"] ~= "move_camera" and
			entity["name"] ~= "set_mappin" and
			entity["name"] ~= "edit_mappin" and
			entity["name"] ~= "apply_effect" and
			entity["name"] ~= "remove_effect" and
			entity["name"] ~= "play_entity_facial" and
			entity["name"] ~= "play_group_facial" and
			entity["name"] ~= "stop_effect" and
			entity["name"] ~= "start_effect" and
			entity["name"] ~= "play_game_sound" and
			entity["name"] ~= "stop_game_sound" and
			entity["name"] ~= "ask_ai_from_item_with_new_contexts"
		) then
		
		for i=1,#actionorder do
			for key,vaz in pairs(entity) do
				
				
				
				if(actionorder[i] == key) then
					
					if(key ~= "name" and key ~= "triggers" and key ~= "requirement" and string.find(key, "help") == nil) then
						
						
						
						if('number' == type(entity[key])  and not(entity["name"] == "set_variable" and key == "value")) then
							entity[key] = ImGui.InputFloat(key, entity[key], 1, 10, "%.3f", ImGuiInputTextFlags.None)
							
							
							
							elseif(key == "npc") then
							newentity.search = ImGui.InputText("Search", newentity.search, 5000, ImGuiInputTextFlags.AutoSelectAll)
							
							
							if ImGui.BeginCombo("##npc", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
								
								for i,items in ipairs(cyberscript.entities) do
									
									
									if(
										
										newentity.search == "" or
										string.match(items.entity_tweak, newentity.search) or
										string.match(items.entity_name, newentity.search) or
										string.match(items.entity_entname, newentity.search) or
										string.match(items.entity_entpath, newentity.search)
										
										
										
									)then 
									
									if ImGui.Selectable(items.entity_tweak) then
										
										entity[key] = items.entity_tweak
										
										ImGui.SetItemDefaultFocus()
									end
									
									end
									
								end
								
								
								
								ImGui.EndCombo()
							end
							
							
							elseif(key == "item") then
							
							
							
							if ImGui.BeginCombo("##animequipitem", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
								
								for i,items in ipairs(animequipitem) do
									
									
									
									
									if ImGui.Selectable(items) then
										
										entity[key] = items
										
										ImGui.SetItemDefaultFocus()
									end
									
									
									
								end
								
								
								
								ImGui.EndCombo()
							end
							
							elseif(key == "slot") then
							
							
							
							if ImGui.BeginCombo("##equipeslot", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
								
								for i,items in ipairs(equipeslot) do
									
									
									
									
									if ImGui.Selectable(items) then
										
										entity[key] = items
										
										ImGui.SetItemDefaultFocus()
									end
									
									
									
								end
								
								
								
								ImGui.EndCombo()
							end
							
							elseif(entity["name"] == "npc_affinity" and key == "value") then
							
							
							
							if ImGui.BeginCombo("##My Combo Box2ssss", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
								
								
								
								for i,items in ipairs(cyberscript.entities) do
									
									
									
									
									if ImGui.Selectable(items.entity_name) then
										
										entity[key] = items.entity_name
										
										ImGui.SetItemDefaultFocus()
									end
									
									
									
								end
								
								ImGui.EndCombo()
							end
							
							
							
							elseif(entity["name"] == "set_variable" and key == "value") then
							
							if entity["type"]  == nil then
								
								if('string' == type(entity[key])) then
									entity["type"] = "text" 
								end
								if('number' == type(entity[key])) then
									
									entity["type"] = "number" 
								end
								if('boolean' == type(entity[key])) then
									
									entity["type"] = "boolean" 
								end
								
								if('table' == type(entity[key])) then
									
									entity["type"] = "table" 
								end
							end
							
							
							
							
							if ImGui.BeginCombo("##set_variabletype", entity["type"] ) then -- Remove the ## if you'd like for the title to display above combo box
								
								
								
								for i,items in ipairs(contexttype) do
									
									
									
									
									if ImGui.Selectable(items) then
										
										entity["type"] = items
										if(entity["type"]  == "text") then
											entity[key] = ""
										end
										
										if(entity["type"]  == "number" )then
											entity[key] = 0
										end
										
										if(entity["type"]  == "boolean") then
											entity[key] = true
										end
										
										ImGui.SetItemDefaultFocus()
										
									end
									
									
									
								end
								
								ImGui.EndCombo()
							end
							
							if(entity["type"]  == "text") then
								entity[key] = ImGui.InputText(key, entity[key], 50000, ImGuiInputTextFlags.None)
							end
							
							if(entity["type"]  == "number" )then
								entity[key] = ImGui.InputFloat(key, entity[key], 1, 10, "%.3f", ImGuiInputTextFlags.None)
							end
							
							if(entity["type"]  == "boolean") then
								entity[key] = ImGui.Checkbox(key, entity[key])
							end
							
							
							
							
							elseif ('string' == type(entity[key])) then
							entity[key] = ImGui.InputText(key, entity[key], 50000, ImGuiInputTextFlags.None)
							
							elseif ('boolean' == type(entity[key])) then
							entity[key] = ImGui.Checkbox(key, entity[key])
							
							
							
							elseif ('table' == type(entity[key])) then
							if(key == "trigger") then
								
								
								if ImGui.TreeNode(key) then
									if ImGui.Button("Edit", 50, 0) then
										local objact = {}
										objact.noroot = true
										objact.parenttag = tag
										objact.parent = entity
										objact.key = key
										objact.name = key
										objact.newname = key
										objact.trigger = deepcopy(entity[key],nil)
										objact.contextscript = contextscript
										currentTrigger[tag.."_"..key] = objact
										
									end
									
									
									ImGui.TreePop()
								end
								
								
								
								elseif(key == "reaction")then
								
								entity[key].category = ImGui.InputFloat("Category", entity[key].category, 1, 10, "%.3f", ImGuiInputTextFlags.None)
								entity[key].idle = ImGui.InputFloat("Idle", entity[key].idle, 1, 10, "%.3f", ImGuiInputTextFlags.None)
								
								
								
								
								
								
								elseif(key == "if_action" or key ==  "else_action" or key ==  "action" or key ==  "answer_action" or key ==  "rejected_action" )then
								
								
								editor.actionNode(key,entity,key,key.."_parent",contextscript)
								else
								
								editor.makeListString(entity[key])
								
								
								
							end
							
						end
						
						else
						
						if(key ~= "name" and key ~= "triggers" and key ~= "requirement") and string.find(key, "helper") == nil then
							ImGui.Text(entity[key])
							
						end
						
					end
					
				end
			end
		end
		
		if(entity["x"] ~= nil) then
			
			if ImGui.Button("Copy Player's XYZ", 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["x"] = vec4.x
				entity["y"] = vec4.y
				entity["z"] = vec4.z
				
				
			end
			
		end
		
		
		
		else
		if(entity["name"] == "spawn_vehicule_v2" ) then
			entity = editor.SpawnVehicleUI(entity)
			
		end
		
		if(entity["name"] == "spawn_npc" ) then
			
			entity = editor.SpawnNPCUI(entity)
		end
		
		if(entity["name"] == "move" ) then
			
			entity = editor.MoveEntityUI(entity)
		end
		
		if(entity["name"] == "teleport" ) then
			
			entity = editor.TeleportEntityUI(entity)
		end
		
		if(entity["name"] == "spawn_item" ) then
			
			entity = editor.SpawnItemUI(entity)
		end
		
		if(entity["name"] == "spawn_camera" or entity["name"] == "move_camera") then
			
			entity = editor.SpawnCamera(entity)
		end
		
		if(entity["name"] == "set_mappin" ) then
			
			entity = editor.SetMappinUI(entity,true)
		end
		
		if(entity["name"] == "edit_mappin" ) then
			
			entity = editor.SetMappinUI(entity,false)
		end
		
		if(entity["name"] == "apply_effect" or entity["name"] == "remove_effect" ) then
			editor.EffectUI(entity)
		end
		if(entity["name"] == "play_group_facial" or entity["name"] == "play_entity_facial" ) then
			editor.ExpressionUI(entity)
		end
		
		if(entity["name"] == "start_effect" or entity["name"] == "stop_effect" ) then
			editor.FXUI(entity)
		end
		
		
		if(entity["name"] == "play_game_sound" or entity["name"] == "stop_game_sound" ) then
			newentity.search = ImGui.InputText("Search", newentity.search, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
			
			if ImGui.BeginCombo("##Gamesound", entity["value"]) then -- Remove the ## if you'd like for the title to display above combo box
				
				
				
				for i,v in ipairs(arrayGameSounds) do
					if(
						
						newentity.search == "" or
						string.match(v, newentity.search)
						
						
					)then 
					if ImGui.Selectable(v, (entity["value"] == v)) then
						
						
						entity["value"] = v
						
						
						ImGui.SetItemDefaultFocus()
					end
					
					end
				end
				
				ImGui.EndCombo()
			end
		end
		
		if(entity["name"] == "ask_ai_from_item_with_new_contexts" ) then
			editor.AIContext(entity)
		end
		
		end
		
		
		
		
		
	end
	
	return entity
	
end


--context windows
function editor.contexts(tag,item)
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0, 1, 0.406, 0.7)
	ImGui.PushStyleColor(ImGuiCol.TabActive,  0, 1, 0.406, 1)
	ImGui.PushStyleColor(ImGuiCol.Text, 0, 0, 0, 1)
	if ImGui.BeginTabItem("Context: "..tag.."("..item.index..")") then
		ImGui.PopStyleColor(1)
		
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				item.parent[item.key][item.index] = item.context
				
			end
			if ImGui.MenuItem("Save&Close") then
				
				item.parent[item.key][item.index] = item.context
				currentContext[tag] = nil
			end
			if ImGui.MenuItem("Close") then
				
				currentContext[tag] = nil
				
			end
			if ImGui.MenuItem("Copy To Context Clipboard") then
				
				clipboard["context"] = deepcopy(item.context)
				
			end
			if(clipboard["context"] ~= nil) then
				if ImGui.MenuItem("Paste from Context Clipboard") then
					
					item.context = deepcopy(clipboard["context"])
					
				end
				if ImGui.MenuItem("Clear Context Clipboard") then
					
					clipboard["context"] = nil
					
				end
			end
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.context)
					
					
				end
				
				
				
			end
			if ImGui.MenuItem("Test it (result in CET console)") then
				if(checkTriggerRequirement(item.context.requirement,item.context.trigger))then
					
					
					
					
					for k,u in pairs(item.context.prop) do
						
						print("Context result for "..k.." : "..tostring(GeneratefromContext(deepcopy(u,nil))))
						
						
					end
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/context", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		editor.triggerNode(getLang("Triggers"),item.context,"trigger",tag,item.contextscript)
		ImGui.Separator()
		editor.requirementNode(getLang("trigger_condition_requirement"),item.context,"requirement","trigger",tag)
		ImGui.Separator()
		editor.actionNode(getLang("Actions"),item.context,"action",tag,item.contextscript)
		ImGui.Separator()
		editor.contextPropNode("Props",item.context,"prop",tag,item.contextscript)
		
		
		ImGui.EndTabItem()
		
	end
	
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
	
	
	
end
function editor.contextprops(tag,item)
	
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.3, 1, 0.406, 0.7)
	ImGui.PushStyleColor(ImGuiCol.TabActive,  0.3, 1, 0.406, 1)
	ImGui.PushStyleColor(ImGuiCol.Text, 0, 0, 0, 1)
	if ImGui.BeginTabItem("Props: "..tag) then
		ImGui.PopStyleColor(1)
		
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				item.parent[item.key][item.newname] = item.prop
				
			end
			if ImGui.MenuItem("Save&Close") then
				
				item.parent[item.key][item.newname] = item.prop
				currentContextProp[tag] = nil
			end
			if ImGui.MenuItem("Close") then
				
				currentContextProp[tag] = nil
				
			end
			if ImGui.MenuItem("Copy To Context Props Clipboard") then
				
				clipboard["contextprops"] = deepcopy(item.prop)
				
			end
			if(clipboard["contextprops"] ~= nil) then
				if ImGui.MenuItem("Paste from Context Props Clipboard") then
					
					item.prop = deepcopy(clipboard["contextprops"])
					
				end
				if ImGui.MenuItem("Clear Context Props Clipboard") then
					
					clipboard["contextprops"] = nil
					
				end
			end
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.prop)
					
					
				end
				
				
				
			end
			if ImGui.MenuItem("Test it (result in CET console)") then
				
				--print("Context prop result for "..item.newname.." : "..tostring(GeneratefromContext(deepcopy(item.prop,nil))))
				
			end
			ImGui.EndMenuBar()
		end
		
		
		item.newname = ImGui.InputText(getLang("Name"), item.newname, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.prop.text = ImGui.InputText(getLang("Text"), item.prop.text, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.prop.alpha =  ImGui.Checkbox("Check values alphabetically ?", item.prop.alpha)
		
		if ImGui.BeginCombo("Type", item.prop.type) then -- Remove the ## if you'd like for the title to display above combo box
			
			for i, types in ipairs(contexttype) do
				
				
				if ImGui.Selectable(types,item.prop.type==types) then
					
					
					item.prop.type = types
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
			end
			
			ImGui.EndCombo()
		end
		ImGui.Separator()
		editor.contextPropValueNode("Values",item.prop,"values",tag,item.contextscript)
		
		
		
		
		ImGui.EndTabItem()
		
	end
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
end
function editor.contextpropvalues(tag,item)
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.65, 1, 0.406, 0.7)
	ImGui.PushStyleColor(ImGuiCol.TabActive,  0.65, 1, 0.406, 1)
	ImGui.PushStyleColor(ImGuiCol.Text, 0, 0, 0, 1)
	if ImGui.BeginTabItem("PropValue: ".. tag) then
		ImGui.PopStyleColor(1)
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/context", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				item.parent[item.key][item.newname] = item.propvalue
				
			end
			if ImGui.MenuItem("Save&Close") then
				
				item.parent[item.key][item.newname] = item.propvalue
				currentContextPropValue[tag] = nil
			end
			if ImGui.MenuItem("Close") then
				
				currentContextPropValue[tag] = nil
				
			end
			if ImGui.MenuItem("Copy To Props Value Clipboard") then
				
				clipboard["propvalue"] = deepcopy(item.propvalue)
				
			end
			
			if(clipboard["propvalue"] ~= nil) then
				if ImGui.MenuItem("Paste from Props Value Clipboard") then
					
					item.propvalue = deepcopy(clipboard["propvalue"])
					
				end
				if ImGui.MenuItem("Clear Props Value Clipboard") then
					
					clipboard["propvalue"] = nil
					
				end
			end
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.propvalue)
					
					
				end
				
				
				
			end
			
			if ImGui.MenuItem("Test it (result in CET console)") then
				
				--print("Context prop result for "..item.newname.." : "..tostring(GenerateTextFromContextValues(deepcopy(item.parent.parent,nil), deepcopy(item.propvalue,nil))))
				
			end
			
			ImGui.EndMenuBar()
		end
		
		
		ImGui.Text("Props : "..item.parenttag.. " Index  : "..item.newname)
		item.newname = ImGui.InputText(getLang("Name"), item.newname, 5000, ImGuiInputTextFlags.AutoSelectAll)
		ImGui.Separator()
		if ImGui.BeginCombo("OutputType", item.propvalue.outputtype) then -- Remove the ## if you'd like for the title to display above combo box
			
			for i, types in ipairs(contexttype) do
				
				
				if ImGui.Selectable(types,item.propvalue.outputtype == types) then
					
					
					item.propvalue.outputtype = types
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
			end
			
			ImGui.EndCombo()
		end
		ImGui.Separator()
		
		editorcontexttypesearch = ImGui.InputText(getLang("Filter"), editorcontexttypesearch, 50, ImGuiInputTextFlags.AutoSelectAll)
		
		if ImGui.BeginCombo("Type", item.propvalue.type) then -- Remove the ## if you'd like for the title to display above combo box
			
			for k, context in pairs(contexttemplate) do
				
				if (editorcontexttypesearch == "" or (editorcontexttypesearch ~= "" and (string.match(string.lower(k),editorcontexttypesearch)))) then
					
					if ImGui.Selectable(k,item.propvalue.type==k) then
						
						
						local obj = deepcopy(contexttemplate[k],nil)
						obj.trigger = deepcopy(item.propvalue.trigger,nil)
						obj.outputtype = deepcopy(item.propvalue.outputtype,nil)
						obj.requirement = deepcopy(item.propvalue.requirement,nil)
						obj.action = deepcopy(item.propvalue.action,nil)
						obj.type = k
						currentContextPropValue[tag].propvalue = obj
						
						ImGui.SetItemDefaultFocus()
					end
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Separator()
		
		editor.triggerNode(getLang("Triggers"),item.propvalue,"trigger",tag,item.contextscript)
		ImGui.Separator()
		editor.requirementNode(getLang("trigger_condition_requirement"),item.propvalue,"requirement","trigger",tag)
		ImGui.Separator()
		editor.actionNode(getLang("Actions"),item.propvalue,"action",tag,item.contextscript)
		
		for k,v in pairs(item.propvalue) do
			
			if(k ~= "type" and k ~= "trigger" and k ~= "action" and k ~= "requirement" and k ~= "outputtype") then
				if(type(v) == "string") then
					item.propvalue[k] = ImGui.InputText(k,item.propvalue[k], 300, ImGuiInputTextFlags.AutoSelectAll)
				end
				if(type(v) == "number") then
					item.propvalue[k] = ImGui.InputFloat(k,item.propvalue[k], 1, 10,"%.2f", ImGuiInputTextFlags.None)
				end
				if(type(v) == "boolean") then
					item.propvalue[k] = ImGui.Checkbox(k, item.propvalue[k])
				end
				if(type(v) == "table") then
					
					if(isArray(v))then
						
						for key,value in ipairs(v) do
							if(type(value) == "string") then
								item.propvalue[k][key] = ImGui.InputText("##"..key,item.propvalue[k][key], 300, ImGuiInputTextFlags.AutoSelectAll)
							end
							if(type(value) == "number") then
								item.propvalue[k][key] = ImGui.InputFloat("##"..key,item.propvalue[k][key], 1, 10,"%.2f", ImGuiInputTextFlags.None)
							end
							if(type(value) == "boolean") then
								item.propvalue[k][key] = ImGui.Checkbox("##"..key, item.propvalue[k][key])
							end
							
						end
						local addnew = ImGui.InputText("##new",addnew, 300, ImGuiInputTextFlags.AutoSelectAll)
						if ImGui.Button("Add new") then
							
							if(type(item.propvalue[k][1]) == "string") then
								table.insert(item.propvalue[k],addnew)
								
							end
							if(type(item.propvalue[k][1]) == "number") then
								table.insert(item.propvalue[k],tonumber(addnew))
							end
							if(type(item.propvalue[k][1]) == "boolean") then
								table.insert(item.propvalue[k],toboolean(addnew))
							end
							
						end
						
						
						else
						if(k == "argument") then
							
							for key,value in pairs(v) do
								if(type(value) == "string") then
									item.propvalue[k][key] = ImGui.InputText(k,item.propvalue[k][key], 300, ImGuiInputTextFlags.AutoSelectAll)
								end
								if(type(value) == "number") then
									item.propvalue[k][key] = ImGui.InputFloat(k,item.propvalue[k][key], 1, 10,"%.2f", ImGuiInputTextFlags.None)
								end
								if(type(value) == "boolean") then
									item.propvalue[k][key] = ImGui.Checkbox(k, item.propvalue[k][key])
								end
								
							end
							
							elseif(k == "list") then
							
							for index,value in ipairs(v) do
								if(type(value) == "string") then
									item.propvalue[k][index] = ImGui.InputText(index,item.propvalue[k][index], 300, ImGuiInputTextFlags.AutoSelectAll)
									
								end
								if(type(value) == "number") then
									item.propvalue[k][index] = ImGui.InputFloat(index,item.propvalue[k][index], 1, 10,"%.2f", ImGuiInputTextFlags.None)
								end
								if(type(value) == "boolean") then
									item.propvalue[k][index] = ImGui.Checkbox(index, item.propvalue[k][index])
								end
								
							end
							local addnew = ImGui.InputText("##new",addnew, 300, ImGuiInputTextFlags.AutoSelectAll)
							if ImGui.Button("Add new") then
								
								if(type(item.propvalue[k][1]) == "string") then
									table.insert(item.propvalue[k],addnew)
									
								end
								if(type(item.propvalue[k][1]) == "number") then
									table.insert(item.propvalue[k],tonumber(addnew))
								end
								if(type(item.propvalue[k][1]) == "boolean") then
									table.insert(item.propvalue[k],toboolean(addnew))
								end
								
							end
							
							
							else
							ImGui.Text(k.." : It's an object, can't be edit like this :(. Use Json editor for edit it ! ")
						end
					end
					
				end
				
				
			end
			
		end
		
		
		
		
		ImGui.EndTabItem()
	end
	
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
	
	
end

function editor.contextNode(title,obj,key,parenttag,contextscript)
	
	if ImGui.TreeNode(title) then
		if obj[key] == nil then obj[key] = {} end
		if( #obj[key] > 0) then
			
			
			for i = 1, #obj[key] do 
				if ImGui.TreeNode("Context ("..tostring(i)..")") then
					if ImGui.Button("Edit", 50, 0) then
						local objact = {}
						
						objact.parenttag = parenttag
						objact.parent = obj
						objact.key = key
						objact.index = i
						objact.contextscript = contextscript
						objact.context = deepcopy(obj[key][i],nil)
						
						currentContext[parenttag.."_context ("..tostring(i)..")"] = objact
						
					end
					
					ImGui.SameLine()
					if currentAction[parenttag.."__context ("..tostring(i)..")"] == nil then
						if ImGui.Button("Delete", 50, 0) then
							
							table.remove(obj[key],i)
							
						end
						else
						ImGui.Text("Currently opened in editor")
					end
					
					ImGui.TreePop()
				end
				
				
			end
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			
			local objact = {}
			objact.parenttag = parenttag
			objact.parent = obj
			objact.key = key
			objact.index = 1
			if(#obj[key] > 0) then objact.index = #obj[key]+1 end
			objact.contextscript = contextscript
			objact.context = {}
			objact.context.action = {}
			objact.context.trigger = {}
			objact.context.requirement = {}
			objact.context.prop = {}
			
			
			
			
			currentContext[parenttag.."_context_new"] = objact
		end
		ImGui.TreePop()
	end
	
end
function editor.contextPropNode(title,obj,key,parenttag,contextscript)
	if obj[key] == nil then obj[key] = {} end
	if ImGui.TreeNode(title) then
		
		
		
		
		for trigtag,prop in pairs(obj[key]) do 
			if ImGui.TreeNode(trigtag) then
				if ImGui.Button("Edit", 50, 0) then
					local objact = {}
					
					objact.parenttag = parenttag
					objact.parent = obj
					objact.key = key
					objact.name = trigtag
					objact.newname = trigtag
					objact.prop = deepcopy(prop,nil)
					if objact.prop.alpha == nil then objact.prop.alpha = false end
					objact.contextscript = contextscript
					currentContextProp[parenttag.."_"..trigtag] = objact
					
				end
				
				ImGui.SameLine()
				if currentContextProp[parenttag.."_"..trigtag] == nil then
					if ImGui.Button("Delete", 50, 0) then
						
						obj[key][trigtag] = nil
						
					end
					else
					ImGui.Text("Currently opened in editor")
				end
				ImGui.TreePop()
			end
			
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			
			local objact = {}
			objact.parenttag = parenttag
			objact.parent = obj
			objact.key = key
			objact.name = parenttag.."_prop_new"
			objact.newname = parenttag.."_prop_new"
			objact.contextscript = contextscript
			objact.prop = {}
			objact.prop.values = {}
			objact.prop.text = ""
			objact.prop.type = "text"
			if objact.prop.alpha == nil then objact.prop.alpha = false end
			
			currentContextProp[parenttag.."_prop_new"] = objact
		end
		ImGui.TreePop()
	end
	
end
function editor.contextPropValueNode(title,obj,key,parenttag,contextscript)
	if obj[key] == nil then obj[key] = {} end
	if ImGui.TreeNode(title) then
		
		
		
		
		for trigtag,prop in pairs(obj[key]) do 
			if ImGui.TreeNode(trigtag) then
				if ImGui.Button("Edit", 50, 0) then
					local objact = {}
					
					objact.parenttag = parenttag
					objact.parent = obj
					objact.key = key
					objact.name = trigtag
					objact.newname = trigtag
					objact.propvalue = deepcopy(prop,nil)
					objact.contextscript = contextscript
					currentContextPropValue[parenttag.."_"..trigtag] = objact
					
				end
				
				ImGui.SameLine()
				if currentContextPropValue[parenttag.."_"..trigtag] == nil then
					if ImGui.Button("Delete", 50, 0) then
						
						obj[key][trigtag] = nil
						
					end
					else
					ImGui.Text("Currently opened in editor")
				end
				ImGui.TreePop()
			end
			
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			
			local objact = {}
			objact.parenttag = parenttag
			objact.parent = obj
			objact.key = key
			objact.name = parenttag.."_propvalue_new"
			objact.newname = parenttag.."_propvalue_new"
			objact.contextscript = contextscript
			objact.propvalue = {}
			objact.propvalue.action = {}
			objact.propvalue.trigger = {}
			objact.propvalue.requirement = {}
			objact.propvalue.text = ""
			objact.propvalue.outputtype = "text"
			objact.propvalue.type = "text"
			
			currentContextPropValue[parenttag.."_propvalue_new"] = objact
		end
		ImGui.TreePop()
	end
	
end




--triggers windows
function editor.triggers(tag,item)
	
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0, 0.795, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.TabActive,  0, 0.795, 1, 1)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Triggers: "..item.name.."##"..tag) then
		ImGui.PopStyleColor(1)
		if item.parent ~= nil then 
			if ImGui.BeginMenuBar()  then 
				if ImGui.MenuItem("Save") then
					if item.noroot == nil or item.noroot == false then
						item.parent[item.key][item.newname] = item.trigger
						else
						item.parent[item.key] = item.trigger
						
					end
				end
				
				if ImGui.MenuItem("Save&Close") then
					
					if item.noroot == nil or item.noroot == false then
						item.parent[item.key][item.newname] = item.trigger
						else
						item.parent[item.key] = item.trigger
						
					end
					currentTrigger[tag] = nil
				end
				
				if ImGui.MenuItem("Close") then
					
					currentTrigger[tag] = nil
					
				end
				
				ImGui.EndMenuBar()
			end
		end
		
		if ImGui.BeginMenuBar() then 
			
			
			
			
			if ImGui.MenuItem("Copy To Trigger Clipboard") then
				
				clipboard["trigger"] = deepcopy(item.trigger)
				
			end
			if(clipboard["trigger"] ~= nil) then
				if ImGui.MenuItem("Paste from Trigger Clipboard") then
					
					item.trigger = deepcopy(clipboard["trigger"])
					
				end
				if ImGui.MenuItem("Clear Trigger Clipboard") then
					
					clipboard["trigger"] = nil
					
				end
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.trigger)
					
					
				end
				
				
				
			end
			
			
			
			ImGui.EndMenuBar()
		end
		if item.noroot == nil or item.noroot == false then
			else
			ImGui.Text("true")			
		end
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/scripting-basics", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.newname)
		
		item.newname = ImGui.InputText(getLang("Name"), item.newname, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if ImGui.BeginChild("part1", 850, 495,true) then
			
			
			editor.triggerFactory(item.trigger,tag,item.contextscript)
			
			
			
			
			ImGui.EndChild()
		end
		ImGui.SameLine()
		if ImGui.BeginChild("part2", 600, 495,true) then
			
			ImGui.Text("Help : ")
			
			ImGui.Text(splitByChunk(getLang(item.trigger.helper),85))
			
			
			ImGui.EndChild()
		end
		
		
		
		
		ImGui.EndTabItem()
		
	end
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
	
	
	
	
	
end
function editor.triggerNode(title,obj,key,parenttag,contextscript)
	if obj[key] == nil then obj[key] = {} end
	if ImGui.TreeNode(title) then
		
		
		for trigtag,trigger in pairs(obj[key]) do 
			if ImGui.TreeNode(trigtag) then
				if ImGui.Button("Edit", 50, 0) then
					local objact = {}
					
					objact.parenttag = parenttag
					objact.parent = obj
					objact.key = key
					objact.name = trigtag
					objact.newname = trigtag
					objact.trigger = deepcopy(trigger,nil)
					
					if(cyberscript.triggertemplate[trigger.name] ~= nil) then
						
						objact.trigger = deepcopy(cyberscript.triggertemplate[trigger.name],nil) 
						
						for k,v in pairs(trigger) do
							if(k ~= "helper" and k ~= "helperTitle" and k ~= "name") then
								objact.trigger[k] = v
							end
						end
						
						else 
						
						objact.trigger = deepcopy(trigger,nil)
						objact.trigger.helper = trigger.name
						objact.trigger.helperTitle = trigger.name
						
					end
					
					objact.contextscript = contextscript
					currentTrigger[parenttag.."_"..trigtag] = objact
					
				end
				
				ImGui.SameLine()
				if currentTrigger[parenttag.."_"..trigtag] == nil then
					if ImGui.Button("Delete", 50, 0) then
						
						obj[key][trigtag] = nil
						
					end
					else
					ImGui.Text("Currently opened in editor")
				end
				
				if ImGui.Button("Copy To Trigger Clipboard") then
					
					clipboard["trigger"] =  deepcopy(trigger,nil)
					
				end
				
				
				
				ImGui.TreePop()
			end
			
			
		end
		
		
		if ImGui.Button("(Add new)", 300, 0) then
			
			local objact = {}
			objact.parenttag = parenttag
			objact.parent = obj
			objact.key = key
			objact.name = parenttag.."_trigger_new"
			objact.newname = parenttag.."_trigger_new"
			objact.contextscript = contextscript
			objact.trigger = deepcopy(cyberscript.triggertemplate["auto"],nil) 
			
			currentTrigger[parenttag.."_trigger_new"] = objact
			
		end
		
		if(clipboard["trigger"] ~= nil) then
			if ImGui.Button("Paste from Trigger Clipboard") then
				local objact = {}
				objact.parenttag = parenttag
				objact.parent = obj
				objact.key = key
				objact.name = parenttag.."_trigger_new"
				objact.newname = parenttag.."_trigger_new"
				objact.contextscript = contextscript
				objact.trigger =deepcopy(clipboard["trigger"])
				
				currentTrigger[parenttag.."_trigger_new"] = objact
				
				
			end
			
		end
		
		ImGui.TreePop()
	end
	
end
function editor.triggerFactory(entity,tag,contextscript)
	ImGui.Text("Choose an trigger : ")
	ImGui.Spacing()
	if(currentTrigger[tag] ~= nil and currentTrigger[tag].trigger.helperTitle == nil) then currentTrigger[tag].trigger.helperTitle = "Auto" end
	
	editortriggersearch = ImGui.InputText(getLang("Filter"), editortriggersearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Spacing()
	if ImGui.BeginCombo("##My Combo Box"..tag, currentTrigger[tag].trigger.helperTitle) then -- Remove the ## if you'd like for the title to display above combo box
		
		for k, option in orderedPairs(arraytriggertemplate) do
			
			if (editortriggersearch == "" or (editortriggersearch ~= "" and (string.match(string.lower(k),editortriggersearch)))) then
				
				if ImGui.Selectable(k, k == currentTrigger[tag].trigger.helperTitle) then
					
					
					
					currentTrigger[tag].trigger = deepcopy(cyberscript.triggertemplate[option],nil)
					
					ImGui.SetItemDefaultFocus()
				end
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	if(entity.output == nil) then
		
		if ImGui.Button("Add CET Output (Optionnal)", 300, 0) then
			entity.output = true
			
		end
		
		
	end
	if(entity.expected == nil) then
		
		if ImGui.Button("Add Expected result (Optionnal)", 300, 0) then
			entity.expected = true
		end
		
		
		
	end
	
	if(entity.comment == nil) then
		
		if ImGui.Button("Add comment (Optionnal)", 300, 0) then
			entity.comment = ""
			
		end
		
		
	end
	
	if(entity ~= nil and entity.name ~= nil) then
		ImGui.Text("Selected : "..entity["name"])
		ImGui.Spacing()
		if ImGui.Button("?", 300, 0) then
			
		end
		
		local hovered = ImGui.IsItemHovered()
		
		if hovered  and entity["helper"]~= nil  then
			ImGui.BeginTooltip()
			
			ImGui.SameLine()
			ImGui.BeginGroup()
			ImGui.BeginChild("ToolTipMain", 500, 50, true,ImGuiWindowFlags.AlwaysAutoResize )
			
			
			
			
			ImGui.Text(splitByChunk(getLang(entity["helper"]),50))--content
			
			
			ImGui.EndChild()
			ImGui.EndGroup()
			ImGui.EndTooltip()
		end
		
		if(string.find(entity["name"], "position") ~= nil) then
			if ImGui.Button(getLang("editor_copy_player_location"), 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["x"] = vec4.x
				entity["y"] = vec4.y
				entity["z"] = vec4.z
				
				
			end
		end 
		
		
		if(string.find(entity["name"], "rotation") ~= nil) then
			if ImGui.Button(getLang("Copy from Player's Rotation"), 300, 0) then
				
				local qat = Game.GetPlayer():GetWorldOrientation()
				local angless = GetSingleton('Quaternion'):ToEulerAngles(qat)
				
				entity["yaw"] = angless.yaw
				entity["pitch"] = angless.pitch
				entity["roll"] = angless.roll
				
				
			end
		end 
		
		
		for i=1,#triggerorder do
			for key,vaz in pairs(entity) do
				
				if(triggerorder[i] == key) then
					
					
					
					
					if(key ~= "name" and string.find(key, "help") == nil) then
						
						
						if('number' == type(entity[key]) and not (entity["name"] == "check_variable" and key == "value")) then
							entity[key] = ImGui.InputFloat(key.."##"..entity.name, entity[key], 1, 10, "%.3f", ImGuiInputTextFlags.None)
							
							elseif((entity["name"] == "npc" and key == "value") or (entity["name"] == "npc_affintiy" and key == "value")) then
							
							if(entity["name"] == "npc" and entity["way"] ~= nil) then
								
								if entity["way"] == "fixer" then
									
									if(entity[key] == nil) then entity[key] = "" end
									
									if ImGui.BeginCombo("Fixer", npcFixer) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										for k,v in pairs(cyberscript.cache["fixer"]) do
											
											if ImGui.Selectable(v.data.name, (v.data.tag == entity[key])) then
												entity[key] = k
												npcFixer = v.data.name
												ImGui.SetItemDefaultFocus()
											end
											
										end
										
										ImGui.EndCombo()
									end
									
									ImGui.Text(entity[key])
									
									else
									
									
									if(entity[key] == nil) then entity[key] = "" end
									
									if ImGui.BeginCombo("NPC", npcchara) then -- Remove the ## if you'd like for the title to display above combo box
										
										
										
										for i=1, #arrayListCharacter do
											
											if ImGui.Selectable(arrayListCharacter[i], (arrayListCharacter[i] == entity[key])) then
												entity[key] = arrayListCharacter[i]
												npcchara = arrayListCharacter[i]
												ImGui.SetItemDefaultFocus()
											end
											
										end
										
										ImGui.EndCombo()
									end
									
									ImGui.Text(entity[key])
									
								end
								
								else
								
								
								if(entity[key] == nil) then entity[key] = "" end
								
								if ImGui.BeginCombo("NPC", entity[key]) then -- Remove the ## if you'd like for the title to display above combo box
									
									
									
									for i,items in ipairs(cyberscript.entities) do
										
										
										
										
										if ImGui.Selectable(items.entity_tweak) then
											
											entity[key] = items.entity_tweak
											
											ImGui.SetItemDefaultFocus()
										end
										
										
										
									end
									
									ImGui.EndCombo()
								end
								
								ImGui.Text(entity[key])
								
								
							end
							
							
							
							elseif(entity["name"] == "check_variable" and key == "value") then
							
							if entity["type"]  == nil then
								
								if('string' == type(entity[key])) then
									entity["type"] = "text" 
								end
								if('number' == type(entity[key])) then
									
									entity["type"] = "number" 
								end
								if('boolean' == type(entity[key])) then
									
									entity["type"] = "boolean" 
								end
								
								if('table' == type(entity[key])) then
									
									entity["type"] = "table" 
								end
							end
							
							
							
							
							if ImGui.BeginCombo("##set_variabletype", entity["type"] ) then -- Remove the ## if you'd like for the title to display above combo box
								
								
								
								for i,items in ipairs(contexttype) do
									
									
									
									
									if ImGui.Selectable(items) then
										
										entity["type"] = items
										if(entity["type"]  == "text") then
											entity[key] = ""
										end
										
										if(entity["type"]  == "number" )then
											entity[key] = 0
										end
										
										if(entity["type"]  == "boolean") then
											entity[key] = true
										end
										
										ImGui.SetItemDefaultFocus()
									end
									
									
									
								end
								
								ImGui.EndCombo()
							end
							
							if(entity["type"]  == "text") then
								entity[key] = ImGui.InputText(key.."##"..entity.name, entity[key], 50000, ImGuiInputTextFlags.None)
							end
							
							if(entity["type"]  == "number" )then
								entity[key] = ImGui.InputFloat(key.."##"..entity.name, entity[key], 1, 10, "%.3f", ImGuiInputTextFlags.None)
							end
							
							if(entity["type"]  == "boolean") then
								entity[key] = ImGui.Checkbox(key.."##"..entity.name, entity[key])
							end
							
							
							
							
							elseif ('string' == type(entity[key])) then
							entity[key] = ImGui.InputText(key.."##"..entity.name, tostring(entity[key]), 5000, ImGuiInputTextFlags.AutoSelectAll)
							
							elseif ('boolean' == type(entity[key])) then
							entity[key] = ImGui.Checkbox(key.."##"..entity.name, entity[key])
							
							
							
							elseif ('table' == type(entity[key])) then
							
							if(key == "trigger") then
								
								
								if ImGui.TreeNode(key) then
									if ImGui.Button("Edit", 50, 0) then
										local objact = {}
										objact.noroot = true
										objact.parenttag = tag
										objact.parent = entity
										objact.key = key
										objact.name = key
										objact.newname = key
										objact.trigger = deepcopy(entity[key],nil)
										objact.contextscript = contextscript
										currentTrigger[tag.."_"..key] = objact
										
									end
									
									
									ImGui.TreePop()
								end
								
								
								
								elseif(key == "triggers")then
								
								editor.triggerNode(getLang("Triggers"),entity,key,entity["name"],contextscript)
								
								elseif(key == "reaction")then
								
								entity[key].category = ImGui.InputFloat(key.."##"..entity.name, entity[key].category, 1, 10, "%.3f", ImGuiInputTextFlags.None)
								entity[key].idle = ImGui.InputFloat(key.."##"..entity.name, entity[key].idle, 1, 10, "%.3f", ImGuiInputTextFlags.None)
								
								
								
								
								
								elseif(key == "if_action" or key ==  "else_action" or key ==  "for_action")then
								editor.actionNode(key.."##"..entity.name,entity,key,key.."_parent",contextscript)
								
								else 
								
								editor.makeListString(entity[key])
								
								
								
								
								
							end
							
						end
						
						else
						
						if(key ~= "name") and string.find(key, "helper") == nil then
							ImGui.Text(entity[key])
							
						end
						
						
						
						
					end
					
				end
			end
			
		end
		
		if(entity["x"] ~= nil ) then
			
			if ImGui.Button("Copy Player's XYZ", 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["x"] = vec4.x
				entity["y"] = vec4.y
				entity["z"] = vec4.z
				
				
			end
			
		end
		
		if(entity["from_x"] ~= nil ) then
			
			if ImGui.Button("From : Copy Player's XYZ", 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["from_x"] = vec4.x
				entity["from_y"] = vec4.y
				entity["from_z"] = vec4.z
				
				
			end
			
		end
		
		if(entity["to_x"] ~= nil ) then
			
			if ImGui.Button("To : Copy Player's XYZ", 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				entity["to_x"] = vec4.x
				entity["to_y"] = vec4.y
				entity["to_z"] = vec4.z
				
				
			end
			
		end
		
		if(entity.context == nil) then
			
			if ImGui.Button("Add Context (Optionnal)", 300, 0) then
				entity.context = {}
			end
			
			else
			editor.contextNode("Context",entity,"context",tag,contextscript)
		end
		
		if ImGui.Button("Test Trigger", 300, 0) then
			editor_check_trigger_test = checkTrigger(entity)
		end
		
		if editor_check_trigger_test then
			ImGui.Text("Result : "..tostring(editor_check_trigger_test))
			else
			ImGui.Text("Result : "..tostring(editor_check_trigger_test))
		end
		
		
		return entity
	end
	
	
	
	
	
end

--requirement

function editor.requirementNode(title,obj,parent,triggerlistkey,parenttag)
	if obj[parent] == nil then obj[parent] = {} end
	if ImGui.TreeNode(title) then
		
		
		if ImGui.Button("Add an new group", 300, 0) then
			local group = {}
			table.insert(obj[parent],group)
			
		end
		
		
		for i = 1, #obj[parent] do 
			
			
			
			if(obj[parent][i] ~= nil and #obj[parent][i] > 0) then
				ImGui.Separator()
				if ImGui.TreeNode("Requirement Group "..i) then
					
					for y,itemm in ipairs(obj[parent][i]) do 
						
						ImGui.PushItemWidth(200)
						if ImGui.BeginCombo("##existingtrigger", obj[parent][i][y]) then -- Remove the ## if you'd like for the title to display above combo box
							
							for key,value in pairs(obj[triggerlistkey]) do
								--logme(2,key)
								if ImGui.Selectable(key, (key == obj[parent][i][y])) then
									obj[parent][i][y] = key
									ImGui.SetItemDefaultFocus()
								end
								
							end
							
							ImGui.EndCombo()
						end
						ImGui.PopItemWidth()
						ImGui.SameLine()
						
						if ImGui.Button("Delete##"..i.."##"..y) then
							
							table.remove(obj[parent][i],y)
							if(#obj[parent][i] == 0) then
								obj[parent][i] = nil
							end
							
						end
						
						
						if(#obj[parent][i] > y)then
							ImGui.Text("AND")
						end
						
						
						
					end
					ImGui.Separator()
					ImGui.PushItemWidth(200)
					if ImGui.BeginCombo("##newtrigger", newRequirementItem) then -- Remove the ## if you'd like for the title to display above combo box
						
						for key,value in pairs(obj[triggerlistkey]) do
							--logme(2,key)
							if ImGui.Selectable(key, (key == newRequirementItem)) then
								newRequirementItem = key
								ImGui.SetItemDefaultFocus()
							end
							
						end
						
						ImGui.EndCombo()
					end
					ImGui.PopItemWidth()
					ImGui.SameLine()
					if ImGui.Button("Add new requirement to that group") then
						
						table.insert(obj[parent][i],newRequirementItem)
						newRequirementItem = ""
						
					end
					ImGui.TreePop()
				end
				
				if(#obj[parent] > i)then
					ImGui.Separator()
					ImGui.Text("OR")
				end
				
				else
				
				
				if ImGui.BeginCombo("##My Combo Box3", newRequirementItem) then -- Remove the ## if you'd like for the title to display above combo box
					
					for key,value in pairs(obj[triggerlistkey]) do
						--logme(2,key)
						if ImGui.Selectable(key, (key == newRequirementItem)) then
							newRequirementItem = key
							ImGui.SetItemDefaultFocus()
						end
						
					end
					
					ImGui.EndCombo()
				end
				if ImGui.Button("Add", 300, 0) then
					
					table.insert(obj[parent][i],newRequirementItem)
					newRequirementItem = ""
				end
				
			end
			
			
			
			
			
		end
		if ImGui.Button("Clear Requirement", 300, 0) then
			
			obj[parent] = {}
		end
		ImGui.Separator()
		ImGui.Text("Fullfill Condition : It will be triggered when ")
		ImGui.SameLine()
		for i = 1, #obj[parent] do 
			ImGui.Text("Group "..i)
			
			if(#obj[parent] > i )then
				ImGui.SameLine()
				ImGui.Text("OR")
				ImGui.SameLine()
			end
			
		end
		ImGui.SameLine()
		ImGui.Text("is fullfilled.")
		ImGui.Spacing()
		ImGui.TreePop()
		ImGui.Separator()
	end
end



--Objective 
function editor.objectives(tag,item)
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Objective: "..tag) then
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				
				local result, message = pcall(function()
					item.parent[item.key][item.index] = item.objective
					local graph =  editor.makeGraphdata(item.parent)
					
					item.parent.sortedobjectives =graph
					
				end)
				
				if result == false then 
					item.graphError=" Can't display the objective in Graph, check that the unlock relation between objectives are good. \n Missing unlock relation between objectives of your missions, check all objectives relation \n Error : "..message
					else
					item.graphError=""
					
					
				end
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				local result, message = pcall(function()
					item.parent[item.key][item.index] = item.objective
					local graph =  editor.makeGraphdata(item.parent)
					
					item.parent.sortedobjectives =graph
					
				end)
				
				if result == false then 
					item.graphError=" Can't display the objective in Graph, check that the unlock relation between objectives are good. \n Missing unlock relation between objectives of your missions, check all objectives relation \n Error : "..message
					else
					item.graphError=""
					
					currentObjective[tag] = nil
				end
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentObjective[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.objective)
					
					
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		ImGui.Text(item.graphError)
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-quest?id=%e2%9c%85-setting-up-the-objectives", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		
		item.objective.title = ImGui.InputText("Title", item.objective.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.objective.tag = ImGui.InputText(getLang("editor_tag"), item.objective.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if ImGui.BeginCombo("State :", defaultJournalEntryState) then
			
			
			for k,v in pairs(EgameJournalEntryState) do
				
				if ImGui.Selectable(k, (item.objective.state == EgameJournalEntryState[k])) then
					item.objective.state = EgameJournalEntryState[k]
					
					defaultJournalEntryState = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		item.objective.isoptionnal = ImGui.Checkbox("Is Optionnal ?", item.objective.isoptionnal)
		
		
		ImGui.Separator()
		
		editor.listStringNode("Unlock Objectives","Unlock Objectives when completed",item.objective,"unlock",false)
		
		ImGui.Separator()
		
		ImGui.Text("Extra :")
		ImGui.Text(" Extra is optionnal information that you will display on the right side of the journal menu for your selected objective. \n It can be :\n -Codex Entry (data) \n -Custom mappin position(mappin) \n -Custom Codex Entry(custom) \n -Update Notification Message(update)")
		
		ImGui.Spacing(2)
		
		if ImGui.TreeNode("Current Extra") then
			
			for k,v in pairs(item.objective.extra) do
				
				if(k == "mappin") then
					
					ImGui.Text(k.." : "..v)
					ImGui.SameLine()
					if ImGui.Button("Delete##"..k) then
						
						item.objective.extra.mappin = nil
						
					end
					
				end
				
				if(k == "data") then
					
					for i,data in ipairs(v) do
						
						
						ImGui.Text(k.." : "..data.value.."( "..data.type.." )")
						ImGui.SameLine()
						if ImGui.Button("Delete##"..i) then
							
							item.objective.extra.data[i] = nil
							
						end
						
					end
				end
				
				
				if(k == "custom") then
					
					for i,data in ipairs(v) do
						
						
						ImGui.Text(k.." : "..data.tag)
						ImGui.SameLine()
						if ImGui.Button("Delete##"..k) then
							
							item.objective.extra.custom[i] = nil
							
						end
						
					end
				end
				
				if(k == "update") then
					
					ImGui.Text(k.." : "..v)
					ImGui.SameLine()
					if ImGui.Button("Delete") then
						
						item.objective.extra.mappin = nil
						
					end
					
				end
				
			end
			ImGui.TreePop(1)
		end
		
		ImGui.Spacing()
		
		
		if ImGui.BeginCombo("Add Extra Type :", defaultextra) then
			
			
			for i,v in ipairs(objectiveextratype) do
				
				if ImGui.Selectable(v, (v == defaultextra)) then
					
					defaultextra = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		if(defaultextra == "mappin") then
			
			mappinextra = ImGui.InputText("Mappin", mappinextra, 5000, ImGuiInputTextFlags.AutoSelectAll)
			if ImGui.Button("Add Extra") then
				
				if(item.objective.extra.mappin == nil) then item.objective.extra.mappin = mappinextra end
				
				
			end
		end
		
		if(defaultextra == "update") then
			
			mappinextra = ImGui.InputText("Update Notification Message", mappinextra, 5000, ImGuiInputTextFlags.AutoSelectAll)
			if ImGui.Button("Add Extra") then
				
				if(item.objective.extra.update == nil) then item.objective.extra.update = mappinextra end
				
				
			end
		end
		
		if(defaultextra == "data") then
			
			dataextratype = ImGui.InputText("Type",dataextratype, 5000, ImGuiInputTextFlags.AutoSelectAll)
			dataextravalue = ImGui.InputText("Value",dataextravalue, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
			if ImGui.Button("Add Extra") then
				
				if(item.objective.extra.data == nil) then item.objective.extra.data = {} end
				local objextra = {}
				objextra.type = dataextratype
				objextra.value = dataextravalue
				table.insert(item.objective.extra.data,objextra)
				
				
			end
			
		end
		
		if(defaultextra == "custom") then
			
			customextratag = ImGui.InputText("Tag",customextratag, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
			if ImGui.Button("Add Extra") then
				
				if(item.objective.extra.custom == nil) then item.objective.extra.custom = {} end
				local objextra = {}
				objextra.tag = customextratag
				
				table.insert(item.objective.extra.custom,objextra)
				
				
			end
			
		end
		
		ImGui.Separator()
		
		if ImGui.TreeNode("Triggers and Actions") then
			
			editor.triggerNode(getLang("trigger_condition"),item.objective,"trigger",tag,item.contextscript)
			
			editor.requirementNode(getLang("trigger_condition_requirement"),item.objective,"requirement","trigger")
			
			editor.actionNode(getLang("trigger_action"),item.objective,"action",tag,item.contextscript)
			editor.actionNode("Fail Action :",item.objective,"failaction",tag,item.contextscript)
			editor.actionNode("Resume Action :",item.objective,"resume_action",tag,item.contextscript)
			
			ImGui.TreePop(1)
		end
		
		
		ImGui.EndTabItem()
		
	end
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
	
end

function editor.questGraph(tag,item)
	
	
	if item.data.sortedobjectives ~= nil and #item.data.objectives > 0 then
		ImGui.PushStyleColor(ImGuiCol.ChildBg,  1,	1,	1, 0.1)
		
		
		if ImGui.BeginChild("graphquest", 850, (75*item.data.sortedobjectives.row), true,ImGuiWindowFlags.AlwaysHorizontalScrollbar) then
			
			
			
			
			
			local flags = ImGuiTableFlags.ScrollX
			
			if ImGui.BeginTable("Table_"..tag, item.data.sortedobjectives.column+3,flags,(questgraphzoomlevel*(item.data.sortedobjectives.column+4)),(60*item.data.sortedobjectives.row)) then
				
				
				
				
				
				for y=0,item.data.sortedobjectives.row-1 do
					ImGui.TableNextRow()
					
					--Start
					if(y==0) then 
						if ImGui.TableSetColumnIndex(0)   then
							
							ImGui.PushStyleColor(ImGuiCol.ChildBg, 0, 1, 0.054901960784314, 1)
							if ImGui.BeginChild("graphquestStart", questgraphzoomlevel, 30, true) then
								
								
								ImGui.PushStyleColor(ImGuiCol.Text,   0,	0,	0, 1)
								ImGui.Text("START OF THE QUEST")
								ImGui.PopStyleColor(1)
								
								
								-- 
							end
							ImGui.EndChild()
							ImGui.PopStyleColor(1)
							
							ImGui.SameLine()
							
							ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
							ImGui.Text("--")
							
							ImGui.PopStyleColor(1)
						end			 
						
						
					end
					
					--Objectives
					for x=1,item.data.sortedobjectives.column do
						
						for index,v in ipairs(item.data.sortedobjectives.objectives) do
							if(v.row == y+1 and v.column == x) then
								if ImGui.TableSetColumnIndex(x)   then
									editor.nextObj(v,1,index,tag,x,y+1,item.data)
								end
							end
						end			 
					end
					
					
					--End
					if(y==0) then 
						
					end
					
					
					
					
				end
				
				ImGui.EndTable()
			end
			
			
			
			
			
			ImGui.EndChild()
		end
		
		ImGui.PopStyleColor(1)
		else
		ImGui.Text("Add a first objective to see the graph")
		if ImGui.Button("Add First Objective")then
			
			
			local objact = {}
			objact.parenttag = tag
			objact.parent = item.data
			objact.key = "objectives"
			objact.contextscript = tag
			objact.index = #item.data.objectives+1
			objact.graphError = ""
			
			objact.objective = {}
			
			
			objact.objective.title = tag.."_objective_new_"..#item.data.objectives+1
			objact.objective.tag = tag.."_objective_new_"..#item.data.objectives+1
			objact.objective.state = EgameJournalEntryState.Active
			objact.objective.isoptionnal = false
			
			
			objact.objective["trigger"] = {}
			objact.objective["requirement"] = {}
			objact.objective["action"] = {}
			objact.objective["failaction"] = {}
			objact.objective["resume_action"] = {}
			objact.objective["unlock"] = {}
			objact.objective["extra"] = {}
			
			
			currentObjective[tag.."_objective_new_".. #item.data.objectives+1] = objact
			
			
			
		end
		
	end
end

--Quest Graph functions
function editor.nextObj(objective,layer,index,parrenttag,column,row,item)
	
	if objective.isoptionnal == true then
		ImGui.PushStyleColor(ImGuiCol.ChildBg,  0.1921568627451,0.77254901960784,0.31372549019608, 0.5)
		else
		ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.1921568627451,0.65882352941176,0.77254901960784, 0.5)
	end
	
	
	
	if ImGui.BeginChild(objective.title.."child", questgraphzoomlevel, 50, false) then
		ImGui.Text(" "..objective.title.."        ")
		ImGui.Spacing()
		if ImGui.Button("Edit") then
			
			local objact = {}
			
			objact.parenttag = parrenttag
			objact.parent = item
			objact.key = "objectives"
			objact.index = index
			objact.contextscript = parrenttag
			objact.objective = deepcopy(item["objectives"][index],nil)
			objact.graphError = ""
			currentObjective[parrenttag.."_"..item["objectives"][index].tag.." ("..tostring(index)..")"] = objact
		end
		ImGui.SameLine()
		if ImGui.Button("Delete") then
			
			table.remove(item["objectives"],index)
			
			if(index == 1) then
				item.sortedobjectives = nil
				
				else
				local result, message = pcall(function()
					local graph =  editor.makeGraphdata(item)
					
					item.sortedobjectives =graph
					
				end)
				
			end
			
		end
		ImGui.SameLine()
		if ImGui.Button("Test Trigger Action##"..index) then
			local list = deepcopy(item["objectives"][index]["action"],nil)
			--print(dump(list[1]))
			runActionList(list, "test","interact",false,"player")
			
			
		end
		
		
		
		
	end
	ImGui.EndChild()
	
	local tab1hov = ImGui.IsItemHovered()
	if tab1hov then
		
		ImGui.BeginTooltip()
		
		
		ImGui.BeginGroup()
		ImGui.BeginChild("ToolTipMain", 400, (600+((#objective.action+1)*20)), true,ImGuiWindowFlags.AlwaysAutoResize )
		ImGui.Text("Title : "..objective.title)
		ImGui.Text("Tag : "..objective.tag)
		ImGui.Text("State : "..objective.statedisplay)
		ImGui.Text("Unlock objectives : ")
		ImGui.SameLine()
		local textobj = "| "
		for i,v in ipairs(objective.unlock) do
			textobj = textobj..v.." | "
		end
		ImGui.Text(textobj)
		ImGui.Text("is Optionnal : "..tostring(objective.isoptionnal))
		ImGui.Text("This objective is finished when : ")
		ImGui.Text(splitByChunk(objective.requirementtext, 70))
		ImGui.Spacing()
		ImGui.Text("Actions : ")
		ImGui.Text(objective.actionsdisplay)
		
		
		ImGui.EndChild()
		ImGui.EndGroup()
		ImGui.EndTooltip()
	end
	
	
	
	ImGui.PopStyleColor(1)
	if(#objective.unlock >0) then
		ImGui.SameLine()
		ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
		ImGui.Text("--")
		
		ImGui.PopStyleColor(1)
		else
		if ImGui.TableSetColumnIndex(item.sortedobjectives.column+1)   then
			
			
			ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
			ImGui.Text("--")
			
			ImGui.PopStyleColor(1)
			
			ImGui.SameLine()
			
			if ImGui.Button("Add new Objective ##"..row)then
				
				
				local objact = {}
				objact.parenttag = parrenttag
				objact.parent = item
				objact.key = "objectives"
				objact.contextscript = parrenttag
				objact.index = #item.objectives+1
				objact.graphError = ""
				
				objact.objective = {}
				
				
				objact.objective.title = parrenttag.."_objective_new_".. #item.objectives+1
				objact.objective.tag = parrenttag.."_objective_new_".. #item.objectives+1
				objact.objective.state = EgameJournalEntryState.Active
				objact.objective.isoptionnal = false
				
				
				objact.objective["trigger"] = {}
				objact.objective["requirement"] = {}
				objact.objective["action"] = {}
				objact.objective["failaction"] = {}
				objact.objective["resume_action"] = {}
				objact.objective["unlock"] = {}
				objact.objective["extra"] = {}
				
				
				currentObjective[parrenttag.."_objective_new_".. #item.objectives+1] = objact
				
				
				
			end
			
			
			
			
		end		
		if(objective.isoptionnal == false) then
			
			
			
			
			
			if ImGui.TableSetColumnIndex( item.sortedobjectives.column+2)   then
				
				ImGui.PushStyleColor(ImGuiCol.Text,  1, 1, 1, 1)
				ImGui.Text("--")
				
				ImGui.PopStyleColor(1)
				
				ImGui.SameLine()
				
				ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.71372549019608,0.0,0.0, 1)
				if ImGui.BeginChild("graphquestEnd"..index, questgraphzoomlevel, 30, true) then
					
					ImGui.PushStyleColor(ImGuiCol.Text,   1, 1, 1, 1)
					ImGui.Text("END OF THE QUEST")
					ImGui.PopStyleColor(1)
					
					--
				end	
				ImGui.EndChild()
				
				ImGui.PopStyleColor(1)
				
			end		
			
			
			
		end
	end
	
end
function editor.makeGraphdata(item)
	
	
	local questgraph = deepcopy(item,nil)
	
	for k,v in pairs(EgameJournalQuestType) do
		if questgraph.questtype == EgameJournalQuestType[k] then
			
			questgraph.questtype  = k 
			
		end
	end
	
	
	if(questgraph.recurrent == false) then questgraph.recurrent = "False" else questgraph.recurrent = "True" end
	
	for k,v in pairs(EgamedataDistrict) do
		
		if questgraph.district == EgamedataDistrict[k] then
			
			questgraph.district = k
			
		end
		
	end
	
	questgraph.requirement = ""
	for iparent,parent in ipairs(questgraph.trigger_condition_requirement) do
		
		for ichildren,children in pairs(parent) do
			
			
			local text =  "- "..children.." : ".."Unknown Trigger"
			
			for i,value in ipairs(triggertemplate) do
				
				if(value.name == questgraph.trigger_condition[children].name) then
					
					text = "- "..children.." : "..value.helper
					
					
				end
				
			end
			
			questgraph.requirement = questgraph.requirement..text
			
			if(questgraph.trigger_condition_requirement[iparent][ichildren+1] ~= nil) then
				
				questgraph.requirement = questgraph.requirement.. "\n AND \n"
				
				else
				
				questgraph.requirement = questgraph.requirement.. "\n"
				
			end
			
		end
		
		if(questgraph.trigger_condition_requirement[iparent+1] ~= nil) then
			
			questgraph.requirement = questgraph.requirement.. "\n OR \n"
			
		end
	end
	
	local objectivekey = {}
	for i,v in ipairs(questgraph.objectives) do
		
		objectivekey[v.tag] = v
		
	end
	questgraph.children ={}
	if(#questgraph.objectives > 0) then
		questgraph.children = editor.SortTreeObjective(questgraph.objectives[1],objectivekey,1,1,item)
		
	end
	local maxcolumn = 1
	local maxrow = 1
	
	
	for i,v in ipairs(questgraph.objectives) do
		if v.column ~= nil then
			v.notsorted = nil
			if(v.column > maxcolumn) then
				
				maxcolumn = v.column
				
			end
			
			if(v.row > maxrow) then
				
				maxrow = v.row
				
			end
			else
			v.notsorted = true
		end
		
	end
	
	questgraph.column = maxcolumn
	questgraph.row = maxrow
	
	
	return questgraph
	
	
end
function editor.SortTreeObjective(objective, objectivekey,row,column,item)
	local tableObj = objective
	
	
	
	tableObj.row = row
	tableObj.column = column
	
	for k,v in pairs(EgameJournalEntryStateRename) do
		
		if tableObj.state == EgameJournalEntryStateRename[k] then
			
			tableObj.statedisplay = k
			
		end
		
	end
	
	local actions = ""
	for k,v in ipairs(tableObj.action) do
		
		
		if(v.name ~= "do_function") then
			actions = actions..v.name.."\n"
			else
			actions = actions..v.name.." "..v.value.."\n"
		end
		
	end
	
	tableObj.actionsdisplay =actions
	
	tableObj.requirementtext = ""
	for iparent,parent in ipairs(tableObj.requirement) do
		
		for ichildren,children in pairs(parent) do
			
			
			local text = "- "..children.." : ".."Unknown Trigger"
			
			for k,value in pairs(cyberscript.triggertemplate) do
				
				if(k== tableObj.trigger[children].name) then
					
					text = "- "..children.." : "..value.helper
					
					
				end
				
			end
			
			tableObj.requirementtext = tableObj.requirementtext..text
			
			if(tableObj.requirement[iparent][ichildren+1] ~= nil) then
				
				tableObj.requirementtext = tableObj.requirementtext.. "\n AND \n"
				
				else
				
				tableObj.requirementtext = tableObj.requirementtext.. "\n"
				
			end
			
		end
		
		if(tableObj.requirement[iparent+1] ~= nil and #tableObj.requirement[iparent+1] >0) then
			--print(dump(tableObj.requirement[iparent+1]))
			tableObj.requirementtext = tableObj.requirementtext.. "\n OR \n"
			
		end
		
		
		
	end
	
	tableObj.children = {}
	
	if(tableObj.unlock ~= nil and #tableObj.unlock >0 and objectivekey[tableObj.unlock[1]] ~= nil) then
		local newrow = row
		for i,child in ipairs(tableObj.unlock) do
			
			if(objectivekey[child] ~= nil) then
				local children = editor.SortTreeObjective(objectivekey[child],objectivekey,newrow,column+1,item)
				
				table.insert(tableObj.children,children)
				newrow = newrow+i
			end
		end
		
	end
	
	return tableObj
end

--Dialog option


function editor.optionsNode(title,obj,parenttag,contextscript)
	if obj["options"] == nil then obj["options"] = {} end
	if ImGui.TreeNode("") then
		
		
		ImGui.SameLine()
		if( #obj["options"] > 0) then
			
			
			for i = 1, #obj["options"] do 
				
				if(obj["options"][i].style ~= nil and obj["options"][i].style.color ~= nil and obj["options"][i].style.color.red ~= nil and obj["options"][i].style.color.green ~= nil and obj["options"][i].style.color.blue ~= nil ) then
					
					ImGui.PushStyleColor(ImGuiCol.Text,  round((obj["options"][i].style.color.red/255),8), round((obj["options"][i].style.color.green/255),8), round((obj["options"][i].style.color.blue/255),8), 1)
					else
					ImGui.PushStyleColor(ImGuiCol.Text,  round((9/255),8), round((218/255),8), round((201/255),8), 1)
				end
				if(obj["options"][i].icon == nil) then obj["options"][i].icon = "" end
				
				if(i>1) then
					ImGui.Text("")
					ImGui.SameLine()
				end
				if ImGui.TreeNode("("..obj["options"][i].icon..")"..obj["options"][i].description.." ("..tostring(i)..")") then
					if ImGui.Button("Edit", 50, 0) then
						local objact = {}
						
						objact.parenttag = parenttag
						objact.parent = obj
						objact.key = "options"
						objact.index = i
						objact.contextscript = contextscript
						objact.options = deepcopy(obj["options"][i],nil)
						
						currentDialogOptions[parenttag.."_"..obj["options"][i].description.." ("..tostring(i)..")"] = objact
						
					end
					
					ImGui.SameLine()
					if currentDialogOptions[parenttag.."_"..obj["options"][i].description.." ("..tostring(i)..")"] == nil then
						if ImGui.Button("Delete", 50, 0) then
							
							table.remove(obj["options"],i)
							
						end
						else
						ImGui.Text("Currently opened in editor")
					end
					
					if ImGui.Button("Up##".."("..obj["options"][i].icon..")"..obj["options"][i].description.." ("..tostring(i)..")", 50, 0) then
						local copy = deepcopy(obj["options"][i],nil)
						table.remove(obj["options"],i)
						
						table.insert(obj["options"], i-1, copy)
						
						
					end
					
					ImGui.SameLine()
					
					if ImGui.Button("Down##".."("..obj["options"][i].icon..")"..obj["options"][i].description.." ("..tostring(i)..")", 50, 0) then
						local copy = deepcopy(obj["options"][i],nil)
						
						table.remove(obj["options"],i)
						table.insert(obj["options"], i+1, copy)
						
						
						
					end
					ImGui.TreePop()
				end
				
				
				
				ImGui.PopStyleColor(1)
				
			end
		end
		
		
		ImGui.TreePop()
	end
	
end


function editor.conversationNode(title,obj,parenttag,contextscript)
	if obj["conversation"] == nil then obj["conversation"] = {} end
	if ImGui.TreeNode(title) then
		
		
		
		if( #obj["conversation"] > 0) then
			
			
			for i = 1, #obj["conversation"] do 
				local result, message = pcall(function()
					local unlocked = "Locked"
					if obj["conversation"][i].unlock then unlocked = "Unlocked" end
					if ImGui.TreeNode("("..unlocked..") "..obj["conversation"][i].name.." ("..tostring(i)..")") then
						
						
						
						
						
						
						
						if ImGui.Button("Edit", 50, 0) then
							local objact = {}
							
							objact.parenttag = parenttag
							objact.parent = obj
							objact.key = "conversation"
							objact.index = i
							objact.contextscript = contextscript
							objact.conversation = deepcopy(obj["conversation"][i],nil)
							
							currentPhoneConversationeditor[parenttag.."_"..obj["conversation"][i].name.." ("..tostring(i)..")"] = objact
							
						end
						
						ImGui.SameLine()
						if currentDialogOptions[parenttag.."_"..obj["conversation"][i].name.." ("..tostring(i)..")"] == nil then
							if ImGui.Button("Delete", 50, 0) then
								
								table.remove(obj["conversation"],i)
								
							end
							else
							ImGui.Text("Currently opened in editor")
						end
						
						
						
						
						ImGui.TreePop()
					end
					
					
					
					
				end
				)
				if(result == false) then
					--print(message)
				end
				
				
			end
		end
		
		
		ImGui.TreePop()
	end
	
end

function editor.controlsNode(title,obj,parenttag,contextscript)
	if obj["controls"] == nil then obj["controls"] = {} end
	
	editoractionsearch = ImGui.InputText(getLang("Filter"), editoractionsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Spacing()
	if ImGui.TreeNode(title) then
		
		
		
		if( #obj["controls"] > 0) then
			
			
			for i = 1, #obj["controls"] do 
				
				if (editorinterfacecontrolsearch == "" or (editorinterfacecontrolsearch ~= "" and (string.match(string.lower(obj["controls"][i].tag),editorinterfacecontrolsearch)))) then
					if ImGui.TreeNode(obj["controls"][i].tag.." ("..tostring(i)..")") then
						
						
						
						
						
						
						
						if ImGui.Button("Edit##"..obj["controls"][i].tag.." ("..tostring(i)..")", 50, 0) then
							local objact = {}
							
							objact.parenttag = parenttag
							objact.parent = obj
							objact.key = "controls"
							objact.index = i
							objact.contextscript = contextscript
							objact.controls = deepcopy(obj["controls"][i],nil)
							
							currentInterfaceControl[parenttag.."_"..obj["controls"][i].tag.." ("..tostring(i)..")"] = objact
							
						end
						
						ImGui.SameLine()
						if currentInterfaceControl[parenttag.."_"..obj["controls"][i].tag.." ("..tostring(i)..")"] == nil then
							if ImGui.Button("Delete", 50, 0) then
								
								table.remove(obj["controls"],i)
								
							end
							else
							ImGui.Text("Currently opened in editor")
						end
						
						
						if ImGui.Button("Up##"..obj["controls"][i].tag.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj["controls"][i],nil)
							table.remove(obj["controls"],i)
							
							table.insert(obj["controls"], i-1, copy)
							
							
						end
						
						ImGui.SameLine()
						
						if ImGui.Button("Down##"..obj["controls"][i].tag.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj["controls"][i],nil)
							
							table.remove(obj["controls"],i)
							table.insert(obj["controls"], i+1, copy)
							
							
							
						end
						
						if ImGui.Button("First##"..obj["controls"][i].tag.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj["controls"][i],nil)
							table.remove(obj["controls"],i)
							
							table.insert(obj["controls"], 1, copy)
							
							
						end
						
						ImGui.SameLine()
						
						if ImGui.Button("Last##"..obj["controls"][i].tag.." ("..tostring(i)..")", 50, 0) then
							local copy = deepcopy(obj["controls"][i],nil)
							
							table.remove(obj["controls"],i)
							table.insert(obj["controls"], #obj["controls"], copy)
							
							
							
						end
						
						
						currentindex = ImGui.InputInt("Index##"..obj["controls"][i].tag.." ("..tostring(i)..")", currentindex, 1,10, ImGuiInputTextFlags.None)
						
						ImGui.SameLine()
						
						if ImGui.Button("Apply new index##"..obj["controls"][i].tag.." ("..tostring(i)..")", 110, 0) then
							
							local copy = deepcopy(obj["controls"][i],nil)
							table.remove(obj["controls"],i)
							
							table.insert(obj["controls"], currentindex, copy)
							
						end
						
						ImGui.TreePop()
					end
					
				end
				
				
				
			end
		end
		
		
		ImGui.TreePop()
	end
	
end

function editor.messageNode(title,obj,parenttag,contextscript)
	if obj["message"] == nil then obj["message"] = {} end
	if ImGui.TreeNode(title) then
		
		
		
		if( #obj["message"] > 0) then
			
			
			for i = 1, #obj["message"] do 
				local unlocked = "Locked"
				if obj["message"][i].unlock then unlocked = "message" end
				if ImGui.TreeNode("("..unlocked..") "..obj["message"][i].text.." ("..tostring(i)..")") then
					
					
					
					
					
					
					
					
					
					ImGui.TreePop()
				end
				
				
				
				ImGui.PopStyleColor(1)
				
			end
		end
		
		
		ImGui.TreePop()
	end
	
end

function editor.messagechoiceNode(title,obj,parenttag,contextscript)
	if obj["message"] == nil then obj["message"] = {} end
	if ImGui.TreeNode(title) then
		
		
		
		if( #obj["message"] > 0) then
			
			
			for i = 1, #obj["message"] do 
				local unlocked = "Locked"
				if obj["message"][i].unlock then unlocked = "message" end
				if ImGui.TreeNode("("..unlocked..") "..obj["message"][i].text.." ("..tostring(i)..")") then
					
					
					
					
					
					
					
					if ImGui.Button("Edit", 50, 0) then
						local objact = {}
						
						objact.parenttag = parenttag
						objact.parent = obj
						objact.key = "message"
						objact.index = i
						objact.contextscript = contextscript
						objact.message = deepcopy(obj["message"][i],nil)
						
						currentPhoneConversationMessageChoice[parenttag.."_"..obj["message"][i].tag.." ("..tostring(i)..")"] = objact
						
					end
					
					ImGui.SameLine()
					if currentDialogOptions[parenttag.."_"..obj["message"][i].tag.." ("..tostring(i)..")"] == nil then
						if ImGui.Button("Delete", 50, 0) then
							
							table.remove(obj["message"],i)
							
						end
						else
						ImGui.Text("Currently opened in editor")
					end
					
					
					
					
					ImGui.TreePop()
				end
				
				
				
				ImGui.PopStyleColor(1)
				
			end
		end
		
		
		ImGui.TreePop()
	end
	
end


function editor.dialogoptions(tag,item)
	
	
	if(item.options.style == nil) then item.options.style = {} end
	if(item.options.style.color == nil) then item.options.style.color = {} end
	if(item.options.icon == nil) then item.options.icon = "" end
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Dialog Option: "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				item.parent[item.key][item.index] = item.options
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				item.parent[item.key][item.index] = item.options
				
				currentDialogOptions[tag] = nil
				
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentDialogOptions[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.options)
					
					
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		
		--ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-choice", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		-- objact.options.description = ""
		-- objact.options.icon = ""
		-- objact.options.action = {}
		-- objact.options.trigger = {}
		-- objact.options.requirement ={}
		-- objact.options.context = {}
		-- objact.options.style = {}
		
		item.options.description = ImGui.InputText("Description", item.options.description, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		editoriconsearch = ImGui.InputText(getLang("Icon Choice Filter"), editoriconsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
		if ImGui.BeginCombo("Icon :", item.options.icon) then
			
			
			for i,v in ipairs(choiceIconList) do
				if (editoriconsearch == "" or (editoriconsearch ~= "" and (string.match(string.lower(v),editoriconsearch)))) then
					if ImGui.Selectable(v, (item.options.icon == v)) then
						item.options.icon = v
						
						
						
						ImGui.SetItemDefaultFocus()
					end
					
				end
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Text("Style : ")
		if(item.options.style ~= nil and item.options.style.color ~= nil and item.options.style.color.red ~= nil and item.options.style.color.green ~= nil and item.options.style.color.blue ~= nil ) then
			
			ImGui.PushStyleColor(ImGuiCol.Text,round((item.options.style.color.red/255),8), round((item.options.style.color.green/255),8), round((item.options.style.color.blue/255),8), 1)
			
			ImGui.Text("Current Color")
			
			ImGui.PopStyleColor(1)
			
			
			ImGui.Text("Red : ".. item.options.style.color.red)
			ImGui.Text("Green : ".. item.options.style.color.green)
			ImGui.Text("Blue : ".. item.options.style.color.blue)
			else
			
			ImGui.Text("No current Style defined ")
			
		end
		
		if ImGui.Button("Open Color Picker") then
			toggleEditorUI("colorPicker")
		end
		
		ImGui.SameLine()
		
		if ImGui.Button("Copy RGB from Color Picker") then
			item.options.style.color.red = currentcolorRGB.red 
			item.options.style.color.green = currentcolorRGB.green
			item.options.style.color.blue = currentcolorRGB.blue
		end
		
		if ImGui.Button("Remove Color") then
			item.options.style.color = nil
		end
		
		
		
		ImGui.Separator()
		
		if ImGui.TreeNode("Triggers and Actions") then
			
			editor.triggerNode(getLang("trigger_condition"),item.options,"trigger",tag,item.contextscript)
			
			editor.requirementNode(getLang("trigger_condition_requirement"),item.options,"requirement","trigger")
			
			editor.actionNode(getLang("Action"),item.options,"action",tag,item.contextscript)
			
			editor.contextNode("Context",item.options,"context",tag,item.contextscript)
			
			ImGui.TreePop(1)
		end
		
		
		
		ImGui.EndTabItem()
	end
	
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
end



function editor.phoneconversation(tag,item)
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Phone Dialog Conversation: "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				item.parent[item.key][item.index] = item.conversation
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				item.parent[item.key][item.index] = item.conversation
				
				currentPhoneConversationeditor[tag] = nil
				
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentPhoneConversationeditor[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.conversation)
					
					
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		
		--ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-choice", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		-- objact.options.description = ""
		-- objact.options.icon = ""
		-- objact.options.action = {}
		-- objact.options.trigger = {}
		-- objact.options.requirement ={}
		-- objact.options.context = {}
		-- objact.options.style = {}
		
		item.conversation.name = ImGui.InputText("Name", item.conversation.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.conversation.tag = ImGui.InputText("Tag", item.conversation.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		item.conversation.unlock = ImGui.Checkbox(getLang("Unlocked ?"), item.conversation.unlock)
		
		
		ImGui.Separator()
		
		-- if ImGui.BeginChild("dispslayoption", 600, 100+(#item.conversation.message+1)*20,true) then
		
		-- editor.messageNode(getLang(item.conversation.name),item.conversation,item.conversation.tag,item.contextscript)
		
		-- end
		-- ImGui.EndChild()
		
		ImGui.Text("Messages :")
		
		if ImGui.BeginChild("msg2", 850, 400,true) then
			
			local flags = ImGuiTableFlags.ScrollY
			if ImGui.BeginTable("Table_"..tag, 2,flags,850,380) then
				
				for i,message in ipairs(item.conversation.message) do
					ImGui.TableNextRow()
					if message.choices == nil then message.choices = {} end
					if(message.sender == 0) then
						if ImGui.TableSetColumnIndex(0)   then
							
							ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.98823, 0.94117, 0.011764, 1)
							if ImGui.BeginChild(message.tag, 400, (countByChunk(message.text,50)*30)+(#message.choices*30), true) then
								
								
								ImGui.PushStyleColor(ImGuiCol.Text,   0,	0,	0, 1)
								ImGui.Text(splitByChunk(message.text,50))
								ImGui.PopStyleColor(1)
								
								
								
								ImGui.SameLine()
								if ImGui.Button("Edit", 50, 0) then
									local objact = {}
									
									objact.parenttag = item.conversation.tag
									objact.parent =  item.conversation
									objact.key = "message"
									objact.index = i
									objact.contextscript = item.contextscript
									objact.message = deepcopy(message,nil)
									
									currentPhoneConversationMessage[item.conversation.tag.."_"..message.tag.." ("..tostring(i)..")"] = objact
									
								end
								
								ImGui.SameLine()
								if currentDialogOptions[item.conversation.tag.."_"..message.tag.." ("..tostring(i)..")"] == nil then
									if ImGui.Button("Delete", 50, 0) then
										
										table.remove( item.conversation["message"],i)
										
									end
									else
									ImGui.Text("Currently opened in editor")
								end
								
								
								if(message.choices ~= nil and #message.choices>0)then
									
									for i,choice in ipairs(message.choices) do
										ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.647058, 0.0196078,	0.941176, 1)
										if ImGui.BeginChild(choice.tag, 300, (countByChunk(choice.text,50)*15), true) then
											
											
											ImGui.PushStyleColor(ImGuiCol.Text,   1, 1,	1, 1)
											ImGui.Text(splitByChunk(choice.text,50))
											ImGui.PopStyleColor(1)
											
											
										end
										ImGui.EndChild()
										ImGui.PopStyleColor(1)
									end
									
									
								end
								
								
								
								
								-- 
							end
							ImGui.EndChild()
							ImGui.PopStyleColor(1)
							
							
						end			 
						
						
						
					end
					
					if(message.sender == 1) then
						if ImGui.TableSetColumnIndex(1)   then
							
							ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.011764, 0.972549, 0.988235, 1)
							if ImGui.BeginChild(message.tag, 400, (countByChunk(message.text,50)*30)+(#message.choices*30), true) then
								
								ImGui.PushStyleColor(ImGuiCol.Text,   0,	0,	0, 1)
								
								
								ImGui.Text(splitByChunk(message.text,50))
								
								
								
								
								ImGui.SameLine()
								if ImGui.Button("Edit", 50, 0) then
									local objact = {}
									
									objact.parenttag = item.conversation.tag
									objact.parent =  item.conversation
									objact.key = "message"
									objact.index = i
									objact.contextscript = item.contextscript
									objact.message = deepcopy(message,nil)
									
									currentPhoneConversationMessage[item.conversation.tag.."_"..message.tag.." ("..tostring(i)..")"] = objact
									
								end
								
								ImGui.SameLine()
								if currentDialogOptions[item.conversation.tag.."_"..message.tag.." ("..tostring(i)..")"] == nil then
									if ImGui.Button("Delete", 50, 0) then
										
										table.remove( item.conversation["message"],i)
										
									end
									else
									ImGui.Text("Currently opened in editor")
								end
								
								
								if(message.choices ~= nil and #message.choices>0)then
									
									for i,choice in ipairs(message.choices) do
										ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.647058, 0.0196078,	0.941176, 1)
										if ImGui.BeginChild(choice.tag, 300, (countByChunk(choice.text,50)*15), true) then
											
											
											ImGui.PushStyleColor(ImGuiCol.Text,   1, 1,	1, 1)
											ImGui.Text(splitByChunk(choice.text,50))
											ImGui.PopStyleColor(1)
											
											
										end
										ImGui.EndChild()
										ImGui.PopStyleColor(1)
									end
									
									
								end
								
								ImGui.PopStyleColor(1)
								
								
								-- 
							end
							ImGui.EndChild()
							ImGui.PopStyleColor(1)
							
							
						end			 
						
						
						
					end
					
					
					
				end
				ImGui.EndTable()
				
			end
			
			
			
			
			ImGui.EndChild()
		end
		
		
		
		ImGui.SameLine()
		if ImGui.Button("Add new Message", 300, 0) then
			
			local objact = {}
			objact.parenttag = item.parenttag
			objact.parent = item.conversation
			objact.key = "message"
			objact.contextscript = item.parent.tag
			objact.index = 1
			if(#item.conversation["message"] > 0) then objact.index = #item.conversation["message"]+1 end
			
			objact.message = {}
			
			objact.message.tag = ""
			objact.message.text = ""
			objact.message.sender = 0
			objact.message.unlock = false
			objact.message.readed = false
			objact.message.unlocknext = ""
			
			
			
			
			objact.message["choices"] = {}
			
			
			
			currentPhoneConversationMessage[item.conversation.tag.."_message_new_"..#item.conversation["message"]+1] = objact
		end
		ImGui.EndTabItem()
	end
	
	
	
end


function editor.phoneconversationmessage(tag,item)
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Conversation Message: "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				item.parent[item.key][item.index] = item.message
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				item.parent[item.key][item.index] = item.message
				
				currentPhoneConversationMessage[tag] = nil
				
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentPhoneConversationMessage[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.message)
					
					
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		item.message.text = ImGui.InputText("Text", item.message.text, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.message.tag = ImGui.InputText("Tag", item.message.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.message.unlock = ImGui.Checkbox(getLang("Unlocked ?"), item.message.unlock)
		
		item.message.readed = ImGui.Checkbox(getLang("Readed ?"), item.message.readed)
		
		item.message.unlocknext =ImGui.InputText("Unlock Next Message Tag", item.message.unlocknext, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		if ImGui.BeginCombo("Source", defaultphonemsgmode[item.message.sender+1]) then
			if ImGui.Selectable("From Speaker") then
				item.message.sender = 0
				
				ImGui.SetItemDefaultFocus()
			end
			if ImGui.Selectable("From V") then
				item.message.sender = 1
				ImGui.SetItemDefaultFocus()
			end
			
			ImGui.EndCombo()
		end
		
		
		ImGui.Separator()
		
		ImGui.Text("Choices :")
		if ImGui.BeginChild("msg3", 850, 400,true) then
			
			local flags = ImGuiTableFlags.ScrollY
			if ImGui.BeginTable("Table_"..tag, 1,flags,850,380) then
				
				for i,choices in ipairs(item.message.choices) do
					ImGui.TableNextRow()
					
					
					if ImGui.TableSetColumnIndex(0)   then
						
						ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.647058, 0.0196078,	0.941176, 1)
						if ImGui.BeginChild(choices.tag, 400, (countByChunk(choices.text,50)*30), true) then
							
							
							ImGui.PushStyleColor(ImGuiCol.Text,   1,	1,	1, 1)
							ImGui.Text(splitByChunk(choices.text,50))
							ImGui.PopStyleColor(1)
							
							
							
							ImGui.SameLine()
							if ImGui.Button("Edit", 50, 0) then
								local objact = {}
								
								objact.parenttag = item.message.tag
								objact.parent =  item.message
								objact.key = "choices"
								objact.index = i
								objact.contextscript = item.contextscript
								objact.choices = deepcopy(choices,nil)
								
								currentPhoneConversationMessageChoice[item.message.tag.."_"..choices.tag.." ("..tostring(i)..")"] = objact
								
							end
							
							ImGui.SameLine()
							if currentDialogOptions[item.message.tag.."_"..choices.tag.." ("..tostring(i)..")"] == nil then
								if ImGui.Button("Delete", 50, 0) then
									
									table.remove( item.message["choices"],i)
									
								end
								else
								ImGui.Text("Currently opened in editor")
							end
							
							
							
							
							
							
							
							-- 
						end
						ImGui.EndChild()
						ImGui.PopStyleColor(1)
						
						
					end			 
					
					
					
				end
				
				
			end
			ImGui.EndTable()
			
			
			
			
			
			
			ImGui.EndChild()
		end
		
		
		
		ImGui.SameLine()
		if ImGui.Button("Add new choice", 300, 0) then
			
			local objact = {}
			objact.parenttag = item.message.tag
			objact.parent =  item.message
			objact.key = "choices"
			objact.index = 1
			objact.contextscript = item.contextscript
			
			if(#item.message["choices"] > 0) then objact.index = #item.message["choices"]+1 end
			
			objact.choices = {}
			
			objact.choices.tag = ""
			objact.choices.text = ""
			objact.choices.unlocknext = ""
			objact.choices.action_bypassmenu_execution = false
			objact.choices["trigger"] = {}
			objact.choices["requirement"] = {}
			objact.choices["action"] = {}
			objact.choices["context"] = {}
			
			
			
			currentPhoneConversationMessageChoice[item.message.tag.."_choice_new_"..#item.message["choices"]+1] = objact
		end
		
		ImGui.Separator()
		editor.contextNode("Context",item.message,"context",item.message.tag,item.contextscript)
		
		ImGui.EndTabItem()
		
		
		
	end
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
end


function editor.phoneconversationmessagechoice(tag,item)
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Message Choice : "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				item.parent[item.key][item.index] = item.choices
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				item.parent[item.key][item.index] = item.choices
				
				currentPhoneConversationMessageChoice[tag] = nil
				
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentPhoneConversationMessageChoice[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					
					
					currentJson[tag] = JSON:encode_pretty(item.choices)
					
					
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		item.choices.text = ImGui.InputText("Text", item.choices.text, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.choices.tag = ImGui.InputText("Tag", item.choices.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.choices.action_bypassmenu_execution = ImGui.Checkbox(getLang("Actions List Execution will execute whatever you are in menu or not ?"), item.choices.action_bypassmenu_execution)
		
		item.choices.unlocknext =ImGui.InputText("Unlock Next Message Tag", item.choices.unlocknext, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
		
		ImGui.Separator()
		
		
		if ImGui.TreeNode("Triggers, Actions and Context") then
			
			editor.triggerNode(getLang("trigger_condition"),item.choices,"trigger",tag,item.contextscript)
			
			editor.requirementNode(getLang("trigger_condition_requirement"),item.choices,"requirement","trigger")
			
			editor.actionNode(getLang("trigger_action"),item.choices,"action",tag,item.contextscript)
			
			editor.contextNode("Context",item.choices,"context",item.choices.tag,tag)
			
			ImGui.TreePop(1)
		end
		
		ImGui.EndTabItem()
		
		
		
	end
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
end


--Places

function editor.rooms(tag,item)
	
	
	if(item.room.range_z == nil) then item.room.range_z = 0 end
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Room : "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				item.room.type = {}
				if(item.room.canEat == true) then
					table.insert(item.room.type,0)
				end
				
				if(item.room.canDrink == true) then
					table.insert(item.room.type,1)
				end
				
				if(item.room.canDo == true) then
					table.insert(item.room.type,2)
				end
				local obj = deepcopy( item.room, nil)
				obj.canEat = nil
				obj.canDrink = nil
				obj.canDo = nil
				
				item.parent[item.key][item.index] = obj
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				item.room.type = {}
				if(item.room.canEat == true) then
					table.insert(item.room.type,0)
				end
				
				if(item.room.canDrink == true) then
					table.insert(item.room.type,1)
				end
				
				if(item.room.canDo == true) then
					table.insert(item.room.type,2)
				end
				local obj = deepcopy( item.room, nil)
				obj.canEat = nil
				obj.canDrink = nil
				obj.canDo = nil
				
				item.parent[item.key][item.index] = obj
				currentPlacesRooms[tag] = nil
				
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentPlacesRooms[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				if(currentJson[tag] == nil) then
					
					item.room.type = {}
					if(item.room.canEat == true) then
						table.insert(item.room.type,0)
					end
					
					if(item.room.canDrink == true) then
						table.insert(item.room.type,1)
					end
					
					if(item.room.canDo == true) then
						table.insert(item.room.type,2)
					end
					local obj = deepcopy( item.room, nil)
					obj.canEat = nil
					obj.canDrink = nil
					obj.canDo = nil
					
					currentJson[tag] = JSON:encode_pretty(obj)
					
					
				end
				
				
				
			end
			ImGui.EndMenuBar()
		end
		
		
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		
		
		item.room.name = ImGui.InputText(getLang("editor_Name"), item.room.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.room.tag = ImGui.InputText(getLang("editor_tag"), item.room.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Separator()
		item.room.x = ImGui.InputFloat(getLang("editor_x"), item.room.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.room.y = ImGui.InputFloat(getLang("editor_y"), item.room.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.room.z = ImGui.InputFloat(getLang("editor_z"), item.room.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			item.room.x = vec4.x
			item.room.y = vec4.y
			item.room.z = vec4.z
			
			
		end
		
		ImGui.Separator()
		item.room.range = ImGui.InputFloat("Area (range)", item.room.range, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.room.range_z = ImGui.InputFloat("Z area (vertical range)", item.room.range_z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
		ImGui.Separator()
		
		item.room.canEat = ImGui.Checkbox("Can Eat in this room ?", item.room.canEat)
		item.room.canDrink = ImGui.Checkbox("Can drink in this room ?", item.room.canDrink)
		item.room.canDo = ImGui.Checkbox("Can do interaction in this room ?(Other than drink or eat)", item.room.canDo)
		
		
		ImGui.Separator()
		
		if ImGui.TreeNode("Triggers, Actions and Context") then
			
			editor.triggerNode(getLang("trigger_condition"),item.room,"trigger",tag,item.contextscript)
			
			editor.requirementNode(getLang("trigger_condition_requirement"),item.room,"requirement","trigger")
			
			editor.actionNode(getLang("trigger_action"),item.room,"action",tag,item.contextscript)
			
			editor.contextNode("Context",item.room,"context",item.room.tag,tag)
			
			ImGui.TreePop(1)
		end
		
		
		ImGui.EndTabItem()
		
	end
	
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
end


function editor.items(tag,item)
	
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("Items : "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if item.item.Id == nil then
				
				
				--save item to object
				
				if ImGui.MenuItem("Save") then
					
					
					
					
					
					
					saveHousing(item.item)
					
					local housing = getHousing(item.item.Tag,item.item.X,item.item.Y,item.item.Z)
					item.item.Id = housing.Id
					
					if(item.parentitem.scripttype == "housing") then
						local obj = deepcopy(item.item,nil)
						obj.entityId = nil
						item.parentitem.data.items[item.index] = obj
						
					end
					
					if(item.parentitem.scripttype == "housing_template") then
						local obj = deepcopy(item.item,nil)
						obj.entityId = nil
						obj.X = item.parentitem.data.center.x-item.item.X 
						obj.Y = item.parentitem.data.center.y-item.item.Y
						obj.Z = item.parentitem.data.center.z-item.item.Z
						
						
						item.parentitem.data.items[item.index] = obj
						
					end
					
					local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
					
					
					local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
					
					
					item.item.entityId = spawnItem(item.item, poss, angless)
					
					Cron.After(0.7, function()
						
						local entity = Game.FindEntityByID(item.item.entityId)
						local components = checkForValidComponents(entity)
						if components then
							local visualScale = checkDefaultScale(components)
							item.item.defaultScale = {
								x = visualScale.x * 100,
								y = visualScale.x * 100,
								z = visualScale.x * 100,
							}
							item.item.scale = {
								x = visualScale.x * 100,
								y = visualScale.y * 100,
								z = visualScale.z * 100,
							}
						end
						
						
						
						
						
						table.insert(currentItemSpawned,item.item)
						
						
						
					end)
					
					
				end
				
				
				
				
				
				if ImGui.MenuItem("Save&Close") then
					
					
					
					
					saveHousing(item.item)
					
					local housing = getHousing(item.item.Tag,item.item.X,item.item.Y,item.item.Z)
					item.item.Id = housing.Id
					
					if(item.parentitem.scripttype == "housing") then
						local obj = deepcopy(item.item,nil)
						obj.entityId = nil
						item.parentitem.data.items[item.index] = obj
						
					end
					
					if(item.parentitem.scripttype == "housing_template") then
						local obj = deepcopy(item.item,nil)
						obj.entityId = nil
						obj.X = item.parentitem.data.center.x-item.item.X 
						obj.Y = item.parentitem.data.center.y-item.item.Y
						obj.Z = item.parentitem.data.center.z-item.item.Z
						
						
						item.parentitem.data.items[item.index] = obj
						
					end
					
					local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
					
					
					local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
					
					
					item.item.entityId = spawnItem(item.item, poss, angless)
					
					Cron.After(0.7, function()
						
						local entity = Game.FindEntityByID(item.item.entityId)
						local components = checkForValidComponents(entity)
						if components then
							local visualScale = checkDefaultScale(components)
							item.item.defaultScale = {
								x = visualScale.x * 100,
								y = visualScale.x * 100,
								z = visualScale.x * 100,
							}
							item.item.scale = {
								x = visualScale.x * 100,
								y = visualScale.y * 100,
								z = visualScale.z * 100,
							}
						end
						
						table.insert(currentItemSpawned,item.item)
						
						
						
					end)
					currentItems[tag] = nil
					
					
				end
				
			end
			if ImGui.MenuItem("Close") then
				
				currentItems[tag] = nil
				
			end
			
			if(item.parentitem.scripttype == "housing" and item.item.Id ~= nil) then
				if ImGui.MenuItem("Save") then
					
					
					
					
					
					
					local obj = deepcopy(item.item,nil)
					obj.entityId = nil
					item.parentitem.data.items[item.index] = obj
					
					
					
				end
			end
			
			if(item.parentitem.scripttype == "housing_template" and item.item.Id ~= nil) then
				if ImGui.MenuItem("Save") then
					
					
					
					
					
					
					local obj = deepcopy(item.item,nil)
					obj.entityId = nil
					
					item.parentitem.data.items[item.index] = obj
					
					
					
				end
			end
			
			
			
			ImGui.EndMenuBar()
		end
		
		
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		if item.item.Id == nil then
			
			searchitem = ImGui.InputText("Search", searchitem, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
			if ImGui.BeginCombo("##My Combo Box", totitem) then -- Remove the ## if you'd like for the title to display above combo box
				
				for i,itemobj in ipairs(arrayDBitems) do
					if(
						(searchitem == "" or searchitem == nil)
						or
						(string.match(itemobj.flag, searchitem) or
							string.match(itemobj.parentCategory, searchitem) or
							string.match(itemobj.childCategory, searchitem) or
							string.match(itemobj.Title, searchitem)
						)
					)then 
					
					if ImGui.Selectable(itemobj.Title) then
						totitem = itemobj.Title
						
						local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
						
						item.item.Tag = itemobj.Tag
						item.item.HouseTag = currentHouse.tag
						item.item.ItemPath = itemobj.Path
						item.item.X = curPos.x
						item.item.Y = curPos.y
						item.item.Z = curPos.z
						item.item.Yaw = curRot.yaw
						item.item.Pitch = curRot.pitch
						item.item.Roll = curRot.roll
						item.item.Title = itemobj.Title
						
						
						ImGui.SetItemDefaultFocus()
					end
					end
				end
				ImGui.EndCombo()
			end
			
			
			
			
			
			
			
			else
			
			if ImGui.Button("Hook Item if change doesn't apply", 300, 0) then
				
				
				if(#currentItemSpawned > 0) then 
					
					for i=1,#currentItemSpawned do
						
						if(currentItemSpawned[i].Id == item.item.Id) then
							
							item.item = deepcopy(currentItemSpawned[i],nil)
							
							if(item.parentitem.scripttype == "housing_template") then
								
								item.item.X = currentItemSpawned[i].X -item.parentitem.data.center.x
								item.item.Y = currentItemSpawned[i].Y-item.parentitem.data.center.y
								item.item.Z= currentItemSpawned[i].Z-item.parentitem.data.center.z
								--print("coconyut")
								else
								
								local entityid = item.item.entityId
								local entity = Game.FindEntityByID(entityid)
								local poss = entity:GetWorldPosition()
								item.item.X = poss.x
								item.item.Y =  poss.y
								item.item.Z =  poss.z
								--print("coconyut2")
							end
							
						end
					end
				end
				
			end
			
			
			
			
			
		end
		
		
		
		
		posstep =  ImGui.DragFloat("##post##"..tag, posstep, 0.001, 0.1, 10, "%.3f Position Step")
		
		
		
		rotstep =  ImGui.DragFloat("##rost##"..tag, rotstep, 0.001, 0.1, 10, "%.4f Rotation Step")
		
		
		itemsdirectmod.state = ImGui.Checkbox("Direct Mode : take Current Looked Location", itemsdirectmod.state)
		
		if ImGui.Button("Set as Direct Mode Target change", 300, 0) then
			
			
			itemsdirectmod.target = item.item
			if targetDeltaPos == nil then
				targetPos = Game.FindEntityByID(item.item.entityId):GetWorldPosition()
				targetAngle = Vector4.ToRotation(Game.FindEntityByID(item.item.entityId):GetWorldForward())
				objectDist = Vector4.Distance(targetPos, playerPos)
				phi = math.atan2(playerAngle.y, playerAngle.x)
				targetDeltaPos = Vector4.new(((objectDist * math.cos(phi)) + playerPos.x), ((objectDist * math.sin(phi)) + playerPos.y), (objectDist * math.sin(playerAngle.z) + playerPos.z), targetPos.w)
				targetDeltaPos = Delta(targetDeltaPos, targetPos)
				
				
			end
			
			
			
			
		end
		
		
		
		
		item.item.X,item.change =  ImGui.DragFloat("##x##"..tag, item.item.X, posstep, -9999, 9999, "%.3f X")
		if item.change ~= nil and item.change == true then
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
			
		end
		
		item.item.Y,item.change = ImGui.DragFloat("##y##"..tag, item.item.Y, posstep, -9999, 9999, "%.3f Y")
		if item.change ~= nil and item.change == true then
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
		end
		
		
		item.item.Z,item.change = ImGui.DragFloat("##z##"..tag, item.item.Z, posstep, -9999, 9999, "%.3f Z")
		
		if item.change ~= nil and item.change == true then
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
			
		end
		
		
		
		item.item.Yaw,item.change =  ImGui.DragFloat("##yaw##"..tag, item.item.Yaw, rotstep, -9999, 9999, "%.3f YAW")
		if item.change ~= nil and item.change == true then
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
			
		end
		item.item.Pitch,item.change = ImGui.DragFloat("##pitch##"..tag, item.item.Pitch, rotstep, -9999, 9999, "%.3f PITCH")
		if item.change ~= nil and item.change == true then
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
			
		end
		item.item.Roll,item.change = ImGui.DragFloat("##roll", item.item.Roll, rotstep, -9999, 9999, "%.3f ROLL")
		if item.change ~= nil and item.change == true then
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
			
		end
		
		
		
		
		
		
		
		if(item.parentitem.scripttype ~= "housing_template") then
			if ImGui.Button("Copy Player's XYZ", 300, 0) then
				
				local vec4 = Game.GetPlayer():GetWorldPosition()
				item.item.X = vec4.x
				item.item.Y = vec4.y
				item.item.Z = vec4.z
				
				local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
				
				
				local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
				
				
				
				
				
				
			end
		end
		if ImGui.Button("Apply change", 300, 0) then
			
			
			local poss = Vector4.new( item.item.X, item.item.Y,  item.item.Z,1)
			
			
			local angless = EulerAngles.new(item.item.Roll, item.item.Pitch,  item.item.Yaw)
			
			
			if(item.parentitem.scripttype == "housing_template") then
				
				poss.x = item.parentitem.data.center.x + item.item.X
				poss.y = item.parentitem.data.center.y + item.item.Y
				poss.z = item.parentitem.data.center.z + item.item.Z
				
				
			end
			
			updateItemPosition(item.item, poss, angless, true)
			if(item.parentitem.scripttype == "housing_template") then
				
				item.item.X = poss.x - item.parentitem.data.center.x
				item.item.Y = poss.y - item.parentitem.data.center.y
				item.item.Z = poss.z - item.parentitem.data.center.z
				
				
			end
			
			
			
		end
		
		
		local entityid = item.item.entityId
		local entity = Game.FindEntityByID(entityid)
		local components = checkForValidComponents(entity)
		if(components) then
			
			if item.item.scale == nil then
				
				
				local visualScale = checkDefaultScale(components)
				item.item.defaultScale = {
					x = visualScale.x * 100,
					y = visualScale.x * 100,
					z = visualScale.x * 100,
				}
				item.item.scale = {
					x = visualScale.x * 100,
					y = visualScale.y * 100,
					z = visualScale.z * 100,
				}
			end
			
			if proportionalMode then
				
				item.item.scale.x, item.scaleChanged = ImGui.DragFloat("##scale", item.item.scale.x, 0.1)
				
				
				if item.scaleChanged then
					item.item.scale.y = item.item.scale.x
					item.item.scale.z = item.item.scale.x
				end
				
				
				
				else
				item.item.scale.x, item.used = ImGui.DragFloat("##scaleX", item.item.scale.x, 0.1)
				if item.used then  item.scaleChanged = true end
				
				item.item.scale.y, used = ImGui.DragFloat("##scaleY", item.item.scale.y, 0.1)
				if item.used then  item.scaleChanged = true end
				
				item.item.scale.z, used = ImGui.DragFloat("##scaleZ", item.item.scale.z, 0.1)
				if item.used then  item.scaleChanged = true end
			end
			
			
			
			if item.scaleChanged then
				Cron.After(0.7, function()
					local entityid = item.item.entityId
					local entity = Game.FindEntityByID(entityid)
					local components = checkForValidComponents(entity)
					setItemScale(entity, item.item, item.item.scale,proportionalMode)
				end)
			end
			
			proportionalMode, proportionalModeChanged = ImGui.Checkbox("Proportional Mode##"..tag, proportionalMode)
			
			if proportionalModeChanged then
				
				setItemScale(entity, item.item, item.item.scale,proportionalMode)
			end
			
		end
		
		local lightcomponents = checkForValidLightComponents(entity)
		if(lightcomponents) then
			
			local comp = lightcomponents[1]
			if item.item.color == nil then
				
				
				
				item.item.color = {
					red = comp.color.Red,
					blue = comp.color.Blue,
					green = comp.color.Green,
					alpha = comp.color.Alpha
				}
				
				item.item.intensity = comp.intensity
				item.item.radius = comp.radius
				item.item.innerAngle = comp.innerAngle
				item.item.outerAngle = comp.outerAngle
				item.item.lightType = comp.type
			end
			
			item.item.intensity, intchange = ImGui.DragFloat("Intensity", item.item.intensity, 1.0, 0.0, 10000.0)
			if intchange then
				comp:SetIntensity(item.item.intensity)
			end
			
			if item.item.lightType == ELightType.LT_Area or item.item.lightType == ELightType.LT_Area then
				item.item.radius, radchange = ImGui.DragFloat("Radius", item.item.radius, 0.1, 0.0, 10000.0)
				if radchange then
					comp:SetRadius(item.item.radius)
				end
			end
			
			if item.item.lightType == ELightType.LT_Spot then
				local anglesChanged = false
				item.item.innerAngle, innerUsed = ImGui.DragFloat("Inner Angle", item.item.innerAngle, 1.0, 0.0, 10000.0)
				item.item.outerAngle, anglesChanged = ImGui.DragFloat("Outer Angle", item.item.outerAngle, 1.0, 0.0, 10000.0)
				
				if innerUsed or anglesChanged then
					comp:SetAngles(item.item.innerAngle, item.item.outerAngle)
				end
			end
			
			
			if ImGui.Button("Open Color Picker") then
				toggleEditorUI("colorPicker")
			end
			
			ImGui.SameLine()
			
			if ImGui.Button("Copy RGB from Color Picker") then
				local newColor = NewObject('Color')
				
				newColor.Red = currentcolorRGB.red 
				newColor.Green = currentcolorRGB.green
				newColor.Blue =  currentcolorRGB.blue
				newColor.Alpha = comp.color.Alpha
				comp:SetColor(newColor)
				
				item.item.color = {
					red = comp.color.Red,
					blue = comp.color.Blue,
					green = comp.color.Green,
					alpha = comp.color.Alpha
				}
				
			end
			
			if ImGui.Button("Remove Color") then
				item.item.color  = nil
			end
			
			
			
			
		end
		ImGui.EndTabItem()
		
	end
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
	
end



function editor.uicontrols(tag,item)
	
	
	
	
	ImGui.PushStyleColor(ImGuiCol.Tab, 0.732, 0.657, 1, 0.3)
	ImGui.PushStyleColor(ImGuiCol.TabActive, 0.732, 0.657, 1, 0.7)
	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
	if ImGui.BeginTabItem("UI Control : "..tag) then
		ImGui.PopStyleColor(1)
		if ImGui.BeginMenuBar() then 
			if ImGui.MenuItem("Save") then
				
				
				
				item.parent[item.key][item.index] = deepcopy(item.controls,nil)
				
				
				
			end
			
			if ImGui.MenuItem("Save&Close") then
				
				
				
				item.parent[item.key][item.index] =  deepcopy(item.controls,nil)
				currentInterfaceControl[tag] = nil
				
				
			end
			
			if ImGui.MenuItem("Close") then
				
				currentInterfaceControl[tag] = nil
				
			end
			
			if ImGui.MenuItem(getLang("View JSON (Read-Only)")) then
				
				
				currentJson[tag] = JSON:encode_pretty( deepcopy(item.controls,nil))
				
				
			end
			
			
			
		end
		ImGui.EndMenuBar()
		
		for k,v in pairs(editorInterfaceGlobalItem) do
			
			if item.controls[k] == nil then item.controls[k] = deepcopy(v,nil) end
			
		end
		
		for k,v in pairs(editorInterfaceItemType[item.controls.type]) do
			
			if item.controls[k] == nil then item.controls[k] = deepcopy(v,nil) end
			
		end
		
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-interface", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		ImGui.Text("Script : "..item.contextscript)
		ImGui.Text("Parent : "..item.parenttag.. " Index  : "..item.index)
		
		ImGui.Separator()
		
		if ImGui.BeginCombo(getLang("Type"), item.controls.type) then
			
			
			
			for k,v in pairs(editorInterfaceItemType) do
				if ImGui.Selectable(k, (item.controls.type  == k)) then
					item.controls.type = k
					
					for i,prop in ipairs(editorInterfaceSpecialProps) do
						
						item.controls[prop] = nil
						
					end
					
					for key,prop in pairs(v) do
						
						item.controls[key] = prop
						
					end
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		
		
		
		ImGui.Separator()
		
		
		
		item.controls.tag = ImGui.InputText(getLang("editor_tag"), item.controls.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.controls.parent = ImGui.InputText(getLang("Parent :"), item.controls.parent, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Separator()
		
		
		ImGui.Text("Dynamic Fields :")
		local dymtext = ""
		
		for i,v in ipairs(item.controls.dynamic) do
			
			if(i > 1) then
				dymtext = dymtext..";"..v
				else
				dymtext = dymtext..v
			end
		end
		
		ImGui.Text(dymtext)
		
		if ImGui.BeginCombo(getLang("Add dynamic field"), editorInterfaceDynamicTypedefault) then
			
			
			
			for k,v in ipairs(editorInterfaceDynamicType) do
				if ImGui.Selectable(v, (editorInterfaceDynamicTypedefault  == v)) then
					editorInterfaceDynamicTypedefault = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				
			end
			
			ImGui.EndCombo()
		end
		
		
		
		
		if ImGui.Button("Add this dynamic field") then
			table.insert(item.controls.dynamic,editorInterfaceDynamicTypedefault)
		end
		
		if #item.controls.dynamic >0 and ImGui.Button("Remove last dynamic")  then
			table.remove(item.controls.dynamic,#item.controls.dynamic)
		end
		
		
		ImGui.Separator()
		
		editor.listDictionnaryIntNode("Margin :","Margin of the element, can be : top||left||bottom||right",item.controls,"margin")
		editor.listDictionnaryIntNode("Padding :","Padding of the element, can be : top||left||bottom||right",item.controls,"padding")
		
		ImGui.Separator()
		
		editor.listDictionnaryIntNode("Size :","Size of the element, can be : width||height",item.controls,"size")
		editor.listDictionnaryIntNode("Scale :","Scale of the element, can be : width||height",item.controls,"scale")
		editor.listDictionnaryIntNode("Translation :","Translation Vector2 of the element, can be : width||height",item.controls,"translation")
		editor.listDictionnaryIntNode("Transform :","Transform Vector2 of the element, can be : width||height",item.controls,"transform")
		
		ImGui.Separator()
		
		
		
		item.controls.fittocontent =  ImGui.Checkbox(getLang("Fit To Content ?"), item.controls.fittocontent )
		item.controls.interactive = ImGui.Checkbox(getLang("Interactive ?"), item.controls.interactive)
		
		ImGui.Separator()
		
		item.controls.opacity = ImGui.InputInt("Opacity", item.controls.opacity, 1,10, ImGuiInputTextFlags.None)
		item.controls.rotation = ImGui.InputInt("Rotation", item.controls.rotation, 1,10, ImGuiInputTextFlags.None)
		item.controls.horizontalalign = ImGui.InputInt("Horizontal alignement", item.controls.horizontalalign, 1,10, ImGuiInputTextFlags.None)
		item.controls.anchor = ImGui.InputInt("Parent Anchor", item.controls.anchor, 1,10, ImGuiInputTextFlags.None)
		item.controls.verticalalign = ImGui.InputInt("Vertical alignement", item.controls.verticalalign, 1,10, ImGuiInputTextFlags.None)
		item.controls.style.fontsize = ImGui.InputInt("Font Size", item.controls.style.fontsize, 1,10, ImGuiInputTextFlags.None)
		
		
		ImGui.Separator()
		
		if(item.controls.interactive) then
			
			if ImGui.TreeNode("Events (if interactive)") then
				
				
				
				if( #item.controls["event"] > 0) then
					
					
					for i = 1, #item.controls["event"] do 
						
						
						if ImGui.TreeNode(item.controls["event"][i].eventname.." ("..tostring(i)..")") then
							
							
							
							
							item.controls["event"][i].eventname = ImGui.InputText(getLang("Event Name ##"..i), item.controls["event"][i].eventname, 5000, ImGuiInputTextFlags.AutoSelectAll)
							
							editor.actionNode(getLang("OnLoad Actions"),item.controls["event"][i],"action",item.controls["event"][i].eventname,item.contextscript)
							
							
							
							if ImGui.Button("Delete", 50, 0) then
								
								table.remove(item.controls["event"],i)
								
							end
							
							
							
							
							
							ImGui.TreePop()
						end
						
						
						
						ImGui.PopStyleColor(1)
						
					end
				end
				
				
				ImGui.TreePop()
			end
			
			if ImGui.BeginCombo(getLang("New Event Type"), newcontrolevent) then
				
				
				
				for k,v in ipairs(editorInterfaceEventName) do
					if ImGui.Selectable(v) then
						
						newcontrolevent = v
						ImGui.SetItemDefaultFocus()
					end
					
					
					
				end
				
				ImGui.EndCombo()
			end
			
			if ImGui.Button("Add new Event") then
				local newvnt = {}
				newvnt.eventname = newcontrolevent
				newvnt.action = {}
				table.insert(item.controls["event"],newvnt)
			end
			
			ImGui.Separator()
			
			
		end
		
		
		
		ImGui.Text("Color : ")
		if(item.controls.textcolor ~= nil and item.controls.textcolor ~= nil and item.controls.textcolor.red ~= nil and item.controls.textcolor.green ~= nil and item.controls.textcolor.blue ~= nil ) then
			
			ImGui.PushStyleColor(ImGuiCol.Text,round((item.controls.textcolor.red/255),8), round((item.controls.textcolor.green/255),8), round((item.controls.textcolor.blue/255),8), 1)
			
			ImGui.Text("Current Text Color")
			
			ImGui.PopStyleColor(1)
			
			
			ImGui.Text("Red : ".. item.controls.textcolor.red)
			ImGui.Text("Green : ".. item.controls.textcolor.green)
			ImGui.Text("Blue : ".. item.controls.textcolor.blue)
			else
			
			ImGui.Text("No current Style defined ")
			
		end
		
		if ImGui.Button("Open Color Picker") then
			toggleEditorUI("colorPicker")
		end
		
		ImGui.SameLine()
		
		if ImGui.Button("Apply RGB to text Color from Color Picker") then
			item.controls.textcolor.red = currentcolorRGB.red 
			item.controls.textcolor.green = currentcolorRGB.green
			item.controls.textcolor.blue = currentcolorRGB.blue
		end
		
		ImGui.Separator()
		ImGui.Text("Special Type Fields : ")
		if(item.controls.type == "label" or item.controls.type == "textinput") then
			
			item.controls.text = ImGui.InputText(getLang("Text"), item.controls.text, 5000, ImGuiInputTextFlags.AutoSelectAll)
			item.controls.split = ImGui.InputInt("Split text By (leave 0 for none)", item.controls.split, 1,10, ImGuiInputTextFlags.None)
			
			item.controls.scrollspeed = ImGui.InputInt("Scroll speed (leave 0 for no scroll)", item.controls.scrollspeed, 1,10, ImGuiInputTextFlags.None)
			item.controls.scrolldelay = ImGui.InputInt("Scroll delay", item.controls.scrolldelay, 1,10, ImGuiInputTextFlags.None)
			item.controls.autoscroll =  ImGui.Checkbox(getLang("Auto scroll ?"), item.controls.autoscroll )
			
		end
		
		
		if(item.controls.type == "image") then
			
			
			item.controls.tweak = ImGui.InputText(getLang("InkAtlas file path"), item.controls.tweak, 1000, ImGuiInputTextFlags.AutoSelectAll)
			
			item.controls.texture = ImGui.InputText(getLang("Texture Name (in the inkatlas)"), item.controls.texture, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
		end
		
		if(item.controls.type == "button") then
			
			item.controls.title = ImGui.InputText(getLang("Title"), item.controls.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
			
			
			ImGui.Text("Background Color : ")
			if(item.controls.bgcolor ~= nil and item.controls.bgcolor ~= nil and item.controls.bgcolor.red ~= nil and item.controls.bgcolor.green ~= nil and item.controls.bgcolor.blue ~= nil ) then
				
				ImGui.PushStyleColor(ImGuiCol.Text,round((item.controls.bgcolor.red/255),8), round((item.controls.bgcolor.green/255),8), round((item.controls.bgcolor.blue/255),8), 1)
				
				ImGui.Text("Current Background Color")
				
				ImGui.PopStyleColor(1)
				
				
				ImGui.Text("Red : ".. item.controls.bgcolor.red)
				ImGui.Text("Green : ".. item.controls.bgcolor.green)
				ImGui.Text("Blue : ".. item.controls.bgcolor.blue)
				else
				
				ImGui.Text("No current Style defined ")
				
			end
			
			if ImGui.Button("Open Color Picker") then
				toggleEditorUI("colorPicker")
			end
			ImGui.SameLine()
			
			if ImGui.Button("Apply RGB to Background Color from Color Picker") then
				item.controls.bgcolor.red = currentcolorRGB.red 
				item.controls.bgcolor.green = currentcolorRGB.green
				item.controls.bgcolor.blue = currentcolorRGB.blue
			end
			
			
			editor.actionNode(getLang("OnClick Actions"),item.controls,"action",item.controls.tag,item.contextscript)
			editor.actionNode(getLang("OnEnter Actions"),item.controls,"onenter_action",item.controls.tag,item.contextscript)
			editor.actionNode(getLang("OnLeave Actions"),item.controls,"onleave_action",item.controls.tag,item.contextscript)
			
		end
		
		if(item.controls.type == "vertical_area" or item.controls.type == "horizontal_area") then
			editor.listDictionnaryIntNode("Child Margin :","Child Margin of the element, can be : top||left||bottom||right",item.controls,"childmargin")
			
			
			
		end
		
		
		if(item.controls.type == "shape") then
			item.controls.shapevariant = ImGui.InputInt("Shape Variant", item.controls.shapevariant, 1,10, ImGuiInputTextFlags.None)
			item.controls.linethickness = ImGui.InputInt("Line Thickness", item.controls.linethickness, 1,10, ImGuiInputTextFlags.None)
			item.controls.endcapstyle = ImGui.InputInt("End Cap Style", item.controls.endcapstyle, 1,10, ImGuiInputTextFlags.None)
			
			if ImGui.TreeNode("Vertex") then
				
				
				
				if( #item.controls["vertex"] > 0) then
					
					
					for i = 1, #item.controls["vertex"] do 
						
						
						if ImGui.TreeNode("Vertex ("..tostring(i)..")") then
							
							
							
							
							item.controls["vertex"][i].x =ImGui.InputInt("X", item.controls["vertex"][i].x, 1,10, ImGuiInputTextFlags.None)
							item.controls["vertex"][i].y =ImGui.InputInt("Y", item.controls["vertex"][i].y, 1,10, ImGuiInputTextFlags.None)
							
							
							if ImGui.Button("Delete", 50, 0) then
								
								table.remove(item.controls["vertex"],i)
								
							end
							
							
							
							
							
							ImGui.TreePop()
						end
						
						
						
						ImGui.PopStyleColor(1)
						
					end
				end
				
				
				ImGui.TreePop()
			end
			
			currentvertex.x =ImGui.InputInt("X", currentvertex.x, 1,10, ImGuiInputTextFlags.None)
			currentvertex.y =ImGui.InputInt("Y", currentvertex.y, 1,10, ImGuiInputTextFlags.None)
			
			
			if ImGui.Button("Add new Vertex") then
				
				table.insert(item.controls["vertex"],deepcopy(currentvertex,nil))
			end
			
			
		end
		
		
		
		ImGui.Separator()
		
		
		
		if ImGui.TreeNode("Triggers, Actions and Context") then
			
			editor.triggerNode(getLang("Triggers"),item.controls,"trigger",item.controls.tag,item.contextscript)
			
			editor.requirementNode(getLang("trigger_condition_requirement"),item.controls,"requirement","trigger",item.contextscript)
			
			editor.contextNode("Context",item.controls,"context",item.controls.tag,item.contextscript)
			
			ImGui.TreePop(1)
		end	
		
		ImGui.EndTabItem()
		
	end
	
	
	ImGui.PopStyleColor(1)
	ImGui.PopStyleColor(1)
	
	
	
end




function editor.scripttoolbar(item,tag,types,functions,hidemenu)
	if ImGui.BeginMenuBar() then 
		if item.data.tag ~= nil and item.data.tag ~= "" then
			
			local hidesave = false
			local hideclose = false
			local hidetemplate = false
			local hidetest = false
			local reader = nil
			if(currentproject ~= nil) then
				reader = dir("datapack/"..currentproject.."/"..types)
				
				if(reader == nil) then
					
					if ImGui.MenuItem(getLang("Folder '"..types.."' for '"..currentproject.."' doesn't exist, please create it before save")) then
						
					end
					
				end
				
			end
			
			if(hidemenu ~= nil) then
				if hidemenu.save ~= nil then hidesave = hidemenu.save end
				if hidemenu.close ~= nil then hideclose = hidemenu.close end
				if hidemenu.template ~= nil then hidetemplate = hidemenu.template end
				if hidemenu.test ~= nil then hidetest = hidemenu.test end
			end
			
			if(not hideclose) then
				if ImGui.MenuItem("Close") then
					
					currentScript[types][tag] = nil
					
				end
			end
			
			if(not hidesave) then
				if ImGui.BeginMenu("File") then
					
					
					
					if((currentproject ~= nil and reader ~= nil) or not (cyberscript.cache[types][item.data.tag] == nil or cyberscript.cache[types][item.data.tag].file ~= nil and file_exists(cyberscript.cache[types][item.data.tag].file) == false or cyberscript.cache[types][item.data.tag].datapack == nil  or cyberscript.cache[types][item.data.tag].datapack == "editor")) then
						if ImGui.MenuItem("Save to file") then
							
							--currentScript[types][tag] = item
							
							local objm =  deepcopy(item.data,nil)
							
							if(functions["save"] ~= nil) then
								functions["save"](item,tag,types,objm)
							end
							
							if(currentproject == nil)then
								
								arrayDatapack[cyberscript.cache[types][item.data.tag].datapack][types][item.data.tag] = objm
								cyberscript.cache[types][item.data.tag].data = objm
								
								
								local file = assert(io.open(cyberscript.cache[types][item.data.tag].file, "w"))
								local stringg = JSON:encode_pretty(objm)
								file:write(stringg)
								file:close()
								else
								arrayDatapack[currentproject][types][item.data.tag] = objm
								cyberscript.cache[types][item.data.tag] = {}
								cyberscript.cache[types][item.data.tag].data = objm
								cyberscript.cache[types][item.data.tag].datapack = currentproject
								cyberscript.cache[types][item.data.tag].file = "datapack/"..currentproject.."/"..types.."/"..item.data.tag..".json"
								
								local file = assert(io.open(cyberscript.cache[types][item.data.tag].file, "w"))
								local stringg = JSON:encode_pretty(objm)
								file:write(stringg)
								file:close()
							end
							
						end
						else
						if ImGui.MenuItem("Save to editor") then
							
							--currentScript[types][tag] = item
							
							local objm =  deepcopy(item.data,nil)
							
							if(functions["save"] ~= nil) then
								functions["save"](item,tag,types,objm)
							end
							
							if(cyberscript.cache[types][item.data.tag] == nil  or cyberscript.cache[types][item.data.tag].datapack == nil  or cyberscript.cache[types][item.data.tag].datapack == "editor") then
								
								cyberscript.cache[types][item.data.tag] = {}
								
								cyberscript.cache[types][item.data.tag].file = item.data.tag..".json"
								cyberscript.cache[types][item.data.tag].datapack = "editor"
								cyberscript.cache[types][item.data.tag].scripttype = types
								
							end
							--print(cyberscript.cache[types][item.data.tag].datapack)
							--print(types)
							--print(item.data.tag)
							
							if(arrayDatapack["editor"] == nil) then 
								
								
								arrayDatapack["editor"] = {}
								arrayDatapack["editor"].enabled = true
								arrayDatapack["editor"].metadata = {}
								arrayDatapack["editor"].metadata.name = "Editor"
								arrayDatapack["editor"].metadata.desc = "Editor"
								arrayDatapack["editor"].metadata.author = "CyberScript"
								arrayDatapack["editor"].metadata.file = "editor"
								arrayDatapack["editor"].metadata.tag = "editor"
								arrayDatapack["editor"].metadata.version = "0.0.0"
								arrayDatapack["editor"].metadata.flags = {"compile","essential"}
								
							end
							if(arrayDatapack["editor"][types] == nil) then arrayDatapack["editor"][types] = {} end
							
							arrayDatapack[cyberscript.cache[types][item.data.tag].datapack][types][item.data.tag] = objm
							cyberscript.cache[types][item.data.tag].data = objm
							
							--print(dump(cyberscript.cache[types][item.data.tag]))
							
							if(functions["after_save"] ~= nil) then
								functions["after_save"](item,tag,types,objm)
							end
						end
						
						
					end
					
					
					
					if ImGui.MenuItem(getLang("editor_export")) and item.data.tag ~= "" then
						
						local objm =  deepcopy(item.data,nil)
						if(functions["save"] ~= nil) then
							functions["save"](item,tag,types,objm)
						end
						local file = assert(io.open("user/editor_output/"..item.data.tag..".json", "w"))
						local stringg = JSON:encode_pretty(objm)
						file:write(stringg)
						file:close()
						
						
					end
					
					
					if ImGui.MenuItem("Dump in CET console") and item.data.tag ~= "" then
						
						local objm =  deepcopy(item.data,nil)
						if(functions["save"] ~= nil) then
							functions["save"](item,tag,types,objm)
						end
						logme(2,dump((objm)))
						
						
					end
					
					
					if ImGui.MenuItem(getLang("View JSON (Read-Only)")) and  item.data.tag ~= "" then
						
						if(currentJson[item.data.tag] == nil) then
							
							
							local objm =  deepcopy(item.data,nil)
							if(functions["save"] ~= nil) then
								functions["save"](item,tag,types,objm)
							end
							currentJson[item.data.tag] = JSON:encode_pretty(objm)
							
							
						end
						
						
						
					end
					
					ImGui.EndMenu()
				end
			end
			
			if(not hidetemplate) then
				if ImGui.BeginMenu("Editor Template") then
					
					if ImGui.MenuItem("Save to template") then
						
						--currentScript[types][tag] = item
						
						local objm =  deepcopy(item.data,nil)
						
						if(functions["save"] ~= nil) then
							functions["save"](item,tag,types,objm)
						end
						
						
						local temp = {}
						temp.tag = item.data.tag
						temp.type = types
						temp.template = objm
						
						editor.user_template[types][item.data.tag] = temp
						
						
						
						local file = assert(io.open("editor/user_template/"..item.data.tag..".json", "w"))
						local stringg = JSON:encode_pretty(temp)
						file:write(stringg)
						file:close()
						
					end
					
					if ImGui.BeginMenu("Load Template") then
						
						for k,v in pairs(editor.user_template[types]) do
							
							if ImGui.MenuItem("Load "..k) then
								
								
								local template = deepcopy(editor.user_template[types][k].template,nil)
								
								local version = deepcopy(scripttemplate[types],nil)
								
								editor.migration(types,template,version.header.version)
								
								for key,prop in pairs(template) do
									
									version[key] = prop
									
								end
								
								item.data = version
								item.data.tag = tag
								
								currentScript[types][item.tag] = deepcopy(item,nil)
								
							end
							
						end
						
						ImGui.EndMenu()
					end
					
					
					ImGui.EndMenu()
				end
			end
			
			if(not hidetest) then
				if ImGui.MenuItem(getLang("editor_test_in_game")) and item.data.tag ~= "" then
					local objm =  deepcopy(item.data,nil)
					
					if(functions["save"] ~= nil) then
						functions["save"](item,tag,types,objm)
					end
					
					if(cyberscript.cache[types][item.data.tag] == nil  or cyberscript.cache[types][item.data.tag].datapack == nil  or cyberscript.cache[types][item.data.tag].datapack == "editor") then
						
						if(arrayDatapack["editor"] == nil) then 
							
							
							arrayDatapack["editor"] = {}
							arrayDatapack["editor"].enabled = true
							arrayDatapack["editor"].metadata = {}
							arrayDatapack["editor"].metadata.name = "Editor"
							arrayDatapack["editor"].metadata.desc = "Editor"
							arrayDatapack["editor"].metadata.author = "CyberScript"
							arrayDatapack["editor"].metadata.file = "editor"
							arrayDatapack["editor"].metadata.tag = "editor"
							arrayDatapack["editor"].metadata.version = "0.0.0"
							arrayDatapack["editor"].metadata.flags = {"compile","essential"}
							
						end
						if arrayDatapack["editor"][types] == nil then arrayDatapack["editor"][types] = {} end
						cyberscript.cache[types][item.data.tag] = {}
						cyberscript.cache[types][item.data.tag].data = objm
						cyberscript.cache[types][item.data.tag].file = path
						cyberscript.cache[types][item.data.tag].datapack = "editor"
						cyberscript.cache[types][item.data.tag].scripttype = types
						
						arrayDatapack["editor"][types][item.data.tag] = objm
						else
						
						cyberscript.cache[types][item.data.tag].data = objm
					end
					
					if(functions["test"] ~= nil) then
						functions["test"](item,tag,types,objm)
					end
					
					
				end
			end
			
			
		end	
		
		
		
		
		
		
		
		
		
		
		
		
		
		ImGui.EndMenuBar()
		
	end
end


--template windows

function editor.editorfunction.mission(item,tag,types)
	
	
	
	
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		item.data.title = tag
		
		item.data.tag = tag
		
		
		
	end
	
	
	
	if(item.data["sortedobjectives"] == nil) then
		item.data["sortedobjectives"] = editor.makeGraphdata(item.data)
	end
	
	
	local functions = {}
	functions["save"] = function(item,tag,types,obj) obj.sortedobjectives = nil  end
	functions["test"] = function(item,tag,types,obj) 
		pcall(function()				
			QuestManager.RemoveQuest(item.data.tag)
			setScore(item.data.tag,"Score",nil)
			QuestManager.MarkQuestAsInactive(item.data.tag)
			QuestManager.MarkAllObjectiveOfQuestAs(item.data.tag,1)
			QuestManager.MarkQuestAsUnVisited(item.data.tag)
		end)
		loadQuestToUI(obj)  
	end
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	if ImGui.BeginTabBar("EditorQuestTabs##"..tag) then
		
		
		
		if ImGui.BeginTabItem("Fields") then
			
			ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-quest", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
			
			item.data.title = ImGui.InputText(getLang("editor_title"), item.data.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
			item.data.content = ImGui.InputText(getLang("editor_content"), item.data.content, 5000, ImGuiInputTextFlags.AutoSelectAll)
			item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
			
			item.data.recommandedlevel =  ImGui.InputInt(getLang("editor_recommendedlevel"), item.data.recommandedlevel, 1,10, ImGuiInputTextFlags.None)
			
			if ImGui.BeginCombo(getLang("editor_Quest_Type"), defaultQuestType) then
				
				
				for k,v in pairs(EgameJournalQuestType) do
					
					if ImGui.Selectable(k, (item.data.questtype == EgameJournalQuestType[k])) then
						item.data.questtype = EgameJournalQuestType[k]
						
						defaultQuestType = k
						
						ImGui.SetItemDefaultFocus()
					end
					
					
				end
				
				ImGui.EndCombo()
			end
			
			
			if ImGui.BeginCombo(getLang("editor_district"), defaultEnumDistrict) then
				
				
				for k,v in pairs(EgamedataDistrict) do
					
					if ImGui.Selectable(k, (item.data.district == EgamedataDistrict[k])) then
						item.data.district = EgamedataDistrict[k]
						
						defaultEnumDistrict = k
						
						ImGui.SetItemDefaultFocus()
					end
					
					
				end
				
				ImGui.EndCombo()
			end
			
			item.data.recurrent = ImGui.Checkbox("Radiant quest ?", item.data.recurrent)
			ImGui.Separator()
			
			ImGui.Text("Extra :")
			ImGui.Text(" Extra is optionnal information that you will display in quest notification. \n It can be :\n -New quest started (new) \n -Failed quest(fail) \n -Success Ending Quest(success)")
			
			ImGui.Spacing(2)
			if item.data.extra == nil then item.data.extra = {} end
			if ImGui.TreeNode("Current Extra") then
				for k,v in pairs(item.data.extra) do
					if(k == "mappin" or k == "success" or k == "fail" or k == "new") then
						
						ImGui.Text(k.." : "..v)
						ImGui.SameLine()
						if ImGui.Button("Delete##"..k) then
							
							item.data.extra[k]  = nil
							--print(k)
						end
						
					end
					
					if(k == "data") then
						
						for i,data in ipairs(v) do
							
							
							ImGui.Text(k.." : "..data.value.."( "..data.type.." )")
							ImGui.SameLine()
							if ImGui.Button("Delete##"..i) then
								
								item.data.extra.data[i] = nil
								
							end
							
						end
					end
					
					
					if(k == "custom") then
						
						for i,data in ipairs(v) do
							
							
							ImGui.Text(k.." : "..data.tag)
							ImGui.SameLine()
							if ImGui.Button("Delete##"..k) then
								
								item.data.extra.custom[i] = nil
								
							end
							
						end
					end
					
				end
				ImGui.TreePop(1)
				
			end
			
			
			if ImGui.BeginCombo("Add Extra Type :", defaultextramission) then
				
				
				for i,v in ipairs(missionextratype) do
					
					if ImGui.Selectable(v, (v == defaultextramission)) then
						
						defaultextramission = v
						
						ImGui.SetItemDefaultFocus()
					end
					
					
				end
				
				ImGui.EndCombo()
			end
			
			if(defaultextramission == "mappin" or defaultextramission == "success" or defaultextramission == "fail" or defaultextramission == "new") then
				
				mappinextra = ImGui.InputText("Extra "..defaultextramission, mappinextra, 5000, ImGuiInputTextFlags.AutoSelectAll)
				if ImGui.Button("Add Extra") then
					
					if(item.data.extra[defaultextramission] == nil) then item.data.extra[defaultextramission] = mappinextra end
					
					
				end
			end	
			
			
			
			
			if(defaultextramission == "data") then
				
				dataextratype = ImGui.InputText("Type",dataextratype, 5000, ImGuiInputTextFlags.AutoSelectAll)
				dataextravalue = ImGui.InputText("Value",dataextravalue, 5000, ImGuiInputTextFlags.AutoSelectAll)
				
				if ImGui.Button("Add Extra") then
					
					if(item.data.extra[defaultextramission] == nil) then item.data.extra[defaultextramission] = {} end
					local objextra = {}
					objextra.type = dataextratype
					objextra.value = dataextravalue
					table.insert(item.data.extra[defaultextramission],objextra)
					
					
				end
				
			end
			
			if(defaultextramission == "custom") then
				
				customextratag = ImGui.InputText("Tag",customextratag, 5000, ImGuiInputTextFlags.AutoSelectAll)
				
				if ImGui.Button("Add Extra") then
					
					if(item.data.extra[defaultextramission] == nil) then item.data.extra[defaultextramission] = {} end
					local objextra = {}
					objextra.tag = customextratag
					
					table.insert(item.data.extra[defaultextramission],objextra)
					
					
				end
				
			end
			
			
			ImGui.Separator()
			if ImGui.TreeNode("Triggers, Actions and Context") then
				
				editor.triggerNode(getLang("Triggers"),item.data,"trigger_condition",item.data.tag,tag)
				
				editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"trigger_condition_requirement","trigger_condition",tag)
				
				editor.actionNode(getLang("Trigger Actions"),item.data,"trigger_action",item.data.tag,tag)
				
				editor.actionNode(getLang("Unlock Actions"),item.data,"unlock_action",item.data.tag,tag)
				
				editor.actionNode(getLang("End Actions"),item.data,"end_action",item.data.tag,tag)
				
				editor.triggerNode(getLang("Failure Triggers"),item.data,"failure_condition",item.data.tag,tag)
				
				editor.requirementNode(getLang("Failure requirements"),item.data,"failure_condition_requirement","failure_condition",tag)
				
				editor.actionNode(getLang("Failure Actions"),item.data,"failure_action",item.data.tag,tag)
				
				editor.actionNode(getLang("Reset Actions"),item.data,"reset_action",item.data.tag,tag)
				
				editor.contextNode("Context",item.data,"context",item.data.tag,tag)
				
				ImGui.TreePop()
			end
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem("Objectives") then
			
			
			
			
			
			
			
			ImGui.Separator()
			ImGui.Text("Quest Graph : ")
			ImGui.Text("Legend : ")
			ImGui.SameLine()
			ImGui.PushStyleColor(ImGuiCol.ChildBg, 0.1921568627451,0.65882352941176,0.77254901960784, 0.5)
			if ImGui.BeginChild("noptionalchild", 75, 20, false) then
				ImGui.Text("Non Optionnal")
				
			end
			ImGui.EndChild()
			ImGui.PopStyleColor(1)
			
			ImGui.SameLine()
			
			ImGui.PushStyleColor(ImGuiCol.ChildBg,  0.1921568627451,0.77254901960784,0.31372549019608, 0.5)
			if ImGui.BeginChild("optionalchild", 75, 20, false) then
				ImGui.Text("Optionnal")
				
			end
			ImGui.EndChild()
			ImGui.PopStyleColor(1)
			
			ImGui.SameLine()
			ImGui.Text("|")
			ImGui.SameLine()
			
			ImGui.Text("Graph Zoom : ")
			ImGui.SameLine()
			if ImGui.BeginChild("zoomchild", 250, 50, false) then
				questgraphzoomlevel = ImGui.SliderInt(getLang("##Zoom"), questgraphzoomlevel, 50,500)
				ImGui.SameLine()
				if ImGui.Button("Reset Zoom")then
					
					questgraphzoomlevel = 150
					
				end
			end
			ImGui.EndChild()
			
			ImGui.Separator()
			
			editor.questGraph(tag,item)
			
			ImGui.Text("Objectives that is not unlocked by any others objectives :")
			if item.data.sortedobjectives ~= nil and #item.data.objectives > 0 then
				for indexss,v in ipairs(item.data.sortedobjectives.objectives) do
					if v.notsorted ~=nil then
						for i,obje in ipairs(item.data.objectives) do 
							if obje.tag == v.tag then
								if ImGui.TreeNode(obje.tag.." ("..tostring(i)..")") then
									if ImGui.Button("Edit", 50, 0) then
										local objact = {}
										
										objact.parenttag = tag
										objact.parent = item.data
										objact.key = "objectives"
										objact.index = i
										objact.contextscript = tag
										objact.objective = deepcopy(obje,nil)
										objact.graphError = ""
										currentObjective[tag.."_"..obje.tag.." ("..tostring(i)..")"] = objact
										
									end
									
									ImGui.SameLine()
									if currentObjective[tag.."_"..obje.tag.." ("..tostring(i)..")"] == nil then
										if ImGui.Button("Delete", 50, 0) then
											
											table.remove(item.data["objectives"],i)
											
											if(i == 1) then
												item.data.sortedobjectives = nil
												
												else
												local result, message = pcall(function()
													local graph =  editor.makeGraphdata(item.data)
													
													item.data.sortedobjectives =graph
													
												end)
											end
										end
										else
										ImGui.Text("Currently opened in editor")
									end
									ImGui.TreePop()
								end
								
							end
						end
					end
				end
			end
			
			
			
			
			
			
			
			
			
			ImGui.EndTabItem()
		end
		
		
		
		
		
		ImGui.EndTabBar()
	end
	
	
end

function editor.editorfunction.character(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("character")
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.name = tag
		
		
	end
	
	
	local functions = {}
	item.data.tag = item.data.name
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	item.data.name = ImGui.InputText(getLang("Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.source = ImGui.InputText(getLang("Source"), item.data.source, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.path = ImGui.InputText(getLang("Path"), item.data.path, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	
end

function editor.editorfunction.circuit(item,tag,types)
	
	if(item.data == nil) then
		
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		item.data.nodes = {}
		
		
	end
	
	
	local functions = {}
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	editor.listStringNode(getLang("editor_Circuit_Nodes"),getLang("editor_Circuit_Nodes_msg"),item.data,"nodes")
	
	
end

function editor.editorfunction.codex(item,tag,types)
	
	
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		
	end
	
	
	local functions = {}
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-codex", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.title = ImGui.InputText(getLang("title"), item.data.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.description = ImGui.InputText(getLang("description"), item.data.description, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.locked =  ImGui.Checkbox("Locked ?", item.data.locked)
	
	editor.contextNode("Context",item.data,"context",tag,item.contextscript)
	
	
end

function editor.editorfunction.choice(item,tag,types)
	
	
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		item.data.speaker= "Your Speaker Name Here"
		
		
		
	end
	
	
	local functions = {}
	functions["test"] = function(item,tag,types,obj) 
	local usedial =  SetNextDialog(item.data.tag,"interact","editor") createDialog(usedial)	 end
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-choice", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("Type : "..types)
	
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.speaker = ImGui.InputText(getLang("Speaker"), item.data.speaker, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
	
	ImGui.Separator()
	
	ImGui.Text("Display : ")
	ImGui.SetWindowFontScale(1.5)
	if ImGui.BeginChild("displayoption", ImGui.CalcTextSize(item.data.speaker), (#item.data.options+1)*10) then
		ImGui.PushStyleColor(ImGuiCol.Text, 0.88039215, 0.38823529, 0.35686274, 1)
		
		ImGui.Text(item.data.speaker.." : ")
		
		ImGui.PopStyleColor(1)
	end
	
	ImGui.EndChild()
	ImGui.SameLine()
	if ImGui.BeginChild("dispslayoption", 600, 100+(#item.data.options+1)*20,true) then
		
		editor.optionsNode(getLang("editor_answer"),item.data,item.data.tag,tag)
		
	end
	
	ImGui.EndChild()
	ImGui.SetWindowFontScale(1)
	ImGui.SameLine()
	if ImGui.Button("Add new Options", 300, 0) then
		
		local objact = {}
		objact.parenttag = item.data.tag
		objact.parent = item.data
		objact.key = "options"
		objact.contextscript = tag
		objact.index = 1
		if(#item.data["options"] > 0) then objact.index = #item.data["options"]+1 end
		
		objact.options = {}
		objact.options.description = ""
		objact.options.icon = ""
		objact.options.action = {}
		objact.options.trigger = {}
		objact.options.requirement ={}
		objact.options.context = {}
		objact.options.style = {}
		
		currentDialogOptions[item.data.tag.."_options_new_"..#item.data["options"]+1] = objact
	end
	
end

function editor.editorfunction.event(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-event", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	
	
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.name = ImGui.InputText(getLang("Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Text(getLang("editor_Event_way_msg"))
	item.data.way = ImGui.InputText(getLang("editor_Event_way"), item.data.way, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	ImGui.Separator()
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.actionNode(getLang("Actions"),item.data,"action",item.data.tag,tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
	
	
end

function editor.editorfunction.faction(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-faction", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.Tag = tag
		
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	ImGui.Text("Type : "..types)
	item.data.name = ImGui.InputText(getLang("editor_Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.logo = ImGui.InputText(getLang("editor_Faction_Logo"), item.data.logo, 5000, ImGuiInputTextFlags.AutoSelectAll)
	--activeEditedFaction.district_tag = ImGui.InputText(getLang("editor_tag"), activeEditedFaction.Tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	
	
	if ImGui.BeginCombo(getLang("editor_district"), item.data.district_tag) then
		
		
		for i,v in ipairs(arrayDistricts) do
			
			if ImGui.Selectable(v.Name, (item.data.district_tag  == v.Tag)) then
				item.data.district_tag  = v.Tag
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	
	
	
	
	ImGui.Separator()
	
	
	
	editor.listStringNode(getLang("Faction Keyword"),getLang("Let the mod know if one of theses keyword is founded in entity props it's been this faction"),item.data,"keyword",false)
	editor.listStringNode(getLang("editor_Faction_AttitudeGroup"),getLang("editor_Faction_AttitudeGroup_msg"),item.data,"attitude_group",false)
	editor.listStringNode(getLang("editor_Faction_Rivals"),getLang("editor_Faction_Rivals_msg"),item.data,"rivals",false)
	editor.listStringNode(getLang("editor_Faction_SpawnableNPC"),getLang("editor_Faction_SpawnableNPC_msg"),item.data,"spawnable_npc",false)
	editor.listStringNode(getLang("editor_Faction_SpawnableVehicule"),getLang("editor_Faction_SpawnableVehicule_msg"),item.data,"spawnable_vehicle",false)
	ImGui.Separator()
	editor.listVIPNode(getLang("editor_Faction_VIP"),getLang("editor_Faction_VIP_msg"),item.data,"vip")
	
	ImGui.Separator()
	editor.contextNode("Context",item.data,"context",item.data.Tag,tag)
	
	
end

function editor.editorfunction.fixer(item,tag,types)
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-fixer", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		
	end
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.name = ImGui.InputText(getLang("Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.faction = ImGui.InputText(getLang("Faction"), item.data.faction, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Separator()
	editorpnjsearch = ImGui.InputText(getLang("PNJ Filter"), editorpnjsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	if ImGui.BeginCombo(getLang("editor_NPC"), item.data.tweakid) then
		
		
		
		for k,v in pairs(cyberscript.entitieshash) do
			if (editorpnjsearch == "" or (editorpnjsearch ~= "" and ((string.match(string.lower(v.entity_tweak),editorpnjsearch)) or (string.match(string.lower(v.entity_name),editorpnjsearch))))) then
				if ImGui.Selectable(v.entity_tweak, (item.data.tweakid  == v.entity_tweak)) then
					item.data.tweakid  = v.entity_tweak
					ImGui.SetItemDefaultFocus()
				end
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Separator()
	item.data.exist =  ImGui.Checkbox(getLang("editor_Fixer_exist"), item.data.exist)
	item.data.npcexist =  ImGui.Checkbox(getLang("editor_Fixer_npc_exist"), item.data.npcexist)
	ImGui.Separator()
	item.data.x = ImGui.InputFloat(getLang("editor_x"), item.data.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.y = ImGui.InputFloat(getLang("editor_y"), item.data.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.z = ImGui.InputFloat(getLang("editor_z"), item.data.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.range = ImGui.InputFloat(getLang("editor_range"), item.data.range, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	if ImGui.Button(getLang("Copy Player's XYZ Location"), 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		item.data.x = vec4.x
		item.data.y = vec4.y
		item.data.z = vec4.z
		
		
	end
	ImGui.Separator()
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.actionNode(getLang("Spawn Actions"),item.data,"spawn_action",item.data.tag,tag)
		editor.actionNode(getLang("Despawn Actions"),item.data,"despawn_action",item.data.tag,tag)
		
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
	
	
	
	
end

function editor.editorfunction.functions(item,tag,types)
	
	
	if(item.data == nil) then
		item.data= deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		
		
	end
	
	local functions = {}
	functions["test"] = function(item,tag,types,obj) runActionList(item.data.action, item.data.tag,"interact",false,"player") end
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-function", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	item.data.name = ImGui.InputText(getLang("editor_Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	editor.actionNode(getLang("Actions"),item.data,"action",item.data.tag,tag)
	
	
	
	
	
	
	
end

function editor.editorfunction.help(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-tutorial", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.title = ImGui.InputText(getLang("Title"), item.data.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	ImGui.Separator()
	editor.HelpSectionNode(getLang("Sections"),getLang("Sections"),item.data,"section")
	
	editor.contextNode("Context",item.data,"context",item.data.tag,tag)
	
	
	
end

function editor.editorfunction.housing(item,tag,types)
	if(item.data == nil) then
		item.data=  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
	end
	
	local functions = {}
	
	
	functions["save"] = function(item,tag,types,obj)
		for i,v in ipairs(obj.items) do
			
			v.entityId = nil
			v.lightType = nil
		end
	end
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	if ImGui.BeginMenuBar() then 
		
		if(item.data.tag ~= nil and item.data.tag ~= "")then
		   	
		   	
		   	
		   	if ImGui.MenuItem(getLang("Import from current House spawned item (will clear the current list)")) then 
		   		
		   		
		   		if(#currentItemSpawned > 0) then
		   			local toexport = {}
		   			local housing = {}
		   			
		   			
		   			for i=1,#currentItemSpawned do
		   				
		   				local obj = deepcopy(currentItemSpawned[i],obj)
		   				obj.entityId = nil
		   				table.insert(toexport,obj)
		   				
					end
		   			
		   			
		   			item.data["items"] = toexport
		   			
		   			
		   			
				end
		   		
			end
		   	
		   	if ImGui.MenuItem(getLang("Show/hide "..item.data.tag.." to place "..item.data.target)) then
		   		
		   		if(item.togglehousing == false) then
		   			spawnItemFromHousingTag(item.data.target, item.data.tag)
		   			item.togglehousing = true
		   			
		   			else
		   			
		   			currentHouseClearHousing(item.data.tag)
		   			item.togglehousing = false
				end
		   		
			end
		   	
		   	
		   	
		end	
		
		
		
		
		
		ImGui.EndMenuBar()
		
		
		
		
		
	end
	
	if item.togglehousing == nil then item.togglehousing = false end
	
	
	ImGui.Text("Visible ? : "..tostring(item.togglehousing))
	
	
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.target = ImGui.InputText(getLang("Targeted Place Tag :"), item.data.target, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Separator()
	
	
	editor.ItemNode("Items",item,item.data.items,tag,item.data.target,tag, item.scripttype)
	
	ImGui.Separator()
	
	if ImGui.TreeNode("Triggers and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
	
	
	
end

function editor.editorfunction.housing_template(item,tag,types)
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		
	end
	
	
	if ImGui.BeginMenuBar() then 
		if ImGui.BeginMenu("Housing Template Menu") then
			
			if(item.data.tag ~= nil and item.data.tag ~= "")then
			   	
			   	
			   	if ImGui.MenuItem(getLang("Import from current House spawned item (will clear the current list)")) then 
			   		
			   		
			   		if(#currentItemSpawned > 0) then
			   			local toexport = {}
			   			local housing = {}
			   			
			   			
			   			for i=1,#currentItemSpawned do
			   				
			   				local obj = deepcopy(currentItemSpawned[i],obj)
			   				obj.entityId = nil
			   				
							
			   				
							
							
							obj.X = currentItemSpawned[i].X -item.data.center.x
							obj.Y = currentItemSpawned[i].Y-item.data.center.y
							obj.Z= currentItemSpawned[i].Z-item.data.center.z
							
			   				
			   				
			   				table.insert(toexport,obj)
			   				obj.Tag = obj.Tag.."_"..item.data.tag.."_"..i
						end
			   			
			   			
			   			item.data["items"] = toexport
			   			
			   			
			   			
					end
			   		
				end
			   	
			   	if ImGui.MenuItem(getLang("editor_Housing_apply_template")) then 
			   		
			   		
			   		if(#item.data.items > 0) then
			   			
			   			
			   			
			   			
			   			for i,v in ipairs(item.data.items) do
			   				
			   				local obj =  deepcopy(v, obj)
			   				obj.fromTemplate = true
			   				obj.HouseTag = item.data.target
			   				obj.X = item.data.center.x +v.X
			   				obj.Y = item.data.center.y + v.Y
			   				obj.Z = item.data.center.z + v.Z
			   				obj.template = item.data.tag
			   				
			   				saveHousing(obj)
			   				
			   				local housing = getHousing(obj.Tag,obj.X,obj.Y,obj.Z)
			   				obj.Id = housing.Id
			   				
			   				local poss = Vector4.new( obj.X, obj.Y,  obj.Z,1)
			   				
			   				
			   				local angless = EulerAngles.new(obj.Roll, obj.Pitch,  obj.Yaw)
			   				
			   				
			   				obj.entityId = spawnItem(obj, poss, angless)
			   				table.insert(currentItemSpawned,obj)
			   				Cron.After(0.5, function(obj)
			   					
			   					local entity = Game.FindEntityByID(obj.entityId)
			   					
			   					
			   					
			   					local components = checkForValidComponents(entity)
			   					if components then
			   						local visualScale = checkDefaultScale(components)
			   						obj.defaultScale = {
			   							x = visualScale.x * 100,
			   							y = visualScale.x * 100,
			   							z = visualScale.x * 100,
									}
			   						if obj.scale and obj.scale ~= "nil" then
			   							setItemScale(entity,obj, obj.scale)
			   							else
			   							obj.scale = {
			   								x = components[1].visualScale.x * 100,
			   								y = components[1].visualScale.y * 100,
			   								z = components[1].visualScale.z * 100,
										}
									end
								end
							end)
			   				
			   				
						end
			   			
			   			
					end
			   		
				end
			   	
			   	if ImGui.MenuItem(getLang("Apply Template To Current Player Position")) then 
			   		
			   		
			   		if(#item.data.items > 0) then
			   			
			   			
			   			
			   			
			   			for i,v in ipairs(item.data.items) do
			   				
			   				local obj =  deepcopy(v, obj)
			   				obj.fromTemplate = true
			   				obj.HouseTag = item.data.target
			   				obj.X = curPos.x +v.X
			   				obj.Y = curPos.y + v.Y
			   				obj.Z = curPos.z + v.Z
			   				obj.template = item.data.tag
			   				
			   				saveHousing(obj)
			   				
			   				local housing = getHousing(obj.Tag,obj.X,obj.Y,obj.Z)
			   				obj.Id = housing.Id
			   				
			   				local poss = Vector4.new( obj.X, obj.Y,  obj.Z,1)
			   				
			   				
			   				local angless = EulerAngles.new(obj.Roll, obj.Pitch,  obj.Yaw)
			   				
			   				
			   				obj.entityId = spawnItem(obj, poss, angless)
			   				table.insert(currentItemSpawned,obj)
			   				Cron.After(0.5, function(obj)
			   					
			   					local entity = Game.FindEntityByID(obj.entityId)
			   					
			   					
			   					
			   					local components = checkForValidComponents(entity)
			   					if components then
			   						local visualScale = checkDefaultScale(components)
			   						obj.defaultScale = {
			   							x = visualScale.x * 100,
			   							y = visualScale.x * 100,
			   							z = visualScale.x * 100,
									}
			   						if obj.scale and obj.scale ~= "nil" then
			   							setItemScale(entity,obj, obj.scale)
			   							else
			   							obj.scale = {
			   								x = components[1].visualScale.x * 100,
			   								y = components[1].visualScale.y * 100,
			   								z = components[1].visualScale.z * 100,
										}
									end
								end
							end)
			   				
			   				
						end
			   			
			   			
					end
			   		
				end
			   	
			   	
			   	if ImGui.MenuItem(getLang("editor_Housing_clear_template")) then 
			   		
			   		
			   		if(#currentItemSpawned > 0) then
			   			
			   			for i=1,#currentItemSpawned do
			   				
			   				if(currentItemSpawned[i].fromTemplate ~= nil and currentItemSpawned[i].fromTemplate == true) then
			   					deleteHousing(currentItemSpawned[i].Id)
			   					despawnItemFromId(currentItemSpawned[i].Id)
			   					
							end
			   				
			   				
						end
			   			
			   			
					end
			   		
			   		
				end
			   	
			   	
			   	
			end	
			
			ImGui.EndMenu()
		end
		
		
		
		ImGui.EndMenuBar()
		
		
		
		
		
	end
	
	local functions = {}
	
	
	functions["save"] = function(item,tag,types,obj)
		for i,v in ipairs(obj.items) do
			
			v.entityId = nil
			v.lightType = nil
		end
	end
	editor.scripttoolbar(item,tag,types,functions)
	
	if ImGui.BeginChild("part1", 850, 495,true) then
		
		ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
		
		if item.togglehousing == nil then item.togglehousing = false end
		
		
		ImGui.Text("Visible ? : "..tostring(item.togglehousing))
		
		
		item.data.tag = ImGui.InputText("Housing Template "..getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.name = ImGui.InputText("Housing Template Name", item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.price = ImGui.InputFloat("Housing Template Price", item.data.price, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.data.desc = ImGui.InputTextMultiline("Housing Template "..getLang("editor_desc"), item.data.desc, 100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		item.data.target = ImGui.InputText("Housing Template Target \n (leave blank if not needed)", item.data.target, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.data.center.x = ImGui.InputFloat(getLang("editor_x"), item.data.center.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.data.center.y = ImGui.InputFloat(getLang("editor_y"), item.data.center.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.data.center.z = ImGui.InputFloat(getLang("editor_z"), item.data.center.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
		if ImGui.Button(getLang("editor_Housing_template_set_center_player_pos")) then 
			
			item.data.center.x = curPos.x
			item.data.center.y = curPos.y
			item.data.center.z = curPos.z
			
		end
		
		
		editor.ItemNode("Items",item,item.data.items,tag,item.data.target,tag,item.scripttype)
		
		
		
		ImGui.EndChild()
	end
	ImGui.SameLine()
	if ImGui.BeginChild("part2", 600, 495,true) then
		
		ImGui.Text("Help : ")
		
		ImGui.Text("How to use it : \n 1) Create place and save \n 2) Make a housing script for that place and save \n 3) Go out of place and go back for let the housing reload items \n 4) Create template, define anchor point, import item from house \n 5) Go somewhere, apply housing")
		
		
		ImGui.EndChild()
	end
	
	
	
	
end

function editor.editorfunction.hud(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.container = ImGui.InputText(getLang("Parent Container tag"), item.data.container, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.text = ImGui.InputText(getLang("Text"), item.data.text, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.fontsize = ImGui.InputInt("Font Size", item.data.fontsize, 1,10, ImGuiInputTextFlags.None)
	item.data.visible =  ImGui.Checkbox(getLang("Visible ?"), item.data.visible)
	
	ImGui.Separator()
	if ImGui.BeginCombo("Type", item.data.type) then -- Remove the ## if you'd like for the title to display above combo box
		
		if ImGui.Selectable("widget", (item.data.type == "widget")) then
			
			item.data.type = "widget"
			
			ImGui.SetItemDefaultFocus()
		end
		if ImGui.Selectable("container", (item.data.type == "container")) then
			
			item.data.type ="container"
			
			ImGui.SetItemDefaultFocus()
		end
		
		
		ImGui.EndCombo()
	end
	
	
	ImGui.Separator()
	editor.listDictionnaryIntNode("Margin :","Margin of the element, can be : top||left||bottom||right",item.data,"margin")
	
	ImGui.Separator()
	ImGui.Text("Style : ")
	if(item.data.color ~= nil and item.data.color.red ~= nil and item.data.color.green ~= nil and item.data.color.blue ~= nil ) then
		
		ImGui.PushStyleColor(ImGuiCol.Text,round((item.data.color.red/255),8), round((item.data.color.green/255),8), round((item.data.color.blue/255),8), 1)
		
		ImGui.Text("Current Color")
		
		ImGui.PopStyleColor(1)
		
		
		ImGui.Text("Red : ".. item.data.color.red)
		ImGui.Text("Green : ".. item.data.color.green)
		ImGui.Text("Blue : ".. item.data.color.blue)
		else
		
		ImGui.Text("No current Style defined ")
		
	end
	
	if ImGui.Button("Open Color Picker") then
		toggleEditorUI("colorPicker")
	end
	
	ImGui.SameLine()
	
	if ImGui.Button("Copy RGB from Color Picker") then
		item.data.color.red = currentcolorRGB.red 
		item.data.color.green = currentcolorRGB.green
		item.data.color.blue = currentcolorRGB.blue
	end
	
	if ImGui.Button("Remove Color") then
		item.data.color = nil
	end
	ImGui.Separator()
	
	
	
	editor.contextNode("Context",item.data,"context",item.data.tag,tag)
	
end

function editor.editorfunction.interact(item,tag,types)
	
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-interact", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data= deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
	end
	
	
	local functions = {}
	
	functions["test"] = function (item,tag,types,obj) 
		
		runActionList(item.data.action, item.data.tag,"interact",false,"player")
		
	end
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	item.data.name = ImGui.InputText(getLang("editor_Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Separator()
	
	item.data.timer = ImGui.InputInt(getLang("Timer"), item.data.timer, 1,10, ImGuiInputTextFlags.None)
	ImGui.Text(getLang("editor_Interact_SortTag_msg"))
	item.data.sorttag = ImGui.InputText(getLang("SortTag"), item.data.sorttag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Text(getLang("editor_Interact_Display_msg"))
	item.data.display = ImGui.InputText(getLang("Display"), item.data.display, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Text(getLang("editor_Interact_Type_msg"))
	
	
	
	item.data.type = ImGui.InputText(getLang("editor_Interact_Type"), item.data.type, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	if(item.data.type == "hint") then
		
		item.data.hold = ImGui.Checkbox(getLang("editor_Interact_hold"), item.data.hold)
		item.data.key = ImGui.InputText(getLang("editor_Interact_key"), item.data.key, 5000, ImGuiInputTextFlags.AutoSelectAll)
	end
	
	
	
	
	ImGui.Separator()
	
	
	editoriconsearch = ImGui.InputText(getLang("Icon Choice Filter"), editoriconsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	if ImGui.BeginCombo("Icon :", item.data.icon) then
		
		
		for i,v in ipairs(choiceIconList) do
			if (editoriconsearch == "" or (editoriconsearch ~= "" and (string.match(string.lower(v),editoriconsearch)))) then
				if ImGui.Selectable(v, (item.data.icon == v)) then
					item.data.icon = v
					
					
					
					ImGui.SetItemDefaultFocus()
				end
				
			end
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Text("Style : ")
	if ImGui.Button("Open Color Picker") then
		toggleEditorUI("colorPicker")
	end
	
	
	
	ImGui.Separator()
	
	
	
	
	if(item.data.style ~= nil and item.data.style.textcolor ~= nil and item.data.style.textcolor.red ~= nil and item.data.style.textcolor.green ~= nil and item.data.style.textcolor.blue ~= nil ) then
		
		ImGui.PushStyleColor(ImGuiCol.Text,round((item.data.style.textcolor.red/255),8), round((item.data.style.textcolor.green/255),8), round((item.data.style.textcolor.blue/255),8), 1)
		
		ImGui.Text("Current Text Color")
		
		ImGui.PopStyleColor(1)
		
		
		ImGui.Text("Red : ".. item.data.style.textcolor.red)
		ImGui.Text("Green : ".. item.data.style.textcolor.green)
		ImGui.Text("Blue : ".. item.data.style.textcolor.blue)
		else
		
		ImGui.Text("No current Text Color defined ")
		
	end
	
	
	
	ImGui.SameLine()
	
	if ImGui.Button("Copy RGB from Color Picker to Text Color") then
		item.data.style.textcolor.red = currentcolorRGB.red 
		item.data.style.textcolor.green = currentcolorRGB.green
		item.data.style.textcolor.blue = currentcolorRGB.blue
	end
	
	if ImGui.Button("Remove Text Color") then
		item.data.style.textcolor = nil
	end
	
	ImGui.Separator()
	
	
	
	
	--limit
	
	
	
	if(item.data.style ~= nil and item.data.style.bgcolor ~= nil and item.data.style.bgcolor.red ~= nil and item.data.style.bgcolor.green ~= nil and item.data.style.bgcolor.blue ~= nil ) then
		
		ImGui.PushStyleColor(ImGuiCol.Text,round((item.data.style.bgcolor.red/255),8), round((item.data.style.bgcolor.green/255),8), round((item.data.style.bgcolor.blue/255),8), 1)
		
		ImGui.Text("Current Background Color")
		
		ImGui.PopStyleColor(1)
		
		
		ImGui.Text("Red : ".. item.data.style.bgcolor.red)
		ImGui.Text("Green : ".. item.data.style.bgcolor.green)
		ImGui.Text("Blue : ".. item.data.style.bgcolor.blue)
		else
		
		ImGui.Text("No current Background Color defined ")
		
	end
	
	
	
	ImGui.SameLine()
	
	if ImGui.Button("Copy RGB from Color Picker to Background Color") then
		item.data.style.bgcolor.red = currentcolorRGB.red 
		item.data.style.bgcolor.green = currentcolorRGB.green
		item.data.style.bgcolor.blue = currentcolorRGB.blue
	end
	
	if ImGui.Button("Remove Background Color") then
		item.data.style.bgcolor = nil
	end
	
	ImGui.Separator()
	
	
	--limit
	
	
	
	if(item.data.style ~= nil and item.data.style.iconcolor ~= nil and item.data.style.iconcolor.red ~= nil and item.data.style.iconcolor.green ~= nil and item.data.style.iconcolor.blue ~= nil ) then
		
		ImGui.PushStyleColor(ImGuiCol.Text,round((item.data.style.iconcolor.red/255),8), round((item.data.style.iconcolor.green/255),8), round((item.data.style.iconcolor.blue/255),8), 1)
		
		ImGui.Text("Current Icon Color")
		
		ImGui.PopStyleColor(1)
		
		
		ImGui.Text("Red : ".. item.data.style.iconcolor.red)
		ImGui.Text("Green : ".. item.data.style.iconcolor.green)
		ImGui.Text("Blue : ".. item.data.style.iconcolor.blue)
		else
		
		ImGui.Text("No current Icon Color defined ")
		
	end
	
	
	
	ImGui.SameLine()
	
	if ImGui.Button("Copy RGB from Color Picker to Icon Color") then
		item.data.style.iconcolor.red = currentcolorRGB.red 
		item.data.style.iconcolor.green = currentcolorRGB.green
		item.data.style.iconcolor.blue = currentcolorRGB.blue
	end
	
	if ImGui.Button("Remove Icon Color") then
		item.data.style.iconcolor = nil
	end
	
	
	
	
	ImGui.Separator()
	
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.actionNode(getLang("Actions"),item.data,"action",item.data.tag,tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
	
	
	
	
	
end

function editor.editorfunction.interfaces(item,tag,types)
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-interface", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		
		
		
	end
	local functions = {}
	
	local hidemenu = {}
	hidemenu.test = true
	
	editor.scripttoolbar(item,tag,types,functions,hidemenu)
	
	
	if ImGui.BeginMenuBar() then 
		
		
		if(item.data.tag ~= nil and item.data.tag ~= "")then
		   	if ImGui.BeginMenu(getLang("Test the UI")) then
		   		
		   		if ImGui.BeginMenu("Popup") then
		   			
		   			if currentInterface == nil or currentInterface.tag ~= item.data.tag then 
		   				if ImGui.MenuItem(getLang("Display In Popup")) and item.data.tag ~= "" then
		   					if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
		   						local obj =  deepcopy(item.data,nil)
		   						cyberscript.cache["interfaces"][item.data.tag] = {}
		   						cyberscript.cache["interfaces"][item.data.tag].data = obj
		   						cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
		   						cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
		   						cyberscript.cache["interfaces"][item.data.tag].scripttype = types
		   						
		   						arrayDatapack["editor"][types][item.data.tag] = obj
		   						else
		   						local obj =  deepcopy(item.data,nil)
		   						cyberscript.cache["interfaces"][item.data.tag].data = obj
							end
		   					
		   					
		   					currentInterface = cyberscript.cache["interfaces"][item.data.tag].data
		   					--logme(3,dump(currentInterface))
		   					if(currentInterface ~= nil) then
		   						--openInterface = true
		   						if UIPopupsManager.IsReady() then
		   							local notificationData = ShardReadPopupData.new()
		   							notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
		   							notificationData.queueName = 'modal_popup'
		   							notificationData.isBlocking = true
		   							notificationData.useCursor = true
		   							UIPopupsManager.ShowPopup(notificationData)
		   							else
		   							Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
								end
		   						else
		   						Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
							end
		   					
						end
					end
		   			
		   			if ImGui.MenuItem(getLang("Refresh It")) and item.data.tag ~= "" then
		   				
		   				UIPopupsManager.ClosePopup()
		   				if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag] = {}
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
		   					cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
		   					cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
		   					cyberscript.cache["interfaces"][item.data.tag].scripttype = types
		   					
		   					arrayDatapack["editor"][types][item.data.tag] = obj
		   					else
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
						end
		   				
		   				
		   				currentInterface = cyberscript.cache["interfaces"][item.data.tag].data
		   				--logme(3,dump(currentInterface))
		   				if(currentInterface ~= nil) then
		   					--openInterface = true
		   					if UIPopupsManager.IsReady() then
		   						local notificationData = ShardReadPopupData.new()
		   						notificationData.notificationName = 'base\\gameplay\\gui\\widgets\\notifications\\shard_notification.inkwidget'
		   						notificationData.queueName = 'modal_popup'
		   						notificationData.isBlocking = true
		   						notificationData.useCursor = true
		   						UIPopupsManager.ShowPopup(notificationData)
		   						else
		   						Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
							end
		   					else
		   					Game.GetPlayer():SetWarningMessage("Open and close Main menu before call an popup.")
						end
		   				
		   				
					end
		   			
		   			if ImGui.MenuItem(getLang("Close Popup")) and item.data.tag ~= "" then
		   				UIPopupsManager.ClosePopup()
		   				
					end
		   			
		   			ImGui.EndMenu()
				end
		   		
		   		if ImGui.BeginMenu("Hud") then
		   			if(currentInterfaceWidget[item.data.tag] == nil)	 then
						if ImGui.MenuItem(getLang("Display In Hud")) and item.data.tag ~= "" then
							if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
								local obj =  deepcopy(item.data,nil)
								cyberscript.cache["interfaces"][item.data.tag] = {}
								cyberscript.cache["interfaces"][item.data.tag].data = obj
								cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
								cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
								cyberscript.cache["interfaces"][item.data.tag].scripttype = types
								
								arrayDatapack["editor"][types][item.data.tag] = obj
								else
								local obj =  deepcopy(item.data,nil)
								cyberscript.cache["interfaces"][item.data.tag].data = obj
							end
							
							
							if(displayHUD["main_root_default"] ~= nil and cyberscript.cache["interfaces"][item.data.tag] ~= nil) then
								
								makeCustomInterface(displayHUD["main_root_default"],cyberscript.cache["interfaces"][item.data.tag].data)
								
								
								
							end
							
						end
					end
		   			
		   			if ImGui.MenuItem(getLang("Refresh It")) and item.data.tag ~= "" then
		   				
		   				if(currentInterfaceWidget[item.data.tag] ~= nil and currentInterfaceWidget[item.data.tag].parent ~= nil) then
		   					
		   					
		   					currentInterfaceWidget[item.data.tag].parent:RemoveChildByName(currentInterfaceWidget[item.data.tag].controls[1].tag)
		   					currentInterfaceWidget[item.data.tag] = nil
		   					
		   					
						end
		   				if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag] = {}
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
		   					cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
		   					cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
		   					cyberscript.cache["interfaces"][item.data.tag].scripttype = types
		   					
		   					arrayDatapack["editor"][types][item.data.tag] = obj
		   					else
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
						end
		   				
		   				
		   				if(displayHUD["main_root_default"] ~= nil and cyberscript.cache["interfaces"][item.data.tag] ~= nil) then
		   					
		   					makeCustomInterface(displayHUD["main_root_default"],cyberscript.cache["interfaces"][item.data.tag].data)
		   					
		   					
		   					
						end
		   				
		   				
					end
		   			
		   			if ImGui.MenuItem(getLang("Clear it from HUD")) and item.data.tag ~= "" then
		   				if(currentInterfaceWidget[item.data.tag] ~= nil and currentInterfaceWidget[item.data.tag].parent ~= nil) then
		   					
		   					
		   					currentInterfaceWidget[item.data.tag].parent:RemoveChildByName(currentInterfaceWidget[item.data.tag].controls[1].tag)
		   					currentInterfaceWidget[item.data.tag] = nil
		   					
		   					
						end
		   				
					end
		   			
		   			ImGui.EndMenu()
				end
		   		
		   		if ImGui.BeginMenu("Web Page") then
		   			
		   			if ImGui.MenuItem(getLang("Display In Web Browser")) and item.data.tag ~= "" then
		   				if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag] = {}
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
		   					cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
		   					cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
		   					cyberscript.cache["interfaces"][item.data.tag].scripttype = types
		   					
		   					arrayDatapack["editor"][types][item.data.tag] = obj
		   					else
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
						end
		   				
		   				
		   				cyberscript.cache["webpage"]["testUI"] = {}
		   				cyberscript.cache["webpage"]["testUI"].file = "testUI.json"
		   				cyberscript.cache["webpage"]["testUI"].datapack = "editor"
		   				cyberscript.cache["webpage"]["testUI"].scripttype = "webpage"
		   				
		   				local webpage = {}
		   				
		   				webpage.name = "Editor Test UI"
		   				webpage.tag = "editor_test_ui"
		   				webpage.target = item.data.tag
		   				webpage.trigger = {}
		   				webpage.trigger.auto = {}
		   				webpage.trigger.auto.name = "auto"
		   				webpage.requirement = {}
		   				webpage.requirement[1] = {}
		   				webpage.requirement[1][1] = "auto"
		   				
		   				
		   				cyberscript.cache["webpage"]["testUI"].data = webpage
		   				
					end
		   			
		   			
		   			if ImGui.MenuItem(getLang("Clear it from WebBrowser")) and item.data.tag ~= "" then
		   				cyberscript.cache["webpage"]["testUI"] = nil
		   				
					end
		   			
		   			ImGui.EndMenu()
				end
				
				if ImGui.BeginMenu("InkWidget Entity") then
		   			if(cyberscript.EntityManager["inkwidget_editor"] == nil) then
						if ImGui.MenuItem(getLang("Display In inkwidgetEntity")) and item.data.tag ~= "" then
							if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
								local obj =  deepcopy(item.data,nil)
								cyberscript.cache["interfaces"][item.data.tag] = {}
								cyberscript.cache["interfaces"][item.data.tag].data = obj
								cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
								cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
								cyberscript.cache["interfaces"][item.data.tag].scripttype = types
								
								arrayDatapack["editor"][types][item.data.tag] = obj
								else
								local obj =  deepcopy(item.data,nil)
								cyberscript.cache["interfaces"][item.data.tag].data = obj
							end
							
							spawnWidgetEnt("inkwidget_editor", curPos.x, curPos.y ,curPos.z+1.65)
							Cron.After(2, function()
								cyberscript.EntityManager["inkwidget_editor"].interface = item.data.tag
								cyberscript.EntityManager["inkwidget_editor"].widget :RemoveAllChildren()
								makeCustomInterface(cyberscript.EntityManager["inkwidget_editor"].widget,cyberscript.cache["interfaces"][item.data.tag].data)
							end)
							
						end
					end
		   			
		   			if ImGui.MenuItem(getLang("Refresh It")) and item.data.tag ~= "" then
		   				
		   				if(currentInterfaceWidget[item.data.tag] ~= nil and currentInterfaceWidget[item.data.tag].parent ~= nil) then
		   					
		   					
		   					currentInterfaceWidget[item.data.tag].parent:RemoveChildByName(currentInterfaceWidget[item.data.tag].controls[1].tag)
		   					currentInterfaceWidget[item.data.tag] = nil
		   					
		   					
						end
		   				if(cyberscript.cache["interfaces"][item.data.tag] == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == nil  or cyberscript.cache["interfaces"][item.data.tag].datapack == "editor") then
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag] = {}
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
		   					cyberscript.cache["interfaces"][item.data.tag].file = item.data.tag..".json"
		   					cyberscript.cache["interfaces"][item.data.tag].datapack = "editor"
		   					cyberscript.cache["interfaces"][item.data.tag].scripttype = types
		   					
		   					arrayDatapack["editor"][types][item.data.tag] = obj
		   					else
		   					local obj =  deepcopy(item.data,nil)
		   					cyberscript.cache["interfaces"][item.data.tag].data = obj
						end
		   				
		   				
		   				if(cyberscript.EntityManager["inkwidget_editor"] ~= nil and cyberscript.cache["interfaces"][item.data.tag] ~= nil) then
							
							cyberscript.EntityManager["inkwidget_editor"].interface = item.data.tag
							cyberscript.EntityManager["inkwidget_editor"].widget :RemoveAllChildren()
							makeCustomInterface(cyberscript.EntityManager["inkwidget_editor"].widget,cyberscript.cache["interfaces"][item.data.tag].data)
							
							else
							----print("no apply")
							-- ----print(tostring(GameDump(displayHUD[action.parent])))
							-- ----print(tostring(dump(cyberscript.cache["interfaces"][action.tag])))
							
						end
		   				
		   				
					end
		   			
		   			if ImGui.MenuItem(getLang("Clear it from inkwidget")) and item.data.tag ~= "" then
		   				if(cyberscript.EntityManager["inkwidget_editor"] ~= nil) then
							
							cyberscript.EntityManager["inkwidget_editor"].interface = nil
							cyberscript.EntityManager["inkwidget_editor"].widget :RemoveAllChildren()
							despawnEntity("inkwidget_editor")
							else
							----print("no apply")
							-- ----print(tostring(GameDump(displayHUD[action.parent])))
							-- ----print(tostring(dump(cyberscript.cache["interfaces"][action.tag])))
							
						end
		   				
					end
		   			
		   			ImGui.EndMenu()
				end
		   		ImGui.EndMenu()
			end
		   	
		   	
		end	
		
		ImGui.EndMenuBar()
		
	end
	
	
	ImGui.Text("Type : "..types)
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.title =  ImGui.InputText(getLang("Title"), item.data.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	ImGui.Separator()
	editor.actionNode(getLang("OnLoad Actions"),item.data,"onload_action",item.data.tag,tag)
	ImGui.Separator()	
	
	if ImGui.BeginChild("dispslayoption", 600, 100+(#item.data.controls+1)*50,true) then
		
		editor.controlsNode(getLang("Childrens"),item.data,item.data.tag,tag)
		
	end
	ImGui.EndChild()
	ImGui.SameLine()
	if ImGui.Button("Add new Children", 300, 0) then
		
		local objact = {}
		objact.parenttag = item.data.tag
		objact.parent = item.data
		objact.key = "controls"
		objact.contextscript = tag
		objact.index = 1
		if(#item.data["controls"] > 0) then objact.index = #item.data["controls"]+1 end
		
		objact.controls = deepcopy(editorInterfaceGlobalItem,nil)
		objact.controls.tag = item.data.tag.."_controls_new_"..#item.data["controls"]+1
		objact.controls.type = "label"
		currentInterfaceControl[item.data.tag.."_controls_new_"..#item.data["controls"]+1] = objact
	end
	
	
	
	
end

function editor.editorfunction.lang(item,tag,types)
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	
	ImGui.Text(getLang("editor_Lang_Key_msg"))
	
	if ImGui.TreeNode("Languages") then
		for lang,tablekey in pairs(item.data.languages) do
			if ImGui.TreeNode(lang) then
				editor.listDictionnaryNode(getLang("editor_Lang_Key").." for "..lang.." language","",item.data.languages,lang)
				ImGui.TreePop(1)
			end
			
		end
		ImGui.TreePop(1)
	end
	
	
	ImGui.Separator()
	
	if ImGui.BeginCombo(getLang("Add Language"), "") then
		
		
		
		for i,lang in ipairs(langcategory) do
			
			if ImGui.Selectable(lang) then
				if item.data.languages[lang] == nil then item.data.languages[lang] = {} end
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	
	
	
	
end

function editor.editorfunction.node(item,tag,types)
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		
	end
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Type : "..types)
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.sort =  ImGui.InputText(getLang("Sort Category"), item.data.sort, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.name =  ImGui.InputText(getLang("Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.x = ImGui.InputFloat(getLang("editor_x"), item.data.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.y = ImGui.InputFloat(getLang("editor_y"), item.data.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.z = ImGui.InputFloat(getLang("editor_z"), item.data.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	
	
	
	if ImGui.Button(getLang("editor_copy_player_location".." For XYZ"), 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		
		item.data.x = vec4.x
		item.data.y = vec4.y
		item.data.z = vec4.z
		
		
		
	end
	
	
	
	item.data.gameplay_x = ImGui.InputFloat(getLang("Gameplay X"), item.data.gameplay_x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.gameplay_y = ImGui.InputFloat(getLang("Gameplay Y"), item.data.gameplay_y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.gameplay_z = ImGui.InputFloat(getLang("Gameplay Z"), item.data.gameplay_z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	
	if ImGui.Button(getLang("editor_copy_player_location".." For Gameplay XYZ"), 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		
		item.data.gameplay_x = vec4.x
		item.data.gameplay_y = vec4.y
		item.data.gameplay_z = vec4.z
		
		
	end
	
	
end

function editor.editorfunction.npc(item,tag,types)
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data =deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		
	end
	
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	ImGui.Text("Type : "..types)
	
	item.data.name = ImGui.InputText(getLang("editor_Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	if ImGui.BeginCombo("TweakDB", item.data.tweakDB) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		
		
		for i,enti in ipairs(cyberscript.entities) do
			
			
			
			
			if ImGui.Selectable(enti.entity_tweak,item.data.tweakDB == enti.entity_tweak) then
				
				item.data.tweakDB =  enti.entity_tweak
				
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	
	
	
	
	item.data.appeareance = ImGui.InputText(getLang("editor_CustomNPC_appeareance"), item.data.appeareance, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.repeat_routine = ImGui.Checkbox(getLang("editor_CustomNPC_repeat_routine"), item.data.repeat_routine)
	
	item.data.auto_despawn = ImGui.Checkbox(getLang("editor_CustomNPC_auto_despawn"), item.data.auto_despawn)
	
	item.data.useBetaSpawn = ImGui.Checkbox(getLang("editor_CustomNPC_useBetaSpawn"), item.data.useBetaSpawn)
	
	ImGui.Separator()
	
	item.data.location.radius = ImGui.InputFloat(getLang("editor_range"), item.data.location.radius, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	item.data.location.player_range = ImGui.InputFloat(getLang("Player's Range"), item.data.location.player_range, 1, 10, "%.3f", ImGuiInputTextFlags.None)
	
	editor.PositionUI(item.data.location)
	
	ImGui.Separator()
	
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"triggers",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","triggers",tag)
		
		
		editor.actionNode(getLang("Routine Actions"),item.data,"routineaction",item.data.tag,tag)
		editor.actionNode(getLang("Spawn Actions"),item.data,"spawnaction",item.data.tag,tag)
		editor.actionNode(getLang("Despawn Actions"),item.data,"despawnaction",item.data.tag,tag)
		editor.actionNode(getLang("Death Actions"),item.data,"deathaction",item.data.tag,tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
end

function editor.editorfunction.path(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data =deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
	end
	
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	ImGui.Text("Type : "..types)
	
	
	if editorPathTarget == nil then
		
		
		editorPathTarget = "player"
	end
	
	
	
	
	
	
	item.data.desc = ImGui.InputText(getLang("editor_Name"), item.data.desc, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.startNode = ImGui.InputText(getLang("editor_Path_StartNode"), item.data.startNode, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.endNode = ImGui.InputText(getLang("editor_Path_EndNode"), item.data.endNode, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.recordRotationOnly = ImGui.Checkbox(getLang("editor_Path_recordRotation").." Only", item.data.recordRotationOnly)
	if item.data.recordRotationOnly == false then
		item.data.recordRotation = ImGui.Checkbox(getLang("editor_Path_recordRotation"), item.data.recordRotation)
		
		item.data.recordRelative = ImGui.Checkbox(getLang("editor_Path_recordRelative"), item.data.recordRelative)
		else
		item.data.recordRelative = false
		item.data.recordRotation = true
	end
	
	if ImGui.BeginTabBar("PathTabs", ImGuiTabBarFlags.NoTooltip) then
		
		if ImGui.BeginTabItem(getLang("editor_Path_Record")) then
			if saveLocationEnabled == false then
				
				if ImGui.BeginCombo(getLang("editor_Path_RecordTarget"), recorderEntity) then
					
					
					for k,v in pairs(cyberscript.EntityManager) do
						
						
						if(v.id ~= nil) then
							local enti = Game.FindEntityByID(v.id)	
							if(enti ~= nil) then
								if ImGui.Selectable(k, (recorderEntity == k)) then
									
									recorderEntity = k
									
									ImGui.SetItemDefaultFocus()
								end
								
							end
						end
					end
					ImGui.EndCombo()
				end
				
				if (recorderEntity == "player")then
					recorderPlayerCamera = 	ImGui.Checkbox("Use Player Camera ?", recorderPlayerCamera)
					else
					recorderPlayerCamera = false
				end
				
				pathOffsetX = ImGui.DragFloat("##pathOffsetX", pathOffsetX, 0.01, -9999, 9999, "%.3f X Offset")
				pathOffsetY = ImGui.DragFloat("##pathOffsetY", pathOffsetY, 0.01, -9999, 9999, "%.3f Y Offset")
				pathOffsetZ = ImGui.DragFloat("##pathOffsetZ", pathOffsetZ, 0.01, -9999, 9999, "%.3f Z Offset")
				
				if(item.data.tag ~= nil and item.data.tag ~= "") then
					
					if ImGui.Button(getLang("editor_Path_RecordPath"))then
						Game.t1()
						recordRotation = item.data.recordRotation
						recordRotationOnly = item.data.recordRotationOnly
						recordRelative = item.data.recordRelative
						if (recorderPlayerCamera == true)then
							recordInitialPosition = Game.GetPlayer():GetFPPCameraComponent():GetLocalPosition() 
							else
							recordInitialPosition = Game.GetPlayer():GetWorldPosition()
							local obj = getEntityFromManager(recorderEntity)
							if(obj.id ~= nil) then
								local enti = Game.FindEntityByID(obj.id)	
								if(enti ~= nil) then
									
									recordInitialPosition = enti:GetWorldPosition()
									if(recordRotationOnly) then
										recordRotationOnlypos.x = enti:GetWorldPosition().x
										recordRotationOnlypos.y = enti:GetWorldPosition().y
										recordRotationOnlypos.z = enti:GetWorldPosition().z
									end
								end
							end
							
							
						end
						
						
						
						tempLocation = {}
						saveLocationEnabled = true
						
						
						
					end
					
					
					else
					ImGui.Text(getLang("editor_Path_mgs"))
					
				end
				else
				if ImGui.Button(getLang("editor_Path_Record_Stop"))then
					saveLocationEnabled = false
					item.data["locations"] = tempLocation
					tempLocation = {}
					Game.t2()
				end
			end
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem(getLang("editor_Path_Play")) then
			if(#item.data["locations"]>0) then
				
				
				
				
				
				if ImGui.BeginCombo(getLang("editor_Path_PlayTarget"), editorPathTarget) then
					
					
					
					
					
					for k,v in pairs(cyberscript.EntityManager) do
						
						
						if(v.id ~= nil) then
							local enti = Game.FindEntityByID(v.id)	
							if(enti ~= nil) then
								if ImGui.Selectable(k, (editorPathTarget == k)) then
									
									editorPathTarget = k
									
									ImGui.SetItemDefaultFocus()
								end
								
							end
						end
					end
					
					ImGui.EndCombo()
				end
				
				
				
				
				
				
				
				
				
				editorPathTarget = ImGui.InputText(getLang("editor_Path_PlayTargetCustom"), editorPathTarget, 5000, ImGuiInputTextFlags.AutoSelectAll)
				
				
				sliderPathTarget, used = ImGui.SliderInt(getLang("editor_Path_CurrentFrame"), sliderPathTarget, 1, #item.data["locations"], "%d")
				if used then
					local frame =item.data["locations"][sliderPathTarget]
					
					
					local poss = Vector4.new( frame.x, frame.y,  frame.z,1)
					
					
					local angless = EulerAngles.new(frame.roll, frame.pitch,  frame.yaw)
					
					local isplayer = false
					if editorPathTarget == "player" then
						isplayer = true
					end
					local obj = getEntityFromManager(editorPathTarget)
					local enti = Game.FindEntityByID(obj.id)
					if(item.data.recordRelative == true) then
						poss = enti:GetWorldPosition()
						poss.x = poss.x + frame.x
						poss.y = poss.y + frame.y
						poss.z = poss.z + frame.z
						
					end
					
					if(enti ~= nil) then
						teleportTo(enti, Vector4.new( poss.x, poss.y, poss.z,1), angless,isplayer)
					end
				end
				
				if ImGui.Button(getLang("editor_Path_PlayPath"))then
					cyberscript.cache["path"][item.data.tag] = {}
					cyberscript.cache["path"][item.data.tag].data = deepcopy(item.data,nil)
					cyberscript.cache["path"][item.data.tag].file = path
					cyberscript.cache["path"][item.data.tag].datapack = datapackname
					
					local actionlist = {}
					local action = {}
					
					
					action.name = "play_path"
					action.path = item.data.tag
					action.tag = editorPathTarget
					action.isrelative = item.data.recordRelative
					action.zoffset = 0
					table.insert(actionlist,action)
					
					runActionList(actionlist, "play_path_"..math.random(1,99999), tag,source,false,executortag)
				end
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_Path_DeleteFrame")..sliderPathTarget)then
					table.remove(item.data["locations"],sliderPathTarget)
					sliderPathTarget = sliderPathTarget - 1
					if(sliderPathTarget <= 0) then sliderPathTarget = 1 end
				end
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_Path_CopyFrameBefore"))then
					table.insert(item.data["locations"],sliderPathTarget-1,item.data["locations"][sliderPathTarget])
					sliderPathTarget = sliderPathTarget - 1
				end
				ImGui.SameLine()
				if ImGui.Button(getLang("editor_Path_CopyFrameAfter"))then
					table.insert(item.data["locations"],sliderPathTarget+1,item.data["locations"][sliderPathTarget])
					sliderPathTarget = sliderPathTarget + 1
				end
				
				
				item.data["locations"][sliderPathTarget].x = ImGui.DragFloat("##locationX", item.data["locations"][sliderPathTarget].x, 0.001, -9999, 9999, "%.4f X ")
				item.data["locations"][sliderPathTarget].y = ImGui.DragFloat("##locationY", item.data["locations"][sliderPathTarget].y, 0.001, -9999, 9999, "%.4f Y ")
				item.data["locations"][sliderPathTarget].z = ImGui.DragFloat("##locationZ", item.data["locations"][sliderPathTarget].z, 0.001, -9999, 9999, "%.4f Z ")
				item.data["locations"][sliderPathTarget].yaw = ImGui.DragFloat("##locationYaw", item.data["locations"][sliderPathTarget].yaw, 0.001, -9999, 9999, "%.4f YAW ")
				item.data["locations"][sliderPathTarget].pitch = ImGui.DragFloat("##locationPitch", item.data["locations"][sliderPathTarget].pitch, 0.001, -9999, 9999, "%.4f PITCH ")
				item.data["locations"][sliderPathTarget].roll = ImGui.DragFloat("##locationRoll", item.data["locations"][sliderPathTarget].roll, 0.001, -9999, 9999, "%.4f Roll ")
				
				
				
				
				if(item.data["locations"][sliderPathTarget]["action"] == nil) then
					item.data["locations"][sliderPathTarget]["action"] = {}
				end
				
				
				editor.actionNode(getLang("editor_Path_CurrentFrameAction"),item.data["locations"][sliderPathTarget],"action",tag,tag)
				
				
				
				else
				
				ImGui.Text(getLang("editor_Path_NoRecord"))
				
			end
			ImGui.EndTabItem()
		end		
		
		ImGui.EndTabBar()
	end
	
	
	
	
	
	
	
end

function editor.editorfunction.phone_dialog(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-phone-conversation", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data= deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		
	end
	
	
	
	local functions = {}
	
	functions["save"]=function(item,tag,types,obj)
		
		
		if(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.unlock == false ) then
			setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.tag,"unlocked",0)
			else
			setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.tag,"unlocked",1)
			
		end
		for z =1, #cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation do
			if(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].unlock == false ) then
				setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].tag,"unlocked",0)
				
				else
				setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].tag,"unlocked",1)
				
			end
			for y=1, #cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message do
				
				if(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message[y].unlock == false ) then
					setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message[y].tag,"unlocked",0)
					
					else
					setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message[y].tag,"unlocked",1)
					
				end
				if(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message[y].choices ~= nil) then
					for j=1, #cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message[y].choices do
						
						setScore(cyberscript.cache["phone_dialog"][tostring(item.data.tag)].data.conversation[z].message[y].choices[j].tag,"unlocked",0)
					end
				end
			end
		end
		
		
	end
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.Separator()
	
	item.data.speaker = ImGui.InputText(getLang("Speaker"), item.data.speaker, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	item.data.unlock = ImGui.Checkbox(getLang("Unlocked ?"), item.data.unlock)
	
	
	ImGui.Separator()
	
	if ImGui.BeginChild("dispslayoption", 600, 100+(#item.data.conversation+1)*20,true) then
		local result, message = pcall(function()
			editor.conversationNode(getLang(item.data.speaker),item.data,item.data.tag,tag)
		end
		)
		if(result == false) then
			--print(message)
		end
	end
	ImGui.EndChild()
	ImGui.SameLine()
	if ImGui.Button("Add new Conversation", 300, 0) then
		
		local objact = {}
		objact.parenttag = item.data.tag
		objact.parent = item.data
		objact.key = "conversation"
		objact.contextscript = tag
		objact.index = 1
		if(#item.data["conversation"] > 0) then objact.index = #item.data["conversation"]+1 end
		
		objact.conversation = {}
		objact.conversation.name = ""
		objact.conversation.tag = ""
		objact.conversation.unlock = false
		objact.conversation.message = {}
		
		currentPhoneConversationeditor[item.data.tag.."_conversation_new_"..#item.data["conversation"]+1] = objact
	end
	
	
end

function editor.editorfunction.place(item,tag,types)
	
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		
		item.data.tag = tag
		
		
	end
	if(item.data.range_z == nil) then item.data.range_z = 0 end
	if(item.data.step == nil) then item.data.step = {} end
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	if ImGui.BeginMenuBar() then 
		
		
		if ImGui.MenuItem(getLang("Clear saved housing items for that place")) and item.data.tag ~= "" then
			local index = nil
			
			for i=1,#currentSave.arrayHousing do
				
				if(currentSave.arrayHousing[i].HouseTag == item.data.tag) then
					index = i
				end
				
			end
			
			if(index ~= nil) then
				table.remove(currentSave.arrayHousing, index)
				
			end
		end
		ImGui.EndMenuBar()
		
	end
	
	ImGui.Text("Type : "..types)
	
	if ImGui.BeginTabBar("EditorPlaceTabs", ImGuiTabBarFlags.NoTooltip) then
		
		
		
		if ImGui.BeginTabItem("Fields") then
			item.data.name = ImGui.InputText(getLang("editor_Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
			item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
			item.data.showMappin = ImGui.Checkbox(getLang("Show Mappin on Map (Mappin Variant is based on place type) ?"), item.data.showMappin)
			
			ImGui.Separator()
			if ImGui.BeginCombo("##My ComboBox2", placetype) then -- Remove the ## if you'd like for the title to display above combo box
				
				if ImGui.Selectable("House", (item.data.type == 0)) then
					item.data.type = 0
					placetype = "House"
					ImGui.SetItemDefaultFocus()
				end
				if ImGui.Selectable("Bar", (item.data.type == 1)) then
					item.data.type = 1
					placetype = "Bar"
					ImGui.SetItemDefaultFocus()
				end
				if ImGui.Selectable("Nightclub", (item.data.type == 2)) then
					item.data.type = 2
					placetype = "Nightclub"
					ImGui.SetItemDefaultFocus()
				end
				if ImGui.Selectable("Restaurant", (item.data.type == 3)) then
					item.data.type = 3
					placetype = "Restaurant"
					ImGui.SetItemDefaultFocus()
				end
				if ImGui.Selectable("Shop/Mall", (item.data.type == 4)) then
					item.data.type = 4
					placetype = "Shop/Mall"
					ImGui.SetItemDefaultFocus()
				end
				if ImGui.Selectable("Special", (item.data.type == 5)) then
					item.data.type = 5
					placetype = "Special"
					ImGui.SetItemDefaultFocus()
				end
				
				
				ImGui.EndCombo()
			end
			
			
			ImGui.Separator()
			if ImGui.TreeNode("Positions") then
				if ImGui.TreeNode("House Location") then
					item.data.x = ImGui.InputFloat(getLang("editor_x"), item.data.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.y = ImGui.InputFloat(getLang("editor_y"), item.data.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.z = ImGui.InputFloat(getLang("editor_z"), item.data.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					
					
					
					
					if ImGui.Button(getLang("editor_copy_player_location"), 300, 0) then
						
						local vec4 = Game.GetPlayer():GetWorldPosition()
						item.data.x = vec4.x
						item.data.y = vec4.y
						item.data.z = vec4.z
						
						
					end
					
					ImGui.TreePop(1)
				end
				
				ImGui.Separator()
				if ImGui.TreeNode("Entrance Position") then
					item.data.enter_x = ImGui.InputFloat(getLang("editor_Place_enter_x"), item.data.enter_x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.enter_y = ImGui.InputFloat(getLang("editor_Place_enter_y"), item.data.enter_y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.enter_z = ImGui.InputFloat(getLang("editor_Place_enter_z"), item.data.enter_z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					
					if ImGui.Button(getLang("editor_Place_Enter_copy"), 300, 0) then
						
						local vec4 = Game.GetPlayer():GetWorldPosition()
						item.data.enter_x = vec4.x
						item.data.enter_y = vec4.y
						item.data.enter_z = vec4.z
						
						
					end
					ImGui.TreePop(1)
				end
				
				ImGui.Separator()
				
				if ImGui.TreeNode("Exit Position") then
					item.data.exit_x = ImGui.InputFloat(getLang("editor_Place_exit_x"), item.data.exit_x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.exit_y = ImGui.InputFloat(getLang("editor_Place_exit_y"), item.data.exit_y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.exit_z = ImGui.InputFloat(getLang("editor_Place_exit_z"), item.data.exit_z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					
					if ImGui.Button(getLang("editor_Place_Exit_copy"), 300, 0) then
						
						local vec4 = Game.GetPlayer():GetWorldPosition()
						item.data.exit_x = vec4.x
						item.data.exit_y = vec4.y
						item.data.exit_z = vec4.z
						
						
					end
					ImGui.TreePop(1)
				end
				
				ImGui.Separator()
				
				if ImGui.TreeNode("Ranges") then
					item.data.range = ImGui.InputFloat(getLang("editor_Place_range"), item.data.range, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					
					item.data.range_z = ImGui.InputFloat(getLang("editor_Place_range_z"), item.data.range_z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					
					ImGui.TreePop(1)
				end
				
				ImGui.TreePop(1)
			end
			
			
			
			ImGui.Separator()
			if ImGui.TreeNode("Prices, rent and coefs") then
				ImGui.Text(getLang("editor_Place_Coef_msg01"))
				ImGui.Text(getLang("editor_Place_Coef_msg02"))
				
				
				item.data.coef = ImGui.InputFloat(getLang("editor_Place_Coef"), item.data.coef, 1, 10, "%.3f", ImGuiInputTextFlags.None)
				item.data.isbuyable = ImGui.Checkbox(getLang("editor_Place_isbuyable"), item.data.isbuyable)
				if(item.data.isbuyable == true) then
					
					item.data.price = ImGui.InputFloat(getLang("editor_Place_price"), item.data.price, 1, 10, "%.3f", ImGuiInputTextFlags.None)
					item.data.isrentable = ImGui.Checkbox(getLang("editor_Place_isrentable"), item.data.isrentable)
					if(item.data.isrentable == true) then
						ImGui.Text(getLang("editor_Place_isrentable_msg"))
						item.data.rent = ImGui.InputFloat(getLang("editor_Place_rent"), item.data.rent, 1, 10, "%.3f", ImGuiInputTextFlags.None)
						
					end
				end
				
				ImGui.TreePop(1)
			end
			ImGui.Separator()
			if ImGui.TreeNode("Triggers, Actions and Context") then
				
				editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
				
				editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
				
				editor.actionNode(getLang("Spawn Actions"),item.data,"action",item.data.tag,tag)
				
				editor.contextNode("Context",item.data,"context",item.data.tag,tag)
				
				ImGui.TreePop(1)
			end
			
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem("Housing Steps") then
			ImGui.Text("You can add housing step to your place. It means the player can upgrade his house to different steps. \n For example Low life House to Palace Style House. \n This is manageable in Ez Estate Web page on V's computer")
			if ImGui.BeginChild("steps", 400, 400,true) then
				
				
				
				if ImGui.TreeNode("Housing Steps") then
					for i,step in ipairs(item.data.step) do
						
						
						if ImGui.TreeNode(step.title) then
							
							
							if ImGui.Button("Load") then
								newhousestep = deepcopy(step,nil)
								newhousestep.index = i
							end
							
							if ImGui.Button("Delete (From Loaded Cache)") then
								item.data.step[i] = nil
							end
							
							ImGui.TreePop()
						end
						
						
						
						
					end
					ImGui.TreePop()
				end
				
				
				
				
				
				
				ImGui.EndChild()
			end
			
			
			
			ImGui.SameLine()
			
			if ImGui.BeginChild("stepsedit", 400, 400,true) then
				newhousestep.title = ImGui.InputText(getLang("Title"), newhousestep.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
				newhousestep.price = ImGui.InputInt("Price", newhousestep.price, 1,10, ImGuiInputTextFlags.None)
				newhousestep.desc = ImGui.InputText(getLang("Description"), newhousestep.desc, 1000, ImGuiInputTextFlags.AutoSelectAll)
				newhousestep.template = ImGui.InputText(getLang("Template Tag"), newhousestep.template, 5000, ImGuiInputTextFlags.AutoSelectAll)
				
				newhousestep.anchor.x = ImGui.InputInt("Anchor Point X", newhousestep.anchor.x, 1,10, ImGuiInputTextFlags.None)
				newhousestep.anchor.y = ImGui.InputInt("Anchor Point Y", newhousestep.anchor.y, 1,10, ImGuiInputTextFlags.None)
				newhousestep.anchor.z = ImGui.InputInt("Anchor Point Z", newhousestep.anchor.z, 1,10, ImGuiInputTextFlags.None)
				
				if(newhousestep.index == nil) then
					if ImGui.Button("Add new step", 300, 0) then
						table.insert(item.data.step,deepcopy(newhousestep,nil))
						
						newhousestep = {}
						newhousestep.title = ""
						newhousestep.price = 0
						newhousestep.desc = ""
						newhousestep.template = ""
						newhousestep.anchor = {}
						newhousestep.anchor.x = 0
						newhousestep.anchor.y = 0
						newhousestep.anchor.z = 0
						
					end
					else
					if ImGui.Button("Edit step", 300, 0) then
						local objstep = deepcopy(newhousestep,nil)
						objstep.index = nil
						item.data.step[newhousestep.index] = objstep
						
						newhousestep = {}
						newhousestep.title = ""
						newhousestep.price = 0
						newhousestep.desc = ""
						newhousestep.template = ""
						newhousestep.anchor = {}
						newhousestep.anchor.x = 0
						newhousestep.anchor.y = 0
						newhousestep.anchor.z = 0
						
					end
				end
				
			end
			ImGui.EndChild()
			
			
			
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem("Rooms") then
			editor.RoomNode(getLang("Rooms"),getLang("Rooms"),item.data,"rooms",tag)
			
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem("Current Placed Items") then
			
			editor.ItemNode("Current Placed Items",item,currentItemSpawned,tag,tag,tag,item.scripttype)
			
			
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem("Associated Housing Script") then
			if ImGui.TreeNode("Associated Housing Script") then
				for k,v in pairs(cyberscript.cache["housing"]) do
					
					if(v.data.target == tag) then
						
						if ImGui.TreeNode(k) then
							
							ImGui.Text("File : "..tostring(v.file))
							ImGui.Text("Datapack : "..tostring(v.datapack))
							
							if ImGui.Button("Open") then
								currentScript["housing"][k] = deepcopy(v,nil)
							end
							
							if ImGui.Button("Delete (From Loaded Cache)") then
								array[k] = nil
							end
							
							if ImGui.Button("Delete (From Cache, if existing json file still in folder, it will be regenerated at next cache check)") then
								arrayDatapack[v.datapack][title][v.file] = nil
							end
							
							ImGui.TreePop()
						end
						
					end
					
					
				end
				ImGui.TreePop()
			end
			
			
			ImGui.EndTabItem()
		end
		
		if ImGui.BeginTabItem("Associated Template Script") then
			if ImGui.TreeNode("Associated Template Script") then
				for k,v in pairs(cyberscript.cache["housing_template"]) do
					
					if(v.data.target == tag) then
						
						if ImGui.TreeNode(k) then
							
							ImGui.Text("File : "..tostring(v.file))
							ImGui.Text("Datapack : "..tostring(v.datapack))
							
							if ImGui.Button("Open") then
								currentScript["housing_template"][k] = deepcopy(v,nil)
							end
							
							if ImGui.Button("Delete (From Loaded Cache)") then
								array[k] = nil
							end
							
							if ImGui.Button("Delete (From Cache, if existing json file still in folder, it will be regenerated at next cache check)") then
								arrayDatapack[v.datapack][title][v.file] = nil
							end
							
							ImGui.TreePop()
						end
						
					end
					
					
				end
				ImGui.TreePop()
			end
			
			
			ImGui.EndTabItem()
		end
		
		ImGui.EndTabBar()
	end
	
	
	
end

function editor.editorfunction.poi(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Type : "..types)
	item.data.desc = ImGui.InputText(getLang("editor_Name"), item.data.desc, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.isFor = ImGui.InputInt(getLang("editor_POI_isFor"),item.data.isFor, 1, 10, ImGuiInputTextFlags.None)
	
	
	
	editor.listLocationsNode(getLang("editor_POI_locations"),"locations list",item.data,"locations")
	
end

function editor.editorfunction.radio(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data= {}
		item.data.name = tag
		item.data.tag = tag
		item.data.only_in_car = false
		item.data["tracks"] = {}
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	item.data.name = ImGui.InputText(getLang("editor_Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.tag = ImGui.InputText(getLang("editor_tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.only_in_car = ImGui.Checkbox(getLang("Only played in car radio ?"), item.data.only_in_car)
	
	
	
	
	ImGui.Separator()
	
	ImGui.Text("Tracks : ")
	
	
	if ImGui.BeginChild("dispslayoption", 600, 100+(#item.data.tracks+1)*20,true) then
		
		if item.data["tracks"] == nil then item.data["tracks"] = {} end
		if ImGui.TreeNode(title) then
			
			
			
			if( #item.data["tracks"] > 0) then
				
				
				for i = 1, #item.data["tracks"] do 
					if ImGui.TreeNode(item.data["tracks"][i].name.." ("..tostring(i)..")") then
						
						
						
						
						
						
						
						if ImGui.Button("Edit", 50, 0) then
							newtrack = deepcopy(item.data["tracks"][i])
							newtrack.index  = i
							
						end
						
						ImGui.SameLine()
						if ImGui.Button("Delete", 50, 0) then
							
							table.remove(item.data["tracks"],i)
							
						end
						
						
						
						ImGui.TreePop()
					end
					
					
					
					ImGui.PopStyleColor(1)
					
				end
			end
			
			
			ImGui.TreePop()
		end
		
	end
	ImGui.EndChild()
	ImGui.SameLine()
	if ImGui.BeginChild("newtracks", 600, 200,true) then
		
		newtrack.name = ImGui.InputText(getLang("editor_Name"), newtrack.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		newtrack.file = ImGui.InputText(getLang("File"), newtrack.file, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		if(newtrack.index == nil) then
			
			if ImGui.Button("Add new Track", 300, 0) then
				
				local objact = deepcopy(newtrack,nil) 
				
				table.insert(item.data.tracks,objact)
				newtrack.index = nil
				newtrack.name = ""
				newtrack.file = ""
			end
			
			else
			
			if ImGui.Button("Edit Track", 300, 0) then
				
				local objact = deepcopy(newtrack,nil) 
				objact.index = nil
				item.data.tracks[newtrack.index] = objact
				newtrack.index = nil
				newtrack.name = ""
				newtrack.file = ""
			end
			
		end
		
	end
	ImGui.EndChild()
	
	
	
	
end

function editor.editorfunction.scene(item,tag,types)
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		
		item.data.tag = tag
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	
	ImGui.Text("Type : "..types)
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.isbraindance =  ImGui.Checkbox(getLang("Is a Braindance Scene ?"), item.data.isbraindance)
	
	ImGui.Separator()
	ImGui.Text("Steps : ")
	
	if ImGui.BeginChild("steps", 400, 400,true) then
		
		
		
		if ImGui.TreeNode("Steps") then
			for i,step in ipairs(item.data.step) do
				
				
				if ImGui.TreeNode(step.tag) then
					
					
					if ImGui.Button("Load") then
						newscenestep = deepcopy(step,nil)
						newscenestep.index = i
					end
					
					if ImGui.Button("Delete (From Loaded Cache)") then
						item.data.step[i] = nil
					end
					
					ImGui.TreePop()
				end
				
				
				
				
			end
			ImGui.TreePop()
		end
		
		
		
		
		
		
		ImGui.EndChild()
	end
	
	
	
	ImGui.SameLine()
	
	if ImGui.BeginChild("stepsedit", 400, 400,true) then
		newscenestep.tag = ImGui.InputText(getLang("Title"), newscenestep.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		editor.actionNode(getLang("Actions"),newscenestep,"action",newscenestep.tag,tag)
		
		
		
		if(newscenestep.index == nil) then
			if ImGui.Button("Add new step", 300, 0) then
				newscenestep.index = #item.data.step+1
				table.insert(item.data.step,deepcopy(newscenestep,nil))
				
				newscenestep = {}
				newscenestep.tag = ""
				newscenestep.action = {}
				
			end
			else
			if ImGui.Button("Edit step", 300, 0) then
				local objstep = deepcopy(newscenestep,nil)
				
				item.data.step[newscenestep.index] = objstep
				
				newscenestep = {}
				newscenestep.tag = ""
				newscenestep.action = {}
				
			end
		end
		
		ImGui.EndChild()
	end
	
	
	
	
	
	
end

function editor.editorfunction.setting(item,tag,types)
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-settings", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		
		item.data.tag = tag
		
		item.data.category = tag
		item.data.categorylibelle = tag
		
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Type : "..types)
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	if ImGui.BeginCombo("##My ComboBox2", item.data.type) then -- Remove the ## if you'd like for the title to display above combo box
		
		if ImGui.Selectable("button", (item.data.type == "button")) then
			item.oldtype =	item.data.type
			item.data.type = "button"
			
			ImGui.SetItemDefaultFocus()
		end
		if ImGui.Selectable("toggle", (item.data.type == "toggle")) then
			item.oldtype =	item.data.type
			item.data.type ="toggle"
			
			ImGui.SetItemDefaultFocus()
		end
		if ImGui.Selectable("sliderInt", (item.data.type == "sliderInt")) then
			item.oldtype =	item.data.type
			item.data.type = "sliderInt"
			
			ImGui.SetItemDefaultFocus()
		end
		if ImGui.Selectable("sliderFloat", (item.data.type == "sliderFloat")) then
			item.oldtype =	item.data.type
			item.data.type = "sliderFloat"
			
			ImGui.SetItemDefaultFocus()
		end
		if ImGui.Selectable("sliderText", (item.data.type == "sliderText")) then
			
			item.oldtype =	item.data.type
			item.data.type = "sliderText"
			ImGui.SetItemDefaultFocus()
		end
		
		
		ImGui.EndCombo()
	end
	
	item.data.category =  ImGui.InputText(getLang("Category"), item.data.category, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.categorylibelle =  ImGui.InputText(getLang("Category Libelle"), item.data.categorylibelle, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.description =  ImGui.InputText(getLang("Description"), item.data.description, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.label = ImGui.InputText(getLang("Label"), item.data.label, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	if(item.data.type == "button" and item.oldtype ~= "button") then
		item.data.buttonlabel = ""
		item.data.textsize = 45
		item.data.defaultvalue = nil
		item.data.variable = nil
		
		item.data.target = nil
		
		item.data.min = nil
		item.data.max = nil
		item.data.step = nil
		item.oldtype =	item.data.type
		
	end
	
	if(item.data.type == "toggle" and item.oldtype ~= "toggle") then
		item.data.buttonlabel = nil
		item.data.textsize = nil
		item.data.defaultvalue = true
		item.data.variable = {}
		item.data.variable.key = ""
		item.data.variable.tag = ""
		item.data.target = nil
		
		item.data.min = nil
		item.data.max = nil
		item.data.step = nil
		item.oldtype =	item.data.type
		
	end
	
	if(item.data.type == "sliderInt" and item.oldtype ~= "sliderInt") then
		item.data.buttonlabel = nil
		item.data.textsize = nil
		item.data.defaultvalue = 50
		item.data.variable = {}
		item.data.variable.key = ""
		item.data.variable.tag = ""
		item.data.target = nil
		
		item.data.min = 0
		item.data.max = 100
		item.data.step = 1
		item.oldtype =	item.data.type
		
	end
	
	if(item.data.type == "sliderFloat" and item.oldtype ~= "sliderFloat") then
		item.data.buttonlabel = nil
		item.data.textsize = nil
		item.data.defaultvalue = 50.55
		item.data.variable = {}
		item.data.variable.key = ""
		item.data.variable.tag = ""
		item.data.target = nil
		
		item.data.min = 0
		item.data.max = 100
		item.data.step = 0.1
		item.oldtype =	item.data.type
		
	end
	
	if(item.data.type == "sliderText" and item.oldtype ~= "sliderText") then
		item.data.buttonlabel = nil
		item.data.textsize = nil
		item.data.defaultvalue = 1
		item.data.variable = {}
		item.data.variable.key = ""
		item.data.variable.tag = ""
		item.data.target = {}
		item.data.target.key = ""
		item.data.target.tag = ""
		item.data.min = nil
		item.data.max = nil
		item.data.step = nil
		item.oldtype =	item.data.type
		
	end
	
	
	
	if(item.data.type == "button") then
		item.data.buttonlabel = ImGui.InputText(getLang("Button Label"), item.data.buttonlabel, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.textsize = ImGui.InputInt(getLang("Text Size"), item.data.textsize, 1,10, ImGuiInputTextFlags.None)
		
		
	end
	
	if(item.data.type == "toggle" ) then
		
		item.data.defaultvalue = ImGui.Checkbox(getLang("Default Value"), item.data.defaultvalue)
		
		item.data.variable.key = ImGui.InputText(getLang("Variable Key"), item.data.variable.key, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.variable.tag =ImGui.InputText(getLang("Variable Tag"), item.data.variable.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
	end
	
	if(item.data.type == "sliderInt") then
		
		item.data.defaultvalue = ImGui.InputInt(getLang("Default Value"), item.data.textsize, 1,10, ImGuiInputTextFlags.None)
		
		item.data.variable.key = ImGui.InputText(getLang("Variable Key"), item.data.variable.key, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.variable.tag =ImGui.InputText(getLang("Variable Tag"), item.data.variable.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.data.min = ImGui.InputInt(getLang("Min"), item.data.textsize, 1,10, ImGuiInputTextFlags.None)
		item.data.max = ImGui.InputInt(getLang("Max"), item.data.textsize, 1,10, ImGuiInputTextFlags.None)
		item.data.step = ImGui.InputInt(getLang("Step"), item.data.textsize, 1,10, ImGuiInputTextFlags.None)
		
	end
	
	if(item.data.type == "sliderFloat") then
		
		item.data.defaultvalue = ImGui.InputFloat("Default Value", item.data.defaultvalue, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
		item.data.variable.key = ImGui.InputText(getLang("Variable Key"), item.data.variable.key, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.variable.tag =ImGui.InputText(getLang("Variable Tag"), item.data.variable.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.data.min = ImGui.InputFloat("Min", item.data.min, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.data.max =ImGui.InputFloat("Max", item.data.max, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		item.data.step = ImGui.InputFloat("Step", item.data.step, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
	end
	
	if(item.data.type == "sliderText") then
		
		
		item.data.defaultvalue = ImGui.InputInt(getLang("Default Value"), item.data.textsize, 1,10, ImGuiInputTextFlags.None)
		
		item.data.variable.key = ImGui.InputText(getLang("Variable Key"), item.data.variable.key, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.variable.tag =ImGui.InputText(getLang("Variable Tag"), item.data.variable.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		item.data.target.key = ImGui.InputText(getLang("Target Key"), item.data.target.key, 5000, ImGuiInputTextFlags.AutoSelectAll)
		item.data.target.tag =ImGui.InputText(getLang("Target Tag"), item.data.target.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		
	end
	
	
	
	
	editor.actionNode(getLang("Actions"),item.data,"action",item.data.tag,tag)
	
	
	
end

function editor.editorfunction.shard(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-shard", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
		
	end
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-codex", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("Type : "..types)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.title = ImGui.InputText(getLang("title"), item.data.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.description = ImGui.InputText(getLang("description"), item.data.description, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.locked =  ImGui.Checkbox("Locked ?", item.data.locked)
	item.data.new =  ImGui.Checkbox("New ?", item.data.new)
	item.data.crypted =  ImGui.Checkbox("Crypted ?", item.data.crypted)
	
	editor.contextNode("Context",item.data,"context",tag,item.contextscript)
	
	
end

function editor.editorfunction.sound(item,tag,types)
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		item.data.language.default = tag
	end
	
	local functions = {}
	
	
	functions["after_save"] = function(item,tag,types,obj)
		local list = {} table.insert(list,obj)
		arrayDatapack[cyberscript.cache["sound"][item.sound.tag].datapack][types][item.sound.tag] = list
	end
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	ImGui.Text("Type : "..types)
	
	
	item.data.tag = ImGui.InputText(getLang("Tag (Need to be the same name than the file in archive)"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.duration =  ImGui.InputFloat(getLang("Duration"), item.data.duration, 0.1, 10, "%.3f", ImGuiInputTextFlags.None)
	
	editor.listDictionnaryNode(getLang("Language","For each language, you can define another sound filename to play instead of the default one",item.data,"language"))
	
	ImGui.Separator()
	
	if ImGui.BeginCombo(getLang("Add Language"), "") then
		
		
		
		for i,lang in ipairs(langcategory) do
			
			if ImGui.Selectable(lang) then
				if item.data.language[lang] == nil then item.data.language[lang] = "" end
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	
	
end

function editor.editorfunction.texture(item,tag,types)
	if ImGui.BeginMenuBar() then 
		
		if ImGui.MenuItem("Close") then
			
			currentScript[types][tag] = nil
			
		end
		
		
		
		
		
		
		
		ImGui.EndMenuBar()
		
	end
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("For Add Texture, simply drop image files into a 'texture' folder in your datapack :D")
	
end

function editor.editorfunction.webpage(item,tag,types)
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	
	if(item.data == nil) then
		item.data =  deepcopy(scripttemplate[types],nil)
		item.data.tag = tag
		
	end
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	
	ImGui.Text("Type : "..types)
	
	
	item.data.name = ImGui.InputText(getLang("Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.target = ImGui.InputText(getLang("Targeted Interface Tag"), item.data.target, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	
	if ImGui.TreeNode("Triggers, and requirements") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		ImGui.TreePop(1)
	end
	
	
end

function editor.editorfunction.email(item,tag,types)
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	ImGui.Text("WIP, come back later :X")
	
end

function editor.editorfunction.quickhack(item,tag,types)
	
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-quickhack", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
		item.data.title = tag
		item.data.titlealternative = tag
		
		
	end
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	
	ImGui.Text("Type : "..types)
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.icon =  ImGui.InputText(getLang("Icon"), item.data.icon, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.title =  ImGui.InputText(getLang("Title"), item.data.title, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.titlealternative =  ImGui.InputText(getLang("Alternative Title"), item.data.titlealternative, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.description =  ImGui.InputText(getLang("Description"), item.data.description, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.inactiveReason = ImGui.InputText(getLang("Reason if inactive"), item.data.inactiveReason, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	item.data.icelevelvisible =  ImGui.Checkbox(getLang("ICE Level Visible ?"), item.data.icelevelvisible)
	item.data.networkbreached = ImGui.Checkbox(getLang("Need Network Breached ?"), item.data.networkbreached)
	item.data.isinstant = ImGui.Checkbox(getLang("Is Instant ?"), item.data.isinstant)
	
	-- item.data.actiontype =  ImGui.InputInt("Action Type", item.data.actiontype, 1,10, ImGuiInputTextFlags.None)
	item.data.cost = ImGui.InputInt("Cost", item.data.cost, 1,10, ImGuiInputTextFlags.None)
	item.data.uploadtime =  ImGui.InputInt("Upload Time", item.data.uploadtime, 1,10, ImGuiInputTextFlags.None)
	item.data.duration = ImGui.InputInt("Duration", item.data.duration, 1,10, ImGuiInputTextFlags.None)
	-- item.data.iceLevel = ImGui.InputInt("ICE Level", item.data.iceLevel, 1,10, ImGuiInputTextFlags.None)
	-- item.data.quality =  ImGui.InputInt("Quality", item.data.quality, 1,10, ImGuiInputTextFlags.None)
	item.data.cooldown =  ImGui.InputInt("Cooldown", item.data.cooldown, 1,10, ImGuiInputTextFlags.None)
	
	
	
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.triggerNode(getLang("Unlock Triggers"),item.data,"unlocktrigger",item.data.tag,tag)
		
		editor.requirementNode("Unlock "..getLang("trigger_condition_requirement"),item.data,"unlockrequirement","unlocktrigger",tag)
		
		editor.actionNode(getLang("Spawn Actions"),item.data,"action",item.data.tag,tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
end

function editor.editorfunction.garage(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://cyberscript77.github.io/wiki/#/create-custom-garage-entry", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		item.data.name = tag
		item.data.tag = tag
	end
	
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	ImGui.Text("Type : "..types)
	item.data.name = ImGui.InputText(getLang("Name"), item.data.name, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	item.data.type = ImGui.SliderInt(getLang("Type : Bike = 0, Car = 1 "), item.data.type, 0,1)
	item.data.tweak = ImGui.InputText(getLang("TweakDB"), item.data.tweak, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	
	if ImGui.TreeNode("Triggers, Actions and Context") then
		
		editor.triggerNode(getLang("Triggers"),item.data,"trigger",item.data.tag,tag)
		
		editor.requirementNode(getLang("trigger_condition_requirement"),item.data,"requirement","trigger",tag)
		
		editor.actionNode(getLang("Spawn Actions"),item.data,"action",item.data.tag,tag)
		
		editor.contextNode("Context",item.data,"context",item.data.tag,tag)
		
		ImGui.TreePop(1)
	end
	
end

function editor.editorfunction.ai(item,tag,types)
	
	
	ImGui.Text("Wiki link : ") ImGui.SameLine() editortext = ImGui.InputText("##wikilink", "https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/chatgpt?pivots=programming-language-chat-completions#system-role", 5000, ImGuiInputTextFlags.ReadOnly) ImGui.Separator()
	if(item.data == nil) then
		item.data = deepcopy(scripttemplate[types],nil)
		
		item.data.tag = tag
	end
	
	
	
	local functions = {}
	
	
	
	editor.scripttoolbar(item,tag,types,functions)
	
	
	item.data.tag = ImGui.InputText(getLang("Tag"), item.data.tag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	
	editor.listAIContext("AI Contexts","Add your AI contexts here",item.data,"contexts")
	
end

function editor.listAIContext(title,help,obj,parent)
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				ImGui.Text(i.."> "..obj[parent][i].context_type.." - "..obj[parent][i].value)
				
				if ImGui.Button("Edit".."##"..i) then
					
					editorContextAIEdit = i
					editorContextTypeDefault = obj[parent][i].context_type
					editorContextValue = obj[parent][i].value
					
				end
				
				if ImGui.Button("Delete".."##"..i) then
					
					table.remove(obj[parent],i)
					
				end
				
				editor.contextNode("Context",obj[parent][i],"context",obj.tag,obj.tag)
				
				
				
				
			end
		end
		
		--	ImGui.Text("Add "..title.." : ")
		ImGui.TreePop()
	end
	ImGui.Separator()
	ImGui.Text("Add a new context")
	
	if ImGui.BeginCombo(getLang("Context Type"), editorContextTypeDefault) then
		
		
		for k,v in ipairs(editorContextType) do
			
			if ImGui.Selectable(v, (editorContextTypeDefault  == v)) then
				editorContextTypeDefault  = v
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	ImGui.SameLine()
	if ImGui.Button("Save") then
		local itemAI = {}
		itemAI.context_type = editorContextTypeDefault
		itemAI.value = editorContextValue
		if(editorContextAIEdit ~= nil) then
			obj[parent][editorContextAIEdit] = itemAI
			else
			table.insert(obj[parent],itemAI)
		end
		editorContextValue = ""
		editorContextAIEdit = nil
	end
	ImGui.SameLine()
	if ImGui.Button("Clear") then
		
		editorContextValue = ""
		editorContextAIEdit = nil
	end
	editorContextValue = ImGui.InputTextMultiline("Context Value", editorContextValue, 5000, 1000, 300, ImGuiInputTextFlags.AutoSelectAll)
	
	
end

function editor.listStringNode(title,help,obj,parent,multiline)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				ImGui.Text("> "..obj[parent][i])
				
				ImGui.SameLine()
				
				if ImGui.Button("Delete") then
					
					table.remove(obj[parent],i)
					
				end
				
				
				
				
				
			end
		end
		
		--	ImGui.Text("Add "..title.." : ")
		
		if(multiline == nil or multiline == false) then
			
			if ImGui.BeginChild("simpletextstring", 400, 20, false) then
				newRequirementItem = ImGui.InputText("Add "..title, newRequirementItem, 50, ImGuiInputTextFlags.AutoSelectAll)
			end
			ImGui.EndChild()
			ImGui.SameLine()
			else
			newRequirementItem = ImGui.InputTextMultiline(title, newRequirementItem, 100, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
		end
		if ImGui.Button("Add") then
			
			table.insert(obj[parent],newRequirementItem)
			newRequirementItem = ""
		end
		
		ImGui.TreePop()
	end
	
end

function editor.listVIPNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				if ImGui.Button("Delete "..obj[parent][i].name, 300, 0) then
					
					table.remove(obj[parent],i)
					
				end
				
				
				
				
				
			end
		end
		
		ImGui.Text("New VIP :")
		editorpnjsearch = ImGui.InputText(getLang("PNJ Filter"), editorpnjsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
		if ImGui.BeginCombo(getLang("editor_NPC"), genericVIPname) then
			
			
			for k,v in pairs(cyberscript.entitieshash) do
				if (editorpnjsearch == "" or (editorpnjsearch ~= "" and ( (string.match(string.lower(v.entity_name),editorpnjsearch))))) then
					if ImGui.Selectable(v.entity_name, (genericVIPname  == v.entity_name)) then
						genericVIPname  = v.entity_name
						ImGui.SetItemDefaultFocus()
					end
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		--	genericVIPname = ImGui.InputText(getLang("editor_Name"),genericVIPname, 5000, ImGuiInputTextFlags.AutoSelectAll)
		genericVIPscore = ImGui.InputInt("Score", genericVIPscore, 1,10, ImGuiInputTextFlags.None)
		
		if ImGui.Button("Add", 300, 0) then
			local objvip = {}
			objvip.name = genericVIPname
			objvip.score = genericVIPscore
			table.insert(obj[parent],objvip)
			
		end
		
		ImGui.TreePop()
	end
	
end


function editor.HelpSectionNode(title,help,obj,parent)
	ImGui.Text(help)
	if ImGui.TreeNode(title) then
		
		
		
		if(#obj[parent] > 0) then
			for i = 1, #obj[parent] do 
				
				if ImGui.TreeNode("section "..i) then
					
					obj[parent][i].message = ImGui.InputTextMultiline("section message "..i, obj[parent][i].message, 1000, 600, 200, ImGuiInputTextFlags.AutoSelectAll)
					
					editor.actionNode(getLang("Actions"),obj[parent][i],"action",parent,parent)
					
					if ImGui.Button("Delete", 300, 0) then
						
						table.remove(obj[parent],i)
						
					end
					ImGui.TreePop()
				end
				ImGui.Separator()
				
				
				
				
			end
		end
		
		
		
		ImGui.TreePop()
	end
	
	ImGui.Text("Add Section :")
	
	helpsectionNode = ImGui.InputText(getLang("editor_Name"),helpsectionNode, 5000, ImGuiInputTextFlags.AutoSelectAll)
	editor.actionNode(getLang("Actions"),helpsectionNodeAction,"action",parent,parent)
	
	if ImGui.Button("Add", 300, 0) then
		
		local objvip = {}
		objvip.message = helpsectionNode
		objvip.action = helpsectionNodeAction.action
		table.insert(obj[parent],objvip)
		helpsectionNodeAction.action = {}
	end
	
end

function editor.listLocationsNode(title,help,obj,parent)
	ImGui.Text(help)
	
	
	
	if ImGui.BeginChild("log", 600, 300) then
		
		
		if ImGui.TreeNode(title) then
			
			
			
			if(#obj[parent] > 0) then
				for i = 1, #obj[parent] do 
					
					if(obj.tag == obj[parent][i].Tag) then obj[parent][i].Tag = obj[parent][i].Tag.."_"..i end
					
					if ImGui.TreeNode(obj[parent][i].Tag) then
						
						for key,prop in pairs(obj[parent][i]) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end			
						
						if ImGui.Button("Delete "..obj[parent][i].Tag) then
							
							table.remove(obj[parent],i)
							
						end
						
						
						
						ImGui.SameLine()
						
						if ImGui.Button("Edit "..obj[parent][i].Tag) then
							
							genericLocation = deepcopy(obj[parent][i],nil)
							
							
							genericLocation.index = i
							
						end
						
						
						if ImGui.Button("TP To "..obj[parent][i].Tag) then
							
							local loca = {}
							loca.x = obj[parent][i].x 
							loca.y = obj[parent][i].y 
							loca.z = obj[parent][i].z 
							
							teleportTo(Game.GetPlayer(), loca, 1,true)
							
							
						end
						ImGui.SameLine()
						if ImGui.Button("Correct District and Subdistrict from current location") then
							
							
							
							obj[parent][i].district = getVariableKey("current_district","enum")
							obj[parent][i].subdistrict = getVariableKey("current_district","subdistrict_enum")
							
							
						end
						
						ImGui.TreePop()
					end
					
					
				end
			end
			ImGui.TreePop()
		end
		
	end
	ImGui.EndChild()
	
	ImGui.SameLine()
	
	if ImGui.BeginChild("log2", 400, 300) then
		if(genericLocation.index ~= nil) then
			ImGui.Text("Edit Location :"..genericLocation.Tag)
			if ImGui.Button("Save changes for"..genericLocation.Tag) then
				
				obj[parent][genericLocation.index] = genericLocation
				
			end
			
			if ImGui.Button("Unselect location "..genericLocation.Tag) then
				
				genericLocation = {}
				genericLocation.x = 0
				genericLocation.y = 0
				genericLocation.z = 0
				genericLocation.district = "Watson"
				genericLocation.subdistrict = "ArasakaWaterfront"
				genericLocation.inVehicule = false
				genericLocation.Tag = ""
				
			end
			else
			ImGui.Text("New Location ")
			
			if ImGui.Button("Clear fields") then
				
				genericLocation = {}
				genericLocation.x = 0
				genericLocation.y = 0
				genericLocation.z = 0
				genericLocation.district = "Watson"
				genericLocation.subdistrict = "ArasakaWaterfront"
				genericLocation.inVehicule = false
				genericLocation.Tag = ""
				
			end
		end
		
		
		genericLocation.Tag = obj.tag.."_"..tostring(#obj[parent]+1)
		
		ImGui.Text("Tag : "..genericLocation.Tag) 
		
		genericLocation.inVehicule = ImGui.Checkbox("in Vehicule", genericLocation.inVehicule)
		
		
		
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		genericLocation.district = ImGui.InputText(getLang("District"),genericLocation.district, 500, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		genericLocation.subdistrict = ImGui.InputText(getLang("SubDistrict"),genericLocation.subdistrict, 500, ImGuiInputTextFlags.AutoSelectAll)
		
		
		ImGui.Spacing()
		ImGui.Text("X : ") 
		ImGui.SameLine()
		genericLocation.x = ImGui.InputFloat("##locx", genericLocation.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Y : ") 
		ImGui.SameLine()
		genericLocation.y = ImGui.InputFloat("##locy", genericLocation.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Z : ") 
		ImGui.SameLine()
		genericLocation.z = ImGui.InputFloat("##loccz", genericLocation.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			
			
			genericLocation.x = vec4.x
			genericLocation.y =vec4.y
			genericLocation.z = vec4.z
			
			genericLocation.district = getVariableKey("current_district","enum")
			genericLocation.subdistrict = getVariableKey("current_district","subdistrict_enum")
		end
		
		
		
		
		
		
		if ImGui.Button("Add", 300, 0) then
			local objq = deepcopy(genericLocation,nil)
			objq.index = nil
			table.insert(obj[parent],objq)
			
			genericLocation = {}
			genericLocation.x = 0
			genericLocation.y = 0
			genericLocation.z = 0
			genericLocation.district = "Watson"
			genericLocation.subdistrict = "ArasakaWaterfront"
			genericLocation.inVehicule = false
			genericLocation.Tag = ""
		end
		
		
	end
	ImGui.EndChild()
end

function editor.listPathLocationsNode(title,help,obj,parent)
	ImGui.Text(help)
	
	
	
	if ImGui.BeginChild("log", 600, 300) then
		
		
		if ImGui.TreeNode(title) then
			
			
			
			if(#obj[parent] > 0) then
				for i = 1, #obj[parent] do 
					
					if(obj.tag == obj[parent][i].Tag) then obj[parent][i].Tag = obj[parent][i].Tag.."_"..i end
					
					if ImGui.TreeNode(obj[parent][i].Tag) then
						
						for key,prop in pairs(obj[parent][i]) do
							
							ImGui.Text(key.." : "..tostring(prop))
							
						end			
						
						if ImGui.Button("Delete "..obj[parent][i].Tag) then
							
							table.remove(obj[parent],i)
							
						end
						
						
						
						ImGui.SameLine()
						
						if ImGui.Button("Edit "..obj[parent][i].Tag) then
							
							genericLocation = deepcopy(obj[parent][i],nil)
							
							
							genericLocation.index = i
							
						end
						
						
						if ImGui.Button("TP To "..obj[parent][i].Tag) then
							
							local loca = {}
							loca.x = obj[parent][i].x 
							loca.y = obj[parent][i].y 
							loca.z = obj[parent][i].z 
							
							teleportTo(Game.GetPlayer(), loca, 1,true)
							
							
						end
						ImGui.SameLine()
						if ImGui.Button("Correct District and Subdistrict from current location") then
							
							
							
							obj[parent][i].district = getVariableKey("current_district","enum")
							obj[parent][i].subdistrict = getVariableKey("current_district","subdistrict_enum")
							
							
						end
						
						ImGui.TreePop()
					end
					
					
				end
			end
			ImGui.TreePop()
		end
		
	end
	ImGui.EndChild()
	
	ImGui.SameLine()
	
	if ImGui.BeginChild("log2", 400, 300) then
		if(genericLocation.index ~= nil) then
			ImGui.Text("Edit Location :"..genericLocation.Tag)
			if ImGui.Button("Save changes for"..genericLocation.Tag) then
				
				obj[parent][genericLocation.index] = genericLocation
				
			end
			
			if ImGui.Button("Unselect location "..genericLocation.Tag) then
				
				genericLocation = {}
				genericLocation.x = 0
				genericLocation.y = 0
				genericLocation.z = 0
				genericLocation.district = "Watson"
				genericLocation.subdistrict = "ArasakaWaterfront"
				genericLocation.inVehicule = false
				genericLocation.Tag = ""
				
			end
			else
			ImGui.Text("New Location ")
			
			if ImGui.Button("Clear fields") then
				
				genericLocation = {}
				genericLocation.x = 0
				genericLocation.y = 0
				genericLocation.z = 0
				genericLocation.district = "Watson"
				genericLocation.subdistrict = "ArasakaWaterfront"
				genericLocation.inVehicule = false
				genericLocation.Tag = ""
				
			end
		end
		
		
		genericLocation.Tag = ImGui.InputText(getLang("Location Tag"),tostring(genericLocation.Tag), 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		genericLocation.inVehicule = ImGui.Checkbox("in Vehicule", genericLocation.inVehicule)
		
		
		
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		genericLocation.district = ImGui.InputText(getLang("District"),genericLocation.district, 500, ImGuiInputTextFlags.AutoSelectAll)
		
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		genericLocation.subdistrict = ImGui.InputText(getLang("SubDistrict"),genericLocation.subdistrict, 500, ImGuiInputTextFlags.AutoSelectAll)
		
		
		ImGui.Spacing()
		ImGui.Text("X : ") 
		ImGui.SameLine()
		genericLocation.x = ImGui.InputFloat("##locx", genericLocation.x, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Y : ") 
		ImGui.SameLine()
		genericLocation.y = ImGui.InputFloat("##locy", genericLocation.y, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Z : ") 
		ImGui.SameLine()
		genericLocation.z = ImGui.InputFloat("##loccz", genericLocation.z, 1, 10, "%.3f", ImGuiInputTextFlags.None)
		
		
		if ImGui.Button("Copy Player's XYZ", 300, 0) then
			
			local vec4 = Game.GetPlayer():GetWorldPosition()
			
			
			genericLocation.x = vec4.x
			genericLocation.y =vec4.y
			genericLocation.z = vec4.z
			
			genericLocation.district = getVariableKey("current_district","enum")
			genericLocation.subdistrict = getVariableKey("current_district","subdistrict_enum")
		end
		
		
		
		
		
		
		if ImGui.Button("Add", 300, 0) then
			local objq = deepcopy(genericLocation,nil)
			objq.index = nil
			table.insert(obj[parent],objq)
			
			genericLocation = {}
			genericLocation.x = 0
			genericLocation.y = 0
			genericLocation.z = 0
			genericLocation.district = "Watson"
			genericLocation.subdistrict = "ArasakaWaterfront"
			genericLocation.inVehicule = false
			genericLocation.Tag = ""
		end
		
		
	end
	ImGui.EndChild()
end

function editor.editorWindowsManager()
	
	for k,v in pairs(editorUIManager) do
		
		if v == true then
			
			editor[k]()
			
		end
		
		
	end
	
	
	scriptWindowsManager()
	
end

function editor.ItemNode(title,obj,list,parenttag,housetag,contextscript,scripttype)
	
	if ImGui.TreeNode("Items") then
		
		
		
		
		for i,item in ipairs(list) do
			
			if ImGui.TreeNode(item.Id.." ("..tostring(i)..")") then
				if ImGui.Button("Edit") then
					local objact = {}
					objact.parenttag = parenttag
					objact.parent = list
					objact.parentitem = obj
					objact.index = i
					objact.contextscript = contextscript
					objact.item = deepcopy(item,nil)
					
					
					
					
					currentItems[parenttag.."_"..item.Tag.." ("..tostring(i)..")"] = objact
					
					
				end
				ImGui.SameLine()
				if ImGui.Button("Delete") then
					
					local housingitem = getHousing(item.Tag,item.X,item.Y,item.Z)
					
					if(housingitem ~= nil) then
						
						deleteHousing(housingitem.Id)
						table.remove(list,i)
					end
					
					despawnItemFromId(item.Id)
					table.remove(list,i)
					
					
				end
				
				ImGui.TreePop()
			end
			
		end
		
		if ImGui.Button("(Add new)", 300, 0) then
			
			
			local objact = {}
			objact.parenttag = parenttag
			objact.parent = list
			objact.parentitem = obj
			objact.index = #list+1
			objact.contextscript = contextscript
			objact.item = {}
			objact.HouseTag = housetag
			currentItems[parenttag.."_new_item".." ("..tostring(#list+1)..")"] = objact
			
		end
		
		ImGui.TreePop()
	end
	
end


function editor.listDictionnaryIntNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		
		for k,v in pairs(obj[parent]) do 
			
			ImGui.Text(k.." ")
			ImGui.SameLine()
			ImGui.Text(tostring(v))
			ImGui.SameLine()
			if ImGui.Button("Delete##"..k, 300, 0) then
				
				obj[parent][k] = nil
				
			end
			
			
			
			
			
		end
		
		
		ImGui.Text("New value :")
		
		dicKey = ImGui.InputText("Key", dicKey, 5000, ImGuiInputTextFlags.AutoSelectAll)
		dicInt = ImGui.InputInt("Value", dicInt, 1, 10, ImGuiInputTextFlags.None)
		if ImGui.Button("Add", 300, 0) then
			obj[parent][dicKey] = dicInt
			dicKey = ""
			dicInt = 0
		end
		
		ImGui.TreePop()
	end
end

function editor.listDictionnaryNode(title,help,obj,parent)
	
	if ImGui.TreeNode(title) then
		
		ImGui.Text(help)
		
		
		ImGui.Text("Key") ImGui.SameLine()	ImGui.Text("| Value")
		
		for k,v in pairs(obj[parent]) do 
			
			ImGui.Text(k)
			ImGui.SameLine()
			obj[parent][k] = ImGui.InputTextMultiline("##"..k, v, 5000, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
			ImGui.SameLine()
			if ImGui.Button("Delete") then
				
				obj[parent][k] = nil
				
			end
			
			
			
			
			
		end
		
		
		ImGui.TreePop()
	end
	
	ImGui.Text("New value :")
	
	dicKey = ImGui.InputText("Key", dicKey, 5000, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.SameLine()
	dicValue = ImGui.InputTextMultiline("Value", dicValue, 5000, 200, 35, ImGuiInputTextFlags.AutoSelectAll)
	ImGui.SameLine()
	if ImGui.Button("Add") then
		obj[parent][dicKey] = dicValue
		dicKey = ""
		dicValue = ""
	end
	
end



function editor.RoomNode(title,help,obj,key,parenttag)
	
	if ImGui.TreeNode(title) then
		
		
		if(#obj[key] > 0) then
			for i=1,#obj[key] do
				
				if ImGui.TreeNode(obj[key][i].name.." ("..tostring(i)..")") then
					if ImGui.Button("Edit", 50, 0) then
						local objact = {}
						
						objact.parenttag = parenttag
						objact.parent = obj
						objact.key = key
						objact.index = i
						objact.contextscript = parenttag
						objact.room = deepcopy(obj[key][i],nil)
						if(#objact.room.type > 0) then
							for i = 1,#objact.room.type  do
								if(objact.room.type[i] == 0) then
									objact.room.canEat = true
								end
								
								if(objact.room.type[i] == 1) then
									objact.room.canDrink = true
								end
								
								if(objact.room.type[i] == 2) then
									objact.room.canDo = true
								end
							end
							
						end
						currentPlacesRooms[parenttag.."_"..obj[key][i].name.." ("..tostring(i)..")"] = objact
						
					end
					
					ImGui.SameLine()
					if currentPlacesRooms[parenttag.."_"..obj[key][i].name.." ("..tostring(i)..")"] == nil then
						if ImGui.Button("Delete", 50, 0) then
							
							table.remove(obj[key],i)
							
						end
						else
						ImGui.Text("Currently opened in editor")
					end
					ImGui.TreePop()
				end
				
				
			end
			
		end
		ImGui.TreePop()
	end
	
	
	if ImGui.Button("(Add new)", 300, 0) then
		
		local objact = {}
		
		objact.parenttag = parenttag
		objact.parent = obj
		objact.key = key
		objact.index = #obj[key]+1
		objact.contextscript = parenttag
		objact.room = {}
		
		
		
		
		
		objact.room.canEat = false
		objact.room.canDrink = false
		objact.room.canDo = false
		objact.room.name = parenttag.."_".."new_room_"..#obj[key]+1
		objact.room.tag = parenttag.."_".."new_room_"..#obj[key]+1
		objact.room.x = 0
		objact.room.y = 0
		objact.room.z= 0
		objact.room.range = 0
		objact.room.range_z = 0
		objact.room["trigger"] = {}
		objact.room["requirement"] = {}
		objact.room["action"] = {}
		objact.room["context"] = {}
		
		currentPlacesRooms[parenttag.."_".."new_room_"..#obj[key]+1] = objact
	end
	
end


-- Misc function
function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end
function showScriptArray(array, title,search,datapack)
	
	
	local count = 0
	for k,v in pairs(array) do
		
		if((search == nil or search == "" or (search ~= "" and (string.match(string.lower(tostring(k)),search) or string.match(string.lower(tostring(v.file)),search) or string.match(string.lower(tostring(v.datapack)),search))   )) and (datapack == nil or (datapack ~= nil and tostring(v.datapack) == datapack))) then
			count = count+1
		end
	end
	
	if(count > 0) then
		ImGui.Separator()
		
		if ImGui.TreeNode(title.."("..count..")") then
			
			
			
			for k,v in pairs(array) do
				
				if((search == nil or search == "" or (search ~= "" and (string.match(string.lower(tostring(k)),search) or string.match(string.lower(tostring(v.file)),search) or string.match(string.lower(tostring(v.datapack)),search))   )) and (datapack == nil or (datapack ~= nil and tostring(v.datapack) == datapack))) then
					
					local enti = v
					ImGui.SetNextItemOpen()
					if ImGui.TreeNode(k) then
						
						ImGui.Text("File : "..tostring(v.file))
						ImGui.Text("Datapack : "..tostring(v.datapack))
						
						if ImGui.Button("Open") then
							
							if(currentScript[v.scripttype] == nil) then
								currentScript[v.scripttype] = {}
							end
							
							
							
							local version = deepcopy(scripttemplate[v.scripttype],nil)
							
							editor.migration(v.scripttype,v.data,version.header.version)
							
							for key,prop in pairs(v.data) do
								
								version[key] = prop
								
							end
							
							v.data = version
							currentScript[v.scripttype][k] = deepcopy(v,nil)
						end
						
						if ImGui.Button("Delete (From Loaded Cache)") then
							array[k] = nil
							if(currentScript[v.scripttype] == nil) then
								currentScript[v.scripttype] = {}
							end
							
							currentScript[v.scripttype][k] = nil
						end
						
						if ImGui.Button("Delete (From Cache, if existing json file still in folder, it will be regenerated at next cache check)") then
							if(currentScript[v.scripttype] == nil) then
								currentScript[v.scripttype] = {}
							end
							
							currentScript[v.scripttype][k] = nil
							arrayDatapack[v.datapack][title][v.file] = nil
						end
						if datapack ~= nil then
							if ImGui.Button("Delete File") then
								os.remove(v.file)
								array[k] = nil
								if(currentScript[v.scripttype] == nil) then
									currentScript[v.scripttype] = {}
								end
								
								currentScript[v.scripttype][k] = nil
								arrayDatapack[v.datapack][title][v.file] = nil
							end
							
							
						end
						if ImGui.Button(getLang("View Cache JSON (Read-Only)")) then
							
							if(currentJson[k] == nil) then
								
								
								local objm =  deepcopy(v,nil)
								
								currentJson[item.data.tag] = JSON:encode_pretty(objm)
								
								
							end
							
							
							
						end
						
						ImGui.TreePop()
					end
				end
			end
			
			
			
			ImGui.TreePop()
		end
	end
	
	
end

function editor.makeListString(enti)
	
	ImGui.Text("Add an value :") 
	defaulttag =  ImGui.InputText("##makeListString",defaulttag, 5000, ImGuiInputTextFlags.AutoSelectAll)
	if ImGui.Button("Add this tag") then
		
		table.insert(enti,defaulttag)
		
	end
	
	if ImGui.Button("Delete Last value") then
		
		table.remove(enti,#enti)
		
	end
	
	local resumeString = ""
	
	
	if(#enti >0)then
		for i = 1,#enti do 
			
			
			local virgule = ""
			if(i > 1) then
				virgule = ","
			end
			
			local entiy = '"'..enti[i]..'"'
			
			resumeString = resumeString..virgule..entiy
		end
	end
	ImGui.Text(resumeString)
end


function editor.makeListInt(enti)
	
	ImGui.Text("Add an value :") 
	defaultnumber =  ImGui.InputFloat("##makeListInt", 1, 10,"%.2f", ImGuiInputTextFlags.None)
	if ImGui.Button("Add this value") then
		
		table.insert(enti,defaultnumber)
		
	end
	removenumber =  ImGui.InputFloat("##removenumber", 1, 10,"%.2f", ImGuiInputTextFlags.None)
	if ImGui.Button("Delete value") then
		
		table.remove(enti,removenumber)
		
	end
	
	local resumeString = ""
	
	
	if(#enti >0)then
		for i = 1,#enti do 
			
			
			local virgule = ""
			if(i > 1) then
				virgule = ","
			end
			
			local entiy = '"'..enti[i]..'"'
			
			resumeString = resumeString..virgule..entiy
		end
	end
	ImGui.Text(resumeString)
	
end



function editor.migration(typescript,script,lastversion)
	
	if((script.header == nil or script.header.version < lastversion) and editor.migrationscript[typescript] ~= nil) then
		
		for i,template in ipairs(editor.migrationscript[typescript]) do
			
			if(script.header == nil or (script.header ~= nil and script.header.version > template.version)) then 
				
				--print("migration for "..typescript.." to version "..template.version)
				
				if(template.migrate ~= nil) then
					for k,v in pairs(template.migrate) do 
						
						if(script[k] == nil) then
							script[k] = deepcopy(script[v],nil)
							script[v] = nil
							--print("migrate "..v.." to "..k.." : "..tostring(script[k]))
						end
						
					end
				end
				
				if(template.add ~= nil) then
					for k,v in pairs(template.add) do 
						
						script[k] = template[k]
						
						
					end
				end
				if(template.remove ~= nil) then
					for k,v in pairs(template.remove) do 
						
						script[k] = nil
						
						
					end
				end
				local stringscript = dump(script)
				if(template.replace ~= nil) then
					for k,v in pairs(template.replace) do 
						
						stringscript = stringscript:gsub( '%f[%a]'..v..'%f[%A]', k) 
						
						
					end
				end
				--print(stringscript)
				script = loadstring("return " .. exportDatapackArray(stringscript),"")()
				
				
				
			end
			
		end
	end
	
	
end





function  editor.SpawnNPCUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Spawn level group (useful for delete an level of entities) : ") 
	ImGui.SameLine()
	entity["spawnlevel"] = ImGui.InputInt("##spawnlevel", entity["spawnlevel"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Amount : ") 
	ImGui.SameLine()
	entity["amount"] = ImGui.InputInt("##amount", entity["amount"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Despawn Timer in second (leave 0 means it will not despawn automatically) : ") 
	ImGui.SameLine()
	if (entity["despawntimer"] == nil or type(entity["despawntimer"]) == "string") then entity["despawntimer"] = 300 end
	entity["despawntimer"] = ImGui.InputInt("##despawntimer", entity["despawntimer"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Use Police Prevention System ? if false, it use experimental spawner, with it, you can set an appeareance directly, use carefully, it can have bug: ") 
	ImGui.Spacing()
	entity["use_police_prevention_system"] =ImGui.Checkbox("##use_police_prevention_system", entity["use_police_prevention_system"])
	
	ImGui.Text("Use Codeware Spawn System (recommended) ? if true, it use codeware spawner, with it, you can set an appeareance directly and use persistance on your entity: ") 
	ImGui.Spacing()
	entity["usecodeware"] =ImGui.Checkbox("##usecodeware", entity["usecodeware"])
	
	ImGui.Spacing()
	
	if(entity["usecodeware"] == true) then
		ImGui.Text("PersistState : If true, the entity state will be saved and restored on next game load, otherwise it will be reset to the initial state on every spawn.: ") 
		ImGui.Spacing()
		entity["persiststate"] =ImGui.Checkbox("##persiststate", entity["persiststate"])
		
		ImGui.Spacing()
		
		ImGui.Text("PersistSpawn: If true, the entity will be automatically spawned on next game load, otherwise it will exist until the end of the session.") 
		ImGui.Spacing()
		entity["persistspawn"] =ImGui.Checkbox("##persistspawn", entity["persistspawn"])
		
		ImGui.Spacing()
		
		ImGui.Text("AlwaysSpawned: If true, the entity will be kept always spawned during the game session, otherwise it will only spawn when player is around.") 
		ImGui.Spacing()
		entity["alwaysspawned"] =ImGui.Checkbox("##alwaysspawned", entity["alwaysspawned"])
		
		ImGui.Spacing()
		
		ImGui.Text("SpawnInView: If true, the entity will spawn on creation, otherwise it will be registered in the system without spawning.") 
		ImGui.Spacing()
		entity["spawninview"] =ImGui.Checkbox("##spawninview", entity["spawninview"])
		
		
		
	end
	
	
	ImGui.Text("Group : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.InputText("##group", entity["group"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Create the group if it doesn't exist yet : ") 
	ImGui.SameLine()
	entity["create_group_if_not_exist"] = ImGui.Checkbox("##create_group_if_not_exist", entity["create_group_if_not_exist"])
	
	ImGui.Spacing()
	
	ImGui.Text("Source of the spawn : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##npcsource", entity["source"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(npcsource) do
			
			if ImGui.Selectable(v, (entity["source"] == v)) then
				
				
				entity["source"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(
		entity["source"] ~= "current_star" 
		and entity["source"] ~= "from_list" 
		and entity["source"] ~= "random" 
		and entity["source"] ~= "npc" 
		and entity["source"] ~= "district_leader" 
		and entity["source"] ~= "faction" 
		and entity["source"] ~= "subdistrict_leader"
		and entity["source"] ~= "district_rival" 
		and entity["source"] ~= "subdistrict_rival"
		and entity["source"] ~= "current_district_rival" 
		and entity["source"] ~= "current_subdistrict_rival"
	)then
	
	ImGui.Text("Source Tag : ") 
	entity["source_tag"] = ImGui.InputText("##source_tag", entity["source_tag"], 5000, ImGuiInputTextFlags.None)
	
	
	
	ImGui.Spacing()
	end
	
	if(entity["source"] == "npc") then
		
		ImGui.Text("NPC : ") 
		newentity.search = ImGui.InputText("Search", newentity.search, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		if ImGui.BeginCombo("##npcsourcenpc", entity["source_tag"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			
			
			for i,items in ipairs(cyberscript.entities) do
				
				
				if(
					
					newentity.search == "" or
					string.match(items.entity_tweak, newentity.search) or
					string.match(items.entity_name, newentity.search) or
					string.match(items.entity_entname, newentity.search) or
					string.match(items.entity_entpath, newentity.search)
					
					
					
				)then 
				
				if ImGui.Selectable(items.entity_tweak,entity["source_tag"] == items.entity_tweak) then
					
					entity["source_tag"] =  items.entity_tweak
					
					ImGui.SetItemDefaultFocus()
				end
				
				
				end
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Spacing()
		ImGui.Text("Appearance : ") 
		ImGui.SameLine()
		entity["appearance"] = ImGui.InputText("##Appearance", entity["appearance"], 5000, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
	end
	
	if(entity["source"] == "from_list") then
		
		listStringNode("List :","list of possible npc",entity,"source_list",false)
		
	end
	
	if(entity["source"] == "faction") then
		
		ImGui.Text("Faction : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcefaction", entity["source_tag"]) then
			
			
			for k,v in pairs(cyberscript.cache["faction"]) do
				
				if ImGui.Selectable(v.data.name, (entity["source_tag"]  == k)) then
					entity["source_tag"] = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "district_rival" or entity["source"] =="subdistrict_rival" or entity["source"] == "current_district_rival" or entity["source"] == "current_subdistrict_rival" )then
		
		ImGui.Text("Put in Source Gang the Gang tag you want test. If you put 'player' it will take Player's current Faction. ") 
		ImGui.Spacing()
		
		
		ImGui.Text("Source Gang : ") 
		ImGui.SameLine()
		entity["source_gang"] =ImGui.InputText("##source_gang", entity["source_gang"], 5000, ImGuiInputTextFlags.None)
		
		
		
	end
	
	if(entity["source"] == "district_leader" or entity["source"] == "district_rival") then
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcedistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arrayDistricts) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v.Tag)) then
					entity["source_tag"] = v.Tag
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "subdistrict_leader" or entity["source"] == "subdistrict_rival") then
		
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcesubdistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arraySubDistrict) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v)) then
					entity["source_tag"] = v
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	if(entity["source"] == "faction" or entity["source"] =="current_district_leader" or entity["source"] == "current_subdistrict_leader" or entity["source"] == "district_leader" or entity["source"] == "subdistrict_leader")then
		
		ImGui.Text("Use Rival of this faction instead of this faction ? : ") 
		ImGui.SameLine()
		entity["source_use_rival"] =ImGui.Checkbox("##source_use_rival", entity["source_use_rival"])
		ImGui.Spacing()
		
		ImGui.Text("Use Faction's VIP list ? If No, it will take the default SpawnableNPC List : ") 
		ImGui.SameLine()
		entity["source_use_vip"] =ImGui.Checkbox("##source_use_vip", entity["source_use_vip"])
		ImGui.Spacing()
		
		
	end
	
	
	
	
	entity =  editor.PositionUI(entity)
	
	
	
	
	return entity
end

function  editor.SpawnVehicleUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Spawn level group (useful for delete an level of entities) : ") 
	ImGui.SameLine()
	entity["spawnlevel"] = ImGui.InputInt("##spawnlevel", entity["spawnlevel"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Amount : ") 
	ImGui.SameLine()
	entity["amount"] = ImGui.InputInt("##amount", entity["amount"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	
	ImGui.Text("Despawn Timer in second (leave 0 means it will not despawn automatically) : ") 
	ImGui.SameLine()
	if (entity["despawntimer"] == nil or type(entity["despawntimer"]) == "string") then entity["despawntimer"] = 300 end
	entity["despawntimer"] = ImGui.InputInt("##despawntimer", entity["despawntimer"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Spawn System : (From Garage : safe way to use for players | Beta: more option but use carefully, it can have bug | Prevention : use only if you spawn npc with prevention in same XYZ or it can corrupt saves): ") 
	ImGui.Spacing()
	
	if ImGui.BeginCombo("##spawnsystem", vehiclespawnsystemeditordefault) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(vehiclespawnsystem) do
			
			if ImGui.Selectable(v, (entity["spawn_system"] == i)) then
				
				
				entity["spawn_system"] = i
				vehiclespawnsystemeditordefault = v
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(entity["spawn_system"] == 1)then
		ImGui.Text("Appears from behind ") 
		ImGui.SameLine()
		entity["appears_from_behind"] =ImGui.Checkbox("##appears_from_behind", entity["appears_from_behind"])
		ImGui.Spacing()
		ImGui.Text("Wait that the vehicule comes to you ? ") 
		ImGui.SameLine()
		entity["wait_for_vehicle"] =ImGui.Checkbox("##wait_for_vehicle", entity["wait_for_vehicle"])
		ImGui.Spacing()
	end
	
	if(entity["spawn_system"] == 4)then
		ImGui.Text("PersistState : If true, the entity state will be saved and restored on next game load, otherwise it will be reset to the initial state on every spawn.: ") 
		ImGui.Spacing()
		entity["persiststate"] =ImGui.Checkbox("##persiststate", entity["persiststate"])
		
		ImGui.Spacing()
		
		ImGui.Text("PersistSpawn: If true, the entity will be automatically spawned on next game load, otherwise it will exist until the end of the session.") 
		ImGui.Spacing()
		entity["persistspawn"] =ImGui.Checkbox("##persistspawn", entity["persistspawn"])
		
		ImGui.Spacing()
		
		ImGui.Text("AlwaysSpawned: If true, the entity will be kept always spawned during the game session, otherwise it will only spawn when player is around.") 
		ImGui.Spacing()
		entity["alwaysspawned"] =ImGui.Checkbox("##alwaysspawned", entity["alwaysspawned"])
		
		ImGui.Spacing()
		
		ImGui.Text("SpawnInView: If true, the entity will spawn on creation, otherwise it will be registered in the system without spawning.") 
		ImGui.Spacing()
		entity["spawninview"] =ImGui.Checkbox("##spawninview", entity["spawninview"])
		
		
		
	end
	
	ImGui.Text("Is an AV (flying machine)? : ") 
	ImGui.SameLine()
	entity["isAV"] =ImGui.Checkbox("##isAV", entity["isAV"])
	
	ImGui.Spacing()
	
	
	ImGui.Text("Group : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.InputText("##group", entity["group"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Create the group if it doesn't exist yet : ") 
	ImGui.SameLine()
	entity["create_group_if_not_exist"] = ImGui.Checkbox("##create_group_if_not_exist", entity["create_group_if_not_exist"])
	
	ImGui.Spacing()
	
	ImGui.Text("Source of the spawn : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##vehiclesource", entity["source"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(vehiclesource) do
			
			if ImGui.Selectable(v, (entity["source"] == v)) then
				
				
				entity["source"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(entity["source"] ~= "random" and
		entity["source"] ~= "from_list" and 
		entity["source"] ~= "vehicle" and 
		entity["source"] ~= "district_leader" and 
		entity["source"] ~= "faction" and 
		entity["source"] ~= "subdistrict_leader"
		and entity["source"] ~= "district_rival" 
		and entity["source"] ~= "subdistrict_rival"
		and entity["source"] ~= "current_district_rival" 
		and entity["source"] ~= "current_subdistrict_rival"
	)
	then
	
	ImGui.Text("Source Tag : ") 
	entity["source_tag"] = ImGui.InputText("##source_tag", entity["source_tag"], 5000, ImGuiInputTextFlags.None)
	
	
	
	ImGui.Spacing()
	end
	if(entity["source"] == "from_list") then
		
		listStringNode("List :","list of possible vehicle",entity,"source_list",false)
		
	end
	
	if(entity["source"] == "vehicle") then
		
		ImGui.Text("Vehicle : ") 
		newentity.search = ImGui.InputText("Search", newentity.search, 5000, ImGuiInputTextFlags.AutoSelectAll)
		
		if ImGui.BeginCombo("##vehisourcenpc", entity["source_tag"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(arrayVehicles) do
				if(
					
					newentity.search == "" or
					string.match(v, newentity.search)
					
					
				)then 
				if ImGui.Selectable(v, (entity["source_tag"] == v)) then
					
					
					entity["source_tag"] = v
					
					
					ImGui.SetItemDefaultFocus()
				end
				end
				
			end
			
			ImGui.EndCombo()
		end
		
		
		
			ImGui.Spacing()
			ImGui.Text("Appearance (empty if not needed) :") 
			ImGui.Spacing()
			entity["appearance"] = ImGui.InputText("##appearance", entity["appearance"], 5000, ImGuiInputTextFlags.None)
			ImGui.Spacing()
			
		
		
	end
	
	if(entity["source"] == "faction") then
		
		ImGui.Text("Faction : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##vehisourcefaction",entity["source_tag"]) then
			
			
			for k,v in pairs(cyberscript.cache["faction"]) do
				
				if ImGui.Selectable(v.data.name, (entity["source_tag"]  == k)) then
					entity["source_tag"] = k
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "district_rival" or entity["source"] =="subdistrict_rival" or entity["source"] == "current_district_rival" or entity["source"] == "current_subdistrict_rival" )then
		
		ImGui.Text("Put in Source Gang the Gang tag you want test. If you put 'player' it will take Player's current Faction. ") 
		ImGui.Spacing()
		
		
		ImGui.Text("Source Gang : ") 
		ImGui.SameLine()
		entity["source_gang"] =ImGui.InputText("##source_gang", entity["source_gang"], 5000, ImGuiInputTextFlags.None)
		
		
		
	end
	
	if(entity["source"] == "district_leader" or entity["source"] == "district_rival") then
		
		ImGui.Text("District : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcedistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arrayDistricts) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v.Tag)) then
					entity["source_tag"] = v.Tag
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	if(entity["source"] == "subdistrict_leader" or entity["source"] == "subdistrict_rival") then
		
		ImGui.Text("SubDistrict : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcsourcesubdistrict", entity["source_tag"]) then
			
			
			for i,v in ipairs(arraySubDistrict) do
				
				if ImGui.Selectable(v.Name, (entity["source_tag"] == v)) then
					entity["source_tag"] = v
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	
	if(entity["source"] == "faction" or entity["source"] =="current_district_leader" or entity["source"] == "current_subdistrict_leader" or entity["source"] == "district_leader" or entity["source"] == "subdistrict_leader")then
		
		ImGui.Text("Use Rival of this faction instead of this faction ? : ") 
		ImGui.SameLine()
		entity["source_use_rival"] =ImGui.Checkbox("##source_use_rival", entity["source_use_rival"])
		ImGui.Spacing()
		
		
		
		
	end
	
	entity =  editor.PositionUI(entity)
	
	return entity
end

function  editor.SetMappinUI(entity,create)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Type of Mappin : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##mappinTypeEnum", entity["typemap"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(mappinTypeEnum) do
			
			if ImGui.Selectable(v, (entity["typemap"] == v)) then
				
				
				entity["typemap"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	if(create == true) then
		ImGui.Text("See throught wall ? ") 
		ImGui.SameLine()
		entity["wall"] =ImGui.Checkbox("##wall", entity["wall"])
	end
	ImGui.Spacing()
	
	ImGui.Text("Active ? ") 
	ImGui.SameLine()
	entity["active"] =ImGui.Checkbox("##active", entity["active"])
	
	ImGui.Spacing()
	
	
	ImGui.Text("Group : ") 
	ImGui.SameLine()
	entity["mapgroup"] = ImGui.InputText("##mapgroup", entity["mapgroup"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Title : ") 
	ImGui.SameLine()
	entity["title"] = ImGui.InputText("##title", entity["title"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Description : ") 
	ImGui.SameLine()
	entity["desc"] = ImGui.InputText("##desc", entity["desc"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	editoriconsearch = ImGui.InputText(getLang("Icon Choice Filter"), editoriconsearch, 5000, ImGuiInputTextFlags.AutoSelectAll)
	if ImGui.BeginCombo("Icon :", entity.icon) then
		
		
		for i,v in ipairs(choiceIconList) do
			if (editoriconsearch == "" or (editoriconsearch ~= "" and (string.match(string.lower(v),editoriconsearch)))) then
				if ImGui.Selectable(v, (entity.icon == v)) then
					entity.icon = v
					
					
					
					ImGui.SetItemDefaultFocus()
				end
				
			end
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Text("Style : ")
	if(entity ~= nil and entity.color ~= nil and entity.color.red ~= nil and entity.color.green ~= nil and entity.color.blue ~= nil ) then
		
		ImGui.PushStyleColor(ImGuiCol.Text,round((entity.color.red/255),8), round((entity.color.green/255),8), round((entity.color.blue/255),8), 1)
		
		ImGui.Text("Current Color")
		
		ImGui.PopStyleColor(1)
		
		
		ImGui.Text("Red : ".. entity.color.red)
		ImGui.Text("Green : ".. entity.color.green)
		ImGui.Text("Blue : ".. entity.color.blue)
		else
		
		ImGui.Text("No current Style defined ")
		
	end
	
	if ImGui.Button("Open Color Picker") then
		toggleEditorUI("colorPicker")
	end
	
	ImGui.SameLine()
	
	if ImGui.Button("Copy RGB from Color Picker") then
		entity.color.red = currentcolorRGB.red 
		entity.color.green = currentcolorRGB.green
		entity.color.blue = currentcolorRGB.blue
	end
	
	if ImGui.Button("Remove Color") then
		entity.color = nil
	end
	
	
	
	ImGui.Separator()
	
	
	entity =  editor.PositionUI(entity)
	return entity
end

function  editor.MoveEntityUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Is a Group ? : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.Checkbox("##group", entity["group"])
	
	ImGui.Text("Movement : ") 
	ImGui.SameLine()
	entity["move"] = ImGui.InputText("##move", entity["move"], 5000, ImGuiInputTextFlags.None)
	
	
	ImGui.Text("Use Move V2 method? ") 
	ImGui.SameLine()
	entity["moveV2"] =ImGui.Checkbox("##move2", entity["moveV2"])
	
	
	ImGui.Spacing()
	if(entity["moveV2"] == true )then
		ImGui.Text("Destination Rotation") 
		ImGui.Spacing()
		
		ImGui.Text("Roll : ") 
		ImGui.SameLine()
		entity["roll"] = ImGui.InputFloat("##xnpcroll", entity["roll"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Pitch : ") 
		ImGui.SameLine()
		entity["pitch"] = ImGui.InputFloat("##xnpcpitch", entity["pitch"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Yaw : ") 
		ImGui.SameLine()
		entity["yaw"] = ImGui.InputFloat("##xnpcyaw", entity["yaw"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		
		ImGui.Text("Distance : ") 
		ImGui.SameLine()
		entity["distance"] = ImGui.InputFloat("##xnpcdistance", entity["distance"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		
		ImGui.Text("Distance Tolerance : ") 
		ImGui.SameLine()
		entity["distancetolerance"] = ImGui.InputFloat("##xnpcdistancetolerance", entity["distancetolerance"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Ignore Navigation ?") 
		ImGui.SameLine()
		entity["ignorenavigation"] =ImGui.Checkbox("##ignorenavigation", entity["ignorenavigation"])
		
		ImGui.Text("Stop On Obstacle ?") 
		ImGui.SameLine()
		entity["stoponobstacle"] =ImGui.Checkbox("##stoponobstacle", entity["stoponobstacle"])
		
		ImGui.Text("Out of Way ?") 
		ImGui.SameLine()
		entity["outofway"] =ImGui.Checkbox("##outofway", entity["outofway"])
		
		
		
	end
	
	
	entity =  editor.PositionUI(entity)
	
	return entity
end

function  editor.TeleportEntityUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Is a Group ? : ") 
	ImGui.SameLine()
	entity["group"] = ImGui.Checkbox("##group", entity["group"])
	
	
	
	entity = editor.PositionUI(entity)
	
	
	entity = editor.RotationUI(entity)
	
	return entity
end

function  editor.SpawnItemUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	
	ImGui.Text("Amount : ") 
	ImGui.SameLine()
	entity["amount"] = ImGui.InputInt("##amount", entity["amount"], 1, 10, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Path : ") 
	ImGui.SameLine()
	for i=1, #arrayDBitems do
		
		if ImGui.Selectable(arrayDBitems[i].Title) then
			
			entity["path"] = arrayDBitems[i].Path
			
			ImGui.SetItemDefaultFocus()
		end
		
		
		
	end
	
	
	
	
	
	
	
	ImGui.Text("Yaw : ") 
	ImGui.SameLine()
	entity["yaw"] = ImGui.InputFloat("##xnpcyaw", entity["yaw"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Pitch : ") 
	ImGui.SameLine()
	entity["pitch"] = ImGui.InputFloat("##xnpcpitch", entity["pitch"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Roll : ") 
	ImGui.SameLine()
	entity["roll"] = ImGui.InputFloat("##xnpcroll", entity["roll"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	
	if ImGui.Button("Copy Player's Rotation", 300, 0) then
		
		local v = Vector4.new(-Game.GetCameraSystem():GetActiveCameraForward().x, -Game.GetCameraSystem():GetActiveCameraForward().y, -Game.GetCameraSystem():GetActiveCameraForward().z, -Game.GetCameraSystem():GetActiveCameraForward().w)
		local euler = GetSingleton('Vector4'):ToRotation(v)
		
		entity["roll"] = euler.pitch
		entity["pitch"] = euler.roll
		entity["yaw"] = euler.yaw + 180
		
		
		
		
	end
	
	entity =  editor.PositionUI(entity)
	
	return entity
end



function  editor.PositionUI(entity)
	
	ImGui.Text("Position source : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##npcposition", entity["position"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(npcposition) do
			
			if ImGui.Selectable(v, (entity["position"] == v)) then
				
				
				entity["position"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	
	if(
		entity["position"] == "relative_to_entity" or 
		entity["position"] =="poi" or 
		entity["position"] =="node" or 
		entity["position"] == "mappin" or 
		entity["position"] == "fasttravel" or 
		entity["position"] == "custom_place" or
		entity["position"] == "custom_room"
		
	)then
	
	ImGui.Text("Position Tag : ") 
	entity["position_tag"] = ImGui.InputText("##position_tag", entity["position_tag"], 5000, ImGuiInputTextFlags.None)
	ImGui.Text(entity["position_change_helper"]) 
	
	
	ImGui.Spacing()
	end
	
	
	if(entity["position"] == "relative_to_entity")then
		
		ImGui.Text("Position Way : ") 
		if ImGui.BeginCombo("##npcpositionway", entity["position_way"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(npcpositionway) do
				
				if ImGui.Selectable(v, (entity["position_way"] == v)) then
					
					
					entity["position_way"] = v
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Spacing()
		
		ImGui.Text("Distance : ") 
		ImGui.SameLine()
		entity["position_distance"] = ImGui.InputInt("##position_distance", entity["position_distance"], 1, 10, ImGuiInputTextFlags.None)
		
		ImGui.Spacing()
	end
	
	if(entity["position"] == "poi")then
		
		
		
		ImGui.Text("Leave Position Tag to empty if you don't need to find an precise POI or Location ") 
		ImGui.SameLine()
		
		ImGui.Text("District Enum Name : (leave blank if unused, put current for get current District, put random for get a random District)") 
		ImGui.SameLine()
		entity["position_poi_district"] = ImGui.InputText("##position_poi_district", entity["position_poi_district"], 5000, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("SubDistrict Enum Name : (leave blank if unused, put current for get current SubDistrict if you are in, put random for get a random subDistrict)") 
		ImGui.SameLine()
		entity["position_poi_subdistrict"] = ImGui.InputText("##position_poi_subdistrict", entity["position_poi_subdistrict"], 5000, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("Is For Car ? ") 
		ImGui.SameLine()
		entity["position_poi_is_for_car"] =ImGui.Checkbox("##is_for_car", entity["position_poi_is_for_car"])
		ImGui.Spacing()
		
		ImGui.Text("Use Location Tag instead of POI Tag (for an precise location) ? ") 
		ImGui.SameLine()
		entity["position_poi_use_location_tag"] =ImGui.Checkbox("##position_poi_use_location_tag", entity["position_poi_use_location_tag"])
		ImGui.Spacing()
		
		ImGui.Text("POI Detection Range : ") 
		ImGui.SameLine()
		entity["position_range"] = ImGui.InputInt("##poirange01", entity["position_range"], 1, 10, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("POI Detection From Position : ") 
		ImGui.SameLine()
		entity["position_poi_from_position"] = ImGui.Checkbox("##poirange02", entity["position_poi_from_position"])
		ImGui.Spacing()
		
		ImGui.Text("POI type : ") 
		ImGui.SameLine()
		entity["position_poi_type"] =ImGui.InputInt("##position_poi_type", entity["position_poi_type"], 1, 10, ImGuiInputTextFlags.None)
		
		ImGui.Spacing()
		ImGui.Text("POI Search List : type|subdistrict|district|tag") 
		ImGui.SameLine()
		entity["position_poi_search"] = ImGui.InputText("##position_poi_search", entity["position_poi_search"], 5000, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
		ImGui.Text("POI Search List Sort Order : near|far|random") 
		ImGui.SameLine()
		entity["position_poi_searchdistance"] = ImGui.InputText("##position_poi_searchdistance", entity["position_poi_searchdistance"], 5000, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
	end
	
	if(entity["position"] == "node")then
		
		ImGui.Text("Node Detection Range : ") 
		ImGui.SameLine()
		entity["position_range"] = ImGui.InputInt("##position_range2", entity["position_range"], 1, 10, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		ImGui.Text("Use Gameplay Position instead of Default Position : ") 
		ImGui.SameLine()
		entity["position_node_usegameplay"] =ImGui.Checkbox("##position_node_usegameplay", entity["position_node_usegameplay"])
		
	end
	
	if(entity["position"] == "custom_place")then
		
		ImGui.Text("Position House Way : ") 
		if ImGui.BeginCombo("##npcpositionhouseway", entity["position_house_way"]) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(npcpositionhouseway) do
				
				if ImGui.Selectable(v, (entity["position_house_way"] == v)) then
					
					
					entity["position_house_way"] = v
					
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
		ImGui.Spacing()
	end
	
	
	
	
	
	if(entity["position"] == "player_look_at" )then
		ImGui.Text("Distance : ") 
		entity["position_lookatdistance"] = ImGui.InputInt("##position_player_look_at_distance", entity["position_lookatdistance"], 1, 10, ImGuiInputTextFlags.None)
		ImGui.Spacing()
		
	end
	
	
	
	
	
	if(entity["position"] == "at" )then
		ImGui.Text("Coordinates") 
		else
		ImGui.Text("Relative Coordinates to the selected position") 
		
	end
	
	ImGui.Spacing()
	
	
	ImGui.Text("X : ") 
	ImGui.SameLine()
	entity["x"] = ImGui.InputFloat("##xnpcx", entity["x"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Y : ") 
	ImGui.SameLine()
	entity["y"] = ImGui.InputFloat("##xnpcy", entity["y"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Z : ") 
	ImGui.SameLine()
	entity["z"] = ImGui.InputFloat("##xnpcz", entity["z"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	if ImGui.Button("Copy Player's XYZ", 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		entity["x"] = vec4.x
		entity["y"] = vec4.y
		entity["z"] = vec4.z
		
		
	end
	
	
	
	return entity
	
end


function  editor.RotationUI(entity)
	
	
	ImGui.Text("Yaw : ") 
	ImGui.SameLine()
	entity["yaw"] = ImGui.InputFloat("##xnpcyaw", entity["yaw"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Pitch : ") 
	ImGui.SameLine()
	entity["pitch"] = ImGui.InputFloat("##xnpcpitch", entity["pitch"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	ImGui.Text("Roll : ") 
	ImGui.SameLine()
	entity["roll"] = ImGui.InputFloat("##xnpcroll", entity["roll"], 1, 10, "%.3f", ImGuiInputTextFlags.None)
	ImGui.Spacing()
	
	
	
	
	return entity
	
end


function showArray(array, title)
	
	ImGui.Separator()
	
	
	if ImGui.TreeNode(title) then
		
		
		
		for k,v in pairs(array) do
			
			local enti = v
			if ImGui.TreeNode(k) then
				
				ImGui.Text("File : "..tostring(v.file))
				ImGui.Text("Datapack : "..tostring(v.datapack))
				
				ImGui.TreePop()
			end
		end
		
		
		
		ImGui.TreePop()
	end
	
end

function  editor.SpawnCamera(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	
	
	if ImGui.BeginCombo("POV Type", scenepovtype) then -- Remove the ## if you'd like for the title to display above combo box
		
		for i=1, #scenepov do
			
			if ImGui.Selectable(scenepov[i]) then
				entity["type"] = scenepov[i]
				
				scenepovtype = scenepovtype
				ImGui.SetItemDefaultFocus()
			end
			
			
			
		end
		
		ImGui.EndCombo()
	end
	
	if(entity["type"] == "entity")then
		
		ImGui.Text("Entity : ") 
		ImGui.SameLine()
		entity["entity"] = ImGui.InputText("##tag", entity["entity"], 5000, ImGuiInputTextFlags.None)
		
	end
	ImGui.Text("Use Surveillance Camera ? : ") 
	ImGui.SameLine()
	entity["surveillance"] = ImGui.Checkbox("##surveillance", entity["surveillance"])
	
	
	entity["x"] =  ImGui.DragFloat("##povx"..entity["tag"], entity["x"], 0.01, -9999, 9999, "%.3f X")
	entity["y"] =  ImGui.DragFloat("##povy"..entity["tag"], entity["y"], 0.01, -9999, 9999, "%.3f Y")
	entity["z"] =  ImGui.DragFloat("##povz"..entity["tag"], entity["z"], 0.01, -9999, 9999, "%.3f Z")
	
	
	entity["roll"] =  ImGui.DragFloat("##roll"..entity["tag"], entity["roll"], 0.01, -9999, 9999, "%.3f roll")
	entity["pitch"] =  ImGui.DragFloat("##pitch"..entity["tag"], entity["pitch"], 0.01, -9999, 9999, "%.3f pitch")
	entity["yaw"] =  ImGui.DragFloat("##yaw"..entity["tag"], entity["yaw"], 0.01, -9999, 9999, "%.3f yaw")
	
	
	
	if ImGui.Button("Copy Player's XYZ", 300, 0) then
		
		local vec4 = Game.GetPlayer():GetWorldPosition()
		entity["x"] = vec4.x
		entity["y"] = vec4.y
		entity["z"] = vec4.z
		
		
		
		
	end
	
	if ImGui.Button("Copy Player's Rotation", 300, 0) then
		
		local v = Vector4.new(-Game.GetCameraSystem():GetActiveCameraForward().x, -Game.GetCameraSystem():GetActiveCameraForward().y, -Game.GetCameraSystem():GetActiveCameraForward().z, -Game.GetCameraSystem():GetActiveCameraForward().w)
		local euler = GetSingleton('Vector4'):ToRotation(v)
		
		entity["roll"] = euler.pitch
		entity["pitch"] = euler.roll
		entity["yaw"] = euler.yaw + 180
		
		
		
		
	end
	
	
	if ImGui.Button("Copy Looked Entity's XYZ", 300, 0) then
		
		if(objLook ~= nil)then
			local vec4 = objLook:GetWorldPosition()
			entity["x"] = vec4.x
			entity["y"] = vec4.y
			entity["z"] = vec4.z
		end
		
		
		
	end
	
	if ImGui.Button("Copy Looked Entity's Rotation", 300, 0) then
		
		if(objLook ~= nil)then
			local qat = objLook:GetWorldOrientation()
			local euler = GetSingleton('Quaternion'):ToEulerAngles(qat)
			
			
			entity["roll"] = euler.pitch
			entity["pitch"] = euler.roll
			entity["yaw"] = euler.yaw + 180
		end
		
		
		
	end
	
	
	if ImGui.Button("Try Camera", 300, 0) and entity["tag"] ~= "" then
		
		local obj = getEntityFromManager(entity["tag"])
		local enti = Game.FindEntityByID(obj.id)
		
		local position = {}
		position.x = entity["x"]
		position.y = entity["y"]
		position.z = entity["z"]
		
		local angle = {}
		angle.yaw = entity["yaw"]
		angle.pitch = entity["pitch"]
		angle.roll = entity["roll"]
		
		
		if(enti ~= nil) then
			
			spawnCamera(entity["tag"],entity["type"],entity["entity"],position,angle,false)
			enableCamera(entity["tag"])
			else
			moveCamera(entity["tag"],entity["type"],entity["entity"],position,angle,false)
		end
		
		
		
	end
	
	
	if ImGui.Button("Stop Camera", 300, 0) and currentSelectSceneStep.pov.tag ~= "" then
		
		
		despawnEntity(entity["tag"])
		
		
	end
	
	
	
	
	
	
	
	
	return entity
end

function  editor.EffectUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Effect : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##statutEffect", entity["value"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(statutEffect) do
			
			if ImGui.Selectable(v, (entity["value"] == v)) then
				
				
				entity["value"] = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
end


function  editor.ExpressionUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	if(entity["value"] == nil) then entity["value"]="Neutral"end
	ImGui.Text("Expressions : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##statutEffect", entity["value"]) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(reactionlist) do
			
			if ImGui.Selectable(v.name, (entity["value"] == v.name)) then
				
				
				entity["value"] = v.name
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
end


function  editor.FXUI(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Source FX : ") 
	ImGui.SameLine()
	if ImGui.BeginCombo("##Fxobjectlist", defaultFXlist) then -- Remove the ## if you'd like for the title to display above combo box
		
		
		
		for i,v in ipairs(Fxobjectlist) do
			
			if ImGui.Selectable(v, (defaultFXlist == v)) then
				
				
				defaultFXlist = v
				
				
				ImGui.SetItemDefaultFocus()
			end
			
			
		end
		
		ImGui.EndCombo()
	end
	
	ImGui.Spacing()
	
	if(defaultFXlist == "player") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##transistionFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(transistionFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	if(defaultFXlist == "npc") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##npcFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(npcFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	
	if(defaultFXlist == "car") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##carFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(carFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
	
	
	if(defaultFXlist == "all") then
		
		ImGui.Text("Effect : ") 
		ImGui.SameLine()
		if ImGui.BeginCombo("##listFX",defaukltFX) then -- Remove the ## if you'd like for the title to display above combo box
			
			
			
			for i,v in ipairs(listFX) do
				
				if ImGui.Selectable(v, (entity["value"] == v)) then
					
					
					entity["value"] = v
					defaukltFX = v
					
					ImGui.SetItemDefaultFocus()
				end
				
				
			end
			
			ImGui.EndCombo()
		end
		
	end
	
end


function editor.AIContext(entity)
	
	ImGui.Text("Tag : ") 
	ImGui.SameLine()
	entity["tag"] = ImGui.InputText("##tag", entity["tag"], 5000, ImGuiInputTextFlags.None)
	
	ImGui.Spacing()
	
	ImGui.Text("Contexts") 
	ImGui.SameLine()
	editor.listAIContext("Contexts","Add your AI contexts here",entity,"contexts")
	ImGui.Spacing()
	
	ImGui.Spacing()
	
	return entity
end


return editor	