logme(1,"CyberScript: relation module loaded")
cyberscript.module = cyberscript.module +1

--Phone UI --
function refreshContact()
	
	
	
	getNPCCallableByAffinity()
	
	waitNPCTakeCoffee = false
	waitNPCTakeBeer = false
	waitNPCGoNightClub = false
	
	waitNPCLookMovie = false
	waitNPCDinner = false
	waitNPCSleepHome = false
	
	waitDoShopping = false
	
	timerDespawn = nil
	openPhone = true
	
	
	
	
	
end

--NPC--

function selectNPCForCall(npc)
	
	
	currentNPC = npc
		-- createInteraction(false)
	if cyberscript.autoload == false then
		getMissionByTrigger()
		
		
	end
	--getMissionByTrigger()
	
	
	
	
	loadBasicDialog(npc,"phone")
	
	
	openPhoneDialogWindow = true
	
	openPhone = false
	
	isPhoneDialog = true
	
	PhoneFistDialogPass = false
	
end

function selectNPCForSpeak(npc)
	
	--createInteraction(false)
	currentStar = npc
	
	loadBasicDialog(npc,"speak")
	
	openSpeakDialogWindow = true
	startSpeak = true
	
	logme(2,"speak init")
	
	
	
end

function getActionbyNPCscore(npc,display)
	
	getTriggeredActions()
	
	if(#possibleInteract > 0) then
		
		for z=1, #possibleInteract do
			if(possibleInteract[z].display == display)then
				npcCustomActions(npc,possibleInteract[z])
			end
			
		end
		
	end
	
local score = getScoreKey(npc.Names,"Score")
logme(2,"NPC Score : !!!")
logme(2,score)
	if score ~= nil and score >= 20 then
		npcAskHelp(npc)
		
	end
	
	
end





--Dialog --

--Load


function loadBasicDialog(npc,way)
	--currentPhoneDialog = nil
	-- currentPhoneDialog = arrayDialog["phone_default_basic_01"].dialog
	-- logme(2,currentPhoneDialog.Desc)
	
	-- logme(2,#currentPhoneDialog.options)
	--currentPhoneDialog.speaker.value = npc.ID
	logme(10,way)
	if(way == "phone") then
	
	
	logme(10,"load for phone")
	local dial = arrayDialog["phone_default_basic_01"].dialog
	dial.speaker.value = npc.Names
	
	local usedial =  SetNextDialog("phone_default_basic_01","phone")
	
	createDialog(usedial)
	
	else
	
	
	logme(10,"load for speak")
	local dial = arrayDialog["speak_default_basic_01"].dialog
	dial.speaker.value = npc.Names
	
	local usedial =  SetNextDialog("speak_default_basic_01","speak",npc.Names)
	
	createDialog(usedial)
	
	end
	logme(2,"loaded")
	
end






function IsDialogTrigged(dialog)
	local result = false
	testTriggerRequirement(dialog.requirement,dialog.trigger)
	result = checkTriggerRequirement(dialog.requirement,dialog.trigger)
	
	return result
end

function doOptionAction(dialogOption,way)
	
	if(#dialogOption.action > 0) then
		
		
		--doActionof(dialogOption.action,way)
		runActionList(dialogOption.action,"options_"..math.random(1,999),way,false,"player")
	end	
end


function GetDialogOptionBasicCustom(npc, source)
	
	
	logme(2,"Loading custom dialog options...")
	logme(2,npc.ID)
	logme(2,source)
	local currentdialogOptionList = {}
	
	
	for key,value in pairs(arrayDialog) do --actualcode
		
		-- logme(2,arrayDialog[key].dialog.speaker.way)
		-- logme(2,arrayDialog[key].dialog.Tag)
		-- logme(2,"requirement "..#arrayDialog[key].dialog.requirement)
		
		local diag = arrayDialog[key].dialog
		if(
			(diag.speaker.value == npc.Names or diag.speaker.value == "any")
			and #diag.requirement == 0 
			and diag.speaker.way == source 
			and string.match(diag.Tag, "phone_default_basic") == nil
			and string.match(diag.Tag, "phone_default_custom_init") == nil
			)then
			
			for y=1, #diag.options do
				
				if(checkTriggerRequirement(diag.options[y].requirement,diag.options[y].trigger) == true) then
					table.insert(currentdialogOptionList, diag.options[y])
					logme(10,dump(diag.options[y]))
				end
			end
			end
	end
	
	
	
		local option = {}
		option.Description = "We talk later."
		option.action = {}
		option.trigger = {}
		option.trigger.auto = {}
		option.trigger.auto.name = "auto"
		option.requirement = {}
		option.input = 1
		
		local requirem = {}
		table.insert(requirem,"auto")
		
		table.insert(option.requirement,requirem)
		
		table.insert(currentdialogOptionList,option)
	
	
	
	logme(10,#currentdialogOptionList)
	return currentdialogOptionList
end


function ClickOnDialog(currentdialoption, npcId, way)
	
	
	
	local havedial = false
	-- if(#currentdialoption.action > 0) then
		-- for i = 1,#currentdialoption.action do
		
			-- if(currentdialoption.action[i].name == "dialog" or currentdialoption.action[i].name == "do_random_dialog") then
			-- havedial = true
			-- end
			
		-- end
	-- else
	
		-- havedial = false
	-- end
	
	isdialogactivehub = havedial
	
	
	if(isdialogactivehub == false) then
		removeDialog()
		currentDialogHub = nil
	
	end
	doOptionAction(currentdialoption,way)
	
	--SetDialogPhoneUI(currentPhoneDialog)
end



function SetNextDialog(tag,source)
	currentPossibleInteractChunkIndex = 0
	--logme(2,"my dialog is"..tag)
	if(tag == "phone_default_custom_init") then
	
		
	
		logme(10,"abotu what "..source)
		
		local speak = {}
		
		if(source == "quest") then
			speak.value = currentNPC.Names
		end
		
		if(source == "interact") then
			speak.value = currentNPC.Names
		end
		
		if(source == "phone") then
			
			
			speak.value = currentNPC.Names
		end
		
		if(source == "speak") then
			speak.value = currentStar.Names
		end
		
		
		
		local currentNPCSpeaker = getNPCByName(speak.value)
		
	
		
		
		speak.way = source
		
		local dial = {}
		
		dial.speaker = speak
		dial.Tag = "DialogCustomInitAnswer"
		dial.Desc = lang.DialogCustomInitAnswer
		
		dial.trigger = {}
		
		PhoneFistDialogPass = true
		
		
		
		dial.options = GetDialogOptionBasicCustom(currentNPCSpeaker, source)
		
		logme(1,"SetNextDialog DialogCustomInitAnswer nb dialog option "..tostring(#dial.options))
		
		
		if(#dial.options > 0) then
				for i=1,#dial.options do
				
					local title = dial.options[i].Description
					
					if(lang[title]) ~= nil then
						dial.options[i].Description = lang[title]		
						logme(1,"SetNextDialog DialogCustomInitAnswer dialog option "..tostring(dial.options[i].Description))
					end	
				
				end
				
				
		else
		
		local option = {}
		option.Description = getLang("relation_talklater")
		option.action = {}
		option.trigger = {}
		option.trigger.auto = {}
		option.trigger.auto.name = "auto"
		option.requirement = {}
		
		option.input = 1
		
		local requirem = {}
		table.insert(requirem,"auto")
		
		table.insert(option.requirement,requirem)
		
		table.insert(dial.options,option)
		
		end
		return dial
		
		
	else
		local diag = arrayDialog[tag].dialog
		
		
		
		
		if(IsDialogTrigged(diag)) then
			
			checkContext(diag)
			
			
			logme(10,"founded")
			haveDialogLoaded = true
			local dialogy = diag
			
			local title = dialogy.Desc
		
			if(lang[title]) ~= nil then
				dialogy.Desc = lang[title]		
			end
			
			
			
			
			if(#dialogy.options > 0) then
				for i=1,#dialogy.options do
				
						checkContext(dialogy.options[i])
					
				
						
				
					local title = dialogy.options[i].Description
					
					if(lang[title]) ~= nil then
						dialogy.options[i].Description = lang[title]		
					end	
			
			
			
				end
				else
				
				if(#dialogy.options == 0 or dialogy.options == nil) then
			
					dialogy.options = {}
					
					local option = {}
					option.Description =getLang("relation_talklater")
					option.action = {}
					option.trigger = {}
					option.trigger.auto = {}
					option.trigger.auto.name = "auto"
					option.requirement = {}
					option.input = 1
					
					local requirem = {}
					table.insert(requirem,"auto")
					
					table.insert(option.requirement,requirem)
					
					table.insert(dialogy.options,option)
					
				end
				
			end
			
			logme(10,dialogy.Desc)
			return dialogy
			
		else
			local speak = diag.speaker
			
			
			local dialog = {}
			dialog.Desc = lang.BadAnswer
			dialog.speaker = speak
			dialog.Tag = "BadAnswer"
			dialog.trigger = {}
			dialog.requirement = {}
			dialog.options = {}
			dialog.havequitoption = true
		
			
			
			PhoneFistDialogPass = false
			haveDialogLoaded = true
			return dialog
			
		end
		
		
		
		
		
	end
	
	
	
	
	
	
	
end


--Custom Message


function customEventMessage(message, npc)
	openSpeakDialogWindow = false
	openPhoneDialogWindow = false
	openEventDialogWindow = false
	local speak = {}
	
	speak.value = npc.Names
	speak.way = "interact"
	
	logme(2,"Event"..message)
	currentEventDialog = {}
	currentEventDialog.Desc = message
	
	currentEventDialog.speaker =speak
	currentEventDialog.Tag = "Event"
	currentEventDialog.trigger = {}
	currentEventDialog.options = {}
	
	logme(2,"Event"..currentEventDialog.Desc)
	openEventDialogWindow = true
	
	
end



--Action Event --
function npcAskHelp(npc)--0
	
	
	local x = ImGui.GetWindowSize()
	local screenWidth, screenHeight = GetDisplayResolution()
	CPS.colorBegin("Button", { 48, 234, 247 ,0})  -- get color from styles.lua
	CPS.colorBegin("Text", "28F0FF")-- get color from styles.lua
	if ImGui.Button(" | "..lang.NPCActionHelp, (screenWidth/12)*6, 0) then
		
		if(npcStarSpawn == false)then
			dbPnjId = currentNPC
			currentStar = 	currentNPC
			
			logme(2,"your star is "..currentStar.Names)
			local positionVec4 = Game.GetPlayer():GetWorldPosition()
			
			
			
			positionVec4.x = positionVec4.x + -5
			positionVec4.y = positionVec4.y + -5
			positionVec4.z = positionVec4.z 
			
			spawnEntity(dbPnjId.TweakIDs,  "current_star", positionVec4.x, positionVec4.y ,positionVec4.z,2,false)
			
			table.insert(cyberscript.GroupManager["companion"].entities,"current_star")
				
			doFunction("currentstar_follower",nil,nil)
			
		
			npcStarSpawn = true
			
			
			
			else
			logme(2,"NPC already Spawn")
		end
		
		
		openPhoneDialogWindow = false
	end
	
	
	CPS.colorEnd(1)
	CPS.colorEnd(1)
end



--Event Manager
function StarIsHere(timer)
	
	currentStar = currentNPC
	local positionVec4 = Game.GetPlayer():GetWorldPosition()
	
	logme(2,"your star is "..currentStar.Names)
	npcStarSpawn = true
	
	
	Cron.After(1, function()
	
	setFollower("current_star")
	
	

	
	
	local obj = getEntityFromManager("current_star")
	local enti = Game.FindEntityByID(obj.id)
	
	if(enti ~= nil) then
	local reaction = {}
				
				
	reaction.category = 1
	reaction.idle = 9
	makeFacial(enti,reaction)		
	
	talk(enti,"greeting")
	
	end
	
	if(timer ~= nil or timer ~= 0) then
	timerDespawn = getGameTime()
	timerDespawn.hour = timerDespawn.hour + timer
	
	if(timerDespawn.hour>24)then
		timerDespawn.hour = timerDespawn.hour - 24
		timerDespawn.day = timerDespawn.day+1
	end
	
	logme(2,"NPC wil despawn at day : "..timerDespawn.day.." hours : "..timerDespawn.hour)
	end
	end)
	
end


function npcCustomActions(npc,interact,way)--0
	local x = ImGui.GetWindowSize()
	local screenWidth, screenHeight = GetDisplayResolution()
	CPS.colorBegin("Button", { 48, 234, 247 ,0})  -- get color from styles.lua
	CPS.colorBegin("Text", "28F0FF")-- get color from styles.lua

	if ImGui.Button(" | "..interact.name, (screenWidth/12)*6, 0) then	
		waitingTag = interact.tag
		
		if(interact.message == nil) then
		customEventMessage(lang.JoinYou01,npc)							
		else
		customEventMessage(interact.message,npc)							
		end
		
	end
	
	CPS.colorEnd(1)
	CPS.colorEnd(1)
	
end


function StarEventManager()
	
	if waitingTag ~= nil then
	logme(2,waitingTag)
		local interact = nil
		interact = arrayInteract[waitingTag].interact
		
		
		if interact ~= nil then
			
			
			if currentHouse ~= nil then
				
				
				if(npcStarSpawn == false)then
					logme(2,"star spawn")
					StarIsHere(interact.timer)
					
						Cron.After(5, function(interact)
					
						
						local interact = nil
						interact = arrayInteract[waitingTag].interact
						waitingTag = nil
						--doActionof(interact.action,"interact")
						runActionList(interact.action,waitingTag,"interact",false,"see_engine")
						end)
					
					
					
					
				end
				
				
				
			end
			
		end
		
	end
	
	
end


