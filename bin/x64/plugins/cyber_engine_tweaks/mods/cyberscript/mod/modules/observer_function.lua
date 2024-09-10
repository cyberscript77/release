logme(1,"CyberScript: observer function module loaded")
cyberscript.module = cyberscript.module +1
------print("hot reload test")
---Observer and Overrider---

local myucurrentQuestData = nil
local hudPhoneShowAvatar = false --Set by HudPhoneAvatarController_ShowAvatar

observerthread1 = false
observerthread2 = false
observerthread3 = false
observerthread4 = false
observerthread5 = false
observerthread6 = false
observerthread7 = false
observerthread8 = false
observerthread9 = false
observerthread10 = false

cyberscript.observers = {}
cyberscript.observers.browser = dofile('mod/modules/observers/browser.lua')
cyberscript.observers.codex = dofile('mod/modules/observers/codex.lua')
cyberscript.observers.gamecontroller = dofile('mod/modules/observers/gamecontroller.lua')
cyberscript.observers.important = dofile('mod/modules/observers/important.lua')
cyberscript.observers.mappin = dofile('mod/modules/observers/mappin.lua')
cyberscript.observers.npcpuppet = dofile('mod/modules/observers/npcpuppet.lua')
cyberscript.observers.phone = dofile('mod/modules/observers/phone.lua')
cyberscript.observers.player = dofile('mod/modules/observers/player.lua')
cyberscript.observers.quest = dofile('mod/modules/observers/quest.lua')
cyberscript.observers.scanner = dofile('mod/modules/observers/scanner.lua')
cyberscript.observers.setting = dofile('mod/modules/observers/setting.lua')
cyberscript.observers.subtitle = dofile('mod/modules/observers/subtitle.lua')
cyberscript.observers.worldmap = dofile('mod/modules/observers/worldmap.lua')









function printChild(widget)
	if(observerthread == true or moddisabled  == true)   then return end
	if(widget ~= nil) then
		logme(10,tostring(NameToString(widget.name)).." "..GameDump(widget))
		local result = pcall(function() widget:GetNumChildren() end)
		
		if(result) then
			if(widget:GetNumChildren() > 0) then
				for i=0,widget:GetNumChildren() do
					logme(10,tostring(NameToString(widget.name)).." ["..tostring(i).."]")
					printChild(widget:GetWidgetByIndex(i))
					
				end
				
			end
		end
	end
end

---Observer and Overrider---
--observerthread6
---Misc Function---
function startListeners(player)
	if(observerthread6 == true or moddisabled  == true)  then return  end
	player:UnregisterInputListener(player, 'QuickMelee')
	player:UnregisterInputListener(player, 'CameraAim')
	player:UnregisterInputListener(player, 'DeviceAttack')
	player:RegisterInputListener(player, 'QuickMelee')
	player:RegisterInputListener(player, 'CameraAim')
	player:RegisterInputListener(player, 'DeviceAttack')
end
---Misc Function---

function listenPlayerInput(action)
	if(observerthread6 == true or moddisabled  == true)  then return  end
	actionName = Game.NameToString(action:GetName(action))
	actionType = action:GetType(action).value
	actionValue = action:GetValue(action)
	-- if((actionType == "BUTTON_RELEASED" or actionType == "BUTTON_PRESSED") and (string.find(tostring(actionName), "hoiceScrollUp") or string.find(tostring(actionName), "hoiceScrollDown") or string.find(tostring(actionName), "up_button") or string.find(tostring(actionName), "down_button") or string.find(tostring(actionName), "hoice1") or string.find(tostring(actionName), "hoice2") or string.find(tostring(actionName), "hoice3") or string.find(tostring(actionName), "hoice4")))then 
	
	
	-- end
	
	-- if (string.find(tostring(actionName), "AXIS") == nil) then
	-- logme(1,actionName)
	-- --logme(10,"currentPhoneConversation"..dump(currentPhoneConversation))
	-- logme(1,actionType)
	-- end
	
	local phoneAction = false 
	
	if actionName == "PhoneReject" and actionType == "BUTTON_HOLD_COMPLETE" and currentPhoneCall ~= nil   then 
		StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
		phoneAction = true 
		local audioEvent = SoundStopEvent.new()
		audioEvent.soundName = "ui_phone_incoming_call"
		Game.GetPlayer():QueueEvent(audioEvent)
		
		runActionList(currentPhoneCall.rejected_action,"phone_call","interact",false,"player")
		incomingCallGameController:OnInitialize()
		currentPhoneCall = nil
		
		phoneAction = false 
		else
		if actionName == "PhoneInteract" and phoneAction == false and actionType == "BUTTON_RELEASED" and currentPhoneCall ~= nil   then 
			logme(10,"dddssssd")
			StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
			
			local audioEvent = SoundStopEvent.new()
			audioEvent.soundName = "ui_phone_incoming_call"
			Game.GetPlayer():QueueEvent(audioEvent)
			
			runActionList(currentPhoneCall.answer_action,"phone_call","interact",false,"player")
			incomingCallGameController:OnInitialize()
			currentPhoneCall = nil
			StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
			
		end
	end
	
	
	
	
	pcall(function()
		if currentHelp ~= nil and currentHelpIndex ~= nil and (actionName == "cancel" and actionType == "BUTTON_RELEASED" and currentController == "gamepad") or ((actionName == "proceed_popup") and actionType == "BUTTON_RELEASED" and currentController ~= "gamepad")then
			
			local actionlisth = {}
			local actionh = {}
			if(currentHelp ~= nil and currentHelpIndex-1 < #currentHelp.section)then
				
				UIPopupsManager.ClosePopup()
				currentHelp = nil
				currentHelpIndex = 1
				else
				actionh.name = "previous_help"
				table.insert(actionlisth,actionh)
				
				actionh = {}
				actionh =currentHelp.action
				actionh.name = "open_help"
				actionh.tag = currentHelp.tag
				table.insert(actionlisth,actionh)
				
				runActionList(actionlisth,currentHelp.tag,"interact",true,"player")
				
			end		
		end
	end)
	if currentHelp ~= nil and (actionName == "close_tutorial" and actionType == "BUTTON_RELEASED" and currentController == "gamepad") or ((actionName == "activate" or actionName == "close_tutorial") and actionType == "BUTTON_RELEASED" and currentController ~= "gamepad") then
		
		local actionlisth = {}
		local actionh = {}
		pcall(function()
			
			if(currentHelpIndex+1 > #currentHelp.section)then
				UIPopupsManager.ClosePopup()
				currentHelp = nil
				currentHelpIndex = 1
				else
				actionh.name = "next_help"
				table.insert(actionlisth,actionh)
				actionh = {}
				actionh =currentHelp.action
				actionh.name = "open_help"
				actionh.tag = currentHelp.tag
				table.insert(actionlisth,actionh)
				
				runActionList(actionlisth,currentHelp.tag,"interact",true,"player")
			end	
		end)
	end
	
	if ((string.find(tostring(actionName), "down_button") and currentDialogHub == nil and actionType == "BUTTON_RELEASED" and currentController == "gamepad")) then
		
		cycleInteract2()
	end
	
	if((actionType == "BUTTON_RELEASED" or actionType == "BUTTON_PRESSED") and (string.find(tostring(actionName), "hoiceScrollUp") or string.find(tostring(actionName), "hoiceScrollDown") or string.find(tostring(actionName), "up_button") or string.find(tostring(actionName), "down_button") or string.find(tostring(actionName), "hoice1") or string.find(tostring(actionName), "hoice2") or string.find(tostring(actionName), "hoice3") or string.find(tostring(actionName), "hoice4")))then 
		
		local inputHitted = false
		
		if(isdialogactivehub == false and candisplayInteract == true ) then
		
			
			if(#loadInteract > 0  ) then
				--print("tnsebdomdokjk")
				local inputIndex = 0
				if(actionName == "Choice1") then
					inputIndex = 1
				end
				if(actionName == "Choice2") then
					inputIndex = 2
				end
				if(actionName == "Choice3") then
					inputIndex = 3
				end
				if(actionName == "Choice4") then
					inputIndex = 4
				end
			
				local interact = cyberscript.cache["interact"][loadInteract[inputIndex]].data
				runActionList(interact.action,interact.tag,"interact",false,"player")
				
				else
				
				
				if(possibleInteractDisplay[currentPossibleInteractChunkIndex] ~= nil) then
					for i = 1, #possibleInteractDisplay[currentPossibleInteractChunkIndex] do
						--	--------print"expected input for "..possibleInteractDisplay[currentPossibleInteractChunkIndex][i].name.." : "..possibleInteractDisplay[currentPossibleInteractChunkIndex][i].input)
						if(inputIndex == i) then
							runActionList(possibleInteractDisplay[currentPossibleInteractChunkIndex][i].action,possibleInteractDisplay[currentPossibleInteractChunkIndex][i].tag,"interact",false,"player")
							if(currentHouse == nil or (currentHouse ~= nil and interactautohide == true)) then
								currentPossibleInteractChunkIndex = 0
								
								createInteraction(false)
								candisplayInteract = false
							end
						end
					end
				end
				
				
			end
		end
	end
	
	
	
	if #currentInputHintList > 0 then
		for i = 1, #currentInputHintList do
			
			if(currentInputHintList[i] ~= nil and currentInputHintList[i].key == actionName and actionType == "BUTTON_RELEASED") then
				local inter = cyberscript.cache["interact"][currentInputHintList[i].tag].data
				runActionList(inter.action,inter.tag,"interact",false,"player")
			end
		end
	end
	
	inputAV(action)
end



--OLD Code


function VehiclesManagerPopupGameController_SetupData(this, wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod()  end
	
	local currnetData 
	
	local result = {}
	
	local vehicleRecord
	local vehiclesList
	vehiclesList = Game.GetVehicleSystem():GetPlayerUnlockedVehicles()
	
	
	for i,vehicle in ipairs(vehiclesList) do
		
		if TDBID.IsValid(vehicle.recordID) then
			vehicleRecord = TweakDBInterface.GetVehicleRecord(vehicle.recordID)
			currnetData =  VehicleListItemData.new()
			currnetData.displayName = vehicleRecord:DisplayName()
			currnetData.icon = vehicleRecord:Icon()
			currnetData.data = vehicle
			table.insert(result, currnetData)
		end
		
	end
	
	
	for k,data in pairs(cyberscript.cache["garage"]) do
		
		local vehicle = data.data
		
		currnetData =  VehicleListItemData.new()
		currnetData.displayName = vehicle.name
		if(vehicle.icon ~= nil) then
			currnetData.icon = TweakDBInterface.GetUIIconRecord("UIIcon."..vehicle.icon)
			else
			currnetData.icon = TweakDBInterface.GetUIIconRecord("UIIcon.".."ItemIcon")
		end
		local vehiclePlayerVehicle = vehiclePlayerVehicle.new()
		CName.add(vehicle.tag)
		
		
		vehiclePlayerVehicle.name = CName.new(vehicle.tag)
		vehiclePlayerVehicle.recordID = TweakDBID.new(vehicle.tweak)
		vehiclePlayerVehicle.vehicleType = vehicle.type
		vehiclePlayerVehicle.isUnlocked  = checkTriggerRequirement(vehicle.requirement,vehicle.trigger)
		
		currnetData.data = vehiclePlayerVehicle
		--------print(dump(vehicle))
		--------print(dump(vehiclePlayerVehicle))
		if(vehiclePlayerVehicle.isUnlocked) then
			
			table.insert(result, currnetData)
		end
	end
	
	
	--------print(dump(result))
	for i,v in ipairs(result) do
		
		--------print(GameDump(v))
		
	end
	
	
	this.dataView:EnableSorting()
	this.dataSource:Reset(result)
	
	
	
	
	
	
end


function VehiclesManagerListItemController_OnDataChanged(this,value, wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return  end
	this.vehicleData = FromVariant(value)
	if(cyberscript.cache["garage"][NameToString(this.vehicleData.data.name)] ~= nil) then
		
		local myvehicle = cyberscript.cache["garage"][NameToString(this.vehicleData.data.name)].data
		--------print(dump(myvehicle))
		
		inkTextRef.SetText(this.label, myvehicle.name)
		
		else
		
		
		inkTextRef.SetLocalizedTextScript(this.label, this.vehicleData.displayName)
		
		
	end
	
	
	if this.vehicleData.data.vehicleType == gamedataVehicleType.Bike then
		inkImageRef.SetTexturePart(this.typeIcon, "motorcycle")
		else 
		inkImageRef.SetTexturePart(this.typeIcon, "car")
	end
end

function VehiclesManagerPopupGameController_Activate(this, wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod()  end
	
	
	local selectedItem = this.listController:GetSelectedItem()
	
	local vehicleData = selectedItem:GetVehicleData()
	--------print(GameDump(vehicleData))
	--------print(GameDump(vehicleData.data))
	if(cyberscript.cache["garage"][NameToString(vehicleData.data.name)] ~= nil) then
		
		local myvehicle = cyberscript.cache["garage"][NameToString(vehicleData.data.name)].data
		--------print(dump(myvehicle))
		runActionList(myvehicle.action,myvehicle.tag,"interact",false,"player")
		this:Close()
		else
		
		wrappedMethod()
		
	end
	
	
	
end

--observerthread5

--observerthread6
