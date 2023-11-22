logme(1,"CyberScript: see module loaded")
cyberscript.module = cyberscript.module +1


function checkTrigger(trigger)
	
	local status, result = pcall(scriptcheckTrigger,trigger)
	
	
	
	if status == false then
		logme(1,dump(trigger),true)
		if(trigger.output == true) then 
			
			logme(1,trigger.name,true)
			logme(1,dump(trigger),true)
			logme(1,tostring(result),true)
			
		end
		
		logme(1,getLang("see_trigger_error") .. result.." Trigger : "..tostring(JSON:encode_pretty(trigger)),true)
		if(trigger.fail_action ~= nil and #trigger.fail_action > 0) then
			runActionList(trigger.fail_action, trigger.name.."_failure", "see",false,nil)
			
		end
		--Game.GetPlayer():SetWarningMessage("CyberScript Trigger error, check the log for more detail")
		return false
		else
		return result
		
	end
	
	
	
end

--Check trigger core function
function scriptcheckTrigger(trigger)
	local result = false
	if trigger ~= nil then 
		
		local entityregion = true
		local groupregion = true
		local vehiculeregion = true
		local scoreregion = true
		local houseregion = true
		local gangregion = true
		local miscregion = true
		local relationregion = true
		local questregion = true
		local noderegion = true
		local soundregion = true
		local logicregion = true
		local uiregion = true
		local avregion = true
		local customnpcregion = true
		local multiregion = true
		local frameworkregion = true
		local playerregion = true
		local scannerregion = true
		local airegion = true
		
		checkContext(trigger)
		
		
		
		if entityregion then
			if(trigger.name == "npc") then
				if(trigger.way == "phone") then
					if currentNPC ~= nil then
						if(currentNPC.Names == (trigger.value))then
							result = true
						end
					end
				end
				if(trigger.way == "speak") then
					if currentStar ~= nil then
						if(currentStar.Names == (trigger.value))then
							result = true
						end
					end
				end
				if(trigger.way == "fixer") then
					if currentfixer ~= nil then
						if(currentfixer.tag == trigger.value)then
							result = true
						end
					end
				end
			end
			
			if(trigger.name == "entity_is_spawn") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						----logme(3,"entity is active"..tostring(enti:IsAttached()))
						if (enti:IsAttached() == true)then
							----logme(3,"entity is actived"..tostring(enti:IsAttached()))
							result = true
						end
					end
				end
			end
			if(trigger.name == "entity_is_vehicle") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						----logme(3,"entity is active"..tostring(enti:IsAttached()))
						
						----logme(3,"entity is actived"..tostring(enti:IsAttached()))
						result = enti:IsVehicle()
						
					end
				end
			end
			if(trigger.name == "choice_is_opened") then
				result = currentDialogHub ~= nil
			end
			if(trigger.name == "native_choice_is_opened") then
				result = nativeDialogOpen ~= nil and nativeDialogOpen == true
			end
			if(trigger.name == "inject_dialog_pending") then
				
				result = interactionUI.injectdialog ~= nil and #interactionUI.injectdialog ~= 0
			end
			if(trigger.name == "specific_choice_is_opened") then
				--print(currentDialogHub.dial.tag)
				result = currentDialogHub ~= nil and currentDialogHub.dial.tag == trigger.tag
			end
			if(trigger.name == "entity_tag_exist") then
				result = cyberscript.EntityManager[trigger.tag] ~= nil
			end
			if(trigger.name == "entity_is_scanned") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						----logme(3,"entity is active"..tostring(enti:IsAttached()))
						if (enti:IsScanned() == true)then
							----logme(3,"entity is actived"..tostring(enti:IsAttached()))
							result = true
						end
					end
				end
			end
			if(trigger.name == "entity_is_crowd") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						----logme(3,"entity is active"..tostring(enti:IsAttached()))
						result = enti:IsCrowd()
					end
				end
			end
			if(trigger.name == "look_at_object") then
				if objLook ~= nil then
					tarName = objLook:ToString()
					appName = Game.NameToString(objLook:GetCurrentAppearanceName())
					dipName = objLook:GetDisplayName()
					if(tarName ~= nil and appName ~= nil)then
						if(
							string.match(tarName, trigger.value) or
							string.match(appName, trigger.value) or 
							string.match(dipName, trigger.value) or 
						(trigger.value == "isnpc" and objLook:IsA("ScriptedPuppet")))then 
						result = true
						end
					end
				end
			end
			if(trigger.name == "scanned_entity") then
				if scannedEntity ~= nil then
					local obj = getEntityFromManager(trigger.value)
					if(obj.id ~= nil) then
						local enti = Game.FindEntityByID(obj.id)	
						if(enti ~= nil) then
							
							if(enti:GetEntityID().hash == scannedEntity:GetEntityID().hash and (trigger.npc_only == false or (trigger.npc_only == true and enti:IsA("NPCPuppet"))))then 
								result = true
							end
						end
						
					end
				end
			end
			if(trigger.name == "entity_is_a") then
			
					local obj = getEntityFromManager(trigger.tag)
					if(obj.id ~= nil) then
						local enti = Game.FindEntityByID(obj.id)	
						if(enti ~= nil) then
							
							if(enti:IsA(trigger.value))then 
								result = true
							end
						end
						
					end
				
			end
			if(trigger.name == "look_at_entity") then
				if objLook ~= nil then
					local obj = getEntityFromManager(trigger.value)
					if(obj.id ~= nil) then
						local enti = Game.FindEntityByID(obj.id)	
						if(enti ~= nil) then
							
							if(enti:GetEntityID().hash == objLook:GetEntityID().hash)then 
								result = true
							end
						end
						
					end
					
				end
			end
			if(trigger.name == "look_at_hash") then
				if objLook ~= nil then
					
					if(trigger.value == tostring(objLook:GetEntityID().hash))then 
						result = true
					end
					
					
				end
			end
			if(trigger.name == "killed_entity") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				if(enti ~= nil) then
					
					result = (enti:IsDead() == true or enti:IsActive() == false)
					
				end
			end
			if(trigger.name == "entity_is_alive") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				if(enti ~= nil) then
					
					result = enti:IsDead() == false and enti:IsActive() == true
				end
			end
			if(trigger.name == "entity_looked_is_follower") then
				local isFollower = false
				if objLook ~= nil then
					tarbName =  objLook:ToString()
				end
				if objLook ~= nil and (string.match(tarbName, "NPCPuppet"))then 
					local aicontrol =  nil
					pcall(function()
						aicontrol  =  objLook:GetAIControllerComponent()
					end)
					if(aicontrol ~= nil) then
						local currentRole =aicontrol:GetAIRole()
						isFollower = (currentRole and (currentRole:IsA('AIFollowerRole')) )
						if(isFollower == nil) then
							isFollower = false
						end
					end
				end
				result = isFollower
			end
			if(trigger.name == "entity_looked_is_registered") then
				if objLook ~= nil then
					tarName = objLook:ToString()
					appName = Game.NameToString(objLook:GetCurrentAppearanceName())
					dipName = objLook:GetDisplayName()
					local entid = objLook:GetEntityID()
					local entity = getEntityFromManagerById(entid)
					if(entity.id ~= nil) then
						result = true
					end
				end
			end
			if(trigger.name == "entity_at_position") then
				local obj = getEntityFromManager(trigger.tag)
				--logme(3,obj.tag)
				local enti = Game.FindEntityByID(obj.id)
				if(enti ~= nil) then
					if(trigger.position == nil) then trigger.position = "at" end
					
					local targetPosition = getPositionFromParameter(trigger)
					
					
					if (targetPosition.x ~= nil and check3DPos(enti:GetWorldPosition(), targetPosition.x, targetPosition.y, targetPosition.z,trigger.range)) then
						result = true
						else
						result = false
					end
					else
					--logme(3,"entity not found : "..trigger.tag)
				end
			end
			if(trigger.name == "entity_in_state") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				if(enti ~= nil) then
					local testres, err = pcall(function()
						local levelstate = enti:GetHighLevelStateFromBlackboard()
						local triggerlevelstate  = gamedataNPCHighLevelState.Any
						if(trigger.value == 0) then
							triggerlevelstate  = gamedataNPCHighLevelState.Alerted
						end
						if(trigger.value == 2) then
							triggerlevelstate  = gamedataNPCHighLevelState.Combat
						end
						if(trigger.value == 3) then
							triggerlevelstate  = gamedataNPCHighLevelState.Dead
						end
						if(trigger.value == 4) then
							triggerlevelstate  = gamedataNPCHighLevelState.Fear
						end
						if(trigger.value == 5) then
							triggerlevelstate  = gamedataNPCHighLevelState.Relaxed
						end
						if(trigger.value == 6) then
							triggerlevelstate  = gamedataNPCHighLevelState.Stealth 
						end
						if(trigger.value == 7) then
							triggerlevelstate  = gamedataNPCHighLevelState.Unconscious
						end
						if(trigger.value == 8) then
							triggerlevelstate  = gamedataNPCHighLevelState.Wounded
						end
						if(trigger.value == 9) then
							triggerlevelstate  = gamedataNPCHighLevelState.Count
						end
						if(trigger.value == 10) then
							triggerlevelstate  = gamedataNPCHighLevelState.Invalid
						end
						
					end)
					if testres == false then
						triggerlevelstate= gamedataNPCHighLevelState.Invalid
						----print(triggerlevelstate)
					end
					
					if(levelstate == triggerlevelstate) then
						result = true
					end
				end
			end
			if(trigger.name == "entity_inbuilding")then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				result = Game.IsEntityInInteriorArea(enti)
			end
			if(trigger.name == "entity_gender") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						logme(1,GetEntityGender(enti))
						logme(1,trigger.value)
						if(trigger.value == tostring(GetEntityGender(enti))) then
							result = true
							else
							result =  false
						end
					end
				end
				
			end
			if(trigger.name == "entity_hash") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						
						if(trigger.value == tostring(enti:GetEntityID().hash)) then
							result = true
							
						end
					end
				end
				
				
			end
			if(trigger.name == "entity_script_level") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					if(checkValue(trigger.operator,obj.scriptlevel,trigger.scriptlevel,trigger.min,trigger.max)) then
						
						result = true
						
					end
					
				end
			end
			
			if(trigger.name == "last_killed_entity_is_registred") then
				if getEntityFromManager("last_killed").id ~= nil then
					
					
					result = true
					
				end
			end
			if(trigger.name == "if_entity_contains_value") then
				local obj = getEntityFromManager(trigger.tag)
				if(obj.id ~= nil) then
					local enti = Game.FindEntityByID(obj.id)	
					if(enti ~= nil) then
						local entName = enti:ToString()
						local entAppName = Game.NameToString(enti:GetCurrentAppearanceName())
						local entDispName = enti:GetDisplayName()
						
						if(entName ~= nil and entAppName ~= nil)then
							for i,filter in ipairs(trigger.filter) do
								
								if(string.match(entName, filter) or string.match(entAppName, filter) or string.match(entDispName, filter) or filter == tostring(newent:GetEntityID().hash))then 
									result = true
								end
							end
						end
					end
				end
				
			end
			if(trigger.name == "if_entities_around_entity") then
				
				local obj = getEntityFromManager(trigger.tag)
				local goodEntity = false
   				local enti = Game.FindEntityByID(obj.id)
   				if(enti ~= nil) then
					
					player = Game.GetPlayer()
					targetingSystem = Game.GetTargetingSystem()
					parts = {}
					local success= false
					searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
					searchQuery.maxDistance = trigger.range
					searchQuery.filterObjectByDistance = true
					searchQuery.includeSecondaryTargets  = true
					success, parts = targetingSystem:GetTargetParts(enti, searchQuery)
					
					
					
					
					for _, v in ipairs(parts) do
						local newent = v:GetComponent(v):GetEntity() 
						
						
						
						if(trigger.filter ~= nil and #trigger.filter > 0) then 
							
							
							local entName = newent:ToString()
							local entAppName = Game.NameToString(newent:GetCurrentAppearanceName())
							local entDispName = newent:GetDisplayName()
							
							if(entName ~= nil and entAppName ~= nil)then
								for i,filter in ipairs(trigger.filter) do
									
									if(goodEntity == false and string.match(entName, filter) or string.match(entAppName, filter) or string.match(entDispName, filter) or filter == tostring(newent:GetEntityID().hash))then 
										goodEntity = true
									end
								end
							end
							
							
							
							else
							
							goodEntity = true
							
						end
						
						
						
						
						
					end
					
					
				end
				result = goodEntity
			end													
			
			
			if(trigger.name == "if_entities_around_you") then
				player = Game.GetPlayer()
				targetingSystem = Game.GetTargetingSystem()
				parts = {}
				local success= false
				searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
				searchQuery.maxDistance = trigger.range
				success, parts = targetingSystem:GetTargetParts(Game.GetPlayer(), searchQuery)
				
				
				
				local goodEntity = false
				
				for _, v in ipairs(parts) do
					local newent = v:GetComponent(v):GetEntity() 
					
					
					
					if(trigger.filter ~= nil and #trigger.filter > 0) then 
						
						
						local entName = newent:ToString()
						local entAppName = Game.NameToString(newent:GetCurrentAppearanceName())
						local entDispName = newent:GetDisplayName()
						if(trigger.output) then
							print(entName)
							print(entAppName)
							print(entDispName)
						end
						if(entName ~= nil and entAppName ~= nil)then
							for i,filter in ipairs(trigger.filter) do
								
								if(goodEntity == false and string.match(entName, filter) or string.match(entAppName, filter) or string.match(entDispName, filter) or filter == tostring(newent:GetEntityID().hash) or (filter == "vehicle" and newent:IsVehicle()))then 
									goodEntity = true
								end
							end
						end
						
						
						
						else
						
						goodEntity = true
						
					end
					
					
					
					
					
				end
				
				result = goodEntity
			end													
		end
		
		if groupregion then
			if(trigger.name == "group_is_spawn") then
				local enemy_count = 0
				local group =getGroupfromManager(trigger.tag)
				--logme(3,group.tag)
				--logme(3,#group.entities)
				if(group ~= nil) then
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)	
						--logme(3,obj.tag)
						--logme(3,obj.id)
						--logme(3,enti)
						if(enti ~= nil) then
							--logme(3,"entity is active"..tostring(enti:IsAttached()))
							if (enti:IsAttached() == true)then
								--logme(3,"npc have be killed")
								enemy_count = enemy_count + 1
							end
						end
					end
					if (enemy_count == #group.entities) then
						result = true
					end
				end
			end
			if(trigger.name == "killed_group") then
				local enemy_count = 0
				local group =getGroupfromManager(trigger.tag)
				if(group ~= nil ) then
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)	
						if(enti ~= nil) then
							--logme(3,"entity is active"..tostring(enti:IsActive()))
							if (enti:IsDead() == true or enti:IsActive() == false)then
								
								enemy_count = enemy_count + 1
							end
							elseif(obj.id == nil or enti == nil) then
							enemy_count = enemy_count + 1
						end
					end
					if (enemy_count == #group.entities) then
						result = true
						--logme(3,tostring(result))
					end
				end
			end
			if(trigger.name == "group_script_level") then
				local group =getGroupfromManager(trigger.tag)
				local count = 0
				if(group ~= nil ) then
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						if(obj.id ~= nil) then
							if(checkValue(trigger.operator,obj.scriptlevel,trigger.scriptlevel,trigger.min,trigger.max)) then
								
								count = count +1
								
							end
						end
					end
					result = (count == #group.entities)
				end
				
				
				
				
			end
		end
		
		if playerregion then
			if(trigger.name == "position") then
				result = checkPos(curPos, trigger.x, trigger.y,trigger.range)
			end
			if(trigger.name == "player_is_noticed") then
				result = playerNoticed
			end
			if(trigger.name == "player_is_targeted") then
				result = playerTargeted
			end
			
			if(trigger.name == "player_is_hit") then
				result = PlayerisHitten
			end
			
			if(trigger.name == "player_death") then
				if(inMenu and ActiveMenu == "DeathMenu")then
					result = true
					
				end
			end
			
			-- if(trigger.name == "check_perk") then
			
			-- local PDS = GameInstance.GetScriptableSystemsContainer():Get("PlayerDevelopmentSystem")
			-- PDS:HasPerk(trigger.value)
			
			-- end
			
			if(trigger.name == "3Dposition") then
				result = check3DPos(Game.GetPlayer():GetWorldPosition(), trigger.x, trigger.y, trigger.z, trigger.range)
			end
			if(trigger.name == "stat") then
				--https://nativedb.red4ext.com/gamedataStatType
				local mod_score = Game.GetStatsSystem():GetStatValue(Game.GetPlayer():GetEntityID(), trigger.value)
				--	logme(3,mod_score)
				if(trigger.score~= nil and tonumber(mod_score) >= tonumber(trigger.score)) then
					result = true
				end
			end
			if(trigger.name == "statpool") then
				--https://nativedb.red4ext.com/gamedataStatPoolType
				local mod_score = Game.GetStatPoolsSystem():GetStatPoolValue(Game.GetPlayer():GetEntityID(), Enum.new('gamedataStatPoolType', trigger.value), trigger.perc)
				--logme(3,mod_score)
				if(trigger.score~= nil and tonumber(mod_score) >= tonumber(trigger.score)) then
					result = true
				end
			end
			if(trigger.name == "item") then
				result = checkItem(trigger.value)
			end
			if(trigger.name == "item_amount") then
				result = checkItemAmount(trigger.value,trigger.score)
			end
			if(trigger.name == "money") then
				result = checkStackableItemAmount("Items.money",trigger.value)
			end
			
			
			if(trigger.name == "player_in_poi") then
				local resultpos = nil
				
				
				if(trigger.district == "current") then
					trigger.district = currentDistricts2.EnumName
				end
				if(trigger.subdistrict == "current") then
					
					if(currentDistricts2.districtLabels ~=nil and #currentDistricts2.districtLabels > 1) then
						
						trigger.subdistrict = currentDistricts2.districtLabels[2]
						
						else
						
						trigger.district = currentDistricts2.EnumName
						
					end
				end
				
				if trigger.position_poi_search == nil then trigger.position_poi_search = "type" end
				if trigger.position_poi_searchdistance == nil then trigger.position_poi_searchdistance = "random" end
				
				resultpos = FindPOI(trigger.tag,trigger.district,trigger.subdistrict,trigger.iscar,trigger.type,trigger.uselocationtag,true,trigger.range,nil,nil,nil,trigger.position_poi_search,trigger.position_poi_searchdistance)
				if(resultpos ~= nil)then
					result = true
				end
			end
			
			if(trigger.name == "player_lifepath") then
				
				local player = Game.GetPlayer()
				local scriptableSystemsContainer = Game.GetScriptableSystemsContainer()
				local playerDevSystem = scriptableSystemsContainer:Get(CName.new('PlayerDevelopmentSystem'))
				local path = playerDevSystem:GetLifePath(player)
				if(trigger.output == true) then
					--print("player_lifepath result "..tostring((path)))
				end
				result = (trigger.value == EnumInt(path))
				
			end
			
			if(trigger.name == "player_have_combatstate") then
				local player = Game.GetPlayer()
				local state = player:GetCurrentCombatState()
				result = (trigger.value == EnumInt(state))
				if(trigger.output == true) then
					--print("player_have_combatstate result "..tostring((state)))
				end
			end
			if(trigger.name == "wanted_level") then
				local level = Game.GetBlackboardSystem():Get(Game.GetAllBlackboardDefs().UI_WantedBar):GetInt(Game.GetAllBlackboardDefs().UI_WantedBar.CurrentWantedLevel)
				if level >= trigger.value then
					result =  true
				end
			end
			if(trigger.name == "player_gender") then
				if(trigger.value == GetPlayerGender()) then
					result = true
					else
					result = false
				end
			end
			if(trigger.name == "player_current_gang"or trigger.name == "player_current_faction") then
				
				local score = getVariableKey("player","current_gang")
				if(score ~= nil and score == trigger.value) then
					result = true
				end
			end
			
		end
		
		if vehiculeregion then
			if(trigger.name == "in_car") then
				local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
				if (inVehicule) then
					local vehicule = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
					result = vehicule ~= nil
				end
			end
			if(trigger.name == "entity_in_car") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				
				if(enti ~= nil) then
					local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(enti)
					if (inVehicule) then
						local vehicule = Game['GetMountedVehicle;GameObject'](enti)
						result = vehicule ~= nil
					end
				end
			end
			if(trigger.name == "vehicle_entity_is_moving") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				
				if(enti ~= nil and enti:IsVehicle()) then
					result = not (enti:GetCurrentSpeed() == 0 or enti:GetCurrentSpeed() == -0 )
					
				end
			end
			
			if(trigger.name == "in_car_specific") then
				local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
				if (inVehicule) then
					local vehicule = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
					if(vehicule ~= nil) then
						local isThiscar = (string.find(string.lower(Game.NameToString(vehicule:GetCurrentAppearanceName())), trigger.value) ~= nil)
						if isThiscar then
							result = true
						end
					end
				end
			end
			if(trigger.name == "entity_in_car_specific") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				
				if(enti ~= nil) then
					local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(enti)
					if (inVehicule) then
						local vehicule = Game['GetMountedVehicle;GameObject'](enti)
						if(vehicule ~= nil) then
							local isThiscar = (string.find(string.lower(vehicule:GetCurrentAppearanceName()), trigger.value) ~= nil)
							if isThiscar then
								result = true
							end
						end
					end
				end
			end
			if(trigger.name == "vehicule_is_in_custom_garage") then
				local test = getVehiclefromCustomGarage(trigger.value)
				if(test ~= nil) then
					result = true
				end
			end
		end
		
		if scoreregion then
			if(trigger.name == "npc_star_affinity") then
				local score = 0
				if(currentStar ~= nil) then
					score = getScoreKey("Affinity",currentStar.Names)
				end
				if(score ~= nil and score >= trigger.value)then
					result = true
				end
			end
			if(trigger.name == "npc_phone_affinity") then
				local score = 0
				if(currentNPC ~= nil) then
					score = getScoreKey("Affinity",currentNPC.Names)
				end
				if(score ~= nil and score >= trigger.value)then
					result = true
				end
			end
			if(trigger.name == "npc_affinity") then
				local score = getScoreKey("Affinity",trigger.value)
				if(score ~= nil and score >= trigger.score)then
					result = true
				end
			end
			if(trigger.name == "entity_affinity") then
				local obj = getEntityFromManager(trigger.tag)
				local score = getScoreKey("Affinity",obj.name)
				if(score ~= nil and score >= trigger.score)then
					result = true
				end
			end
			
			if(trigger.name == "check_variable") then
				local score = getVariableKey(trigger.variable,trigger.key)
				
				if(trigger.operator== nil) then
					
					if(score ~= nil and score == trigger.value) then
						result = true
					end
					
					else
					if(type(score) == "number") then
						
						
						if(checkValue(trigger.operator,score,trigger.value, trigger.min, trigger.max)) then
							
							result = true
							
						end
						else
						
						if(trigger.operator == "=") then
							
							if(score ~= nil and score == trigger.value) then
								
								result = true
							end
							
						end
						
						if(trigger.operator == "!=") then
							
							if(score ~= trigger.value) then
								result = true
							end
							
						end
						
						if(trigger.operator == "contains") then
							
							if(score ~= nil and string.match(score, trigger.value)) then
								result = true
							end
							
						end
						
						if(trigger.operator == "empty" or trigger.operator == "nothing") then
							
							
							result = score == nil or score == ""
							
							
						end				
						
						if(trigger.operator == "notempty" or trigger.operator == "notnothing") then
							
							
							result = score ~= nil and score ~= ""
							
							
						end
					end 
				end
			end
			
			if(trigger.name == "check_value") then
				
				
				if(trigger.operator== nil) then
					
					if(trigger.value ~= nil and trigger.value == trigger.target) then
						result = true
					end
					
					else
					if(type(trigger.value) == "number") then
						
						
						if(checkValue(trigger.operator,trigger.value,trigger.target, trigger.min, trigger.max)) then
							
							result = true
							
						end
						else
						
						
						if(trigger.operator == "=") then
							
							if(trigger.value ~= nil and trigger.value == trigger.target) then
								result = true
							end
							
						end
						
						if(trigger.operator == "!=") then
							
							if(trigger.value ~= nil and trigger.value ~= trigger.target) then
								result = true
							end
							
						end
						
						if(trigger.operator == "contains") then
							
							if(trigger.value ~= nil and string.match(trigger.value, trigger.target)) then
								result = true
							end
							
						end
						
						if(trigger.operator == "empty" or trigger.operator == "nothing") then
							
							
							result = trigger.value == nil or trigger.value == ""
							
							
						end
						
						
						if(trigger.operator == "notempty" or trigger.operator == "notnothing") then
							
							
							result = trigger.value ~= nil and trigger.value ~= ""
							
							
						end
						
						
					end
					
					
				end
			end
		end
		if scannerregion then
			if(trigger.name == "check_scannerdata_for_entity") then
				
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)
				if(enti ~= nil and ScannerInfoManager[trigger.tag]) then
					
					
					
					if(trigger.prop == "primaryname" or trigger.prop == "secondaryname" or trigger.prop == "text" or trigger.prop == "entityname") then
						
						
						
						result = string.match(ScannerInfoManager[trigger.tag][trigger.prop], trigger.value)
						
						
						
					end
					
					if(trigger.prop == "level" or trigger.prop == "rarity" or trigger.prop == "attitude") then
						
						
						
						result = checkValue(trigger.operator,ScannerInfoManager[trigger.tag][trigger.prop],trigger.value,trigger.min,trigger.max)
						
						
						
					end
					
					
					if(trigger.prop == "reward" or trigger.prop == "streetreward" or trigger.prop == "danger") then
						
						
						
						result = checkValue(trigger.operator,ScannerInfoManager[trigger.tag]["bounty"][trigger.prop],trigger.value,trigger.min,trigger.max)
						
						
						
					end
					
					
					if(trigger.prop == "issuedby" ) then
						
						
						
						result = string.match(ScannerInfoManager[trigger.tag]["bounty"][trigger.prop], trigger.value)
						
						
						
					end
					
					
					
					
					
					if(trigger.prop == "customtransgressions" or trigger.prop == "transgressions"  ) then
						
						result = table_contains(ScannerInfoManager[trigger.tag]["bounty"][trigger.prop],trigger.value,false)
						
						
						
					end
					
					
					
					
					
					
					
					
				end
				
			end
			
			if(trigger.name == "check_current_scannerdata") then
				if(currentScannerItem ~= nil) then
					if(trigger.prop == "primaryname" or trigger.prop == "secondaryname" or trigger.prop == "entityname") then
						
						
						
						result = string.match(currentScannerItem[trigger.prop], trigger.value)
						
						
						
					end
					
					if(trigger.prop == "level" or trigger.prop == "rarity" or trigger.prop == "attitude") then
						
						
						
						result = checkValue(trigger.operator,currentScannerItem[trigger.prop],trigger.value,trigger.min,trigger.max)
						
						
						
					end
					
					
					if(trigger.prop == "reward" or trigger.prop == "streetreward" or trigger.prop == "danger") then
						
						
						
						result = checkValue(trigger.operator,currentScannerItem["bounty"][trigger.prop],trigger.value,trigger.min,trigger.max)
						
						
						
					end
					
					
					if(trigger.prop == "issuedby" ) then
						
						
						
						result = string.match(currentScannerItem["bounty"][trigger.prop], trigger.value)
						
						
						
					end
					
					
					
					
					
					if(trigger.prop == "transgressions" or trigger.prop == "customtransgressions"  ) then
						
						result = table_contains(currentScannerItem["bounty"][trigger.prop],trigger.value)
						
						
						
					end
				end
			end
			
			
		end
		if houseregion then
			
			if(trigger.name == "is_in_custom_place") then
				if currentHouse ~= nil then
					if(trigger.value == "current") or (currentHouse.tag == trigger.value)then
						result = true
					end
					
				end
			end
			if(trigger.name == "is_in_custom_room") then
				if currentRoom ~= nil then
					if("current" == trigger.value) or (currentRoom.tag == trigger.value)then
						result = true
					end
				end
			end
			if(trigger.name == "is_in_buyed_place") then
				if currentHouse ~= nil then
					if(getHouseStatut(currentHouse.tag) ~= nil and getHouseStatut(currentHouse.tag) >= 1) then
						result = true
					end
				end
			end
			if(trigger.name == "is_in_rented_place") then
				if currentHouse ~= nil then
					if(getHouseStatut(currentHouse.tag) ~= nil and getHouseStatut(currentHouse.tag) >= 2) then
						result = true
					end
				end
			end
			if(trigger.name == "place_canbe_buyed") then
				if currentHouse ~= nil then
					local statut = getHouseStatut(currentHouse.tag)
					if(currentHouse.isbuyable == true and getStackableItemAmount("Items.money") > currentHouse.price and (statut == nil or statut < 1)) then
						result = true
					end
				end
			end
			if(trigger.name == "place_canbe_rented") then
				if currentHouse ~= nil then
					local statut = getHouseStatut(currentHouse.tag)
					if(currentHouse.isrentable == true and getStackableItemAmount("Items.money") > (currentHouse.price*currentHouse.coef) and (statut ~= nil and statut == 1)) then
						result = true
					end
				end
			end
			if(trigger.name == "custom_place_type") then
				if currentHouse ~= nil then
					if(trigger.value == currentHouse.type) then
						result = true
					end
				end
			end
			if(trigger.name == "custom_room_type") then
				if currentRoom ~= nil then
					------logme(3,currentRoom.type[i])
					for i=1,#currentRoom.type do
						------logme(3,currentRoom.type[i])
						if(trigger.value == currentRoom.type[i]) then
							result = true
						end
					end
				end
			end
			if(trigger.name == "entity_is_in_custom_place_type") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				if(enti ~= nil and currentHouse ~= nil )then
					if(trigger.value == currentHouse.type) then
						local targetPosition = enti:GetWorldPosition()
						if check3DPos(targetPosition, currentHouse.x, currentHouse.x, currentHouse.z,currentHouse.range,currentHouse.range_z) then
							result = true
							else
							result = false
						end
					end
				end
			end
			if(trigger.name == "entity_is_in_custom_room_type") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				if(enti ~= nil and currentRoom ~= nil )then
					local targetPosition = enti:GetWorldPosition()
					if( check3DPos(targetPosition, currentRoom.x, currentRoom.x, currentRoom.z,currentRoom.range,currentRoom.range_z)) then
						for i=1,#currentRoom.type do
							
							if(trigger.value == currentRoom.type[i]) then
								result = true
							end
						end
					end
					
				end
			end
			if(trigger.name == "item_looked_is_registered") then
				if objLook ~= nil then
					tarName = objLook:ToString()
					appName = Game.NameToString(objLook:GetCurrentAppearanceName())
					dipName = objLook:GetDisplayName()
					local entid = objLook:GetEntityID()
					local entity = getItemEntityFromManager(entid)
					if(entity ~= nil) then
						result = true
						else
						entity = getItemEntityFromManagerByPlayerLookinAt()
						if(entity ~= nil) then
							result = true
						end
					end
				end
			end
			if(trigger.name == "have_selected_item") then
				if selectedItem ~= nil then
					result =  true
				end
			end
			if(trigger.name == "have_selected_item_can_be_grabbed") then
				if selectedItem ~= nil  and selectedItem.entityId ~= nil and Game.FindEntityByID(selectedItem.entityId)~=nil then
					result = Game.FindEntityByID(selectedItem.entityId):IsA('gameObject') 
				end
			end
		end
		
		if gangregion then
			if(trigger.name == "gang_affinity") then
				local score = 0
				score = getScoreKey("Affinity",trigger.value)
				if(score ~= nil and score >= trigger.score)then
					result = true
				end
			end
			if(trigger.name == "entity_looked_is_gangfriendly") then
				if objLook ~= nil then
					result = openCompanion
				end
			end
			if(trigger.name == "entity_looked_gang_score") then
				if objLook ~= nil then
					if(gangscore ~= nil and gangscore == trigger.value) then
						result = true
					end
				end
			end
			if(trigger.name == "entity_looked_is_gang") then
				if lookatgang ~= nil then
					result = true
				end
			end
			if(trigger.name == "entity_looked_is_specific_gang") then
				if lookatgang ~= nil and lookatgang.tag == trigger.value then
					result = true
				end
			end
			if(trigger.name == "entity_in_faction") then
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)	
				if(enti ~= nil) then
					local targetAttAgent = enti:GetAttitudeAgent()
					local group = Game.NameToString(targetAttAgent:GetAttitudeGroup())
					local npcCurrentName = Game.NameToString(enti:GetCurrentAppearanceName())
					local faction = getFactionByTag(trigger.faction)
					
					local resultent,msg = pcall(function() enti:GetRecordID() end)
					
					
					if(resultent == true and enti:GetRecordID().hash ~= nil and cyberscript.entitieshash[tostring(enti:GetRecordID().hash)] ~= nil) then
						
						local entity = cyberscript.entitieshash[tostring(enti:GetRecordID().hash)]
						
						
						if(entity ~= nil) then
							
							if(faction ~= nil) then
								for y=1,#faction.spawnable_npc do
									
									
									
									if(string.find(entity.entity_tweak,faction.spawnable_npc[y]) ~= nil)then
										result = true
									end
								end
								if(result == false) then
									for y=1,#faction.keyword do
										
										
										
										if(string.find(entity.entity_tweak,faction.keyword[y]) ~= nil)then
											result = true
										end
									end
								end
							end
							
						end
						else
						
						if(faction ~= nil) then
							for y=1,#faction.attitude_group do
								
								
								
								if(string.find(group,faction.attitude_group[y]) ~= nil or string.find(npcCurrentName,faction.attitude_group[y]) ~= nil)then
									result = true
								end
							end
						end
					end
				end
			end
			if(trigger.name == "check_gang_district_score") then
				if  getVariableKey(trigger.faction,trigger.district) ~= nil then
					if getVariableKey(trigger.faction,trigger.district)  >= trigger.value then
						result =  true
					end
				end
			end
			
			if(trigger.name == "check_gang_relation") then
				
				if(trigger.tag == "player") then
					
					trigger.tag = getVariableKey("player","current_gang")
					
				end
				
				if(trigger.tag ~= "") then
					
					if(trigger.mode == "gang") then
						
						
						if(trigger.target ~= trigger.tag ) then
							
							local score = getFactionRelation(trigger.tag,trigger.target)
							if(checkValue(trigger.operator,score,trigger.score,trigger.min,trigger.max)) then
								
								result = true
								
							end
							
							
							
						end
						
					end
					
					if(trigger.mode == "district_leader" or trigger.mode == "district_subleader") then
						
						local gangs = getGangfromDistrict(trigger.target,20)
						if(#gangs > 0) then
							
							
							
							if(gangs[1].tag ~= trigger.tag) then
								
								local score = getFactionRelation(trigger.tag,gangs[1].tag)
								if(checkValue(trigger.operator,score,trigger.score,trigger.min,trigger.max)) then
									result = true
								end
								
								
							end
						end
						
						
					end
					
					if(trigger.mode == "current_district_leader") then
						
						if currentDistricts2 ~= nil then
							local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
							if(#gangs > 0) then
								if(gangs[1].tag ~= trigger.tag) then
									
									local score = getFactionRelation(trigger.tag,gangs[1].tag)
									if(checkValue(trigger.operator,score,trigger.score,trigger.min,trigger.max)) then
										
										result = true
									end
								end
							end
							
						end
						
					end
					if(trigger.mode == "current_district_subleader") then
						if currentDistricts2 ~= nil then
							if currentDistricts2.districtLabels[2] ~= nil then
								local gangs = getGangfromDistrict(currentDistricts2.districtLabels[2],20)
								if(#gangs > 0) then
									
									if(gangs[1].tag ~= trigger.tag) then
										
										local score = getFactionRelation(trigger.tag,gangs[1].tag)
										if(checkValue(trigger.operator,score,trigger.score,trigger.min,trigger.max)) then
											result = true
										end
									end
								end
							end
							
						end
						
					end
					
					
				end
				
				
				
			end
			
			
			if(trigger.name == "last_killed_entity_is_in_specific_gang") then
				if lastTargetKilled ~= nil then
					local killComp, killGangScore, killGang = checkAttitudeByGangScore(lastTargetKilled)
					
					if killGang ~= nil and killGang.tag == trigger.value then
						result = true
					end
				end
			end
			
			if(trigger.name == "last_killed_entity") then
				if lastTargetKilled ~= nil then
					result = true
				end
				
			end
			
			if(trigger.name == "last_killed_entity_is_in_gang") then
				if lastTargetKilled ~= nil then
					local killComp, killGangScore, killGang = checkAttitudeByGangScore(lastTargetKilled)
					if killGang ~= nil then
						result = true
					end
				end
			end
			
			
			if(trigger.name == "last_killed_entity_gang_score") then
				if lastTargetKilled ~= nil then
					local killComp, killGangScore, killGang = checkAttitudeByGangScore(lastTargetKilled)
					
					if(checkValue(trigger.operator,killGangScore,trigger.score,trigger.min,trigger.max)) then
						result = true
					end
					
				end
			end
			
		end
		
		if miscregion then
			if(trigger.name == "auto")then
				result = true
			end
			if(trigger.name == "tracked_game_quest")then
				local objective = Game.GetJournalManager():GetTrackedEntry()
				
				if objective ~= nil then
					local phase = Game.GetJournalManager():GetParentEntry(objective)
					local quest = Game.GetJournalManager():GetParentEntry(phase)
					
					result= (string.match(tostring(quest.id), trigger.value) ~= nil)
				end
			end
			if(trigger.name == "tracked_game_phase")then
				local objective = Game.GetJournalManager():GetTrackedEntry()
				
				if objective ~= nil then
					local phase = Game.GetJournalManager():GetParentEntry(objective)
					
					result= (string.match(tostring(phase.id), trigger.value) ~= nil)
				end
			end
			if(trigger.name == "tracked_game_objective")then
				local objective = Game.GetJournalManager():GetTrackedEntry()
				
				if objective ~= nil then
					
					result= (string.match(tostring(objective.id), trigger.value) ~= nil)
				end
			end
			if(trigger.name == "time") then
				local currentime = tonumber(getGameTimeHHmm())
				----logme(3,"currentime "..currentime)
				if(tonumber(currentime) >= tonumber(trigger.min) and tonumber(currentime) <= tonumber(trigger.max)) then
					result = true
				end
			end
			if(trigger.name == "os_time") then
				local currentime =  getOsTimeHHmm()
				----logme(3,"currentime "..currentime)
				local times = currentime.hour*100 + currentime.min
				if(tonumber(times) >= tonumber(trigger.min) and tonumber(times) <= tonumber(trigger.max)) then
					result = true
				end
			end
			if(trigger.name == "os_date") then
				local currentime =  getOsTimeHHmm()
				----logme(3,"currentime "..currentime)
				if((tonumber(currentime.month) == tonumber(trigger.month) or trigger.month == "") and (tonumber(currentime.day) == tonumber(trigger.day)) or trigger.day == "")  and (tonumber(currentime.year) == tonumber(trigger.year) or trigger.year == "") then
					result = true
				end
			end
			if(trigger.name == "check_setting") then
				local score = 0
				score = getUserSetting(trigger.value)
				if(score ~= nil and score == trigger.score)then
					result = true
				end
			end
			if(trigger.name == "debug") then
				result = cyberscript.debug
			end
			if(trigger.name == "current_district") then
				if currentDistricts2 ~= nil and currentDistricts2.customdistrict ~= nil then
					if(string.lower(currentDistricts2.customdistrict.EnumName) == string.lower(trigger.value))then 
						--logme(3,"district OK")
						result =  true
					end
				end
			end
			if(trigger.name == "current_subdistrict") then
				if currentDistricts2 ~= nil then
					if(currentDistricts2.districtLabels~=nil)then
						for i, subd in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								if(string.lower(subd) == string.lower(trigger.value))then 
									--logme(3,"subdistrict OK")
									result =  true
								end
							end
						end
					end
				end
			end
			if(trigger.name == "salary_is_possible") then
				result = SalaryIsPossible
			end
			if(trigger.name == "have_custom_mappin_placed") then
				if(mappinManager["selected_mappin"] ~= nil) then
					result =  true
				end
			end
			if(trigger.name == "have_fasttravel_mappin_placed") then
				
				if(ActiveFastTravelMappin ~= nil) then
					result =  true
					logme(3,"toto"..dump(ActiveFastTravelMappin))
				end
			end
			if(trigger.name == "event_is_finished") then
				if(workerTable[trigger.tag] == nil ) then 
					result =  true
				end
			end
			
			if(trigger.name == "event_exist") then
				if(workerTable[trigger.tag] ~= nil ) then 
					result =  true
				end
			end
			if(trigger.name == "metro_time_is_finished") then
				if MetroCurrentTime <=0 and activeMetroDisplay == false then
					result =  true
				end
			end
			if(trigger.name == "area_security_level") then
				local level = FromVariant(GetPlayer():GetPlayerStateMachineBlackboard():GetVariant(GetAllBlackboardDefs().PlayerStateMachine.SecurityZoneData))
				if level == trigger.value then
					result =  true
				end
			end
			if(trigger.name == "is_recording_mode_active") then
				if recordingMode then
					result =  true
				end
			end
			
			if(trigger.name == "interact_is_forceloaded") then
				if(#loadInteract > 0) then
					
					for i,v in ipairs(loadInteract) do
						
						if(v == trigger.tag) then
							
							result =  true
							
						end
						
					end
					
					
					
					
				end
				
				
				
			end
			if(trigger.name== "check_mod") then
				
				result = GetMod(trigger.value) ~= nil
				
			end
			
			if(trigger.name== "have_collision") then
				
				local collision = false
				trigger.output = true
				local from = Vector4.new(
					trigger.from_x,
					trigger.from_y,
					trigger.from_z,
					1
				)
				
				
				local to = Vector4.new(
					trigger.to_x,
					trigger.to_y,
					trigger.to_z,
					1
				)
				
				
				-- local filters = {
				
				-- 'Static', -- Buildings, Concrete Roads, Crates, etc.
				
				-- 'Terrain'
				
				-- }
				-- local filters = {
				-- -- 'Dynamic', -- Movable Objects
				-- -- 'Vehicle',
				-- 'Static', -- Buildings, Concrete Roads, Crates, etc.
				-- 'Water',
				-- 'Terrain',
				-- -- 'PlayerBlocker', -- Trees, Billboards, Barriers
				-- }
				local filters = trigger.filters
				local results = {}
				
				
				
				
				
				
				
				for _, filter in ipairs(filters) do
					local success, physicsTraceResult = Game.GetSpatialQueriesSystem():SyncRaycastByCollisionGroup(from, to, filter, false, false)
					
					if success then
						collision = true
						
						
						
					end
				end
				
				result = collision
				
				
				
			end
			
			
			if(trigger.name== "check_raycasting") then
				
				local collision = false
				
				local from = Vector4.new(
					trigger.from_x,
					trigger.from_y,
					trigger.from_z,
					1
				)
				
				
				local to = Vector4.new(
					trigger.to_x,
					trigger.to_y,
					trigger.to_z,
					1
				)
				
				
				
				local filters = trigger.filters
				local results = {}
				
				local points = {}
				for i=1,action.points do
					points[i] = {}
					if(to.x > from.x) then
						points[i].x = (math.abs(to.x - from.x) / action.points) * i + from.x;
						else
						
						points[i].x = 0-((math.abs(from.x - to.x) / action.points) * i - from.x);
					end
					
					
					if(to.y > from.y) then
						points[i].y = (math.abs(to.y - from.y) / action.points) * i + from.y;
						else
						
						points[i].y = 0-((math.abs(from.y - to.y) / action.points) * i - from.y);
					end
					
					
					if(to.z > from.z) then
						points[i].z = (math.abs(to.z - from.z) / action.points) * i + from.z;
						else
						
						points[i].z = 0-((math.abs(from.z - to.z) / action.points) * i - from.z);
					end
					
					
				end
				
				for i=1,#points do
					local mypoint = Vector4.new(
						points[i].x,
						points[i].y,
						points[i].z,
						1
					)
					
					
					for _, filter in ipairs(filters) do
						local success, physicsTraceResult = Game.GetSpatialQueriesSystem():SyncRaycastByCollisionGroup(from, mypoint, filter, false, false)
						
						if success then
							collision = true
							
							
							
						end
					end
					
					
				end
				
				
				
				
				result = collision
				
				
				
			end
			
			if(trigger.name== "game_language") then
				
				result = cyberscript.language == trigger.value
				
			end
			
			if(trigger.name== "device_active_radio_channel_id") then
				
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)
				if(enti ~= nil) then
					local ps = enti:GetDevicePS()
					result = ps.activeStation == trigger.value
					
					
				end
			end
			
			if(trigger.name== "device_active_tv_channel_id") then
				
				local obj = getEntityFromManager(trigger.tag)
				local enti = Game.FindEntityByID(obj.id)
				if(enti ~= nil) then
					local ps = enti:GetController():GetPS():GetActiveStationIndex()
					result = ps.activeStation == trigger.value
					
					
				end
			end
			
			if(trigger.name== "have_shard") then
				
				
				if(gameshardscompiled == nil) then 
					
					local activeData = CodexListSyncData.new()
					local gameshards = CodexUtils.GetShardsDataArray(GameInstance.GetJournalManager(), activeData)
					if gameshardscompiled == nil then gameshardscompiled = {} end
					for i,v in pairs(gameshards) do
						if gameshardscompiled[v.data.title] == nil then gameshardscompiled[v.data.title] = true end
						
						
					end		
				end
				
				result = gameshardscompiled[trigger.value] ~= nil
			end
			
			if(trigger.name== "mappin_exist") then
				
				result = mappinManager[trigger.tag] ~= nil
			end
			
		end
		
		if relationregion then
			if(trigger.name == "current_phoned_npc_is_defined") then
				if(currentNPC ~= nil) then
					result = true
				end
			end
			
			if(trigger.name == "current_phoned_npc_name") then
				if(currentNPC ~= nil) then
					
					if(currentNPC.Names == trigger.value) then
						result = true
					end
				end
			end
			
			if(trigger.name == "current_star_name") then
				if(currentStar ~= nil) then
					
					if(currentStar.Names == trigger.value) then
						result = true
					end
				end
			end
		end
		
		if questregion then
			if(trigger.name == "quest_fact") then
				isquestok =Game.GetQuestsSystem():GetFactStr(trigger.value)
				if(isquestok == 1)then
					result = true
				end
			end
			if(trigger.name == "mission_fact") then
				local score = getScoreKey(trigger.value,"Score")
				if(score ~= nil and score == 1) then
					result = true
				end
			end
		end
		
		if noderegion then
			if(trigger.name == "entity_path_is_finish") then
				local founded = false
				local obj = getEntityFromManager(trigger.tag)
				if(obj.path ~= nil) then
					result = obj.path.finish
					else
					result = true
				end
			end
			if(trigger.name == "is_arrived_to_destination") then
				local obj = getEntityFromManager(trigger.tag)
				--logme(3,obj.tag)
				local enti = Game.FindEntityByID(obj.id)
				if(enti ~= nil) then
					local targetPosition = enti:GetWorldPosition()
					if obj.destination ~= nil then
						
						if check3DPos(targetPosition, obj.destination.x, obj.destination.y, obj.destination.z,trigger.range) then
							result = true
							else
							result = false
						end
						else
						--logme(3,"entity not found : "..trigger.tag)
						result = false
					end
				end
			end
		end
		
		if soundregion then
			if(trigger.name == "gameVolume") then 
				if (GetSoundSettingValue(trigger.value) >= trigger.score) then
					result =  true
				end
			end
			if(trigger.name == "soundmanager_isplaying") then
				--logme(3,"soundmanager_isplaying "..tostring(IsPlaying(trigger.channel)))
				if IsPlaying(trigger.channel) == true then
					result =  true
				end
			end
		end
		
		if logicregion then
			if(trigger.name == "compare") then
				local res = checkTrigger(trigger.trigger)
				--logme(3,tostring(res))
				result = (res == trigger.expected)
				--logme(3,tostring(result))
			end
			if(trigger.name == "testFor") then
				local count = 0
				local counttrigger = 0
				if(isArray(trigger.triggers))then
					for i=1, #trigger.triggers do 
						counttrigger = #trigger.triggers
						
						
						local trig = trigger.triggers[i]
						
						local rs = checkTrigger(trig)
						if(rs == true ) then
							count = count +1
						end
					end
					else
					
					for k,v in pairs(trigger.triggers) do 
						counttrigger = counttrigger+1
						
						
						local trig = v
						
						local rs = checkTrigger(trig)
						if(rs == true ) then
							count = count +1
						end
					end
					
				end
				
				if(trigger.logic == "or") then
					--logme(3,tostring(count >=1))
					result = (count >=1 )
					else
					result = (count == counttrigger)
				end
			end
		end
		
		if uiregion then
			
			if(trigger.name == "timer_is_finished") then
				if(currentTimer ~= nil) then
					
					if( os.time(os.date("!*t"))+0  > currentTimer.time) then
						
						
						result = true
						
					end
					
					
				end
			end
			if(trigger.name == "interact_is_inprogress") then
				result = actionistaken
			end
			if(trigger.name == "is_in_menu") then
				result = inMenu
			end
			if(trigger.name == "scanner_active") then
				result = (inScanner ~= nil and inScanner == true)
			end
			if(trigger.name == "is_in_specific_menu") then
				if(inMenu and ActiveMenu == trigger.menu)then
					result = true
					else
					result = false
				end
			end
			if(trigger.name == "texture_is_visible") then
				result = (currentLoadedTexture[trigger.tag] ~= nil)
			end
		end
		
		if avregion then
			if(trigger.name == "player_is_in_av") then
				local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
				if (inVehicule) then
					local vehicule = Game.GetMountedVehicle(Game.GetPlayer())
					if(vehicule ~=nil) then
						local entid = vehicule:GetEntityID()
						local entity = getEntityFromManagerById(entid)
						if(entity ~= nil and entity.isAV ~= nil) then
							result = entity.isAV or JackFlight
						end
					end
				end
			end
			if(trigger.name == "entity_looked_is_custom_av") then
				if objLook ~= nil then
					tarName = objLook:ToString()
					appName = Game.NameToString(objLook:GetCurrentAppearanceName())
					dipName = objLook:GetDisplayName()
					--logme(3,appName)
					local entid = objLook:GetEntityID()
					local entity = getEntityFromManagerById(entid)
					if(entity ~= nil) then
						
						if(entity.isAV == true or entity.tag == "fake_av") then
							result = true
						end
					end
				end
			end
		end
		
		if frameworkregion then
			if(trigger.name =="datapack_is_enabled")then
				if( arrayDatapack[trigger.tag] ~= nil and  arrayDatapack[trigger.tag].enabled == true) then
					
					result = true
					
				end
			end
			
			if(trigger.name =="datapack_version")then
				
				local localversion = arrayDatapack[trigger.tag].metadata.version
				result = checkVersionNumber(localversion,trigger.value)
			end
			
			if(trigger.name =="datapack_is_outdated")then
				
				local serverversion = "0.0.0"
				
				for i = 1,#arrayDatapack3  do
					
					local datapack = arrayDatapack3[i]
					if(datapack.tag == trigger.tag) then
						serverversion = datapack.version
					end
					
				end
				local localversion = arrayDatapack[trigger.tag].metadata.version
				result = checkVersionNumber(localversion,serverversion)
				
			end
			
			if(trigger.name =="mod_is_outdated")then
				if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069" and checkVersionNumber(cyberscript.version,CurrentServerModVersion.version))then
					result = true
				end
			end
			
		end
		
		if airegion then
			if(trigger.name =="ai_answer_is_ready")then
				return (getAIAnswerOrDefault(trigger.aitag) ~= nil )
			end
		end
		
		
		if(trigger.output == true) then 
			
			--print(trigger.name)
			--print(dump(trigger))
			--print(tostring(result))
			spdlog.error(dump(action))
		end
		
	end
	
	if(trigger.expected ~= nil and trigger.name ~= "compare") then result = result == trigger.expected end
	
	return result
end


--execute actions core function
function executeAction(action,tag,parent,index,source,executortag)
   	local result = true
	
   	local canDoaction = true
   	actionistaken = true
   	
   	if(action.tag == "this") then
   		action.tag = executortag
	end
   	
   	checkContext(action)
   	
   	if(action.requirement ~= nil and action.triggers ~= nil)then
   		
   		canDoaction = checkTriggerRequirement(action.requirement,action.triggers)
   		
	end
   	
   	if(canDoaction) then
   		
   		local entityregion = true
   		local groupregion = true
   		local vehiculeregion = true
   		local scoreregion = true
   		local houseregion = true
   		local gangregion = true
   		local miscregion = true
   		local relationregion = true
   		local questregion = true
   		local noderegion = true
   		local soundregion = true
   		local logicregion = true
   		local uiregion = true
   		local avregion = true
   		local customnpcregion = true
   		local multiregion = true
   		local framework = true
   		local scene = true
   		local scannerregion = true
   		local hudregion = true
   		local animationregion = true
   		local airegion = true
   		
		local status, retval = pcall(function()
			
			if groupregion then
				if(action.name == "create_group") then
					local group = {}
					group.tag = action.tag
					group.entities = {}
					cyberscript.GroupManager[action.tag] = group
					
					logme(3,"group created")
				end
				if(action.name == "add_entity_to_group") then
					
					for i=1, #action.entities do
						table.insert(cyberscript.GroupManager[action.tag].entities,action.entities[i])
					end
					
				end
				if(action.name == "set_entity_to_group") then
					
					cyberscript.GroupManager[action.tag].entities = action.entities
					
				end
				if(action.name == "despawn_group") then
					local group =getGroupfromManager(action.tag)
					if group ~= nil then
						for i=1, #group.entities do 
							local entityTag = group.entities[i]
							
							despawnEntity(entityTag)
							
						end
					end
				end
				if(action.name == "remove_group") then
					cyberscript.GroupManager[action.tag] = nil
				end
				if(action.name == "remove_entity_from_group") then
					
					for i=1, #cyberscript.GroupManager[action.tag].entities do 
						local entityTag = cyberscript.GroupManager[action.tag].entities[i]
						for y=1, action.entities do
							if(entityTag == action.entities[y]) then
								table.remove(cyberscript.GroupManager[action.tag].entities,i)
							end
						end
					end
				end
				
				if(action.name == "clear_entity_from_group_and_manager") then
					
					for i,entitygroup in ipairs(cyberscript.GroupManager[action.tag].entities) do 
						
						cyberscript.EntityManager[entitygroup] = nil
						
					end
					
					
					cyberscript.GroupManager[action.tag].entities = {}
				end
				
				if(action.name == "attitude_group_against_entity") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						if action.attitude == "hostile" then
							setAggressiveAgainst(entityTag, action.entity)
						end
						if action.attitude == "passive"   then
							setPassiveAgainst(entityTag, action.entity)
						end
						if action.attitude == "companion"   then
							setFollower(entityTag)
						end
						if action.attitude == "friendly"   then
							setFriendAgainst(entityTag, action.entity)
						end
						if action.attitude == "psycho" then
							setPsycho(entityTag, action.entity)
						end
					end
				end
				if(action.name == "attitude_group_against_group") then
					if action.attitude == "hostile" then
						setAggressiveAgainstAttitudeGroup(action.tag, action.target, action.attitudegroup, action.attitudegrouptarget)
					end
					if action.attitude == "passive" then
						setPassiveAgainstAttitudeGroup(action.tag, action.target, action.attitudegroup, action.attitudegrouptarget)
					end
				end
				if(action.name == "play_group_voice") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							talk(enti,action.voice)
						end
					end
				end
				if(action.name == "play_group_facial") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						local reaction = getExpression(action.value)
						if(enti ~= nil) then
							makeFacial(enti,reaction)
						end
					end
				end
				if(action.name == "reset_group_facial") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							resetFacial(enti)
						end
					end
				end
				
				if(action.name == "look_at_entity_group") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							if(action.entity == "player") then
								lookAtPlayer(enti)
								else
								lookAtEntity(enti,action.entity)
							end
						end
					end
				end
				if(action.name == "execute_at_script_level_group") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							if(obj.scriptlevel == nil or obj.scriptlevel <= action.scriptlevel) then
								
								runSubActionList(action.action, tag.."_execute_at_level", tag,source,false,obj.tag)
								
							end
						end
					end
					
				end
				if(action.name == "ressurect_group") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							
							local sp = Game.GetScriptableSystemsContainer():Get(CName.new("ScriptedPuppet"))
							sp:SendResurrectEvent(enti)
							
							
						end
						
					end
					
				end
				if(action.name == "set_script_level_group") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							obj.scriptlevel = action.scriptlevel 
						end
					end
					
				end
				
				if(action.name == "apply_effect_to_group") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							StatusEffectHelper.ApplyStatusEffectForTimeWindow(enti, TweakDBID.new(action.value),obj.id, 0,1000)
						end
					end
				end
				if(action.name == "remove_effect_to_group") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							StatusEffectHelper.RemoveStatusEffect(enti, TweakDBID.new(action.value))
						end
					end
				end
				
				
			end
			
			if vehiculeregion then
				
				if(action.name == "spawn_vehicule_v2" or action.name == "spawn_vehicule") then
					local chara = ""
					if(action.amount == nil) then
						action.amount = 1
					end
					if(action.amount == 0) then
						action.amount = math.random(1,6)
					end
					for i=1,action.amount do
						if(action.source == "random") then
							local indexchara = math.random(1,#arrayVehicles)
							chara = arrayVehicles[indexchara]
						end
						if(action.source == "from_list") then
							local indexchara = math.random(1,#action.source_list)
							chara = action.source_list[indexchara]
						end
						if(action.source == "vehicle") then
							chara = action.source_tag
						end
						if(action.source == "faction") then
							local gang = getFactionByTag(action.source_tag)
							if(action.source_use_rival == true) then
								gang = getFactionByTag(gang.rivals[1])
							end
							if(#gang.spawnable_vehicle > 0) then
								local index = math.random(1,#gang.spawnable_vehicle)
								chara = gang.spawnable_vehicle[index]
							end
						end
						if(action.source == "district_leader" or action.source == "subdistrict_leader") then
							local gangs = getGangfromDistrict(action.source_tag,20)
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								if(action.source_use_rival == true) then
									gang = getFactionByTag(gang.rivals[1])
								end
								if(#gang.spawnable_vehicle > 0) then
									local index = math.random(1,#gang.spawnable_vehicle)
									chara = gang.spawnable_vehicle[index]
								end
							end
						end
						if(action.source == "current_district_leader") then
							local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								if(action.source_use_rival == true) then
									gang = getFactionByTag(gang.rivals[1])
								end
								if(#gang.spawnable_vehicle > 0) then
									local index = math.random(1,#gang.spawnable_vehicle)
									chara = gang.spawnable_vehicle[index]
								end
							end
						end
						if(action.source == "current_subdistrict_leader") then
							local gangs = {}
							for j, test in ipairs(currentDistricts2.districtLabels) do
								if j > 1 then
									gangs = getGangfromDistrict(test,20)
									if(#gangs > 0) then
										break
									end
								end
							end
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								
								if(action.source_use_rival == true) then
									gang = getFactionByTag(gang.rivals[1])
								end
								
								if(#gang.spawnable_vehicle > 0) then
									local index = math.random(1,#gang.spawnable_vehicle)
									chara = gang.spawnable_vehicle[index]
								end
								
							end
						end
						
						if(action.source == "district_rival" or action.source == "subdistrict_rival") then
							
							if(action.source_gang == "player") then
								
								action.source_gang = getVariableKey("player","current_gang")
								
							end
							
							local gangs = getGangRivalfromDistrict(action.source_gang,action.source_tag,20)
							
							
							
							if(#gangs > 0) then
								
								
								local gang = getFactionByTag(gangs[1].tag)
								
								if(#gang.spawnable_vehicle > 0) then
									local index = math.random(1,#gang.spawnable_vehicle)
									chara = gang.spawnable_vehicle[index]
								end
							end
						end
						if(action.source == "current_district_rival") then
							
							if(action.source_gang == "player") then
								
								action.source_gang = getVariableKey("player","current_gang")
								
							end
							
							local gangs = getGangRivalfromDistrict(action.source_gang,currentDistricts2.Tag,20)
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								
								if(#gang.spawnable_vehicle > 0) then
									local index = math.random(1,#gang.spawnable_vehicle)
									chara = gang.spawnable_vehicle[index]
								end
							end
						end
						if(action.source == "current_subdistrict_rival") then
							
							if(action.source_gang == "player") then
								
								action.source_gang = getVariableKey("player","current_gang")
								
							end
							
							
							local gangs = {}
							for j, test in ipairs(currentDistricts2.districtLabels) do
								if j > 1 then
									gangs = getGangRivalfromDistrict(action.source_gang,test,20)
									if(#gangs > 0) then
										break
									end
								end
							end
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								
								if(#gang.spawnable_vehicle > 0) then
									local index = math.random(1,#gang.spawnable_vehicle)
									chara = gang.spawnable_vehicle[index]
								end
							end
						end
						
						local tag = action.tag
						if(action.amount > 1) then
							tag = action.tag.."_"..i
						end
						
						local rotation = {}
						if(action.yaw == nil) then
							action.yaw = 0
							action.pitch = 0
							action.roll = 0
						end
						
						local position = getPositionFromParameter(action)
						
						rotation.yaw = action.yaw
						rotation.pitch = action.pitch
						rotation.roll = action.roll
						
						if(chara ~= "" and position.x ~= nil) then
							if(action.amount > 1) then
								
								position.x = position.x + (i*0.5)
								
							end
							
							spawnVehicleV2(chara,action.appearance,tag, position.x, position.y ,position.z,action.spawnlevel,action.spawn_system,action.isAV,action.appears_from_behind,false,action.wait_for_vehicle, action.scriptlevel, action.wait_for_vehicle_second,action.fakeav,action.despawntimer,action.persiststate,action.persistspawn,action.alwaysspawned,action.spawninview,action.dontregister,rotation)
							if(action.group ~= nil and action.group ~= "") then
								
								if(cyberscript.GroupManager[action.group] == nil and action.create_group_if_not_exist == true) then
									local group = {}
									group.tag = action.group
									group.entities = {}
									cyberscript.GroupManager[action.group] = group
									logme(3,"group created")
									
								end
								if(cyberscript.GroupManager[action.group] ~= nil) then
									table.insert(cyberscript.GroupManager[action.group].entities,tag)
									else
									logme(3,"group with tag : "..action.group.." doesn't exist")
								end
							end
							else
							logme(10,getLang("see_action_novehicle"))
						end
					end
				end
				if(action.name == "entity_set_seat") then
					SetSeat(action.tag, action.vehicle, action.waitforsit, action.seat)
				end
				if(action.name == "entity_set_seat_looked_av") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local entity = getEntityFromManagerById(entid)
						if(entity ~= nil) then
							local garagVeh = getVehiclefromCustomGarageTag(entity.tag)
							if(garagVeh ~= nil and garagVeh.asAV == true) then
								SetSeat(action.tag, entity.tag, true, action.seat)
							end
						end
					end
				end
				if(action.name == "set_vehicule_to_garage") then
					SetVehiculeToGarage(action.tweakid,action.enabled,action.asAV,action.tag,action.fakeAV)
				end
				if(action.name == "entity_unset_seat") then
					UnsetSeat(action.tag, action.waitforsit,action.seat)
				end
				if(action.name == "vehicle_follow_entity") then
					
					VehicleFollowEntity(action.vehicle, action.tag, action.distanceMin,action.distanceMax,action.useTraffic,action.useKinematic,action.needDriver,action.stopWhenTargetReached)
				end
				if(action.name == "vehicle_chase_entity") then
					VehicleChaseEntity(action.vehicle, action.tag, action.min,action.max,action.startspeed)
				end
				if(action.name == "change_av_velocity") then
					AVVelocity = action.value
				end
				if(action.name == "reset_av_velocity") then
					AVVelocity = 0.005
				end
				if(action.name == "vehicle_change_doors") then
					VehicleDoors(action.tag,action.value)
				end
				if(action.name == "vehicle_force_brake") then
					VehicleBrake(action.tag,action.value,false)
				end
				if(action.name == "vehicle_force_brake_until_stop") then
					VehicleBrake(action.tag,action.value,true)
				end
				if(action.name == "vehicle_change_windows") then
					VehicleWindows(action.tag,action.value)
				end
				if(action.name == "vehicle_detach_all_part") then
					VehicleDetachAll(action.tag)
				end
				if(action.name == "vehicle_explose") then
					VehicleDestroy(action.tag)
				end
				if(action.name == "vehicle_repair") then
					VehicleRepair(action.tag)
				end
				if(action.name == "vehicle_honk_and_flash") then
					VehicleHonkFlash(action.tag)
				end
				if(action.name == "vehicle_change_light") then
					VehicleLights(action.tag,action.value)
				end
				if(action.name == "vehicle_change_engine") then
					VehicleEngine(action.tag,action.value)
				end
				if(action.name == "vehicle_reset") then
					VehicleReset(action.tag)
				end
				if(action.name == "vehicle_add_to_traffic") then
					local vehiculeobj =  getEntityFromManager(action.tag)
					local vehicule = Game.FindEntityByID(vehiculeobj.id)
					if(vehicule ~= nil) then
						VehicleGoToXYZ(action.tag, 0,0,0 ,1,5,true)
					end
				end
				if(action.name == "vehicle_go_to_position") then
					local vehiculeobj =  getTrueEntityFromManager(action.tag)
					local vehicule = Game.FindEntityByID(vehiculeobj.id)
					if(vehicule ~= nil) then
						
						
						
						
						local position = getPositionFromParameter(action)
						vehiculeobj.destination = position
						VehicleGoToXYZ(action.tag, position.x,position.y,position.z,action.minspeed,action.maxspeed,action.cleartraffic)
						
					end
				end
				if(action.name == "vehicle_set_invincible") then
					VehicleSetInvincible(action.tag)
				end
				if(action.name == "vehicle_go_to_current_fasttravel_point") then
					local vehiculeobj =  getTrueEntityFromManager(action.tag)
					local vehicule = Game.FindEntityByID(vehiculeobj.id)
					if(vehicule ~= nil and ActiveFastTravelMappin ~= nil) then
						
						vehiculeobj.destination = ActiveFastTravelMappin.position
						VehicleGoToGameNode(action.tag, ActiveFastTravelMappin.markerRef, action.speed, action.forcegreenlight, action.needdriver, action.usetraffic, action.useKinematic)
						
					end
				end
				if(action.name == "vehicle_go_to_current_mappin_point") then
					local vehiculeobj =  getTrueEntityFromManager(action.tag)
					local vehicule = Game.FindEntityByID(vehiculeobj.id)
					if(vehicule ~= nil and mappinManager["selected_mappin"] ~= nil) then
						
						
						vehiculeobj.destination = mappinManager["selected_mappin"].position
						
						local mappin = mappinManager["selected_mappin"].position
						VehicleGoToXYZ(action.tag, mappin.x,mappin.y,mappin.z,action.minspeed,action.maxspeed,false)
						
					end
				end
				if(action.name == "vehicle_go_to_fasttravel_point") then
					local vehiculeobj =  getEntityFromManager(action.tag)
					local vehicule = Game.FindEntityByID(vehiculeobj.id)
					if(vehicule ~= nil) then
						local markerref = nil
						local position = nil
						for i=1, #mappedFastTravelPoint do
							local point = mappedFastTravelPoint[i]
							if(point.markerref == action.destination) then
								markerref = point.markerrefdata
								position = point.position
							end
							if(markerref ~= nil) then
								vehiculeobj.destination =position
								VehicleGoToGameNode(action.tag, markerref, action.speed, action.forcegreenlight, action.needdriver, action.usetraffic)
							end
						end
					end
				end
				if(action.name == "vehicle_go_to_fasttravel_point_from_mappin") then
					local mappin = getMappinByTag(tag)
					local vehiculeobj =  getTrueEntityFromManager(action.tag)
					local vehicule = Game.FindEntityByID(vehiculeobj.id)
					if(mappin)then
						if(vehicule ~= nil) then
							vehiculeobj.destination =position
							VehicleGoToGameNode(action.tag, point.markerrefdata, action.speed, action.forcegreenlight, action.needdriver, action.usetraffic)
						end
					end
				end
			end
			
			if scoreregion then
				
				if(action.name == "do_math") then
					local score  = tonumber(action.value)
					local score2 = tonumber(action.modifier)
					if(score == nil) then score = 0 end
					
					if(action.operator == "+") then
						score = score + score2
					end
					if(action.operator == "-") then
						score = score - score2
					end
					if(action.operator == "*") then
						score = score * score2
					end
					if(action.operator == "/") then
						score = score / score2
					end
					if(action.operator == "floor") then
						score = math.floor(score)
					end
					if(action.operator == "ceil") then
						score = math.ceil(score)
					end
					if(action.operator == "positive") then
						if(score > 0) then
							score = 0 + score
							else
							score = 0 - score
						end
					end
					if(action.operator == "negative") then
						if(score > 0) then
							score = 0 - score
							else
							score = 0 + score
						end
					end
					if(action.operator == "random") then
						score = math.random(action.min,action.max)
					end
					
					if(action.store ~= nil) then
						
						setScore(action.store.score,action.store.key,score)
						
					end
					
					
				end
				
				if(action.name == "set_variable") then
					setVariable(action.variable,action.key,action.value)
				end
				
				
				if(action.name == "concate_variable") then
					local var  = getVariableKey(action.variable,action.key)
					var = var .. action.value
					setVariable(action.variable,action.key,var)
				end
				
				
				
				if(action.name == "operate_score") then
					local score  = getScoreKey(action.score,action.key)
					if(score == nil) then score = 0 end
					
					if(action.operator == "+") then
						score = score + action.value
					end
					if(action.operator == "-") then
						score = score - action.value
					end
					if(action.operator == "*") then
						score = score * action.value
					end
					if(action.operator == "/") then
						score = score / action.value
					end
					if(action.operator == "positive") then
						if(score > 0) then
							score = 0 + score
							else
							score = 0 - score
						end
					end
					if(action.operator == "negative") then
						if(score > 0) then
							score = 0 - score
							else
							score = 0 + score
						end
					end
					if(action.operator == "random") then
						score = math.random(action.min,action.max)
					end
					if(action.operator == "floor") then
						score = math.floor(score)
					end
					if(action.operator == "ceil") then
						score = math.ceil(score)
					end
					
					
					setScore(action.score,action.key,score)
				end
				
				
				
				
				
			end
			
			if houseregion then
				if(action.name == "change_house_statut") then
					
					setScore(action.value,"Statut",action.score)
				end
				if(action.name == "change_house_score") then
					
					setScore(action.value,"Score",action.score)
				end
				
				
				
				if(action.name == "open_placed_item_ui") then
					if currentHouse ~= nil then
						if(getHouseStatut(currentHouse.tag) == 1) then
							PlacedItemsUI()
						end
					end
				end
				if(action.name == "open_buyed_item_ui") then
					if currentHouse ~= nil then
						if(getHouseStatut(currentHouse.tag) == 1) then
							
							BuyedItemsUI()
						end
					end
				end
				if(action.name == "move_looked_item_to_player_position") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local obj = getItemEntityFromManager(entid)
						if(obj == nil) then
							obj = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(obj ~= nil) then
							local objpos = Game.GetPlayer():GetWorldPosition()
							local qat = Game.GetPlayer():GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(obj, objpos, angle, true)
						end
					end
				end
				if(action.name == "move_looked_item_Z") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local obj = getItemEntityFromManager(entid)
						if(obj == nil) then
							obj = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(obj ~= nil) then
							local objpos = objLook:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.z = objpos.z + action.value
							local qat = objLook:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(obj, objpos, angle, true)
							else
							logme(3,"null")
						end
					end
				end
				if(action.name == "move_looked_item_X") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local obj = getItemEntityFromManager(entid)
						if(obj == nil) then
							obj = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(obj ~= nil) then
							local objpos = objLook:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.x = objpos.x + action.value
							local qat = objLook:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(obj, objpos, angle, true)
						end
					end
				end
				if(action.name == "move_looked_item_Y") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local obj = getItemEntityFromManager(entid)
						if(obj == nil) then
							obj = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(obj ~= nil) then
							local objpos = objLook:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.y = objpos.y + action.value
							local qat = objLook:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(obj, objpos, angle, true)
						end
					end
				end
				if(action.name == "yaw_looked_item") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local obj = getItemEntityFromManager(entid)
						if(obj == nil) then
							obj = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(obj ~= nil) then
							local objpos = objLook:GetWorldPosition()
							local qat = objLook:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.yaw = angle.yaw + action.value
							updateItemPosition(obj, objpos, angle, true)
						end
					end
				end
				if(action.name == "roll_looked_item") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local entity = getItemEntityFromManager(entid)
						if(entity == nil) then
							entity = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(entity ~= nil) then
							local worldpos = entity:GetWorldTransform()
							local pos = worldpos.Position:ToVector4(worldpos.Position)	
							local qat = worldpos:GetOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.roll = angle.roll + action.value
							updateItemPosition(obj, pos, angle)
						end
					end
				end
				if(action.name == "pitch_looked_item") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local entity = getItemEntityFromManager(entid)
						if(entity == nil) then
							entity = getItemEntityFromManagerByPlayerLookinAt()
						end
						if(entity ~= nil) then
							local worldpos = entity:GetWorldTransform()
							local pos = worldpos.Position:ToVector4(worldpos.Position)	
							local qat = worldpos:GetOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.roll = angle.roll + action.value
							updateItemPosition(obj, pos, angle)
						end
					end
				end
				if(action.name == "set_item") then
					if grabbedTarget ~= nil then
						--	tp:Teleport(grabbedTarget, targetPos, targetAngle)
						-- if(Game.FindEntityByID(selectedItem.entityId):IsA('gameObject') == false)then
						-- grabbedTarget:Destroy()
						-- end
						updateItemPosition(selectedItem, targetPos, targetAngle,true)
						grabbedTarget = nil
						grabbed = false
						objPush = false
						objPull = false
						enabled = false
						id = false
					end
				end
				if(action.name == "looked_item_remove") then
					if objLook ~= nil then
						tarName = objLook:ToString()
						appName = Game.NameToString(objLook:GetCurrentAppearanceName())
						dipName = objLook:GetDisplayName()
						local entid = objLook:GetEntityID()
						local entity = getItemEntityFromManager(entid)
						if(entity == nil) then
							entity = getItemEntityFromManagerByPlayerLookinAt()
						end
						-- if(entity ~= nil) then
						logme(3,entity.Tag)
						logme(3,entity.Tag)
						logme(3,#currentSave.arrayPlayerItems)
						for i =1, #currentSave.arrayPlayerItems do
							local mitem = currentSave.arrayPlayerItems[i]
							logme(3,mitem.Tag)
							if(mitem.Tag == entity.Tag) then
								local housingitem = getHousing(entity.Tag,entity.X,entity.Y,entity.Z)
								deleteHousing(housingitem.Id)
								updatePlayerItemsQuantity(mitem,1)
								despawnItem(entid)
							end
						end
						else
						logme(3,"nope")
					end
				end
				
				if(action.name == "grab_select_item") then
					if selectedItem ~= nil then
						enabled = true
						id = true
						grabbedTarget = Game.FindEntityByID(selectedItem.entityId)
						if(grabbedTarget:IsA('gameObject') == false)then
							grabbedTarget = nil
							grabbed = false
							objPush = false
							objPull = false
							enabled = false
							id = false
							--Game.GetPlayer():SetWarningMessage(getLang(action.value))
							-- local objpos = grabbedTarget:GetWorldPosition()
							-- local worldpos = Game.GetPlayer():GetWorldTransform()
							-- local qat = grabbedTarget:GetWorldOrientation()
							-- local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							-- local transform = Game.GetPlayer():GetWorldTransform()
							-- transform:SetPosition(objpos)
							-- transform:SetOrientationEuler(angle)
							-- grabbedTarget = WorldFunctionalTests.SpawnEntity("base\\items\\interactive\\dining_accessories\\int_dining_accessories_001__bar_asset_h_sponge.ent", transform, '')
						end
						Cron.After(0.7,function()	
							if (grabbedTarget ~= nil) then
								targetPos = grabbedTarget:GetWorldPosition()
								targetAngle = Vector4.ToRotation(grabbedTarget:GetWorldForward())
								objectDist = Vector4.Distance(targetPos, playerPos)
								phi = math.atan2(playerAngle.y, playerAngle.x)
								targetDeltaPos = Vector4.new(((objectDist * math.cos(phi)) + playerPos.x), ((objectDist * math.sin(phi)) + playerPos.y), (objectDist * math.sin(playerAngle.z) + playerPos.z), targetPos.w)
								targetDeltaPos = Delta(targetDeltaPos, targetPos)
								logme(3,grabbedTarget, "grabbed.")
								grabbed = true
								else
								logme(3,"No target!")
							end
						end)
					end
				end
				if(action.name == "select_item") then
					if(#currentItemSpawned > 0 )then
						for i = 1, #currentItemSpawned do 
							local mitems = currentItemSpawned[i]
							if(mitems.Id == action.value) then
								selectedItem = nil
								selectedItem = mitems
								if(selectedItem.entityId ~= nil and Game.FindEntityByID(selectedItem.entityId) ~=nil and Game.FindEntityByID(selectedItem.entityId):IsA('gameObject') == true)then
									grabbedTarget = Game.FindEntityByID(selectedItem.entityId)
									enabled = true
									id = true
									if (grabbedTarget ~= nil) then
										targetPos = grabbedTarget:GetWorldPosition()
										targetAngle = Vector4.ToRotation(grabbedTarget:GetWorldForward())
										objectDist = Vector4.Distance(targetPos, playerPos)
										phi = math.atan2(playerAngle.y, playerAngle.x)
										targetDeltaPos = Vector4.new(((objectDist * math.cos(phi)) + playerPos.x), ((objectDist * math.sin(phi)) + playerPos.y), (objectDist * math.sin(playerAngle.z) + playerPos.z), targetPos.w)
										targetDeltaPos = Delta(targetDeltaPos, targetPos)
										logme(3,grabbedTarget, "grabbed.")
										grabbed = true
										else
										logme(3,"No target!")
									end
								end
							end
						end
					end
				end
				if(action.name == "unselect_item") then
					selectedItem = nil
					grabbedTarget = nil
					grabbed = false
					objPush = false
					objPull = false
					enabled = false
					id = false
				end
				if(action.name == "move_select_item_to_player_position") then
					if selectedItem ~= nil then
						local objpos = Game.GetPlayer():GetWorldPosition()
						local qat = Game.GetPlayer():GetWorldOrientation()
						local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
						updateItemPosition(selectedItem, objpos, angle, true)
					end
				end
				if(action.name == "move_selected_item_Z") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local objpos = entity:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.z = objpos.z + action.value
							local qat = entity:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
					end
				end
				if(action.name == "move_selected_item_X") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local objpos = entity:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.x = objpos.x + action.value
							local qat = entity:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
					end
				end
				if(action.name == "move_selected_item_Y") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local objpos = entity:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							objpos.y = objpos.y + action.value
							local qat = entity:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							updateItemPosition(selectedItem, objpos, angle, true)
						end
					end
				end
				if(action.name == "yaw_selected_item") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local objpos = entity:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							local qat = entity:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.yaw = angle.yaw + action.value
							updateItemPosition(selectedItem, objpos, angle, true)
						end
					end
				end
				if(action.name == "roll_selected_item") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local objpos = entity:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							local qat = entity:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.roll = angle.roll + action.value
							updateItemPosition(selectedItem, objpos, angle, true)
						end
					end
				end
				if(action.name == "pitch_selected_item") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local objpos = entity:GetWorldPosition()
							local worldpos = Game.GetPlayer():GetWorldTransform()
							local qat = entity:GetWorldOrientation()
							local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
							angle.pitch = angle.pitch + action.value
							updateItemPosition(selectedItem, objpos, angle, true)
						end
					end
				end
				if(action.name == "selected_item_remove") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							for i =1, #currentSave.arrayPlayerItems do
								local mitem = currentSave.arrayPlayerItems[i]
								if(mitem.Tag == selectedItem.Tag) then
									Game.FindEntityByID(selectedItem.entityId):GetEntity():Destroy()
									logme(3,"toto")
									updatePlayerItemsQuantity(mitem,1)
									deleteHousing(selectedItem.Id)
									local index = getItemEntityIndexFromManager(selectedItem.entityId)
									--despawnItem(selectedItem.Id)
									table.remove(currentItemSpawned,index)
									Cron.After(1, function()
										selectedItem = nil
									end)
								end
							end
							else
							logme(3,"nope")
						end
					end
				end
				if(action.name == "spawn_buyed_item") then
					if action.tag ~= nil then
						local pos = Game.GetPlayer():GetWorldPosition()
						local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
						local spawnedItem = {}
						local mitems =  getPlayerItemsbyTag(action.tag)
						if(currentHouse ~= nil and mitems ~= nil and mitems.Quantity > 0 and (string.match(tostring(mitems.Tag), "AMM_Props.") == nil or (string.match(tostring(mitems.Tag), "AMM_Props.") ~= nil and AMM ~= nil)  )    ) then
							spawnedItem.Tag = mitems.Tag
							spawnedItem.HouseTag = currentHouse.tag
							spawnedItem.ItemPath = mitems.Path
							spawnedItem.X = pos.x
							spawnedItem.Y = pos.y
							spawnedItem.Z = pos.z
							spawnedItem.Yaw = angles.yaw
							spawnedItem.Pitch = angles.pitch
							spawnedItem.Roll = angles.roll
							spawnedItem.Title = mitems.Title
							spawnedItem.fromTemplate = false
							saveHousing(spawnedItem)
							local housing = getHousing(spawnedItem.Tag,spawnedItem.X,spawnedItem.Y,spawnedItem.Z)
							spawnedItem.Id = housing.Id
							updatePlayerItemsQuantity(mitems,-1)
							spawnedItem.entityId = spawnItem(spawnedItem, pos, angles)
							local entity = Game.FindEntityByID(spawnedItem.entityId)
							local components = checkForValidComponents(entity)
							if components then
								local visualScale = checkDefaultScale(components)
								spawnedItem.defaultScale = {
									x = visualScale.x * 100,
									y = visualScale.x * 100,
									z = visualScale.x * 100,
								}
								spawnedItem.scale = {
									x = visualScale.x * 100,
									y = visualScale.y * 100,
									z = visualScale.z * 100,
								}
							end
							table.insert(currentItemSpawned,spawnedItem)
							selectedItem = spawnedItem
						end
					end
				end
				if(action.name == "despawn_placed_item") then
					if action.tag ~= nil then
						local pos = Game.GetPlayer():GetWorldPosition()
						local angles = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
						local spawnedItem = {}
						if(currentHouse ~= nil)then
							local entity =  getItemByHouseTagandTagFromManager(action.tag,currentHouse.tag)
							if(entity ~= nil) then
								for i =1, #currentSave.arrayPlayerItems do
									local mitem = currentSave.arrayPlayerItems[i]
									if(mitem.Tag == entity.Tag) then
										local housingitem = getHousing(entity.Tag,entity.X,entity.Y,entity.Z)
										despawnItem(entity.entityId)
										deleteHousing(housingitem.Id)
										updatePlayerItemsQuantity(mitem,1)
									end
								end
								else
								logme(3,"nope")
							end
						end
					end
				end
				if(action.name == "current_place_clear_all_item") then
					
					if(currentHouse ~=nil) then
						if(#currentItemSpawned > 0) then
							
							
							for i=1,#currentItemSpawned do
								
								deleteHousing(currentItemSpawned[i].Id)
								
								
							end
							
							despawnItemFromHouse()
							
						end
					end
					
				end
				if(action.name == "scale_selected_item") then
					if selectedItem ~= nil then
						local entity = Game.FindEntityByID(selectedItem.entityId)
						if(entity ~= nil) then
							local values = Vector3.new(action.x, action.y, action.z)
							setItemScale(entity, values)
						end
					end
				end
				
				
				
				if(action.name == "current_place_apply_template") then
					
					currentHouseApplyTemplate(action.tag,action.x,action.y,action.z)
					
				end
				
				if(action.name == "current_place_clear_all_template") then
					currentHouseClearAllTemplate()
					
				end
				
				
				if(action.name == "current_place_clear_template") then
					
					
					currentHouseClearTemplate(action.tag)
					
				end
				
			end
			
			if gangregion then
				if(action.name == "gang_affinity") then
					local score = getScoreKey("Affinity",action.value)
					if(score == nil) then
						score = 0
						setScore("Affinity",action.value,score)
					end
					score = score + action.score
					setScore("Affinity",action.value,score)
				end
				if(action.name == "add_gang_district_score") then
					local score = getVariableKeyWithDefault(action.faction,action.district,0)
					setVariable(action.faction,action.district,score + action.value)
				end
				if(action.name == "remove_gang_district_score") then
					local score = getVariableKeyWithDefault(action.faction,action.district,0)
					setVariable(action.faction,action.district,score - action.value)
				end
				if(action.name == "set_gang_district_score") then
					setVariable(action.faction,action.district,action.value)
				end
				if(action.name == "gang_affinity_from_current_district_leader") then
					local gangs = getGangfromDistrict(currentDistricts2.tag,20)
					if(#gangs > 0) then
						local gang = getFactionByTag(gangs[1].tag)
						local score = getScoreKey("Affinity",gang.tag)
						if(score == nil) then
							score = 0
							setScore("Affinity",gang.tag,score)
						end
						score = score + action.score
						setScore("Affinity",gang.tag,score)
					end
				end
				if(action.name == "gang_affinity_from_current_district_leader_rival") then
					
					local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
					if(#gangs > 0) then
						local gang = getFactionByTag(gangs[1].tag)
						local rivalindex = math.random(1,#gang.rivals)
						gang = getFactionByTag(gang.rivals[rivalindex])
						local score = getScoreKey("Affinity",gang.tag)
						if(score == nil) then
							score = 0
							setScore("Affinity",gang.tag,score)
						end
						score = score + action.score
						setScore("Affinity",gang.tag,score)
					end
				end
				if(action.name == "gang_affinity_from_current_subdistrict_leader") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local gangs = getGangfromDistrict(test,20)
								if(#gangs > 0) then
									local gang = getFactionByTag(gangs[1].tag)
									local score = getScoreKey(gang.tag,"Score")
									if(score == nil) then
										score = 0
										setScore("Affinity",gang.tag,score)
									end
									score = score + action.score
									setScore("Affinity",gang.tag,score)
									break
								end
							end
						end
					end
				end
				if(action.name == "gang_affinity_from_current_subdistrict_leader_rival") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local gangs = getGangfromDistrict(test,20)
								if(#gangs > 0) then
									local gang = getFactionByTag(gangs[1].tag)
									local rivalindex = math.random(1,#gang.rivals)
									gang = getFactionByTag(gang.rivals[rivalindex])
									local score = getScoreKey("Affinity",gang.tag)
									if(score == nil) then
										score = 0
										setScore("Affinity",gang.tag,score)
									end
									score = score + action.score
									setScore("Affinity",gang.tag,score)
									break
								end
							end
						end
					end
				end
				
				
				if(action.name == "add_gang_currentdistrict_score") then
					if currentDistricts2 ~= nil then
						
						local score = getVariableKeyWithDefault(action.faction,currentDistricts2.Tag,0)
						setVariable(action.faction,currentDistricts2.Tag, score + action.value) 
						
					end
				end
				if(action.name == "remove_gang_currentdistrict_score") then
					if currentDistricts2 ~= nil then
						local score = getVariableKeyWithDefault(action.faction,currentDistricts2.Tag,0)
						setVariable(action.faction,currentDistricts2.Tag, score + action.value) 
					end
				end
				if(action.name == "add_leader_currentdistrict_score") then
					if currentDistricts2 ~= nil then
						local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
						if(#gangs > 0) then
							
							
							local score = getVariableKeyWithDefault(gangs[1].tag,currentDistricts2.Tag,0)
							setVariable(gangs[1].tag,currentDistricts2.Tag, score + action.value) 
						end
					end
				end
				if(action.name == "remove_leader_currentdistrict_score") then
					if currentDistricts2 ~= nil then
						local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
						if(#gangs > 0) then
							local score = getVariableKeyWithDefault(gangs[1].tag,currentDistricts2.Tag,0)
							setVariable(gangs[1].tag,currentDistricts2.Tag, score - action.value) 
						end
					end
				end
				if(action.name == "add_leader_currentsubdistrict_score") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local gangs = getGangfromDistrict(test,20)
								if(#gangs > 0) then
									
									local score = getVariableKeyWithDefault(gangs[1].tag,test,0)
									setVariable(gangs[1].tag,test, score + action.value) 
									break
								end
							end
						end
					end
				end
				if(action.name == "remove_leader_currentsubdistrict_score") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local gangs = getGangfromDistrict(test,20)
								if(#gangs > 0) then
									
									local score = getVariableKeyWithDefault(gangs[1].tag,test,0)
									setVariable(gangs[1].tag,test, score - action.value) 
									break
								end
							end
						end
					end
				end
				if(action.name == "set_gang_currentdistrict_score") then
					if currentDistricts2 ~= nil then
						
						setVariable(action.faction,currentDistricts2.Tag, action.value) 
					end
				end
				if(action.name == "add_gang_currentsubdistrict_score") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local score = getVariableKeyWithDefault(action.faction,test,0)
								setVariable(action.faction,test, score + action.value) 
								break
							end
						end
					end
				end
				if(action.name == "remove_gang_currentsubdistrict_score") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local score = getVariableKeyWithDefault(action.faction,test,0)
								setVariable(action.faction,test, score - action.value) 
								break
							end
						end
					end
				end
				if(action.name == "set_gang_currentsubdistrict_score") then
					if #currentDistricts2.districtLabels > 0 then
						for i, test in ipairs(currentDistricts2.districtLabels) do
							if i > 1 then
								local score = getVariableKeyWithDefault(action.faction,test,0)
								setVariable(action.faction,test,action.value) 
								break
							end
						end
					end
				end
				if(action.name == "trigger_edit_crew_mode") then
					inCrewManager = action.value
				end
				if(action.name == "set_player_current_gang") then
					setVariable("player","current_gang",action.tag)
				end
				if(action.name == "set_gang_relation") then
					
					if(action.tag == "player") then
						
						action.tag = getVariableKey("player","current_gang")
						
					end
					
					
					if(action.mode == "gang") then
						
						
						if(action.target ~= action.tag) then
							
							setFactionRelation(action.tag,action.target,action.score)
							
						end
						
					end
					
					if(action.mode == "district_leader" or action.mode == "district_subleader") then
						
						local gangs = getGangfromDistrict(action.target,20)
						if(#gangs > 0) then
							
							if(gangs[1].tag ~= action.tag) then
								
								setFactionRelation(action.tag,gangs[1].tag,action.score)
								
							end
						end
						
						
					end
					
					if(action.mode == "current_district_leader") then
						
						if currentDistricts2 ~= nil then
							local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
							if(#gangs > 0) then
								setFactionRelation(action.tag,gangs[1].tag,action.score)
								
							end
						end
						
					end
					
					if(action.mode == "current_district_subleader") then
						if currentDistricts2 ~= nil then
							if #currentDistricts2.districtLabels > 0 and #currentDistricts2.districtLabels > 1 then
								local gangs = getGangfromDistrict(currentDistricts2.districtLabels[2],20)
								if(#gangs > 0) then
									setFactionRelation(action.tag,gangs[1].tag,action.score)
									
								end
							end
						end
						
					end
					
				end
				
				if(action.name == "add_gang_relation") then
					
					if(action.tag == "player") then
						
						action.tag = getVariableKey("player","current_gang")
						
					end
					
					
					if(action.mode == "gang") then
						
						
						if(action.target ~= action.tag) then
							
							addFactionRelation(action.tag,action.target,action.score)
							
						end
						
					end
					
					if(action.mode == "district_leader" or action.mode == "district_subleader") then
						
						local gangs = getGangfromDistrict(action.target,20)
						if(#gangs > 0) then
							
							if(gangs[1].tag ~= action.tag) then
								
								addFactionRelation(action.tag,gangs[1].tag,action.score)
								
							end
						end
						
						
					end
					
					if(action.mode == "current_district_leader") then
						
						if currentDistricts2 ~= nil then
							local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
							if(#gangs > 0) then
								addFactionRelation(action.tag,gangs[1].tag,action.score)
								
							end
						end
						
					end
					
					if(action.mode == "current_district_subleader") then
						if currentDistricts2 ~= nil then
							if #currentDistricts2.districtLabels > 0 and #currentDistricts2.districtLabels > 1 then
								local gangs = getGangfromDistrict(currentDistricts2.districtLabels[2],20)
								if(#gangs > 0) then
									addFactionRelation(action.tag,gangs[1].tag,action.score)
									
								end
							end
						end
						
					end
					
				end
			end
			
			if miscregion then
				if(action.name == "set_fact") then
					Game.SetDebugFact(action.value, action.score)
				end
				if(action.name == "refresh_shard_cache") then
					local activeData = CodexListSyncData.new()
					local gameshards = CodexUtils.GetShardsDataArray(GameInstance.GetJournalManager(), activeData)
					if gameshardscompiled == nil then gameshardscompiled = {} end
					for i,v in pairs(gameshards) do
						if gameshardscompiled[v.data.title] == nil then gameshardscompiled[v.data.title] = true end
						
						
					end		
				end
				if(action.name == "execute_in_tick") then
					
					if(#action.action > 0) then
						for i,act in ipairs(action.action) do
							
							executeAction(act,tag,parent,index,source,executortag)
							
						end
					end
					
				end
				if(action.name == "load_interact") then
					
					if(#loadInteract < 4 and (table_contains(loadInteract,action.tag,false) == false))then
						table.insert(loadInteract,action.tag)
						
						createInteraction(false)
						candisplayInteract = true
						createInteraction(true)
						cycleInteract()
						else
						if((table_contains(loadInteract,action.tag,false) == false)) then
							error("There is already 4 force loaded interact. Limit is reached !")
						end
					end
				end
				
				if(action.name == "unload_interact") then
					if(#loadInteract > 0 and (table_contains(loadInteract,action.tag,false) == true)) then
						local indextoremove  = nil
						for i,v in ipairs(loadInteract) do
							
							if(v == action.tag) then
								
								indextoremove = i
								
							end
							
						end
						
						
						if(indextoremove ~= nil) then
							
							table.remove(loadInteract,indextoremove)
							
						end
						
					end
					candisplayInteract = false
					createInteraction(false)
				end
				
				if(action.name == "clean_all_loaded_interact") then
					loadInteract = {}
					candisplayInteract = false
					createInteraction(false)
				end
				
				if(action.name == "buy_item") then
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new("Items.money")
					local itemid = ItemID.new(tid)
					local amount = tonumber(action.price)
					if currentHouse ~= nil and currentHouse.coef ~=nil and currentHouse.coef > 0 then
						amount = amount * currentHouse.coef	
					end
					if currentStar ~= nil then
						amount = amount * 2
					end
					local result = ts:RemoveItem(player, itemid, amount)
					------logme(3,"remove money")
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new(action.value)
					local itemid = ItemID.new(tid)
					local result = ts:GiveItem(player, itemid, tonumber(action.amount))
					------logme(3,"give item")
				end
				if(action.name == "give_item") then
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new(action.value)
					local itemid = ItemID.new(tid)
					local result = ts:GiveItem(player, itemid, tonumber(action.amount))
					------logme(3,"give item")
				end
				if(action.name == "remove_item") then
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new(action.value)
					local itemid = ItemID.new(tid)
					local result = ts:RemoveItem(player, itemid, tonumber(action.amount))
				end
				if(action.name == "give_money") then
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new("Items.money")
					local itemid = ItemID.new(tid)
					local amount = tonumber(action.value)
					if currentHouse ~= nil and currentHouse.coef ~= nil then
						amount = amount * currentHouse.coef	
					end
					local result = ts:GiveItem(player, itemid, amount)
					------logme(3,"give money")
				end
				if(action.name == "remove_money") then
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new("Items.money")
					local itemid = ItemID.new(tid)
					local amount = tonumber(action.value)
					if(action.useplacecoef ~= nil and action.useplacecoef == true) then
						if currentHouse ~= nil and currentHouse.coef ~=nil then
							amount = amount * currentHouse.coef	
						end
						if currentStar ~= nil then
							amount = amount * 2
						end
					end
					local result = ts:RemoveItem(player, itemid, amount)
					logme(3,result)
				end
				if(action.name == "remove_random_money") then
					local player = Game.GetPlayer()
					local ts = Game.GetTransactionSystem()
					local tid = TweakDBID.new("Items.money")
					local itemid = ItemID.new(tid)
					local amount = tonumber(action.value)
					if currentHouse ~= nil and currentHouse.coef ~=nil then
						amount = amount * currentHouse.coef	
					end
					if currentStar ~= nil then
						amount = amount * 2
					end
					local result = ts:RemoveItem(player, itemid, amount)
					--logme(3,result)
					--logme(3,"remove money")
				end
				if(action.name == "clean_custommappin") then
					ActivecustomMappin = nil
					
					
					
					
					mappinManager["selected_mappin"] = nil
				end
				if(action.name == "clean_activefasttravelpoint") then
					ActiveFastTravelMappin = nil
					mappinManager["selected_fasttravel_mappin"] = nil
				end
				
				if(action.name == "notify") then
					Game.GetPlayer():SetWarningMessage(getLang(action.value))
				end
				
				if(action.name == "custom_notification") then
					
					
					
					
					
					local message = SimpleScreenMessage.new()
					message.message = getLang(action.value)
					message.isShown = true
					message.duration = 5
					if action.type ~= 0 then
						message.type = action.type
					end
					
					local blackboardDefs = Game.GetAllBlackboardDefs()
					local blackboardUI = Game.GetBlackboardSystem():Get(blackboardDefs.UI_Notifications)
					blackboardUI:SetVariant(
						blackboardDefs.UI_Notifications.WarningMessage,
						ToVariant(message),
						true
					)
					
				end
				
				if(action.name == "simple_message") then
					local message = SimpleScreenMessage.new()
					message.message = getLang(action.value)
					message.isShown = true
					local blackboardDefs = Game.GetAllBlackboardDefs()
					local blackboardUI = Game.GetBlackboardSystem():Get(blackboardDefs.UI_Notifications)
					blackboardUI:SetVariant(
						blackboardDefs.UI_Notifications.OnscreenMessage,
						ToVariant(message),
						true
					)
				end
				
				if(action.name == "npcd_finish_notification") then
					local ncpd = NCPDJobDoneEvent.new()
					ncpd.levelXPAwarded = action.levelXPAwarded
					ncpd.streetCredXPAwarded  = action.streetCredXPAwarded
					Game.GetUISystem():QueueEvent(ncpd)
				end
				if(action.name == "quest_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					
					local userData = QuestUpdateNotificationViewData.new()
					userData.text = getLang(action.desc)
					
					if(action.type == "new") then
						
						local questAction = TrackQuestNotificationAction.new()
						questAction.eventDispatcher = GameController["JournalNotificationQueue"]
						
						if(action.quest ~= nil and action.quest ~= "") then
							local questentry = gameJournalQuest.new()
							questentry.districtID = action.objective
							questentry.id = action.quest
							questAction.questEntry = questentry
							
						end
						
						userData.title = test
						userData.canBeMerged = false;
						userData.action = questAction
						userData.soundEvent = CName("QuestNewPopup")
						userData.soundAction = CName("OnOpen")
						userData.animation = CName("notification_new_quest_added")
						
						
						
						
						
						local notificationData = gameuiGenericNotificationData.new()
						notificationData.time = action.duration
						notificationData.widgetLibraryItemName = CName('notification_new_quest_added')
						notificationData.notificationData = userData
						GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
						
						
					end
					
					if(action.type == "update") then
						
						local questAction = TrackQuestNotificationAction.new()
						questAction.eventDispatcher = GameController["JournalNotificationQueue"]
						
						
						userData.title = "UI-Notifications-QuestUpdated"
						userData.canBeMerged = false;
						userData.action = questAction
						userData.soundEvent = CName("QuestUpdatePopup")
						userData.soundAction = CName("OnOpen")
						userData.animation = CName("notification_quest_updated")
						
						
						if(action.quest ~= nil and action.quest ~= "") then
							local questentry = gameJournalQuest.new()
							questentry.districtID = action.objective
							questentry.id = action.quest
							
							questAction.questEntry = questentry
							
						end
						
						
						local notificationData = gameuiGenericNotificationData.new()
						notificationData.time = action.duration
						notificationData.widgetLibraryItemName = CName('notification_quest_updated')
						notificationData.notificationData = userData
						GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
						
						
					end
					
					if(action.type == "success") then
						
						
						
						
						userData.title = "UI-Notifications-QuestCompleted"
						userData.canBeMerged = false
						userData.soundEvent = CName("QuestSuccessPopup")
						userData.soundAction = CName("OnOpen")
						userData.animation = CName("notification_quest_completed")
						userData.dontRemoveOnRequest = false
						
						
						
						
						local notificationData = gameuiGenericNotificationData.new()
						notificationData.time = action.duration
						notificationData.widgetLibraryItemName = CName('notification_quest_completed')
						notificationData.notificationData = userData
						GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
						
						
					end
					
					if(action.type == "fail") then
						
						
						userData.title = "LocKey#27566"
						userData.canBeMerged = false
						userData.soundEvent = CName("QuestFailedPopup")
						userData.soundAction = CName("OnOpen")
						userData.animation = CName("notification_quest_failed")
						userData.dontRemoveOnRequest = false
						
						
						
						
						local notificationData = gameuiGenericNotificationData.new()
						notificationData.time = action.duration
						notificationData.widgetLibraryItemName = CName('notification_quest_failed')
						notificationData.notificationData = userData
						GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
						
						
					end
					
				end
				if(action.name == "shard_notification") then
					local test = getLang(action.title)
					
					
					local notificationData =  gameuiGenericNotificationData.new()
					
					local userData = ShardCollectedNotificationViewData.new()
					userData.title = GetLocalizedText("UI-Notifications-ShardCollected") .. " " .. test
					userData.text = getLang(action.desc)
					userData.shardTitle = test
					userData.isCrypted = action.iscrypted
					userData.entry = nil
					
					
					if(action.shard ~= nil and action.shard ~= "") then
						
						local shard = getShardByTag(action.shard)
						
						if(shard ~= nil) then
							checkContext(shard)
							
							userData.title = GetLocalizedText("UI-Notifications-ShardCollected") .. " " .. getLang(shard.title)
							userData.text = getLang(shard.description)
							userData.shardTitle = getLang(shard.title)
							cyberscript.cache["shard"][shard.tag].data.locked = false
							userData.isCrypted = shard.crypted
						end
					end
					
					
					
					
					local shardOpenAction = OpenShardNotificationAction.new()
					shardOpenAction.eventDispatcher = Game.GetUISystem()
					
					userData.action = shardOpenAction
					userData.soundEvent = CName("ShardCollectedPopup")
					userData.soundAction = CName("OnLoot")
					
					
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName('notification_shard')
					notificationData.notificationData = userData
					
					
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					
					
				end
				if(action.name == "contact_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					
					local notificationData =  gameuiGenericNotificationData.new()
					
					local userData = QuestUpdateNotificationViewData.new()
					userData.title = GetLocalizedText("Story-base-gameplay-gui-widgets-notifications-quest_update-_localizationString6")
					userData.text = getLang(action.desc)
					userData.animation = CName("notification_newContactAdded")
					
					
					
					
					userData.soundEvent = CName("QuestUpdatePopup")
					userData.soundAction = CName("OnOpen")
					
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName('notification_NewContactAdded')
					notificationData.notificationData = userData
					
					
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					
					
				end
				if(action.name == "location_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					
					local userData = QuestUpdateNotificationViewData.new()
					userData.title = test
					userData.text = getLang(action.desc)
					userData.animation = CName("notification_LocationAdded")
					userData.soundEvent = CName("ui_phone_sms")
					userData.soundAction = CName("OnOpen")
					
					local notificationData = gameuiGenericNotificationData.new()
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName("notification_LocationAdded")
					notificationData.notificationData = userData
					
					
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					
					
				end
				
				if(action.name == "codex_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					
					local userData = QuestUpdateNotificationViewData.new()
					userData.title = test
					userData.text = getLang(action.desc)
					userData.animation = CName("notification_LocationAdded")
					userData.soundEvent = CName("ui_phone_sms")
					userData.soundAction = CName("OnOpen")
					
					local notificationData = gameuiGenericNotificationData.new()
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName("notification_LocationAdded")
					notificationData.notificationData = userData
					
					
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					
					
				end
				
				if(action.name == "activity_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					
					local userData = QuestUpdateNotificationViewData.new()
					userData.title = test
					userData.text = getLang(action.desc)
					userData.animation = CName("notification_new_activity")
					userData.soundEvent = CName("QuestNewPopup")
					userData.soundAction = CName("OnOpen")
					userData.canBeMerged = false
					
					local notificationData = gameuiGenericNotificationData.new()
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName("notification_new_activity")
					notificationData.notificationData = userData
					
					
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					
					
				end
				
				if(action.name == "authorization_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					-- local notificationData = gameuiGenericNotificationData.new()
					-- local userData = AuthorisationNotificationViewData.new()
					-- userData.title = test
					-- userData.text = getLang(action.desc)
					-- userData.authType = 2;
					-- notificationData.time = action.duration
					-- notificationData.widgetLibraryItemName = CName("access_granted")
					-- notificationData.notificationData = userData
					
					
					-- GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					local notification = AuthorisationNotificationEvent.new();
					notification.type = action.type
					
					Game.GetPlayer():QueueEvent(notification);
					
				end
				
				
				
				
				if(action.name == "hacking_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					
					local userData = QuestUpdateNotificationViewData.new()
					userData.title = test
					userData.text = getLang(action.desc)
					userData.animation = CName("notification_hacking_reward")
					userData.soundEvent = CName("QuestNewPopup")
					userData.soundAction = CName("OnOpen")
					userData.canBeMerged = false
					
					local notificationData = gameuiGenericNotificationData.new()
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName("notification_hacking_reward")
					notificationData.notificationData = userData
					
					
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
					
					
				end
				if(action.name == "phone_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					local openAction = OpenMessengerNotificationAction.new()
					openAction.eventDispatcher = GameController["JournalNotificationQueue"]
					local userData = PhoneMessageNotificationViewData.new()
					userData.title = test
					userData.SMSText = getLang(action.desc)
					userData.action = openAction
					userData.animation = CName('notification_phone_MSG')
					userData.soundEvent = CName('PhoneSmsPopup')
					userData.soundAction = CName('OnOpen')
					currentPhoneDialogPopup = gameJournalPhoneMessage.new()
					currentPhoneDialogPopup.sender = 1
					currentPhoneDialogPopup.text = getLang(action.desc)
					currentPhoneDialogPopup.delay = -9999
					currentPhoneDialogPopup.id = test
					local gotsomething = false
					if(action.conversation ~= nil and action.conversation ~= "") then
						
						for k,v in pairs(cyberscript.cache["phone_dialog"]) do
							local phoneConversation = v.data
							for z=1,#phoneConversation.conversation do
								local conversation = phoneConversation.conversation[z]
								if(conversation.tag == action.conversation)then
									gotsomething = true
								
									currentPhoneConversation = phoneConversation.conversation[z]
									currentPhoneConversation.currentchoices = {}
									currentPhoneConversation.loaded = 0
									currentPhoneConversation.speaker = conversation.speaker
									phonecounter = -1
									
								end
							end
							
						end
					end
					
					if(gotsomething == false ) then
						
   						currentPhoneConversation = "cs_nothing"
					end
					
					local notificationData = gameuiGenericNotificationData.new()
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName('notification_message')
					notificationData.notificationData = userData
					GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
				end
				
				if(action.name == "phone_news_notification") then
					local test = getLang(action.title)
					local obj = getEntityFromManager(action.title)
					local enti = Game.FindEntityByID(obj.id)
					if(action.title == "lookat")then
						enti = objLook
					end
					if(enti ~= nil) then
						if(action.title == "current_phone_npc") then
							if(currentNPC ~= nil) then
								test  = currentNPC.Names
							end
						end
						if(action.title == "current_star") then
							if(currentStar ~= nil) then
								test  = currentStar.Names
							end
						end
					end
					local openAction = OpenMessengerNotificationAction.new()
					openAction.eventDispatcher = GameController["JournalNotificationQueue"]
					local userData = PhoneMessageNotificationViewData.new()
					userData.title = test
					
					local text = "Error, connect to keystone for get the latest news !"
					
					if(#corpoNews > 0) then
						local id = math.random(1,#corpoNews)
						text = corpoNews[id]
					end
					userData.SMSText  = text
					
					userData.action = openAction
					userData.animation = CName('notification_phone_MSG')
					userData.soundEvent = CName('PhoneSmsPopup')
					userData.soundAction = CName('OnOpen')
					currentPhoneDialogPopup = gameJournalPhoneMessage.new()
					currentPhoneDialogPopup.sender = 1
					currentPhoneDialogPopup.text = text
					currentPhoneDialogPopup.delay = -9999
					currentPhoneDialogPopup.id = test
					
					
					local phone_news_conv = {}
					phone_news_conv.tag = "corpo_news"
					phone_news_conv.unlock = false
					phone_news_conv.speaker = getLang("see_action_phone_news_speaker")
					phone_news_conv.conversation = {}
					
					local phone_news_conv01 = {}
					phone_news_conv01.tag = "corpo_news01"
					phone_news_conv01.name = "Latest News"
					phone_news_conv01.unlock = false
					phone_news_conv01.message = {}
					
					local phone_news_conv01_msg = {}
					phone_news_conv01_msg.tag = "corpo_news01"
					phone_news_conv01_msg.text = text
					phone_news_conv01_msg.sender = 0
					phone_news_conv01_msg.unlock = true
					phone_news_conv01_msg.readed = false
					phone_news_conv01_msg.choices =  {}
					
					table.insert(phone_news_conv01.message,phone_news_conv01_msg)
					table.insert(phone_news_conv.conversation,phone_news_conv01)
					
					cyberscript.cache["phone_dialog"]["corpo_news"] = {}
					cyberscript.cache["phone_dialog"]["corpo_news"].data = phone_news_conv
					cyberscript.cache["phone_dialog"]["corpo_news"].file = "default"
					cyberscript.cache["phone_dialog"]["corpo_news"].datapack = "default"
					
					
					
					currentPhoneConversation = cyberscript.cache["phone_dialog"]["corpo_news"].data.conversation[1]
					currentPhoneConversation.currentchoices = {}
					currentPhoneConversation.loaded = 0
					currentPhoneConversation.speaker = cyberscript.cache["phone_dialog"]["corpo_news"].speaker
					
					
					local notificationData = gameuiGenericNotificationData.new()
					notificationData.time = action.duration
					notificationData.widgetLibraryItemName = CName('notification_message')
					notificationData.notificationData = userData
					GameController["NewHudPhoneGameController"]:AddNewNotificationData(notificationData)
				end
				
				if(action.name == "tutorial_notification") then
					
					--openInterface = true
					if UIPopupsManager.IsReady() then
						local notificationData = TutorialPopupData.new()
						notificationData.notificationName = CName("base\\gameplay\\gui\\widgets\\notifications\\tutorial.inkwidget")
						notificationData.queueName = CName("tutorial")
						notificationData.closeAtInput = action.closeatinput
						notificationData.pauseGame = action.pausegame
						notificationData.position = action.position
						notificationData.isModal = action.ismodal
						notificationData.margin = inkMargin.new()
						notificationData.title = action.title
						notificationData.message = action.desc
						notificationData.imageId = nil
						notificationData.videoType = gameVideoType.Unknown 
						notificationData.video = nil
						notificationData.useCursor = true
						notificationData.isBlocking = action.isblocking
						
						UIPopupsManager.ShowPopup(notificationData)
						else
						Game.GetPlayer():SetWarningMessage(getLang("see_action_poup_fail"))
					end
					
				end
				if(action.name=="next_help")then
					if currentHelp ~= nil then
						currentHelpIndex =currentHelpIndex+1
						if(currentHelpIndex > #currentHelp.section)then
							UIPopupsManager.ClosePopup()
							currentHelp = nil
							currentHelpIndex = 1
						end
						UIPopupsManager.ClosePopup()
					end
				end
				
				if(action.name=="previous_help")then
					if currentHelp ~= nil then
						currentHelpIndex =currentHelpIndex-1
						if(currentHelpIndex < 1)then
							currentHelpIndex =  1
						end
						UIPopupsManager.ClosePopup()
					end
					
				end
				if(action.name == "open_help") then
					currentHelp = cyberscript.cache["help"][action.tag].data
					--openInterface = true
					
					if currentHelp ~= nil then
						if(currentHelpIndex > #currentHelp.section)then
							UIPopupsManager.ClosePopup()
							currentHelp = nil
							currentHelpIndex = 1
							else
							currentHelp.action = action
							if UIPopupsManager.IsReady() then
								local notificationData = TutorialPopupData.new()
								notificationData.notificationName = CName("base\\gameplay\\gui\\widgets\\notifications\\tutorial.inkwidget")
								notificationData.queueName = CName("tutorial")
								notificationData.closeAtInput = action.closeatinput
								notificationData.pauseGame = action.pausegame
								notificationData.position = action.popupposition
								notificationData.isModal = action.ismodal
								notificationData.margin = inkMargin.new()
								notificationData.title = currentHelp.title
								if(currentHelp.section[currentHelpIndex].message == nil) then
									notificationData.message = currentHelp.section[currentHelpIndex]
									else
									notificationData.message = currentHelp.section[currentHelpIndex].message
									if(#currentHelp.section[currentHelpIndex].action > 0) then
										runActionList(currentHelp.section[currentHelpIndex].action, currentHelp.tag.."_"..currentHelpIndex, tag,source,false,executortag)
									end
								end
								notificationData.imageId = nil
								notificationData.videoType = gameVideoType.Unknown 
								notificationData.video = nil
								notificationData.useCursor = true
								notificationData.isBlocking = action.isblocking
								
								UIPopupsManager.ShowPopup(notificationData)
								else
								Game.GetPlayer():SetWarningMessage(getLang("see_action_poup_fail"))
							end
						end
						
						else
						logme(10,"no help founded with the tag "..action.tag)
					end
				end
				
				if(action.name == "hide_tutorial_notification") then
					if GameController["TutorialPopupGameController"] ~= nil then
						GameController["TutorialPopupGameController"]:GetRootWidget():SetVisible(false)
					end
				end
				
				if(action.name == "start_upload_program") then
					local evt = UploadProgramProgressEvent.new()
					evt.state = EUploadProgramState.STARTED
					evt.duration = action.duration
					evt.progressBarType = EProgressBarType.UPLOAD
					evt.progressBarContext = EProgressBarContext.QuickHack 
					
					evt.statPoolType = gamedataStatPoolType.QuickHackUpload
					Game.GetPersistencySystem():QueueEntityEvent(Game.GetPlayer():GetEntityID(), evt)
				end
				
				if(action.name == "end_upload_program") then
					local evt = UploadProgramProgressEvent.new()
					evt.state = EUploadProgramState.COMPLETED
					evt.duration = action.duration
					evt.progressBarType = EProgressBarType.UPLOAD
					evt.progressBarContext = EProgressBarContext.QuickHack 
					
					evt.statPoolType = gamedataStatPoolType.QuickHackUpload
					Game.GetPersistencySystem():QueueEntityEvent(Game.GetPlayer():GetEntityID(), evt)
				end
				
				
				if(action.name == "set_metro_time") then
					MetroCurrentTime =  action.value
				end
				if(action.name == "trigger_metro_time") then
					activeMetroDisplay = action.value
				end
				if(action.name == "consolelog") then
					logme(1,getLang(action.value))
				end
				
				if(action.name == "log") then
					logme(getLang(action.value),action.level)
				end
				
				if(action.name == "shard_window") then
					shardUIevent = NotifyShardRead.new()
					shardUIevent.text = action.content
					shardUIevent.title = action.title
					Game.GetUISystem():QueueEvent(shardUIevent)
				end
				if(action.name == "add_time") then
					local temp = getGameTime()
					addGameTime(temp, action.value)
				end
				if(action.name == "set_time") then
					setGameTime(action.hour,action.minute)
				end
				if(action.name == "add_stat") then
					Game.GetStatPoolsSystem():RequestChangingStatPoolValue(Game.GetPlayer():GetEntityID(), action.value, action_score, Game.GetPlayer(), true, false)
				end
				if(action.name == "add_stat_perc") then
					Game.GetStatPoolsSystem():RequestChangingStatPoolValue(Game.GetPlayer():GetEntityID(), action.value, action.score, Game.GetPlayer(), true, true)
				end
				if(action.name == "mod_stat") then
					--			https://nativedb.red4ext.com/gamedataStatType
					Game.ModStatPlayer(action.value, action.score)
				end
				if(action.name == "mod_statpool") then
					--https://nativedb.red4ext.com/gamedataStatPoolType
					Game.GetStatPoolsSystem():RequestSettingStatPoolValue(Game.GetPlayer():GetEntityID(), Enum.new('gamedataStatPoolType', action.value), action.score, Game.GetPlayer(), action.perc);
				end
				if(action.name == "mod_statpool_max") then
					--https://nativedb.red4ext.com/gamedataStatPoolType
					Game.GetStatPoolsSystem():RequestSettingStatPoolMaxValue(Game.GetPlayer():GetEntityID(), Enum.new('gamedataStatPoolType', action.value), Game.GetPlayer());
				end
				
				if(action.name == "set_attribute") then
					Game.SetAtt(action.value, action.score)
				end
				
				if(action.name == "give_skill_point") then
					Game.GiveDevPoints("Attribute", action.score) 
				end
				
				if(action.name == "give_perk_point") then
					Game.GiveDevPoints("Primary", action.score) 
				end
				
				if(action.name == "toggle_infinite_stamina") then
					InfiniteStamina(action.value) 
				end
				
				if(action.name == "set_level") then
					Game.SetLevel("Level", action.score)
					
				end
				
				
				
				if(action.name == "wanted_level") then
					local preventionSystem = Game.GetScriptableSystemsContainer():Get("PreventionSystem")
					preventionSystem:SetHeatStage(action.value)
					preventionSystem:OnHeatChanged()
					if(action.value == 0) then
						
						
						if preventionSystem:IsChasingPlayer() then
							
							
							preventionSystem.systemDisabled = false
							preventionSystem:WhipeBlinkData()
							preventionSystem:ChangeAgentsAttitude(EAIAttitude.AIA_Neutral)
							preventionSystem:WakeUpAllAgents(false)
							preventionSystem:WhipeHitNPC()
							preventionSystem:DespawnAllPolice()
							preventionSystem:RemovePlayerFromSecuritySystemBlacklist()
							preventionSystem:CancelAllDelayedEvents()
							preventionSystem.isHidingFromPolice = false
							preventionSystem.generalPercent = 0
							
							for _, veh in ipairs(preventionSystem.vehicles) do
								if preventionSystem:IsVehicleValid(veh) then
									Game.GetPreventionSpawnSystem():JoinTraffic(veh)
								end
							end
							
							local playergroup = Game.GetPlayer():GetAttitudeAgent():GetAttitudeGroup()
							Game.GetAttitudeSystem():SetAttitudeGroupRelationPersistent("police", playergroup, EAIAttitude.AIA_Neutral)
						end
					end
				end
				if(action.name == "change_zone") then
					if(action.value == "safe") then
						
						RemoveEffectPlayer("GameplayRestriction.NoCombat")
						
						ChangeZoneIndicatorSafe()
						
					end
					if(action.value == "neutral") then
						Game.ChangeZoneIndicatorPublic()
						RemoveEffectPlayer("GameplayRestriction.NoCombat")
					end
					if(action.value == "hostile") then
						Game.ChangeZoneIndicatorDanger()
						RemoveEffectPlayer("GameplayRestriction.NoCombat")
					end
				end
				if(action.name == "recording_mode") then
					if(action.value == "true") then
						Game.t1()
						recordingMode = true
					end
					if(action.value == "false") then
						Game.t2()
						recordingMode = false
					end
				end
				if(action.name == "fade_in") then
					local temp = os.time(os.date("!*t"))+0 
					local nexttemp = temp
					nexttemp =nexttemp +  action.value
					fademessage = getLang(action.message)
					action.tick = nexttemp
					result = false
				end
				if(action.name == "fade_out") then
					local temp = os.time(os.date("!*t"))+0 
					local nexttemp = temp
					nexttemp =nexttemp +  action.value
					action.tick = nexttemp
					result = false
				end	
				if(action.name == "set_timer") then
					if(currentTimer == nil) then
						local temp = os.time(os.date("!*t"))+0 
						local nexttemp = temp
						nexttemp =nexttemp +  action.value
						currentTimer = {}
						currentTimer.time = nexttemp
						currentTimer.value = (action.value) 
						currentTimer.message = action.message
						currentTimer.type = action.type
						ticktimer = 0
						else
						Game.GetPlayer():SetWarningMessage(getLang("see_timer_already"))
					end
				end
				
				
				
				
				
				if(action.name == "reset_timer") then
					currentTimer = nil
					
					ticktimer = 0
				end
				
				
				if(action.name == "open_stash") then
					local stash = getMainStash()
					if stash then
						local openEvent = NewObject('handle:OpenStash')
						openEvent:SetProperties()
						stash:OnOpenStash(openEvent)
					end
				end
				if(action.name == "open_door") then	
					if IsAFakeDoor(objLook) then
						objLook:Dispose()
						else
						local handlePS = objLook:GetDevicePS()
						if handlePS:IsLocked() then handlePS:ToggleLockOnDoor() end
						if handlePS:IsSealed() then handlePS:ToggleSealOnDoor() end
						if handlePS:IsSealed() then handlePS:ToggleSealOnDoor() end
						objLook:OpenDoor()
					end
				end
				if(action.name == "set_mappin") then
					
					if(action.position ~= "on_entity" and action.position ~= "on_group")then
						local position = getPositionFromParameter(action)
						if(position.x ~= nil)then
							registerMappin(position.x,position.y,position.z,action.tag,action.typemap,action.wall,action.active,action.mapgroup,nil,action.title,action.desc,action.color,action.icon)
							else
							error("can't make an mappin to this position")
						end
						else
						if(action.position == "on_entity")then
							if(action.position_tag ~= nil)then
								local obj = getEntityFromManager(action.position_tag)
								local enti = Game.GetPlayer()
								if(action.position_tag ~= "player") then 
									enti = Game.FindEntityByID(obj.id)
								end
								if(enti ~= nil) then
									registerMappintoEntity(enti,action.tag,action.typemap,action.wall,action.active,action.mapgroup,nil,action.title,action.desc,action.color,action.icon)
									else
									error("can't make an mappin to this entity")
								end
								else
								error("can't make an mappin to this entity")
							end
						end
						if(action.position == "on_group")then
							local group =getGroupfromManager(action.position_tag)
							if group ~= nil then
								for i=1, #group.entities do 
									local entityTag = group.entities[i]
									local obj = getEntityFromManager(entityTag)
									local enti = Game.FindEntityByID(obj.id)
									if(enti ~= nil) then
										local mapTag = action.position_tag.."_"..i
										registerMappintoEntity(enti,mapTag,action.typemap,action.wall,action.active,action.mapgroup,action.title,action.desc,action.color,action.icon)
										else
										error("can't make an mappin to this entity")
									end
								end
								else
								error("can't make an mappin to this group")
							end
						end
					end
				end
				
				
				
				
				if(action.name == "edit_mappin") then
					
					if(action.position ~= "on_entity" and action.position ~= "on_group")then
						local position = getPositionFromParameter(action)
						if(position.x ~= nil)then
							editMappin(position.x,position.y,position.z,action.tag,action.typemap,action.active,action.mapgroup,nil,action.title,action.desc,action.color,action.icon)
							else
							error("can't make an mappin to this position")
						end
						else
						if(action.position == "on_entity")then
							if(action.position_tag ~= nil)then
								local obj = getEntityFromManager(action.position_tag)
								local enti = Game.GetPlayer()
								if(action.position_tag ~= "player") then 
									enti = Game.FindEntityByID(obj.id)
								end
								if(enti ~= nil) then
									editMappin(enti,action.tag,action.typemap,action.wall,action.active,action.mapgroup,nil,action.title,action.desc,action.color,action.icon)
									setMappinTrackingByTag(tag,enti)
									else
									error("can't make an mappin to this entity")
								end
								else
								error("can't make an mappin to this entity")
							end
						end
						if(action.position == "on_group")then
							local group =getGroupfromManager(action.position_tag)
							if group ~= nil then
								for i=1, #group.entities do 
									local entityTag = group.entities[i]
									local obj = getEntityFromManager(entityTag)
									local enti = Game.FindEntityByID(obj.id)
									if(enti ~= nil) then
										local mapTag = action.position_tag.."_"..i
										
										editMappin(enti,action.mapTag,action.typemap,action.wall,action.active,action.mapgroup,nil,action.title,action.desc,action.color,action.icon)
										setMappinTrackingByTag(mapTag,enti)
										else
										error("can't make an mappin to this entity")
									end
								end
								else
								error("can't make an mappin to this group")
							end
						end
					end
				end
				
				
				
				
				
				
				
				if(action.name == "delete_map_point" or action.name == "delete_mappin") then
					deleteMappinByTag(action.tag)
				end
				if(action.name == "delete_map_group" or action.name == "delete_mappin_group") then
					local maplist = getMappinByGroup(action.mapgroup)
					if(#maplist > 0) then
						for i = 1,#maplist do 
							deleteMappinByTag(maplist[i].tag)
						end
					end
				end
				if(action.name == "active_map_point" or action.name == "active_mappin") then
					activeMappinByTag(action.tag,action.active)
				end
				if(action.name == "active_map_group" or action.name == "active_mappin_group") then
					local maplist = getMappinByGroup(action.mapgroup)
					if(#maplist > 0) then
						for i = 1,#maplist do 
							activeMappinByTag(maplist[i].tag,action.active)
						end
					end
				end
				if(action.name == "track_mappin") then
					if GameController["WorldMapMenuGameController"] ~= nil then
						
						
						local mappin = getMappinByTag(action.tag)
						if(mappin and mappin.controller ~= nil)then
							
							local startHub = StartHubMenuEvent.new()
							
							local userData = MapMenuUserData.new()
							userData.moveTo = Vector3.new(mappin.position.x, mappin.position.y, mappin.position.z)					
							startHub:SetStartMenu("world_map",nil,userData)
							Game.GetUISystem():QueueEvent(startHub)
							
							Cron.After(0.2, function()
								
								GameController["WorldMapMenuGameController"]:TrackMappin(mappin.controller)
								local closeHub = ForceCloseHubMenuEvent.new()
								Game.GetUISystem():QueueEvent(closeHub)							
								
							end)
						end
					end
					
					
				end
				if(action.name == "untrack_mappin") then
					if GameController["WorldMapMenuGameController"] ~= nil and GameController["WorldMapMenuGameController"]:IsA("gameuiWorldMapMenuGameController") then
						local mappin = getMappinByTag(action.tag)
						if(mappin and mappin.controller ~= nil)then
							GameController["WorldMapMenuGameController"]:UntrackMappin()
						end
						
						
					end
				end
				
				if(action.name == "set_map_point_position" or action.name == "set_mappin_position") then
					setMappinPositionByTag(action.tag,action.x,action.y,action.z)
				end
				if(action.name == "set_map_group_position" or action.name == "set_mappin_group_position") then
					local maplist = getMappinByGroup(action.mapgroup)
					if(#maplist > 0) then
						for i = 1,#maplist do 
							setMappinPositionByTag(maplist[i].tag,action.x,action.y,action.z)
						end
					end
				end
				if(action.name == "set_map_point_type" or action.name == "set_mappin_type") then
					setMappinTypeByTag(action.tag,action.typemap)
				end
				if(action.name == "set_map_group_type" or action.name == "set_mappin_group_type") then
					local maplist = getMappinByGroup(action.mapgroup)
					if(#maplist > 0) then
						for i = 1,#maplist do 
							setMappinTypeByTag(maplist[i].tag,action.typemap)
						end
					end
				end
				if(action.name == "set_map_point_tracking_to" or action.name == "set_mappin_tracking_to") then
					setMappinTrackingByTag(action.tag,action.target)
				end
				if(action.name == "set_map_group_tracking_to" or action.name == "set_mappin_group_tracking_to") then
					local maplist = getMappinByGroup(action.mapgroup)
					if(#maplist > 0) then
						for i = 1,#maplist do 
							setMappinTrackingByTag(maplist[i].tag,action.target)
						end
					end
				end
				
				if(action.name == "loot_item") then
					
					local obj = getEntityFromManager(action.target)
					local enti = Game.FindEntityByID(obj.id)
					
					if(action.target == "lookat" )then
						enti = objLook
						
					end
					
					if(enti ~= nil) then
						
						if(#action.value > 1) then
							local instructions = {}
							
							
							for i,value in ipairs(action.value) do 
								
								local ts = Game.GetTransactionSystem()
								local tid = TweakDBID.new(value)
								local itemid = ItemID.new(tid)
								local result = ts:GiveItem(enti, itemid, 1)
								
								
								table.insert(instructions, DropInstruction.Create(itemid, 1))
								
								
								-- if (RPGManager.GetItemCategory(itemid) ~= gamedataItemCategory.Part and RPGManager.GetItemCategory(itemid) ~= gamedataItemCategory.Weapon) then
								
								-- else
								-- --print(RPGManager.GetItemCategory(itemid))
								-- Game.GetLootManager():SpawnItemDrop(enti,itemid,Vector4.new(action.x,action.y,action.z+1,1))
								-- end
								
								
								
								
								
								
								
							end
							
							Game.GetLootManager():SpawnItemDropOfManyItems(enti, instructions, "playerDropBag",Vector4.new(action.x,action.y,action.z+1,1))
							
							else
							
							
							local ts = Game.GetTransactionSystem()
							local tid = TweakDBID.new(action.value[1])
							local itemid = ItemID.new(tid)
							local result = ts:GiveItem(enti, itemid, 1)
							
							
							
							
							local instructions = {}
							
							
							if (RPGManager.GetItemCategory(itemid) ~= gamedataItemCategory.Part or RPGManager.GetItemCategory(itemid) ~= gamedataItemCategory.Weapon   ) then
								table.insert(instructions, DropInstruction.Create(itemid, 1))
								--print("test"..action.x)
								--print("test"..action.y)
								--print("test"..action.z)
								Game.GetLootManager():SpawnItemDropOfManyItems(Game.GetPlayerSystem():GetLocalPlayerControlledGameObject(), instructions, "playerDropBag",Vector4.new(action.x,action.y,action.z,1))
								else
								Game.GetLootManager():SpawnItemDrop(enti,itemid,Vector4.new(action.x,action.y,action.z+1,1))
							end
							
							
							
						end
					end
				end
				
				if(action.name == "save_lock") then
					if(action.value == true)then
						local request = SaveLockRequest.new()
						request.operation = EItemOperationType.ADD
						request.reason = 'FastTravel'
						GameInstance.QueueScriptableSystemRequest('SaveLocksManager', request)
						else
						
						local request = SaveLockRequest.new()
						request.operation = EItemOperationType.REMOVE
						request.reason = 'FastTravel'
						GameInstance.QueueScriptableSystemRequest('SaveLocksManager', request)
						
					end
				end
				
				if(action.name == "safe_execution") then
					local status, result = pcall(executeAction(action.action,tag,parent,index,source,executortag))
					
					
					
					if status == false then
						
						if(action.output == true) then 
							
							logme(1,action.name)
							logme(1,dump(action))
							logme(1,tostring(result))
						end
						
						logme(1,getLang("Action execution error") .. result.." Action : "..tostring(JSON:encode_pretty(action)))
						
						--Game.GetPlayer():SetWarningMessage("CyberScript Trigger error, check the log for more detail")
						runActionList(action.failactions, tag, source,false,executortag)
						
					end
					
				end
				
				if(action.name == "change_weather") then
					Game.GetWeatherSystem():SetWeather(action.value, action.blendtime, action.priority);
				end
				
				if(action.name == "reset_weather") then
					Game.GetWeatherSystem():ResetWeather(action.value);;
				end
				
				
				
			end
			
			if relationregion then
				if(action.name == "dialog") then
					--logme(3,"is logme(10,source)
					local usedial =  SetNextDialog(action.dialog,source,executortag)
					-- logme(3,source)
					-- logme(3,executortag)
					-- logme(3,usedial.desc)
					createDialog(usedial)	
					-- logme(3,source)
					-- if(source == "quest") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openQuestDialogWindow = false
					-- currentQuestdialog = dioal
					-- openQuestDialogWindow = true
					-- end
					-- if(source == "interact") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openEventDialogWindow = false
					-- currentEventDialog = dioal
					-- openEventDialogWindow = true
					-- end
					-- if(source == "phone") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openPhoneDialogWindow = false
					-- currentPhoneDialog = dioal
					-- openPhoneDialogWindow = true
					-- --SetDialogPhoneUI(dioal)
					-- ------logme(3,"dialog phone enabled")
					-- end
					-- if(source == "speak") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openSpeakDialogWindow = false
					-- currentSpeakDialog = dioal
					-- openSpeakDialogWindow = true
					-- end
				end
				if(action.name == "clean_dialog") then
					interactionUI.hideHub()
					currentDialogHub = nil
					print(dump((currentDialogHub)))
				end
				
				if(action.name == "inject_dialog") then
					--logme(3,"is logme(10,source)
					local usedial =  SetNextDialog(action.dialog,source,executortag)
					if(interactionUI.injectdialog == nil) then interactionUI.injectdialog = {} end
					table.insert(interactionUI.injectdialog,usedial)
					
					
					-- logme(3,source)
					-- logme(3,executortag)
					-- logme(3,usedial.desc)
					
					-- logme(3,source)
					-- if(source == "quest") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openQuestDialogWindow = false
					-- currentQuestdialog = dioal
					-- openQuestDialogWindow = true
					-- end
					-- if(source == "interact") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openEventDialogWindow = false
					-- currentEventDialog = dioal
					-- openEventDialogWindow = true
					-- end
					-- if(source == "phone") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openPhoneDialogWindow = false
					-- currentPhoneDialog = dioal
					-- openPhoneDialogWindow = true
					-- --SetDialogPhoneUI(dioal)
					-- ------logme(3,"dialog phone enabled")
					-- end
					-- if(source == "speak") then
					-- local dioal = SetNextDialog(action.value,source)
					-- if dioal.havequitoption == nil then dioal.havequitoption = true end
					-- logme(3,dioal.desc)
					-- openSpeakDialogWindow = false
					-- currentSpeakDialog = dioal
					-- openSpeakDialogWindow = true
					-- end
				end
				
				
				
				if(action.name == "speak_npc")then
					
					
					
					if(action.speaker == "current_phone_npc") then
						
						if(currentNPC ~= nil) then
							
							loadBasicDialog(currentNPC,action.way)
							
							else
							
							error("No Current NPC at Phone exist")
						end
						
						
						elseif(action.speaker == "current_star") then
						
						if(currentStar ~= nil) then
							
							loadBasicDialog(currentStar,action.way)
							else
							
							error("No Current Star exist")
						end
						
						
						else
						local phoned = findPhonedNPCByName(action.speaker)
						if(phoned ~= nil) then
							
							loadBasicDialog(phoned,action.way)
							else
							
							error("No NPC exist")
						end
					end
					
				end
				
				
				
				
				if(action.name == "speak_to_current_star")then
					
					
					if currentStar ~= nil then
						--if string.match(currentStar.Names,targName) then
						
						
						
						
						
						loadBasicDialog(currentStar,"speak")
						
						
						
						
						else
						error("Current Star is not defined")
						
					end
				end
				if(action.name == "incoming_call") then
					
					
					
					if(GameController["NewHudPhoneGameController"] ~= nil) then
						StatusEffectHelper.ApplyStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
						GameController["NewHudPhoneGameController"].incomingCallElement.request = GameController["NewHudPhoneGameController"]:AsyncSpawnFromLocal(inkWidgetRef.Get(GameController["NewHudPhoneGameController"].incomingCallElement.slot), GameController["NewHudPhoneGameController"].incomingCallElement.libraryID, GameController["NewHudPhoneGameController"], "OnIncommingCallSpawned");
						
						GameController["NewHudPhoneGameController"]:HandleCall()
						local audioEvent = SoundPlayEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						GameController["NewHudPhoneGameController"]:SetPhoneFunction(EHudPhoneFunction.IncomingCall);
						Cron.After(0.2, function()
							
							local controller = GameController["NewHudPhoneGameController"].incomingCallElement.widget:GetController()
							
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.HolocallHolder:SetVisible(true);
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.SignalRangeIcon:SetVisible(false);
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.WaveformPlaceholder:SetVisible(false);
							
							
							controller.contactNameWidget:SetText(action.caller)
							InkImageUtils.RequestSetImage(controller, controller.avatar, "PhoneAvatars."..action.image)
							
							inkWidgetRef.SetVisible(controller.buttonHint, action.isrejectable);
							currentPhoneCall = action
						end)
						else
						error("can't find IncomingCallGameController controller, please call an npc for load one or reload an save")
					end
				end
				
				if(action.name == "outcoming_call") then
					
					
					if(GameController["NewHudPhoneGameController"] ~= nil) then
						StatusEffectHelper.ApplyStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
						
						GameController["NewHudPhoneGameController"]:HandleCall()
						local audioEvent = SoundPlayEvent.new()
						audioEvent.soundName = "ui_phone_initiation_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						GameController["NewHudPhoneGameController"]:SetPhoneFunction(EHudPhoneFunction.Holocall);
						Cron.After(0.2, function()
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.HolocallHolder:SetVisible(true);
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.SignalRangeIcon:SetVisible(false);
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.WaveformPlaceholder:SetVisible(false);
							
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController:Show() 
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController:ShowIncomingContact("cyberscript", "cyberscript")
							GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.ContactName.widget:SetText(getLang(action.caller))
							InkImageUtils.RequestSetImage(GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController, GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.ContactAvatar, "PhoneAvatars."..action.image)
							
						end)
						else
						error("can't find IncomingCallGameController controller, please call an npc for load one or reload an save")
					end
				end
				
				if(action.name == "show_phone_avatar") then
					if(GameController["NewHudPhoneGameController"] ~= nil ) then
						
						if(GameController["NewHudPhoneGameController"].incomingCallElement.widget ~=nil) then
							local controller = GameController["NewHudPhoneGameController"].incomingCallElement.widget:GetController()
							
							GameController["NewHudPhoneGameController"]:DeactivatePhoneElement(gameuiActivePhoneElement.IncomingCall);
							inkCompoundRef.RemoveChild(GameController["NewHudPhoneGameController"].incomingCallElement.slot, GameController["NewHudPhoneGameController"].incomingCallElement.widget);
							GameController["NewHudPhoneGameController"].incomingCallElement.widget = nil;
						end
						local audioEvent = SoundStopEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						local audioEvent = SoundStopEvent.new()
						audioEvent.soundName = "ui_phone_initiation_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						local audioEvent = SoundPlayEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call_positive"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController:Show() 
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController:ShowIncomingContact("cyberscript", "cyberscript")
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.ContactName.widget:SetText(getLang(action.caller))
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController:SetStatusText(getLang(action.desc));
						
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.HolocallHolder:SetVisible(true);
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.SignalRangeIcon:SetVisible(false);
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.WaveformPlaceholder:SetVisible(false);
						InkImageUtils.RequestSetImage(GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController, GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.ContactAvatar, "PhoneAvatars."..action.image)
						
						
					end
					
					
					
				end
				if(action.name == "show_call_avatar") then
					if(GameController["NewHudPhoneGameController"] ~= nil ) then
						StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
						if(GameController["NewHudPhoneGameController"].incomingCallElement.widget ~=nil) then
							local controller = GameController["NewHudPhoneGameController"].incomingCallElement.widget:GetController()
							
							GameController["NewHudPhoneGameController"]:DeactivatePhoneElement(gameuiActivePhoneElement.IncomingCall);
							inkCompoundRef.RemoveChild(GameController["NewHudPhoneGameController"].incomingCallElement.slot, GameController["NewHudPhoneGameController"].incomingCallElement.widget);
							GameController["NewHudPhoneGameController"].incomingCallElement.widget = nil;
						end
						local audioEvent = SoundStopEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						local audioEvent = SoundStopEvent.new()
						audioEvent.soundName = "ui_phone_initiation_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						local audioEvent = SoundPlayEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call_positive"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController:Show() 
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController:ShowIncomingContact("cyberscript", "cyberscript")
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.ContactName.widget:SetText(getLang(action.caller))
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController:SetStatusText(getLang(action.desc));
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.HolocallHolder:SetVisible(false);
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.SignalRangeIcon:SetVisible(true);
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.WaveformPlaceholder:SetVisible(true);
						InkImageUtils.RequestSetImage(GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController, GameController["NewHudPhoneGameController"].holoAudioCallLogicController.AvatarController.ContactAvatar, "PhoneAvatars."..action.image)
						
						
					end
					
					
					
				end
				if(action.name == "hide_phone_avatar") then
					if(GameController["NewHudPhoneGameController"] ~= nil) then
						StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
						local audioEvent = SoundStopEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						local audioEvent = SoundPlayEvent.new()
						audioEvent.soundName = "ui_phone_initiation_call_negative"
						Game.GetPlayer():QueueEvent(audioEvent)
						if(GameController["NewHudPhoneGameController"].incomingCallElement.widget ~=nil) then
							local controller = GameController["NewHudPhoneGameController"].incomingCallElement.widget:GetController()
							
							GameController["NewHudPhoneGameController"]:DeactivatePhoneElement(gameuiActivePhoneElement.IncomingCall);
							inkCompoundRef.RemoveChild(GameController["NewHudPhoneGameController"].incomingCallElement.slot, GameController["NewHudPhoneGameController"].incomingCallElement.widget);
							GameController["NewHudPhoneGameController"].incomingCallElement.widget = nil
						end
						--GameController["NewHudPhoneGameController"].holoAudioCallLogicController:Show() 
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController:ShowIncomingContact("cyberscript", "cyberscript");
						GameController["NewHudPhoneGameController"].holoAudioCallLogicController:ShowEndCallContact("cyberscript", "cyberscript")
						
					end
					
					
					
				end
				
				if(action.name == "take_call") then
					if currentPhoneCall ~= nil   then 
						
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
				
				if(action.name == "refuse_call") then
					if currentPhoneCall ~= nil   then 
						
						StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.NoCombat")
						phoneAction = true 
						local audioEvent = SoundStopEvent.new()
						audioEvent.soundName = "ui_phone_incoming_call"
						Game.GetPlayer():QueueEvent(audioEvent)
						
						runActionList(currentPhoneCall.rejected_action,"phone_call","interact",false,"player")
						incomingCallGameController:OnInitialize()
						currentPhoneCall = nil
					end
					
					
				end
				
				if(action.name == "subtitle") then 
					if(GameController["SubtitlesGameController"] ~= nil) then
						--logme(3,"ye")
						local linesToShow = {}
						--GameController["SubtitlesGameController"]:Cleanup()
						local dialogLine = scnDialogLineData.new()
						local id = math.random(1,9999)
						dialogLine.id = CRUID(id)
						dialogLine.text  = getLang(action.title)
						dialogLine.type  = action.type
						dialogLine.speaker = Game.GetPlayer()
						dialogLine.speakerName  = getLang(action.speaker)
						local candotext = true
						if(action.speaker == "current_phone_npc") then
							if(currentNPC ~= nil) then
								dialogLine.speakerName  = currentNPC.Names
								else
								candotext = false
							end
							elseif(action.speaker == "current_star") then
							if(currentStar ~= nil) then
								dialogLine.speakerName  = currentStar.Names
								else
								candotext = false
							end
							elseif(action.speaker == "entity") then
							local obj = getEntityFromManager(action.speakertag)
							dialogLine.speakerName = obj.name
							candotext = true
							elseif(action.speaker == "mp_player") then
							dialogLine.speakerName = myTag
							candotext = true
							elseif(action.speaker == "mp_looked_player") then
							if(multiName == "") then
								dialogLine.speakerName = "Player"
								else
								dialogLine.speakerName = multiName
							end
							candotext = true
							else
							dialogLine.speakerName = getLang(action.speaker)
							candotext = true
						end
						
						
						
						
						
						if(candotext == true) then
							dialogLine.isPersistent  = true
							dialogLine.duration  = action.duration
							local restry,msg = pcall(function()
								GameController["SubtitlesGameController"]:SpawnDialogLine(dialogLine)
							end)
							
							if(restry == false) then
								local inkSystem = Game.GetInkSystem();
								local layers = inkSystem:GetLayers();
								
								for i,layer in ipairs(layers) do
									for j,controller in ipairs(layer:GetGameControllers()) do
										if(GameController[NameToString(controller:GetClassName())] == "SubtitlesGameController") then
											GameController["SubtitlesGameController"] = controller
										end
										
									end
								end
								
								GameController["SubtitlesGameController"]:SpawnDialogLine(dialogLine)
								
							end
							
							local temp = os.time(os.date("!*t"))+0 
							local nexttemp = temp
							nexttemp =nexttemp +  action.duration
							action.tick = nexttemp
							result = false
						end
						else
						error("can't find Subtitle controller, please call an npc for load one")
					end
				end
				if(action.name == "news_subtitle") then 
					if(GameController["SubtitlesGameController"] ~= nil) then
						--logme(3,"ye")
						local linesToShow = {}
						--GameController["SubtitlesGameController"]:Cleanup()
						local dialogLine = scnDialogLineData.new()
						local id = math.random(1,9999)
						dialogLine.id = CRUID(id)
						dialogLine.text  = getLang(action.title)
						dialogLine.type  = 5
						dialogLine.speaker = Game.GetPlayer()
						dialogLine.speakerName  =  getLang(action.speaker)
						local candotext = true
						if(action.speaker == "current_phone_npc") then
							if(currentNPC ~= nil) then
								dialogLine.speakerName  = currentNPC.Names
								else
								candotext = false
							end
							elseif(action.speaker == "current_star") then
							if(currentStar ~= nil) then
								dialogLine.speakerName  = currentStar.Names
								else
								candotext = false
							end
							elseif(action.speaker == "entity") then
							local obj = getEntityFromManager(action.speakertag)
							dialogLine.speakerName = obj.name
							candotext = true
							elseif(action.speaker == "mp_player") then
							dialogLine.speakerName = myTag
							candotext = true
							elseif(action.speaker == "mp_looked_player") then
							if(multiName == "") then
								dialogLine.speakerName = "Player"
								else
								dialogLine.speakerName = multiName
							end
							candotext = true
							else
							dialogLine.speakerName =  getLang(action.speaker)
							
							if(action.usecorponews == true) then
								if(#corpoNews > 0) then
									local id = math.random(1,#corpoNews)
									dialogLine.text  = getLang(corpoNews[id])
								end
							end
							
							
							candotext = true
						end
						if(candotext == true) then
							dialogLine.isPersistent  = true
							dialogLine.duration  = action.duration
							GameController["SubtitlesGameController"]:SpawnDialogLine(dialogLine)
							local temp = os.time(os.date("!*t"))+0 
							local nexttemp = temp
							nexttemp =nexttemp +  action.duration
							action.tick = nexttemp
							result = false
						end
						else
						error("can't find Subtitle controller, please call an npc for load one")
					end
				end
				if(action.name == "random_subtitle") then 
					if(GameController["SubtitlesGameController"] ~= nil) then
						--logme(3,"ye")
						local linesToShow = {}
						--GameController["SubtitlesGameController"]:Cleanup()
						local tago = math.random(1,#action.title)
						local dialogLine = scnDialogLineData.new()
						local id = math.random(1,9999)
						dialogLine.id = CRUID(id)
						dialogLine.text  = getLang(action.title[tago])
						dialogLine.type  = action.type
						dialogLine.speaker = Game.GetPlayer()
						dialogLine.speakerName  =  getLang(action.speaker)
						local candotext = true
						if(action.speaker == "current_phone_npc") then
							if(currentNPC ~= nil) then
								dialogLine.speakerName  = currentNPC.Names
								else
								candotext = false
							end
							elseif(action.speaker == "current_star") then
							if(currentStar ~= nil) then
								dialogLine.speakerName  = currentStar.Names
								else
								candotext = false
							end
							elseif(action.speaker == "entity") then
							local obj = getEntityFromManager(action.speakertag)
							dialogLine.speakerName = obj.name
							candotext = true
							else
							dialogLine.speakerName =  getLang(action.speaker)
							candotext = true
						end
						if(candotext == true) then
							dialogLine.isPersistent  = true
							dialogLine.duration  = action.duration
							GameController["SubtitlesGameController"]:SpawnDialogLine(dialogLine)
							local temp = os.time(os.date("!*t"))+0 
							local nexttemp = temp
							nexttemp =nexttemp +  action.duration
							action.tick = nexttemp
							result = false
						end
						else
						error("can't find Subtitle controller, please call an npc for load one")
						
					end
				end
				if(action.name == "npc_chat") then 
					if(GameController["ChattersGameController"] ~= nil) then
						local linesToShow = {}
						local obj = getEntityFromManager(action.target)
						local enti = Game.FindEntityByID(obj.id)
						if(action.target == "lookat")then
							enti = objLook
						end
						if(enti ~= nil) then
							
							local dialogLine = scnDialogLineData.new()
							local id = math.random(1,9999)
							dialogLine.id = CRUID(id)
							dialogLine.text  = getLang(action.title)
							dialogLine.type  = action.type
							local candotext = true
							dialogLine.speaker = enti
							dialogLine.speakerName  =  getLang(action.speaker)
							if(action.speaker == "current_phone_npc") then
								if(currentNPC ~= nil) then
									dialogLine.speakerName  = currentNPC.Names
									else
									candotext = false
								end
							end
							if(action.speaker == "current_star") then
								if(currentStar ~= nil) then
									dialogLine.speakerName  = currentStar.Names
									else
									candotext = false
								end
							end
							if(action.speaker == "entity") then
								local obj = getEntityFromManager(action.speakertag)
								dialogLine.speakerName = obj.name
								candotext = true
							end
							if(candotext == true) then
								dialogLine.isPersistent  = true
								dialogLine.duration  = action.duration
								GameController["ChattersGameController"]:SpawnDialogLine(dialogLine)
								local temp = os.time(os.date("!*t"))+0 
								local nexttemp = temp
								nexttemp =nexttemp +  action.duration
								--logme(3,nexttemp)
								action.tick = nexttemp
								result = false
							end
						end
						else
						error("can't find chat Subtitle controller, please go to see an npc who speak in street or an TV or an Radio for load one")
						
					end
				end
				if(action.name == "random_npc_chat") then 
					if(GameController["ChattersGameController"] ~= nil) then
						local linesToShow = {}
						local tago = math.random(1,#action.title)
						local obj = getEntityFromManager(action.target)
						local enti = Game.FindEntityByID(obj.id)
						if(action.target == "lookat")then
							enti = objLook
						end
						if(enti ~= nil) then
							local dialogLine = scnDialogLineData.new()
							local id = math.random(1,9999)
							dialogLine.id = CRUID(id)
							dialogLine.text  = getLang(action.title[tago])
							dialogLine.type  = action.type
							local candotext = true
							dialogLine.speaker = enti
							dialogLine.speakerName  =  getLang(action.speaker)
							if(action.speaker == "current_phone_npc") then
								if(currentNPC ~= nil) then
									dialogLine.speakerName  = currentNPC.Names
									else
									candotext = false
								end
							end
							if(action.speaker == "current_star") then
								if(currentStar ~= nil) then
									dialogLine.speakerName  = currentStar.Names
									else
									candotext = false
								end
							end
							if(action.speaker == "entity") then
								local obj = getEntityFromManager(action.speakertag)
								dialogLine.speakerName = obj.name
								candotext = true
							end
							if(candotext == true) then
								dialogLine.isPersistent  = true
								dialogLine.duration  = action.duration
								GameController["ChattersGameController"]:SpawnDialogLine(dialogLine)
								local temp = os.time(os.date("!*t"))+0 
								local nexttemp = temp
								nexttemp =nexttemp +  action.duration
								--logme(3,nexttemp)
								action.tick = nexttemp
								result = false
							end
						end
						else
						error("can't find chat Subtitle controller, please go to see an npc who speak in street or an TV or an Radio for load one")
					end
				end
				if(action.name == "clean_subtitle") then 
					if(GameController["SubtitlesGameController"] ~= nil) then
						GameController["SubtitlesGameController"]:Cleanup()
						GameController["SubtitlesGameController"]:Cleanup()
					end
				end
				if(action.name == "clean_npc_chat") then 
					if(GameController["ChattersGameController"] ~= nil) then
						GameController["ChattersGameController"]:Cleanup()
						GameController["ChattersGameController"]:Cleanup()
					end
				end
				if(action.name == "do_random_dialog")then
					local tago = math.random(1,#action.dialog)
					--	logme(3,action.dialog[tago])
					if( tago ~= nil) then
						createDialog(SetNextDialog(action.dialog[tago],source,executortag))
					end
				end
				if(action.name == "npc_star_affinity") then
					if(currentStar ~= nil) then
						local score = getScoreKey("Affinity",currentStar.Names)
						if(score == nil) then score = 0 end
						score = score + action.value
						setScore("Affinity",currentStar.Names,score)
					end
				end
				if(action.name == "npc_affinity") then
					local score = getScoreKey("Affinity",action.value)
					if(score == nil) then score = 0 end
					score = score + action.score
					setScore("Affinity",action.value,score)
				end
				if(action.name == "entity_affinity") then
					local obj = getEntityFromManager(action.tag)
					logme(3,dump((obj)))
					local score = getScoreKey("Affinity",obj.name)
					if(score == nil) then score = 0 end
					score = score + action.score
					setScore("Affinity",obj.name,score)
				end
				if(action.name == "custom_star_message") then
					------logme(3,npcStarSpawn)
					if(npcStarSpawn) then
						customEventMessage(action.value, currentStar)
					end
				end
				if(action.name == "change_dialog_windows") then
					if(action.window == "quest" ) then
						if(string.lower(tostring(action.value)) == "true")then
							openQuestDialogWindow = true
							else
							openQuestDialogWindow = false
							currentQuestdialog = nil
						end
					end
					if(action.window == "speak" ) then
						if(string.lower(tostring(action.value)) == "true")then
							openSpeakDialogWindow = true
							else
							openSpeakDialogWindow = false
							currentSpeakDialog = nil
						end
					end
					if(action.window == "phone" ) then
						if(string.lower(tostring(action.value)) == "true")then
							openPhoneDialogWindow = true
							else
							openPhoneDialogWindow = false
							currentPhoneDialog = nil
						end
					end
					if(action.window == "event" ) then
						if(string.lower(tostring(action.value)) == "true")then
							openEventDialogWindow = true
							else
							openEventDialogWindow = false
							currentEventDialog = nil
						end
					end
				end
			end
			
			if questregion then
				if(action.name == "change_quest_content") then
					QuestManager.ChangeQuestContent(action.tag,getLang(action.value))
				end
				
				if(action.name == "change_quest_title") then
					QuestManager.ChangeQuestTitle(action.tag,getLang(action.value))
				end
				
				if(action.name == "change_objective_content" or action.name == "change_objective_text") then
					QuestManager.ChangeObjectiveContent(action.tag,getLang(action.value))
				end
				
				
				if(action.name == "mission") then
					setScore(action.value,"Score",0)
					
					QuestManager.MarkQuestAsActive(action.value)
					local objective = QuestManager.GetFirstObjectiveEntry(action.value)
					QuestManager.TrackObjective(objective.id)
					
					TriggerQuest(action.value)
					
				end
				if(action.name == "lock_mission") then
					setScore(action.value,"Score",nil)
					QuestManager.MarkQuestAsUnVisited(action.value)
				end
				if(action.name == "lock_objective") then
					QuestManager.MarkObjectiveAsUndefined(action.value)
					if(QuestManager.IsTrackedObjective(action.value)) then
						QuestManager.UntrackObjective()
					end
				end
				if(action.name == "set_objective_state") then
					QuestManager.MarkObjectiveAs(action.value,action.state)
				end
				if(action.name == "unlock_objective") then
					QuestManager.MarkObjectiveAsActive(action.value)
				end
				if(action.name == "inactive_objective") then
					QuestManager.MarkObjectiveAsInactive(action.value)
					if(QuestManager.IsTrackedObjective(action.value)) then
						QuestManager.UntrackObjective()
					end
				end
				if(action.name == "fail_objective") then
					QuestManager.MarkObjectiveAsFailed(action.value)
				end
				if(action.name == "win_objective") then
					QuestManager.MarkObjectiveAsComplete(action.value)
				end
				if(action.name == "track_objective") then
					QuestManager.TrackObjective(action.value)
				end
				if(action.name == "unlock_mission") then
					setScore(action.value,"Score",0)
				end
				if(action.name == "finish_mission") then
					if currentQuest ~= nil and currentQuest.tag == action.tag then
						canDoEndAction = true
						else
						if currentQuest ~= nil and currentQuest.tag ~= action.tag then
							result = false
						end
					end
				end
				if(action.name == "fail_mission") then
					if currentQuest ~= nil then
						canDoFailActionForce = true
					end
				end
				if(action.name == "reset_mission") then
					if getQuestByTag(action.tag) ~= nil then
						QuestManager.resetQuestfromJson(action.tag)
					end
				end
			end
			
			if noderegion then
				if(action.name == "draw_custom_3Dmappin_node") then
					local node = getNode(action.tag)
					if(action.atgameplayposition)then
						draw3DCustomMappin(node.gameplay_x,node.gameplay_y,node.gameplay_z)
						else
						draw3DCustomMappin(node.x,node.y,node.z)
					end
				end
				if(action.name == "set_entity_circuit") then
					local circuit = getCircuit(action.circuit)
					circuit.reverse = action.reverse
					local obj = getEntityFromManager(action.tag)
					obj.circuit = circuit
				end
				if(action.name == "set_entity_node_current") then
					local obj = getEntityFromManager(action.tag)
					obj.currentNode = getNode(action.data)
				end
				if(action.name == "set_entity_node_current_auto") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					local positionVec4 = enti:GetWorldPosition()
					obj.currentNode = getNodefromPosition(positionVec4.x, positionVec4.y, positionVec4.z, action.range)
				end
				if(action.name == "set_entity_node_next") then
					local obj = getEntityFromManager(action.tag)
					if(obj.circuit.reverse == false) then
						local nextNodeIndex = getNodeIndexFromCircuit(action.data,obj.circuit.datas)
						obj.nextNode = obj.circuit.datas[nextNodeIndex+1]
						else
						local inversed_circuit = reverseTable(obj.circuit.datas)
						local nextNodeIndex = getNodeIndexFromCircuit(action.data,inversed_circuit)
						obj.nextNode = inversed_circuit[nextNodeIndex+1]
					end
				end
				if(action.name == "set_entity_node_next_auto") then
					local obj = getEntityFromManager(action.tag)
					if(obj.circuit.reverse == false) then
						local nextNodeIndex = getNodeIndexFromCircuit(obj.currentNode.tag,obj.circuit.datas)
						obj.nextNode = getNode(obj.circuit.datas[nextNodeIndex+1])
						else
						local inversed_circuit = reverseTable(obj.circuit.datas)
						local nextNodeIndex = getNodeIndexFromCircuit(obj.currentNode.tag,inversed_circuit)
						obj.nextNode = getNode(inversed_circuit[nextNodeIndex+1])
					end
				end
				if(action.name == "set_entity_node_path") then
					local obj = getEntityFromManager(action.tag)
					obj.path = getPath(action.path)
					if(obj.path == nil) then
						Game.GetPlayer():SetWarningMessage(getLang("see_action_nopath"))
						else
						obj.path.reverse = obj.circuit.reverse
						if(obj.path.reverse == true) then
							obj.path.index = #obj.path.locations
							obj.path.finish = false
							else
							track.index = 1
							obj.path.finish = false
						end
					end
				end
				if(action.name == "set_entity_node_path_auto") then
					local obj = getEntityFromManager(action.tag)
					obj.path = getPathBetweenTwoNode(obj.currentNode.tag, obj.nextNode.tag)
					if(obj.path == nil) then
						Game.GetPlayer():SetWarningMessage(getLang("see_action_nopath"))
						else
						obj.path.reverse = obj.circuit.reverse
						if(obj.path.reverse == true) then
							obj.path.index = #obj.path.locations
							obj.path.finish = false
							else
							obj.path.index = 1
							obj.path.finish = false
						end
					end
				end
				if(action.name == "run_entity_path") then
					local obj = getEntityFromManager(action.tag)
					if(obj ~= nil and obj.path ~= nil) then
						local actionlist = {}
						--logme(3,#actionlist)
						--doActionofIndex(actionlist,"interact",listaction,currentindex)
						result = false
						local path = getEntityFromManager(group.entities[1]).path
						if(path.reverse == false) then
							for i=1,#path.locations do
								local trackpos = obj.path.locations[i]
								local nexttrackpos = obj.path.locations[i+1]
								if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
									logme(3,obj.path.index)
									local direction = {}
									local separate = 0
									if(action.separate ~= nil and action.separate == true) then
										separate = i-1
									end
									direction.x = nexttrackpos.x-separate
									direction.y = nexttrackpos.y-separate
									direction.z = nexttrackpos.z+action.zoffset
									direction.w = 1
									local enti = Game.FindEntityByID(obj.id)
									if(enti ~= nil) then
										local isplayer = false
										if entityTag == "player" then
											isplayer = true
										end
										local dirVector = diffVector(enti:GetWorldPosition(), direction)
										local angle = GetSingleton('Vector4'):ToRotation(dirVector)
										if(path.recordRotation == true) then
											angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
										end
										--logme(3,"yaw "..angle.yaw)
										local newaction = {}
										newaction.name = "teleport_entity_at_position"
										newaction.tag = entityTag
										newaction.x = direction.x
										newaction.y = direction.y
										newaction.z = direction.z
										newaction.angle = angle
										table.insert(actionlist,newaction)
										
										
										if(trackpos.action ~= nil and #trackpos.action > 0) then
											
											for y=1,#trackpos.action do
												
												table.insert(actionlist,trackpos.action[y])
												
											end
											
											
										end
									end
									else
									obj.path.finish = true
								end
							end
							else
							for i= #path.locations, 1,-1 do
								if(obj ~= nil) then
									local trackpos = obj.path.locations[i]
									local nexttrackpos = obj.path.locations[i+1]
									if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
										logme(3,obj.path.index)
										local direction = {}
										local separate = 0
										if(action.separate ~= nil and action.separate == true) then
											separate = i-1
										end
										direction.x = nexttrackpos.x-separate
										direction.y = nexttrackpos.y-separate
										direction.z = nexttrackpos.z+action.zoffset
										direction.w = 1
										local enti = Game.FindEntityByID(obj.id)
										if(enti ~= nil) then
											local isplayer = false
											if entityTag == "player" then
												isplayer = true
											end
											local dirVector = diffVector(enti:GetWorldPosition(), direction)
											local angle = GetSingleton('Vector4'):ToRotation(dirVector)
											if(path.recordRotation == true) then
												angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
											end
											--logme(3,"yaw "..angle.yaw)
											local newaction = {}
											newaction.name = "teleport_entity_at_position"
											newaction.tag = entityTag
											newaction.x = direction.x
											newaction.y = direction.y
											newaction.z = direction.z
											newaction.angle = angle
											table.insert(actionlist,newaction)
											
											
											if(trackpos.action ~= nil and #trackpos.action > 0) then
												
												for y=1,#trackpos.action do
													
													table.insert(actionlist,trackpos.action[y])
													
												end
												
												
											end
										end
										else
										obj.path.finish = true
									end
								end
							end
						end
						-- for i=1,#actionlist do 
						-- executeAction(actionlist[i],tag,parent,index,source)
						-- end
						runSubActionList(actionlist, tag.."_run_path", tag,source,false,executortag)
					end
				end
				
				if(action.name == "play_path") then
					local obj = getEntityFromManager(action.tag)
					if(obj ~= nil ) then
						local actionlist = {}
						--logme(3,#actionlist)
						--doActionofIndex(actionlist,"interact",listaction,currentindex)
						result = false
						local path = getPath(action.path)
						if(action.reverse == nil or action.reverse == false) then
							path.index = 1
							for i=1,#path.locations do
								local trackpos = path.locations[i]
								local nexttrackpos = path.locations[i+1]
								if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
									logme(3,path.index)
									local direction = {}
									local separate = 0
									if(action.separate ~= nil and action.separate == true) then
										separate = i-1
									end
									direction.x = nexttrackpos.x-separate
									direction.y = nexttrackpos.y-separate
									direction.z = nexttrackpos.z+action.zoffset
									direction.w = 1
									local enti = Game.FindEntityByID(obj.id)
									if(enti ~= nil) then
										local isplayer = false
										if action.tag == "player" then
											isplayer = true
										end
										local dirVector = diffVector(enti:GetWorldPosition(), direction)
										local angle = GetSingleton('Vector4'):ToRotation(dirVector)
										if(path.recordRotation == true) then
											angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
										end
										--logme(3,"yaw "..angle.yaw)
										
										local newaction = {}
										if(action.isrelative ~= nil and action.isrelative == true) then
											newaction.name = "teleport_entity_at_relative_position"
											
											else
											newaction.name = "teleport_entity_at_position"
										end
										newaction.tag = action.tag
										newaction.x = direction.x
										newaction.y = direction.y
										newaction.z = direction.z
										newaction.angle = angle
										table.insert(actionlist,newaction)
										
										if(trackpos.action ~= nil and #trackpos.action > 0) then
											
											for y=1,#trackpos.action do
												
												table.insert(actionlist,trackpos.action[y])
												
											end
											
											
										end
									end
									else
									obj.path = {} 
									obj.path.finish = true
								end
							end
							else
							path.index = #path.locations
							for i= #path.locations, 1,-1 do
								if(obj ~= nil) then
									local trackpos = path.locations[i]
									local nexttrackpos = path.locations[i+1]
									if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
										logme(3,path.index)
										local direction = {}
										local separate = 0
										if(action.separate ~= nil and action.separate == true) then
											separate = i-1
										end
										direction.x = nexttrackpos.x-separate
										direction.y = nexttrackpos.y-separate
										direction.z = nexttrackpos.z+action.zoffset
										direction.w = 1
										local enti = Game.FindEntityByID(obj.id)
										if(enti ~= nil) then
											local isplayer = false
											if action.tag == "player" then
												isplayer = true
											end
											local dirVector = diffVector(enti:GetWorldPosition(), direction)
											local angle = GetSingleton('Vector4'):ToRotation(dirVector)
											if(path.recordRotation == true) then
												angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
											end
											--logme(3,"yaw "..angle.yaw)
											local newaction = {}
											if(action.isrelative ~= nil and action.isrelative == true) then
												newaction.name = "teleport_entity_at_relative_position"
												
												else
												newaction.name = "teleport_entity_at_position"
											end
											newaction.tag = action.tag
											newaction.x = direction.x
											newaction.y = direction.y
											newaction.z = direction.z
											newaction.angle = angle
											table.insert(actionlist,newaction)
											if(trackpos.action ~= nil and #trackpos.action > 0) then
												
												for y=1,#trackpos.action do
													
													table.insert(actionlist,trackpos.action[y])
													
												end
												
												
											end
											
										end
										else
										obj.path = {} 
										obj.path.finish = true
									end
								end
							end
						end
						-- for i=1,#actionlist do 
						-- executeAction(actionlist[i],tag,parent,index,source)
						-- end
						spdlog.error(dump(actionlist))
						runSubActionList(actionlist, tag.."_run_path", tag,source,false,executortag)
					end
				end
				
				
				
				if(action.name == "clean_entity_circuit") then
					local obj = getEntityFromManager(action.tag)
					if(obj ~= nil) then
						obj.path = nil
						obj.circuit = nil
						obj.currentNode = nil
						obj.nextNode = nil
					end
				end
				if(action.name == "summon_entity_at_node") then
					local node = getNode(action.data)
					local isAV = false
					if(action.isAV ~= nil) then
						isAV = action.isAV
					end
					chara = action.npc
					if(action.atgameplayposition) then
						
					end
					if(action.group ~= nil and action.group ~= "") then
						
						table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
					end
				end
				if(action.name == "summon_entity_at_mappin") then
					local mappin = getMappinByTag(action.mappin)
					local isAV = false
					if(action.isAV ~= nil) then
						isAV = action.isAV
					end
					chara = action.npc
					if(mappin) then
						
						if(action.group ~= nil and action.group ~= "") then
							
							table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
						end
					end
				end
				if(action.name == "teleport_entity_at_node") then
					local node = getNode(action.data)
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					local isplayer = false
					if(action.tag == "player") then
						enti = Game.GetPlayer()
						isplayer = true
					end
					if(enti ~= nil) then
						--logme(3,"moveit")
						if(action.atgameplayposition) then
							teleportTo(enti, Vector4.new( node.gameplay_x+action.offset, node.gameplay_y, node.gameplay_z,1), 1,isplayer)
							else
							teleportTo(enti, Vector4.new( node.x+action.offset, node.y, node.z,1), 1,isplayer)
						end
					end
				end
				if(action.name == "teleport_entity_at_current_node") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					local isplayer = false
					if(action.tag == "player") then
						enti = Game.GetPlayer()
						isplayer = true
					end
					local position = enti:GetWorldPosition()
					local range = 70
					if(action.range ~= nil) then
						range = action.range
					end
					local node = getNodefromPosition(position.x,position.y,position.z,range)
					if node ~= nil then
						if(enti ~= nil) then
							logme(3,"tp to node "..data.name)
							if(action.atgameplayposition) then
								teleportTo(enti, Vector4.new( node.gameplay_x+action.offset, node.gameplay_y, node.gameplay_z,1), 1,isplayer)
								else
								teleportTo(enti, Vector4.new( node.x+action.offset, node.y, node.z,1), 1,isplayer)
							end
						end
					end
				end
				if(action.name == "summon_entity_at_current_node") then
					local position = Game.GetPlayer():GetWorldPosition()
					local range = 70
					if(action.range ~= nil) then
						range = action.range
					end
					local node = getNodefromPosition(position.x,position.y,position.z,range)
					if node ~= nil then
						chara = action.npc
						local isAV = false
						if(action.isAV ~= nil) then
							isAV = action.isAV
						end
						if(action.atgameplayposition) then
							
						end
						if(action.group ~= nil and action.group ~= "") then
							
							table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
						end
					end
				end
				if(action.name == "set_group_circuit") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						logme(3,entityTag)
						logme(3,action.circuit)
						local obj = getEntityFromManager(entityTag)
						local circuit = getCircuit(action.circuit)
						logme(3,dump(circuit))
						logme(3,dump(obj))
						obj.circuit =circuit
						logme(3,"set circuit.."..obj.circuit.tag)
						logme(3,"action.reverse"..tostring(action.reverse))
						obj.circuit.reverse = action.reverse
					end
				end
				if(action.name == "set_group_node_current") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getTrueEntityFromManager(entityTag)
						obj.currentNode = getNode(action.data)
						setEntityFromManager(entityTag,obj)
					end
				end
				if(action.name == "set_group_node_current_auto") then
					local group =getGroupfromManager(action.tag)
					logme(3,"test.."..#group.entities)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getTrueEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						local positionVec4 = enti:GetWorldPosition()
						obj.currentNode = getNodefromPosition(positionVec4.x, positionVec4.y, positionVec4.z, action.range)
						logme(3,"currentNode "..obj.currentNode.tag)	
						--                                          	setEntityFromManager(entityTag,obj)
					end
				end
				if(action.name == "set_group_node_next") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						if(obj.circuit.reverse == false ) then
							local nextNodeIndex = getNodeIndexFromCircuit(action.data,obj.circuit.datas)
							obj.nextNode = obj.circuit.datas[nextNodeIndex+1]
							else
							local inversed_circuit = reverseTable(obj.circuit.datas)
							local nextNodeIndex = getNodeIndexFromCircuit(action.data,inversed_circuit)
							obj.nextNode = inversed_circuit[nextNodeIndex+1]
						end
					end
				end
				if(action.name == "set_group_node_next_auto") then
					local group =getGroupfromManager(action.tag)
					logme(3,"test.."..#group.entities)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getTrueEntityFromManager(entityTag)
						logme(3,"currentNode "..obj.currentNode.tag)	
						logme(3,#obj.circuit)
						logme(3,tostring(obj.circuit.reverse))
						if(obj.circuit.reverse == false or obj.circuit.reverse == nil) then
							local nextNodeIndex = getNodeIndexFromCircuit(obj.currentNode.tag,obj.circuit.datas)
							logme(3,"nextNodeIndex "..nextNodeIndex)
							obj.nextNode = getNode(obj.circuit.datas[nextNodeIndex+1])
							logme(3,"nextNode "..obj.nextNode.tag)
							setEntityFromManager(entityTag,obj)
							else
							local inversed_circuit = reverseTable(obj.circuit.datas)
							local nextNodeIndex = getNodeIndexFromCircuit(obj.currentNode.tag,inversed_circuit)
							obj.nextNode = getNode(inversed_circuit[nextNodeIndex+1])
							--setEntityFromManager(entityTag,obj)
						end
					end
				end
				if(action.name == "set_group_node_path") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						obj.path = getPath(action.path)
						if(obj.path == nil) then
							Game.GetPlayer():SetWarningMessage(getLang("see_action_nopath"))
							else
							obj.path.reverse = obj.circuit.reverse
							if(obj.path.reverse == true) then
								obj.path.index = #obj.path.locations
								obj.path.finish = false
								else
								track.index = 1
								obj.path.finish = false
							end
						end
					end
				end
				if(action.name == "set_group_node_path_auto") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						logme(3,obj.currentNode.tag)
						logme(3,obj.nextNode.tag)
						if(obj.circuit.reverse == true) then
							obj.path = getPathBetweenTwoNode(obj.nextNode.tag, obj.currentNode.tag)
							else
							obj.path = getPathBetweenTwoNode(obj.currentNode.tag, obj.nextNode.tag)
						end
						if(obj.path == nil) then
							Game.GetPlayer():SetWarningMessage(getLang("see_action_nopath"))
							else
							obj.path.reverse = obj.circuit.reverse
							if(obj.path.reverse == true) then
								obj.path.index = #obj.path.locations
								obj.path.finish = false
								else
								obj.path.index = 1
								obj.path.finish = false
							end
						end
					end
				end
				
				if(action.name == "run_group_path_cached" or action.name == "run_group_path") then
					local group =getGroupfromManager(action.tag)
					local actionlist = {}
					--logme(3,#actionlist)
					--doActionofIndex(actionlist,"interact",listaction,currentindex)
					result = false
					local path = getEntityFromManager(group.entities[1]).path
					if(path.reverse == false) then
						for i=1,#path.locations do
							for y=1, #group.entities do 
								local entityTag = group.entities[y]
								local obj = getEntityFromManager(entityTag)
								if(obj ~= nil) then
									local trackpos = obj.path.locations[i]
									local nexttrackpos = obj.path.locations[i+1]
									if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
										logme(3,obj.path.index)
										local direction = {}
										local separate = 0
										if(action.separate ~= nil and action.separate == true) then
											separate = i-1
										end
										direction.x = nexttrackpos.x-separate
										direction.y = nexttrackpos.y-separate
										direction.z = nexttrackpos.z+action.zoffset
										direction.w = 1
										local enti = Game.FindEntityByID(obj.id)
										if(enti ~= nil) then
											local isplayer = false
											if entityTag == "player" then
												isplayer = true
											end
											local dirVector = diffVector(enti:GetWorldPosition(), direction)
											local angle = GetSingleton('Vector4'):ToRotation(dirVector)
											if(path.recordRotation == true) then
												angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
											end
											--logme(3,"yaw "..angle.yaw)
											local newaction = {}
											if(action.isrelative ~= nil and action.isrelative == true) then
												newaction.name = "teleport_entity_at_relative_position"
												
												else
												newaction.name = "teleport_entity_at_position"
											end
											newaction.tag = entityTag
											newaction.x = direction.x
											newaction.y = direction.y
											newaction.z = direction.z
											newaction.angle = angle
											table.insert(actionlist,newaction)
											
											if(trackpos.action ~= nil and #trackpos.action > 0) then
												
												for y=1,#trackpos.action do
													
													table.insert(actionlist,trackpos.action[y])
													
												end
												
												
											end
										end
										else
										obj.path.finish = true
									end
								end
							end
						end
						else
						for i= #path.locations, 1,-1 do
							for y=1, #group.entities do 
								local entityTag = group.entities[y]
								local obj = getEntityFromManager(entityTag)
								if(obj ~= nil) then
									local trackpos = obj.path.locations[i]
									local nexttrackpos = obj.path.locations[i+1]
									if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
										logme(3,obj.path.index)
										local direction = {}
										local separate = 0
										if(action.separate ~= nil and action.separate == true) then
											separate = i-1
										end
										direction.x = nexttrackpos.x-separate
										direction.y = nexttrackpos.y-separate
										direction.z = nexttrackpos.z+action.zoffset
										direction.w = 1
										local enti = Game.FindEntityByID(obj.id)
										if(enti ~= nil) then
											local isplayer = false
											if entityTag == "player" then
												isplayer = true
											end
											local dirVector = diffVector(enti:GetWorldPosition(), direction)
											local angle = GetSingleton('Vector4'):ToRotation(dirVector)
											if(path.recordRotation == true) then
												angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
											end
											--logme(3,"yaw "..angle.yaw)
											local newaction = {}
											if(action.isrelative ~= nil and action.isrelative == true) then
												newaction.name = "teleport_entity_at_relative_position"
												
												else
												newaction.name = "teleport_entity_at_position"
											end
											newaction.tag = entityTag
											newaction.x = direction.x
											newaction.y = direction.y
											newaction.z = direction.z
											newaction.angle = angle
											table.insert(actionlist,newaction)
											
											if(trackpos.action ~= nil and #trackpos.action > 0) then
												
												for y=1,#trackpos.action do
													
													table.insert(actionlist,trackpos.action[y])
													
												end
												
												
											end
										end
										else
										obj.path.finish = true
									end
								end
							end
						end
					end
					-- for i=1,#actionlist do 
					-- executeAction(actionlist[i],tag,parent,index,source)
					-- end
					runSubActionList(actionlist, tag.."_run_path", tag,source,false,executortag)
				end
				
				-- end
				if(action.name == "play_group_path_cached" or action.name == "play_group_path") then
					local group =getGroupfromManager(action.tag)
					local actionlist = {}
					--logme(3,#actionlist)
					--doActionofIndex(actionlist,"interact",listaction,currentindex)
					result = false
					local path =  getPath(action.path)
					if(path.reverse == false) then
						for i=1,#path.locations do
							for y=1, #group.entities do 
								local entityTag = group.entities[y]
								local obj = getEntityFromManager(entityTag)
								if(obj ~= nil) then
									local trackpos = path.locations[i]
									local nexttrackpos = path.locations[i+1]
									if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
										logme(3,path.index)
										local direction = {}
										local separate = 0
										if(action.separate ~= nil and action.separate == true) then
											separate = i-1
										end
										direction.x = nexttrackpos.x-separate
										direction.y = nexttrackpos.y-separate
										direction.z = nexttrackpos.z+action.zoffset
										direction.w = 1
										local enti = Game.FindEntityByID(obj.id)
										if(enti ~= nil) then
											local isplayer = false
											if entityTag == "player" then
												isplayer = true
											end
											local dirVector = diffVector(enti:GetWorldPosition(), direction)
											local angle = GetSingleton('Vector4'):ToRotation(dirVector)
											if(path.recordRotation == true) then
												angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
											end
											--logme(3,"yaw "..angle.yaw)
											local newaction = {}
											
											if(action.isrelative ~= nil and action.isrelative == true) then
												newaction.name = "teleport_entity_at_relative_position"
												
												else
												newaction.name = "teleport_entity_at_position"
											end
											newaction.tag = entityTag
											newaction.x = direction.x
											newaction.y = direction.y
											newaction.z = direction.z
											newaction.angle = angle
											table.insert(actionlist,newaction)
										end
										else
										obj.path = {} 
										obj.path.finish = true
									end
								end
							end
						end
						else
						for i= #path.locations, 1,-1 do
							for y=1, #group.entities do 
								local entityTag = group.entities[y]
								local obj = getEntityFromManager(entityTag)
								if(obj ~= nil) then
									local trackpos = path.locations[i]
									local nexttrackpos = path.locations[i+1]
									if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
										logme(3,path.index)
										local direction = {}
										local separate = 0
										if(action.separate ~= nil and action.separate == true) then
											separate = i-1
										end
										direction.x = nexttrackpos.x-separate
										direction.y = nexttrackpos.y-separate
										direction.z = nexttrackpos.z+action.zoffset
										direction.w = 1
										local enti = Game.FindEntityByID(obj.id)
										if(enti ~= nil) then
											local isplayer = false
											if entityTag == "player" then
												isplayer = true
											end
											local dirVector = diffVector(enti:GetWorldPosition(), direction)
											local angle = GetSingleton('Vector4'):ToRotation(dirVector)
											if(path.recordRotation == true) then
												angle = EulerAngles.new(trackpos.roll, trackpos.pitch,  nexttrackpos.yaw)
											end
											--logme(3,"yaw "..angle.yaw)
											local newaction = {}
											
											if(action.isrelative ~= nil and action.isrelative == true) then
												newaction.name = "teleport_entity_at_relative_position"
												
												else
												newaction.name = "teleport_entity_at_position"
											end
											newaction.tag = entityTag
											newaction.x = direction.x
											newaction.y = direction.y
											newaction.z = direction.z
											newaction.angle = angle
											table.insert(actionlist,newaction)
										end
										
										else
										obj.path = {} 
										obj.path.finish = true
										
									end
								end
							end
						end
					end
					-- for i=1,#actionlist do 
					-- executeAction(actionlist[i],tag,parent,index,source)
					-- end
					runSubActionList(actionlist, tag.."_run_path", tag,source,false,executortag)
				end
				
				
				
				if(action.name == "clean_group_circuit") then
					local group =getGroupfromManager(action.tag)
					if group ~= nil then
						for i=1, #group.entities do 
							local entityTag = group.entities[i]
							local obj = getEntityFromManager(entityTag)
							if(obj ~= nil) then
								obj.path = nil
								obj.circuit = nil
								obj.currentNode = nil
								obj.nextNode = nil
							end
						end
					end
				end
				if(action.name == "group_look_at_next_path_position") then
					local group =getGroupfromManager(action.tag)
					for i=1, #group.entities do 
						local entityTag = group.entities[i]
						local obj = getEntityFromManager(entityTag)
						if(obj ~= nil) then
							local trackpos = obj.path.locations[obj.path.index]
							local nexttrackpos = obj.path.locations[obj.path.index+1]
							if obj.path.reverse == true then 
								nexttrackpos = obj.path.locations[obj.path.index-1]
							end
							if(nexttrackpos ~= nil) and (trackpos ~= nil) then 
								logme(3,obj.path.index)
								local direction = {}
								local separate = 0
								if(action.separate ~= nil and action.separate == true) then
									separate = i-1
								end
								direction.x = nexttrackpos.x-separate
								direction.y = nexttrackpos.y-separate
								direction.z = nexttrackpos.z+action.zoffset
								direction.w = 1
								local enti = Game.FindEntityByID(obj.id)
								if(enti ~= nil) then
									local isplayer = false
									if entityTag == "player" then
										isplayer = true
									end
									local dirVector = diffVector(enti:GetWorldPosition(), direction)
									local angle = GetSingleton('Vector4'):ToRotation(dirVector)
									logme(3,"yaw "..angle.yaw)
									teleportTo(enti, enti:GetWorldPosition(), angle,isplayer)
								end
							end
						end
					end
				end
			end
			
			if soundregion then
				if(action.name == "play_game_sound") then
					local audioEvent = SoundPlayEvent.new()
					audioEvent.soundName = action.value
					Game.GetPlayer():QueueEvent(audioEvent)
				end
				if(action.name == "stop_game_sound") then
					local audioEvent = SoundStopEvent.new()
					audioEvent.soundName = action.value
					Game.GetPlayer():QueueEvent(audioEvent)
				end
				if(action.name == "play_custom_sound") then 
					
					if(cyberscript.cache["sound"][action.value] ~= nil) then
						local path = cyberscript.cache["sound"][action.value].data
						
						local isradio = false
						local needrepeat = false
						
						if action.isradio ~= nil then isradio = action.isradio end
						if action.needrepeat ~= nil then needrepeat = action.needrepeat end
						
						
						
						PlaySound(path,isradio,needrepeat)
						else
						error("No sound founded")
					end
				end
				
				if(action.name == "play_custom_sound_with_subtitle") then 
					
					if(cyberscript.cache["sound"][action.value] ~= nil) then
						
						if(GameController["SubtitlesGameController"] ~= nil) then
							--logme(3,"ye")
							local linesToShow = {}
							--GameController["SubtitlesGameController"]:Cleanup()
							local dialogLine = scnDialogLineData.new()
							local id = math.random(1,9999)
							dialogLine.id = CRUID(id)
							dialogLine.text  = getLang(cyberscript.cache["sound"][action.value].data.subtitle)
							dialogLine.type  = action.type
							dialogLine.speaker = Game.GetPlayer()
							dialogLine.speakerName  = getLang(action.speaker)
							local candotext = true
							if(action.speaker == "current_phone_npc") then
								if(currentNPC ~= nil) then
									dialogLine.speakerName  = currentNPC.Names
									else
									candotext = false
								end
								elseif(action.speaker == "current_star") then
								if(currentStar ~= nil) then
									dialogLine.speakerName  = currentStar.Names
									else
									candotext = false
								end
								elseif(action.speaker == "entity") then
								local obj = getEntityFromManager(action.speakertag)
								dialogLine.speakerName = obj.name
								candotext = true
								elseif(action.speaker == "mp_player") then
								dialogLine.speakerName = myTag
								candotext = true
								elseif(action.speaker == "mp_looked_player") then
								if(multiName == "") then
									dialogLine.speakerName = "Player"
									else
									dialogLine.speakerName = multiName
								end
								candotext = true
								else
								dialogLine.speakerName = getLang(action.speaker)
								candotext = true
							end
							
							
							
							
							
							if(candotext == true) then
								dialogLine.isPersistent  = true
								dialogLine.duration  = math.ceil(cyberscript.cache["sound"][action.value].data.duration)
								GameController["SubtitlesGameController"]:SpawnDialogLine(dialogLine)
								local temp = os.time(os.date("!*t"))+0 
								local nexttemp = temp
								nexttemp =nexttemp +  math.ceil(cyberscript.cache["sound"][action.value].data.duration)
								action.tick = nexttemp
								
								local path = cyberscript.cache["sound"][action.value].data
								
								local isradio = false
								local needrepeat = false
								
								if action.isradio ~= nil then isradio = action.isradio end
								if action.needrepeat ~= nil then needrepeat = action.needrepeat end
								
								
								if(action.target == nil) then
									PlaySound(path,isradio,needrepeat)
									else
									local obj = getEntityFromManager(action.target)
									if(obj ~= nil) then
										local enti = Game.FindEntityByID(obj.id)
										
										if(enti ~= nil) then
											
											local actionb = deepcopy(cyberscript.actiontemplate["fake_lips_sync"])
											actionb.duration = math.floor(cyberscript.cache["sound"][action.value].data.duration)-1
											actionb.tag = action.target
											local actionlist = {}
											actionlist[1] = actionb
											runActionList(actionlist, "fake_lips_sync_async_action_"..tostring(math.random(1,987987)), "see",false,nil)
											PlaySound(path,isradio,needrepeat,enti)
											else
											PlaySound(path,isradio,needrepeat)
										end
										else
										PlaySound(path,isradio,needrepeat)
									end
								end
								result = false
							end
							else
							error("can't find Subtitle controller, please call an npc for load one")
						end
						
						
						else
						error("No sound founded")
					end
				end
				
				if(action.name == "play_random_custom_sound_with_subtitle") then 
					local tago = math.random(1,#action.value)
					local tag = action.value[tago]
					if(cyberscript.cache["sound"][tag] ~= nil) then
						
						if(GameController["SubtitlesGameController"] ~= nil) then
							--logme(3,"ye")
							local linesToShow = {}
							--GameController["SubtitlesGameController"]:Cleanup()
							local dialogLine = scnDialogLineData.new()
							local id = math.random(1,9999)
							dialogLine.id = CRUID(id)
							dialogLine.text  = getLang(cyberscript.cache["sound"][tag].data.subtitle)
							dialogLine.type  = action.type
							dialogLine.speaker = Game.GetPlayer()
							dialogLine.speakerName  = getLang(action.speaker)
							local candotext = true
							if(action.speaker == "current_phone_npc") then
								if(currentNPC ~= nil) then
									dialogLine.speakerName  = currentNPC.Names
									else
									candotext = false
								end
								elseif(action.speaker == "current_star") then
								if(currentStar ~= nil) then
									dialogLine.speakerName  = currentStar.Names
									else
									candotext = false
								end
								elseif(action.speaker == "entity") then
								local obj = getEntityFromManager(action.speakertag)
								dialogLine.speakerName = obj.name
								candotext = true
								elseif(action.speaker == "mp_player") then
								dialogLine.speakerName = myTag
								candotext = true
								elseif(action.speaker == "mp_looked_player") then
								if(multiName == "") then
									dialogLine.speakerName = "Player"
									else
									dialogLine.speakerName = multiName
								end
								candotext = true
								else
								dialogLine.speakerName = getLang(action.speaker)
								candotext = true
							end
							
							
							
							
							
							if(candotext == true) then
								dialogLine.isPersistent  = true
								dialogLine.duration  = math.ceil(cyberscript.cache["sound"][tag].data.duration)
								GameController["SubtitlesGameController"]:SpawnDialogLine(dialogLine)
								local temp = os.time(os.date("!*t"))+0 
								local nexttemp = temp
								nexttemp =nexttemp +  math.ceil(cyberscript.cache["sound"][tag].data.duration)
								action.tick = nexttemp
								
								local path = cyberscript.cache["sound"][tag].data
								
								local isradio = false
								local needrepeat = false
								
								if action.isradio ~= nil then isradio = action.isradio end
								if action.needrepeat ~= nil then needrepeat = action.needrepeat end
								
								
								
								if(action.target == nil) then
									PlaySound(path,isradio,needrepeat)
									else
									local obj = getEntityFromManager(action.target)
									if(obj ~= nil) then
										local enti = Game.FindEntityByID(obj.id)
										
										if(enti ~= nil) then
											
											local actionb = deepcopy(cyberscript.actiontemplate["fake_lips_sync"])
											actionb.duration = math.floor(cyberscript.cache["sound"][action.value].data.duration)-1
											actionb.tag = action.target
											local actionlist = {}
											actionlist[1] = actionb
											runActionList(actionlist, "fake_lips_sync_async_action_"..tostring(math.random(1,987987)), "see",false,nil)
											PlaySound(path,isradio,needrepeat,enti)
											else
											PlaySound(path,isradio,needrepeat)
										end
										else
										PlaySound(path,isradio,needrepeat)
									end
								end
								
								result = false
							end
							else
							error("can't find Subtitle controller, please call an npc for load one")
						end
						
						
						else
						error("No sound founded for "..tag)
					end
				end
				
				if(action.name == "play_custom_sound_at_entity") then 
					
					if(cyberscript.cache["sound"][action.value] ~= nil) then
						local path = cyberscript.cache["sound"][action.value].data
						
						local isradio = false
						local needrepeat = false
						
						if action.isradio ~= nil then isradio = action.isradio end
						if action.needrepeat ~= nil then needrepeat = action.needrepeat end
						
						
						
						PlaySoundAtEntity(path,isradio,needrepeat,action.tag)
						else
						error("No sound founded")
					end
				end
				
				if(action.name == "stop_custom_sound") then 
					local path = cyberscript.cache["sound"][action.value].data
					Stop(path)
				end
				if(action.name == "setGameVolume") then 
					SetSoundSettingValue(action.value, action.score)
				end
				if(action.name == "change_radio_index") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						ps.activeStation = action.value
						enti:PlayGivenStation()
						
					end
				end
				
				if(action.name == "change_tv_index") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:SelectChannel(action.value)
						
					end
				end
				
				if(action.name == "device_turn_on") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:TurnOnDevice()
						
					end
				end
				
				if(action.name == "device_turn_off") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:TurnOffDevice()
						
					end
				end
				
				
				if(action.name == "device_glitch_on") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:StartGlitching(action.value, 1)
						
					end
				end
				
				
				if(action.name == "device_stop_using") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:StopUsing()
					end
				end
				
				if(action.name == "device_start_using") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:StartUsing()
					end
				end
				
				if(action.name == "device_glitch_off") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local ps = enti:GetDevicePS()
						
						enti:StopGlitching()
						
					end
				end
				
				if(action.name == "play_custom_sound_with_subtitle_as_chat") then 
					
					if(cyberscript.cache["sound"][action.value] ~= nil) then
						
						if(GameController["ChattersGameController"] ~= nil) then
							local linesToShow = {}
							local obj = getEntityFromManager(action.target)
							local enti = Game.FindEntityByID(obj.id)
							if(action.target == "lookat")then
								enti = objLook
							end
							if(enti ~= nil) then
								local dialogLine = scnDialogLineData.new()
								local id = math.random(1,9999)
								dialogLine.id = CRUID(id)
								dialogLine.text  =getLang(cyberscript.cache["sound"][action.value].data.subtitle)
								dialogLine.type  = action.type
								local candotext = true
								dialogLine.speaker = enti
								dialogLine.speakerName  =  getLang(action.speaker)
								if(action.speaker == "current_phone_npc") then
									if(currentNPC ~= nil) then
										dialogLine.speakerName  = currentNPC.Names
										else
										candotext = false
									end
								end
								if(action.speaker == "current_star") then
									if(currentStar ~= nil) then
										dialogLine.speakerName  = currentStar.Names
										else
										candotext = false
									end
								end
								if(action.speaker == "entity") then
									local obj = getEntityFromManager(action.speakertag)
									dialogLine.speakerName = obj.name
									candotext = true
								end
								if(candotext == true) then
									dialogLine.isPersistent  = false
									dialogLine.duration  = math.ceil(cyberscript.cache["sound"][action.value].data.duration)
									GameController["ChattersGameController"]:SpawnDialogLine(dialogLine)
									local temp = os.time(os.date("!*t"))+0 
									local nexttemp = temp
									nexttemp =nexttemp +  math.ceil(cyberscript.cache["sound"][action.value].data.duration)
									action.tick = nexttemp
									
									local path = cyberscript.cache["sound"][action.value].data
									
									local isradio = false
									local needrepeat = false
									
									if action.isradio ~= nil then isradio = action.isradio end
									if action.needrepeat ~= nil then needrepeat = action.needrepeat end
									
									
									
									if(action.target == nil) then
									PlaySound(path,isradio,needrepeat)
									else
									local obj = getEntityFromManager(action.target)
									if(obj ~= nil) then
										local enti = Game.FindEntityByID(obj.id)
										
										if(enti ~= nil) then
											
											local actionb = deepcopy(cyberscript.actiontemplate["fake_lips_sync"])
											actionb.duration = math.floor(cyberscript.cache["sound"][action.value].data.duration)-1
											actionb.tag = action.target
											local actionlist = {}
											actionlist[1] = actionb
											runActionList(actionlist, "fake_lips_sync_async_action_"..tostring(math.random(1,987987)), "see",false,nil)
											PlaySound(path,isradio,needrepeat,enti)
											else
											PlaySound(path,isradio,needrepeat)
										end
										else
										PlaySound(path,isradio,needrepeat)
									end
								end
									
									result = false
								end
							end
							else
							error("can't find chat Subtitle controller, please go to see an npc who speak in street or an TV or an Radio for load one")
							
						end
						
						
						else
						error("No sound founded")
					end
					
					
				end
				
			end
			
			if entityregion then
				if(action.name == "spawn_npc") then
					local chara = ""
					if(action.amount == nil) then
						action.amount = 1
					end
					if(action.amount == 0) then
						action.amount = math.random(1,6)
					end
					for i=1,action.amount do
						
						
						
						if(action.source == "from_list") then
							local indexchara = math.random(1,#action.source_list)
							chara = action.source_list[indexchara]
						end
						if(action.source == "npc") then
							chara = action.source_tag
						end
						if(action.source == "custom_npc") then
							local npc =  getCustomNPCbyTag(action.tag)
							if(npc ~= nil) then
								chara = npc.tweakDB
								npc.spawnforced=true
								
								
								npc.isspawn=true
								npc.init=false
							end
						end
						if(action.source == "current_star") then
							if(currentStar ~= nil) then
								chara = currentStar.TweakIDs
								else
								error("No Current Star defined, can't spawn !")
							end
						end
						if(action.source == "current_phoned_npc") then
							if(currentNPC ~= nil) then
								chara = currentNPC.TweakIDs
								else
								error("No Current Phoned NPC defined, can't spawn !")
							end
						end
						if(action.source == "faction") then
							local gang = getFactionByTag(action.source_tag)
							if(action.source_use_rival == true) then
								gang = getFactionByTag(gang.rivals[1])
							end
							if(action.source_use_vip == true) then
								if(#gang.vip > 0) then
									local viptable = getVIPfromfactionbyscore(gang.tag)
									if(#viptable > 0) then
										local index = math.random(1,#viptable)
										
										chara = viptable[index]
										else
										
										error("No VIP NPC for this faction")
									end
								end
								else
								--spdlog.error(dump(gang))
								if(gang.spawnable_npc ~= nil and #gang.spawnable_npc > 0) then
									local index = math.random(1,#gang.spawnable_npc)
									chara = gang.spawnable_npc[index]
									
									else
									
									error("No Spawnable NPC for this faction")
								end
							end
						end
						if(action.source == "district_leader" or action.source == "subdistrict_leader") then
							local gangs = getGangfromDistrict(action.source_tag,20)
							logme(3,dump(gangs))
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								if(action.source_use_rival == true) then
									gang = getFactionByTag(gang.rivals[1])
								end
								if(action.source_use_vip == true) then
									if(#gang.vip > 0) then
										local viptable = getVIPfromfactionbyscore(gang.tag)
										if(#viptable > 0) then
											local index = math.random(1,#viptable)
											
											chara = viptable[index]
										end
									end
									else
									if(#gang.spawnable_npc > 0) then
										local index = math.random(1,#gang.spawnable_npc)
										chara = gang.spawnable_npc[index]
									end
								end
							end
						end
						if(action.source == "current_district_leader") then
							
							local gangs = getGangfromDistrict(currentDistricts2.Tag,0)
							
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								
								if(action.source_use_rival == true) then
									gang = getFactionByTag(gang.rivals[1])
								end
								
								if(action.source_use_vip == true) then
									if(#gang.vip > 0) then
										local viptable = getVIPfromfactionbyscore(gang.tag)
										if(#viptable > 0) then
											local index = math.random(1,#viptable)
											
											chara = viptable[index]
										end
									end
									else
									if(#gang.spawnable_npc > 0) then
										local index = math.random(1,#gang.spawnable_npc)
										chara = gang.spawnable_npc[index]
									end
								end
							end
						end
						if(action.source == "current_subdistrict_leader") then
							local gangs = {}
							for j, test in ipairs(currentDistricts2.districtLabels) do
								if j > 1 then
									gangs = getGangfromDistrict(test,20)
									if(#gangs > 0) then
										break
									end
								end
							end
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								if(action.source_use_rival == true) then
									gang = getFactionByTag(gang.rivals[1])
								end
								if(action.source_use_vip == true) then
									if(#gang.vip > 0) then
										local viptable = getVIPfromfactionbyscore(gang.tag)
										if(#viptable > 0) then
											local index = math.random(1,#viptable)
											
											chara = viptable[index]
										end
									end
									else
									if(#gang.spawnable_npc > 0) then
										local index = math.random(1,#gang.spawnable_npc)
										chara = gang.spawnable_npc[index]
									end
								end
							end
						end
						if(action.source == "district_rival" or action.source == "subdistrict_rival") then
							
							if(action.source_gang == "player") then
								
								action.source_gang = getVariableKey("player","current_gang")
								
							end
							
							local gangs = getGangRivalfromDistrict(action.source_gang,action.source_tag,20)
							
							
							
							if(#gangs > 0) then
								
								
								local gang = getFactionByTag(gangs[1].tag)
								
								if(action.source_use_vip == true) then
									if(#gang.vip > 0) then
										local viptable = getVIPfromfactionbyscore(gang.tag)
										if(#viptable > 0) then
											local index = math.random(1,#viptable)
											
											chara = viptable[index]
										end
									end
									else
									if(#gang.spawnable_npc > 0) then
										local index = math.random(1,#gang.spawnable_npc)
										chara = gang.spawnable_npc[index]
									end
								end
							end
						end
						if(action.source == "current_district_rival") then
							
							if(action.source_gang == "player") then
								
								action.source_gang = getVariableKey("player","current_gang")
								
							end
							
							local gangs = getGangRivalfromDistrict(action.source_gang,currentDistricts2.Tag,20)
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								
								if(action.source_use_vip == true) then
									if(#gang.vip > 0) then
										local viptable = getVIPfromfactionbyscore(gang.tag)
										if(#viptable > 0) then
											local index = math.random(1,#viptable)
											
											chara = viptable[index]
										end
									end
									else
									if(#gang.spawnable_npc > 0) then
										local index = math.random(1,#gang.spawnable_npc)
										chara = gang.spawnable_npc[index]
									end
								end
							end
						end
						
						if(action.source == "current_subdistrict_rival") then
							
							if(action.source_gang == "player") then
								
								action.source_gang = getVariableKey("player","current_gang")
								
							end
							
							local gangs = {}
							for j, test in ipairs(currentDistricts2.districtLabels) do
								if j > 1 then
									gangs = getGangRivalfromDistrict(action.source_gang,test,20)
									if(#gangs > 0) then
										break
									end
								end
							end
							if(#gangs > 0) then
								local gang = getFactionByTag(gangs[1].tag)
								
								if(action.source_use_vip == true) then
									if(#gang.vip > 0) then
										local viptable = getVIPfromfactionbyscore(gang.tag)
										if(#viptable > 0) then
											local index = math.random(1,#viptable)
											
											chara = viptable[index]
										end
									end
									else
									if(#gang.spawnable_npc > 0) then
										local index = math.random(1,#gang.spawnable_npc)
										chara = gang.spawnable_npc[index]
									end
								end
							end
						end
						
						
						local tag = action.tag
						if(action.amount > 1) then
							tag = action.tag.."_"..i
						end
						
						
						local position = {}
						local position = getPositionFromParameter(action)
						
						if(chara ~= "" and chara ~= nil and position.x ~= nil) then
							if(action.amount > 1) then
								
								position.x = position.x + (i*0.5)
								
							end
							spawnNPC(chara,action.appearance, tag, position.x, position.y ,position.z,action.spawnlevel,action.use_police_prevention_system,false,action.scriptlevel,action.useEntpath,nil,action.despawntimer,action.usecodeware,action.persiststate,action.persistspawn,action.alwaysspawned,action.spawninview,action.dontregister)
							if(action.group ~= nil and action.group ~= "") then
								
								if(cyberscript.GroupManager[action.group] == nil and action.create_group_if_not_exist == true) then
									local group = {}
									group.tag = action.group
									group.entities = {}
									cyberscript.GroupManager[action.group] = group
									logme(3,"group created")
									
								end
								if(cyberscript.GroupManager[action.group] ~= nil) then
									table.insert(cyberscript.GroupManager[action.group].entities,tag)
									else
									error("group with tag : "..action.group.." doesn't exist")
								end
							end
							else
							error("bad character or position. character tweak : "..chara.." position : "..dump(position))
						end
					end
				end
				if(action.name == "despawn_lookat") then
					if(objLook ~= nil) then
						local enti = getEntityFromManagerById(objLook:GetEntityID()) 
						if(enti ~= nil)then
							logme(3,"yahoo")
							despawnEntity(enti.tag)
							
						end
					end
				end
				if(action.name == "despawnAll") then
					despawnAll()
				end
				if(action.name == "teleport_player") then
					--Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Vector4.new( action.x, action.y, action.z,1) , 1)
					TeleportPlayerToPosition(action.x,action.y,action.z)
				end
				if(action.name == "set_component_hidden") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local components = enti:GetComponents();
						for i,component in ipairs(components) do
							if(NameToString(component:GetName()) == action.value) then
								component:TemporaryHide(action.hide)
							end
						end
						
					end
				end
				
				if(action.name == "set_current_star") then
					if(currentNPC ~= nil) then
						
						currentStar = currentNPC
						currentNPC = nil
						
						else
						
						error("No current Phoned NPC ")
					end
				end
				if(action.name == "clone_entity") then
					local obj = getEntityFromManager(action.target)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						
						local postp = enti:GetWorldPosition()
						local worldpos = Game.GetPlayer():GetWorldTransform()
						
						worldpos:SetOrientation(worldpos, enti:GetWorldOrientation())	
						
						
						local npcSpec =  DynamicEntitySpec.new()
						npcSpec.recordID = enti:GetRecordID()
						npcSpec.appearanceName = Game.NameToString(enti:GetCurrentAppearanceName())
						npcSpec.position = postp
						npcSpec.orientation = enti:GetWorldOrientation()
						npcSpec.persistState = action.persiststate
						npcSpec.persistSpawn = action.persistspawn
						npcSpec.alwaysSpawned = action.alwaysspawned
						npcSpec.spawnInView =  action.spawninview
						
						CName.add("CyberScript")
						CName.add("CyberScript.NPC")
						CName.add("CyberScript.NPC."..action.tag)
						
						npcSpec.tags = {"CyberScript","CyberScript.NPC","CyberScript.NPC."..action.tag}
						if(Game.GetDynamicEntitySystem():IsPopulated("CyberScript.NPC."..action.tag) == true) then Game.GetDynamicEntitySystem():DeleteTagged("CyberScript.NPC."..action.tag) end
						
						if(Game.GetDynamicEntitySystem():IsPopulated("CyberScript.NPC."..action.tag) == false) then
							
							NPC = Game.GetDynamicEntitySystem():CreateEntity(npcSpec)
							
							if(NPC ~= nil) then
								local entity = {}
								entity.id = NPC
								entity.spawntimespan = os.time(os.date("!*t"))+0
								entity.despawntimespan = os.time(os.date("!*t"))+action.despawntimer
								entity.tag = action.tag
								entity.spawnlocation = postp
								entity.isitem = false
								entity.tweak =""
								entity.isprevention = false
								entity.iscodeware = true
								entity.persistState =  false
								entity.persistSpawn =  false
								entity.alwaysSpawned =  false
								entity.spawnInView =  true
								entity.scriptlevel = 0
								entity.name = entity.tag
								
								
								
								
								cyberscript.EntityManager[action.tag]=entity
								cyberscript.EntityManager["last_spawned"].tag=action.tag
								
								if(action.deleteoriginal == true) then
									
									enti:Dispose()
									cyberscript.EntityManager[action.target]=nil
								end
								-- Cron.After(0.5, function()
								
								
								-- if isprevention == true then
								-- local postp = Vector4.new( x, y, z,1)
								-- teleportTo(Game.FindEntityByID(NPC), postp, 1,false)
								-- end
								
								
								
								
								-- end)
							end
							
							else
							
							
						end
						
						
					end
				end
				
				
				if(action.name == "replace_entity") then
					local obj = getEntityFromManager(action.target)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						
						local postp = enti:GetWorldPosition()
						local worldpos = Game.GetPlayer():GetWorldTransform()
						
						worldpos:SetOrientation(worldpos, enti:GetWorldOrientation())	
						
						
						local npcSpec =  DynamicEntitySpec.new()
						npcSpec.recordID = action.source_tag
						npcSpec.appearanceName = action.appearance
						npcSpec.position = postp
						npcSpec.orientation = enti:GetWorldOrientation()
						npcSpec.persistState = action.persiststate
						npcSpec.persistSpawn = action.persistspawn
						npcSpec.alwaysSpawned = action.alwaysspawned
						npcSpec.spawnInView =  action.spawninview
						
						CName.add("CyberScript")
						CName.add("CyberScript.NPC")
						CName.add("CyberScript.NPC."..action.tag)
						
						npcSpec.tags = {"CyberScript","CyberScript.NPC","CyberScript.NPC."..action.tag}
						if(Game.GetDynamicEntitySystem():IsPopulated("CyberScript.NPC."..action.tag) == true) then Game.GetDynamicEntitySystem():DeleteTagged("CyberScript.NPC."..action.tag) end
						
						if(Game.GetDynamicEntitySystem():IsPopulated("CyberScript.NPC."..action.tag) == false) then
							
							NPC = Game.GetDynamicEntitySystem():CreateEntity(npcSpec)
							
							if(NPC ~= nil) then
								local entity = {}
								entity.id = NPC
								entity.spawntimespan = os.time(os.date("!*t"))+0
								entity.despawntimespan = os.time(os.date("!*t"))+action.despawntimer
								entity.tag = action.tag
								entity.spawnlocation = postp
								entity.isitem = false
								entity.tweak =""
								entity.isprevention = false
								entity.iscodeware = true
								entity.persistState =  false
								entity.persistSpawn =  false
								entity.alwaysSpawned =  false
								entity.spawnInView =  true
								entity.scriptlevel = 0
								entity.name = entity.tag
								
								
								
								
								cyberscript.EntityManager[action.tag]=entity
								cyberscript.EntityManager["last_spawned"].tag=action.tag
								
								if(action.deleteoriginal == true) then
									
									enti:Dispose()
									cyberscript.EntityManager[action.target]=nil
								end
								-- Cron.After(0.5, function()
								
								
								-- if isprevention == true then
								-- local postp = Vector4.new( x, y, z,1)
								-- teleportTo(Game.FindEntityByID(NPC), postp, 1,false)
								-- end
								
								
								
								
								-- end)
							end
							
							else
							
							
						end
						
						
					end
				end
				
				if(action.name == "change_entity_tag") then
					local obj = getEntityFromManager(action.target)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local entity = deepcopy(obj)
						entity.id = enti:GetEntityID()
						entity.tag = action.tag
						cyberscript.EntityManager[action.tag]=entity
						cyberscript.EntityManager[action.target]=nil
					end		
				end
						
						
				
				
				if(action.name == "register_entity_you_look_at") then
					if(objLook ~= nil) then
						local entity = getEntityFromManager(action.tag)
						if (entity.id == nil) then
							local entity = {}
							entity.id = objLook:GetEntityID()
							entity.tag = action.tag
							entity.tweak = "None"
							entity.iscompanion = false
							cyberscript.EntityManager[action.tag]=entity
							if(action.group ~= nil and action.group ~= "") then
								
								table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
							end
							else
							Game.GetPlayer():SetWarningMessage("An entity with this tag already exist.")
						end
					end
				end
				
				if(action.name == "register_entity_by_hash") then
					
					player = Game.GetPlayer()
					targetingSystem = Game.GetTargetingSystem()
					parts = {}
					local success= false
					searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
					searchQuery.maxDistance = action.range
					success, parts = targetingSystem:GetTargetParts(Game.GetPlayer(), searchQuery)
					
					
					
					local goodEntity = false
					
					for i, v in ipairs(parts) do
						local newent = v:GetComponent(v):GetEntity() 
						
						
						
						
						
						
						if(action.value == tostring(newent:GetEntityID().hash))then 
							local entity = {}
							entity.id = newent:GetEntityID()
							entity.tag = action.tag
							entity.tweak = "None"
							entity.iscompanion = false
							cyberscript.EntityManager[action.tag]=entity
							if(action.group ~= nil and action.group ~= "") then
								
								table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
							end
						end
						
						
						
						
						
						
						
						
						
					end
				end
				
				if(action.name == "register_entity_by_filter") then
					
					player = Game.GetPlayer()
					targetingSystem = Game.GetTargetingSystem()
					parts = {}
					local success= false
					searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
					
					searchQuery.maxDistance = action.range
					success, parts = targetingSystem:GetTargetParts(Game.GetPlayer(), searchQuery)
					
					
					
					local goodEntity = false
					
					for i, v in ipairs(parts) do
						local newent = v:GetComponent(v):GetEntity() 
						
						
						
						
						
						
						if(string.match(newent:ToString(), action.value) or string.match( Game.NameToString(newent:GetCurrentAppearanceName()), action.value) or string.match(newent:GetDisplayName(), action.value))then 
							local entity = {}
							entity.id = newent:GetEntityID()
							entity.tag = action.tag
							entity.tweak = "None"
							entity.iscompanion = false
							cyberscript.EntityManager[action.tag]=entity
							if(action.group ~= nil and action.group ~= "") then
								
								table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
							end
						end
						
						
						
						
						
						
						
						
						
					end
				end
				
				if(action.name == "register_entities_around_you") then
					
					player = Game.GetPlayer()
					targetingSystem = Game.GetTargetingSystem()
					parts = {}
					local success= false
					searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
					searchQuery.maxDistance = action.range
					success, parts = targetingSystem:GetTargetParts(Game.GetPlayer(), searchQuery)
					local startindex = 0
					local goodEntity = false
					local limitactive = 0
					for i, v in ipairs(parts) do
						local newent = v:GetComponent(v):GetEntity() 
						
						
						
						if(action.limit == nil or limitactive <= action.limit ) then
							
							if #action.filter > 0  then
								for i,filter in ipairs(action.filter) do
									
									if(string.match(newent:ToString(), filter) or string.match( Game.NameToString(newent:GetCurrentAppearanceName()), filter) or string.match(newent:GetDisplayName(), filter) or filter == tostring(newent:GetEntityID().hash) or (filter == "isnpc" and newent:IsA("ScriptedPuppet")) or (filter == "vehicle" and newent:IsVehicle()))then 
										local entity = {}
										entity.id = newent:GetEntityID()
										
										local canadd = true
										
										for k,v in pairs(cyberscript.EntityManager) do
											
											if(v.id == entity.id) then
												
												cyberscript.EntityManager[k] = nil
											end
											
										end
										
										if(action.prefix == nil) then action.prefix = "entity" end
										
										if(action.startindex == nil) then startindex = newent:GetEntityID().hash end
										if(action.startindex ~= nil) then startindex = action.startindex + i - 1 end
										entity.tag = action.prefix..tostring(action.startindex)
										entity.tweak = "None"
										entity.iscompanion = false
										if(canadd) then
											limitactive = limitactive + 1
											cyberscript.EntityManager[entity.tag]=entity
											if(action.group ~= nil and action.group ~= "") then
												
												table.insert(cyberscript.GroupManager[action.group].entities,entity.tag)
											end
										end
									end
								end
								else
								
								local entity = {}
								entity.id = newent:GetEntityID()
								
								local canadd = true
								
								for k,v in pairs(cyberscript.EntityManager) do
									
									if(v.id == entity.id) then
										
										cyberscript.EntityManager[k] = nil
										
									end
									
								end
								
								if(action.prefix == nil) then action.prefix = "entity_" end
								startindex = 0
								if(action.startindex == nil) then startindex = newent:GetEntityID().hash end
								if(action.startindex ~= nil) then startindex = action.startindex + i - 1 end
								entity.tag = action.prefix..tostring(startindex)
								entity.tweak = "None"
								entity.iscompanion = false
								
								if(canadd) then
									
									cyberscript.EntityManager[entity.tag]=entity
									if(action.group ~= nil and action.group ~= "") then
										
										table.insert(cyberscript.GroupManager[action.group].entities,entity.tag)
									end
								end
							end
							
						end
						
						
						
						
						
						
						
					end
					
					
				end	
				
				if(action.name == "register_enemy_around_you") then
					
					player = Game.GetPlayer()
					targetingSystem = Game.GetTargetingSystem()
					parts = {}
					local success= false
					searchQuery = Game["TSQ_EnemyNPC;"]() -- Search ALL objects
					searchQuery.maxDistance = action.range
					success, parts = targetingSystem:GetTargetParts(Game.GetPlayer(), searchQuery)
					
					local goodEntity = false
					
					for i, v in ipairs(parts) do
						local newent = v:GetComponent(v):GetEntity() 
						
						
						
						
						if(action.limit == nil or i <= action.limit ) then
							
							if #action.filter > 0  then
								for i,filter in ipairs(action.filter) do
									
									if(string.match(newent:ToString(), filter) or string.match( Game.NameToString(newent:GetCurrentAppearanceName()), filter) or string.match(newent:GetDisplayName(), filter) or filter == tostring(newent:GetEntityID().hash))then 
										local entity = {}
										entity.id = newent:GetEntityID()
										
										local canadd = true
										
										for k,v in pairs(cyberscript.EntityManager) do
											
											if(v.id == entity.id) then
												
												cyberscript.EntityManager[k] = nil
												
											end
											
										end
										
										if(action.prefix == nil) then action.prefix = "entity" end
										startindex = 0
										if(action.startindex == nil) then startindex = newent:GetEntityID().hash end
										if(action.startindex ~= nil) then startindex = action.startindex + i - 1 end
										entity.tag = action.prefix..tostring(startindex)
										entity.tweak = "None"
										entity.iscompanion = false
										if(canadd) then
											
											cyberscript.EntityManager[entity.tag]=entity
											if(action.group ~= nil and action.group ~= "") then
												
												table.insert(cyberscript.GroupManager[action.group].entities,entity.tag)
											end
										end
									end
								end
								else
								
								local entity = {}
								entity.id = newent:GetEntityID()
								
								local canadd = true
								
								for k,v in pairs(cyberscript.EntityManager) do
									
									if(v.id == entity.id) then
										
										cyberscript.EntityManager[k] = nil
										
									end
									
								end
								
								if(action.prefix == nil) then action.prefix = "entity_" end
								startindex = 0
								if(action.startindex == nil) then startindex = newent:GetEntityID().hash end
								if(action.startindex ~= nil) then startindex = action.startindex + i - 1 end
								entity.tag = action.prefix..tostring(startindex)
								entity.tweak = "None"
								entity.iscompanion = false
								
								if(canadd) then
									
									cyberscript.EntityManager[entity.tag]=entity
									if(action.group ~= nil and action.group ~= "") then
										
										table.insert(cyberscript.GroupManager[action.group].entities,entity.tag)
									end
								end
							end
							
						end
						
						
						
						
						
						
						
					end
					
					
				end	
				
				
				if(action.name == "register_entities_around_entity") then
					
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						targetingSystem = Game.GetTargetingSystem()
						parts = {}
						local success= false
						searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
						searchQuery.maxDistance = action.range
						success, parts = targetingSystem:GetTargetParts(enti, searchQuery)
						
						
						
						local goodEntity = false
						
						for i, v in ipairs(parts) do
							local newent = v:GetComponent(v):GetEntity() 
							
							
							
							
							
							
							if #action.filter > 0 then
								for i,filter in ipairs(action.filter) do
									
									if(string.match(newent:ToString(), filter) or string.match( Game.NameToString(newent:GetCurrentAppearanceName()), filter) or string.match(newent:GetDisplayName(), filter) or filter == tostring(newent:GetEntityID().hash))then 
										local entity = {}
										entity.id = newent:GetEntityID()
										
										local canadd = true
										
										for k,v in pairs(cyberscript.EntityManager) do
											
											if(v.id == entity.id) then
												
												canadd = false
												print("NOK1")
											end
											
										end
										
										entity.tag = "entity_"..tostring(newent:GetEntityID().hash)
										entity.tweak = "None"
										entity.iscompanion = false
										if(canadd) then
											
											cyberscript.EntityManager["entity_"..tostring(newent:GetEntityID().hash)]=entity
											if(action.group ~= nil and action.group ~= "") then
												
												table.insert(cyberscript.GroupManager[action.group].entities,"entity_"..tostring(newent:GetEntityID().hash))
											end
										end
									end
								end
								else
								
								local entity = {}
								entity.id = newent:GetEntityID()
								
								local canadd = true
								
								for k,v in pairs(cyberscript.EntityManager) do
									
									if(v.id == entity.id) then
										
										canadd = false
										
									end
									
								end
								
								entity.tag = "entity_"..tostring(newent:GetEntityID().hash)
								entity.tweak = "None"
								entity.iscompanion = false
								if(candd) then
									cyberscript.EntityManager["entity_"..tostring(newent:GetEntityID().hash)]=entity
									if(action.group ~= nil and action.group ~= "") then
										
										table.insert(cyberscript.GroupManager[action.group].entities,"entity_"..tostring(newent:GetEntityID().hash))
									end
								end
							end
							
							
							
							
							
							
							
							
							
						end
						
					end
				end	
				
				
				if(action.name == "register_last_killed_entity") then
					if(lastTargetKilled ~= nil) then
						local entity = getEntityFromManager(action.tag)
						if (entity.id == nil) then
							local entity = {}
							entity.id = lastTargetKilled:GetEntityID()
							entity.tag = action.tag
							entity.tweak = "None"
							entity.iscompanion = false
							cyberscript.EntityManager[action.tag]=entity
							if(action.group ~= nil and action.group ~= "") then
								
								table.insert(cyberscript.GroupManager[action.group].entities,action.tag)
							end
							lastTargetKilled = nil
							else
							Game.GetPlayer():SetWarningMessage("An entity with this tag already exist.")
						end
						else
						error("No killed entity fonded")
					end
				end
				
				if(action.name == "destroy_entity_you_look_at") then
					if(objLook ~= nil) then
						objLook:Dispose()
					end
				end
				
				if(action.name == "reset_last_killed_entity") then
					if(lastTargetKilled ~= nil) then
						lastTargetKilled = nil
					end
				end
				
				if(action.name == "register_entity_you_look_at_in_group") then
					if(objLook ~= nil) then
						local tag = "entity_"..math.random(0,999)
						local entity = getEntityFromManager(tag)
						if (entity.id == nil) then
							local entity = {}
							entity.id = objLook:GetEntityID()
							entity.tag = tag
							entity.tweak = "None"
							entity.iscompanion = false
							
							cyberscript.EntityManager[tag]=entity
							table.insert(cyberscript.GroupManager[action.group].entities,tag)
							else
							Game.GetPlayer():SetWarningMessage("An entity with this tag already exist.")
						end
					end
				end
				if(action.name == "kill_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						enti:OnDied()
						-- local sp = GetSingleton("ScriptedPuppet")
						-- sp.Kill(enti,false,false)
					end
				end
				
				
				
				
				if(action.name == "ressurect_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						
						local sp = GetSingleton("ScriptedPuppet")
						sp:SendResurrectEvent(enti)
						enti:OnResurrected()
						enti:QueueEvent(CreateDisableRagdollEvent("DisableRagdollTask"))
						
					end
					
				end
				
				
				
				if(action.name == "set_entity_highlight") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						obj.isquest = action.value
						enti:MarkAsQuest(obj.isquest)
					end
					
				end
				if(action.name == "bound_entity_to_entity") then
					
					if(arrayBoundedEntity[action.tag] == nil) then
						
						arrayBoundedEntity[action.tag] = {}
						arrayBoundedEntity[action.tag].anchor=action.entity
						arrayBoundedEntity[action.tag].x = action.x
						arrayBoundedEntity[action.tag].y = action.y
						arrayBoundedEntity[action.tag].z = action.z
						arrayBoundedEntity[action.tag].yaw = action.yaw
						arrayBoundedEntity[action.tag].pitch = action.pitch
						arrayBoundedEntity[action.tag].roll = action.roll
						arrayBoundedEntity[action.tag].copyrotation = action.copyrotation
						arrayBoundedEntity[action.tag].isitem = action.isitem
						arrayBoundedEntity[action.tag].lastposition = {}
						arrayBoundedEntity[action.tag].lastposition.x = 0
						arrayBoundedEntity[action.tag].lastposition.y = 0
						arrayBoundedEntity[action.tag].lastposition.z = 0
						
						
						arrayBoundedEntity[action.tag].lastorientation = {}
						arrayBoundedEntity[action.tag].lastorientation.yaw = 0
						arrayBoundedEntity[action.tag].lastorientation.pitch = 0
						arrayBoundedEntity[action.tag].lastorientation.roll = 0
					end
					
				end
				
				if(action.name == "unbound_entity") then
					
					if(arrayBoundedEntity[action.tag] ~= nil) then
						
						arrayBoundedEntity[action.tag] = nil
						
					end
					
				end
				
				if(action.name == "despawn_entity") then
					
					despawnEntity(action.tag)
					if(action.tag == "current_star") then
						currentStar = nil
					end
				end
				if(action.name == "unregister_entity") then
					cyberscript.EntityManager[action.tag]=nil
				end
				
				if(action.name == "change_stance_entity") then 
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						changeStance(enti,action.value)
					end
				end
				
				if(action.name == "kill_group") then
					local group =getGroupfromManager(action.tag)
					if(group ~= nil) then
						for i,v in ipairs(group.entities) do 
							local entityTag = v
							local obj = getEntityFromManager(entityTag)
							local enti = Game.FindEntityByID(obj.id)
							if(enti ~= nil) then
								enti:OnDied()
								
							end
						end
					end
				end
				
				if(action.name == "move") then
					
					if(action.group == true ) then
						local actionlist = {}
						
						local group =getGroupfromManager(action.tag)
						for i=1, #group.entities do 
							local entityTag = group.entities[i]
							local obj = getEntityFromManager(entityTag)
							local enti = Game.FindEntityByID(obj.id)
							if(enti ~= nil) then
								
								local newaction = deepcopy(action)
								newaction.group = false
								newaction.tag = entityTag
								newaction.x = newaction.x+(0.1*i)
								table.insert(actionlist,newaction)
								
								local waitaction = deepcopy(cyberscript.actiontemplate["wait_second"])
								waitaction.value = 1
								table.insert(actionlist,waitaction)
								
								
							end
							
						end
						logme(1,dump(actionlist[1]))
						runActionList(actionlist, tag.."_move_grosssup"..tostring(math.random(1,987987)), "see",false,"",false)
						else
						local obj = getEntityFromManager(action.tag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							
							local position = getPositionFromParameter(action)
							
							if(position.x ~= nil) then
								
								local v2 = nil
								
								if(action.moveV2 == true) then
									v2 = {}
									v2.quat= GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(action.roll, action.pitch, action.yaw))
									v2.ignoreNav = action.ignorenavigation
									v2.stoponobstacle = action.stoponobstacle
									v2.distance = action.distance
									v2.distancetolerance = action.distancetolerance
									v2.outofway=action.outofway
									
									
								end
								
								
								MoveTo(enti, position, 1, action.move,v2)
								
								
								
								else
								error("bad character or position. character tweak : "..chara.." position : "..dump(position))
							end
							
							
							
							
						end
					end
				end
				
				if(action.name == "teleport") then
					
					if(action.group == true ) then
						local group =getGroupfromManager(action.tag)
						for i=1, #group.entities do 
							local entityTag = group.entities[i]
							local obj = getEntityFromManager(entityTag)
							local enti = Game.FindEntityByID(obj.id)
							if(enti ~= nil) then
								
								
								local position = getPositionFromParameter(action)
								
								if(position.x ~= nil) then
									
									local v2 = nil
									
									local rot =  GetSingleton('Quaternion'):ToEulerAngles(enti:GetWorldOrientation())
									
									if(action.yaw) ~= nil then
										
										rot = EulerAngles.new(action.roll, action.pitch,  action.yaw)
										
									end
									
									teleportTo(enti, position, rot,false)
									
									
									
									else
									error("bad character or position. character tweak : "..chara.." position : "..dump(position))
								end
								
								
								
								
							end
						end
						else
						local obj = getEntityFromManager(action.tag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							local isplayer = false
							if action.tag == "player" then
								isplayer = true
							end
							
							local position = getPositionFromParameter(action)
							
							if(position.x ~= nil) then
								
								
								local rot =  GetSingleton('Quaternion'):ToEulerAngles(enti:GetWorldOrientation())
								if(action.yaw) ~= nil then
									
									rot = EulerAngles.new(action.roll, action.pitch,  action.yaw)
									
								end
								teleportTo(enti, position, rot,isplayer)
								
								
								
								else
								error("bad character or position. character tweak : "..chara.." position : "..dump(position))
							end
							
							
							
							
						end
					end
				end
				
				
				if(action.name == "entity_hold_position") then
					local enti = nil
					local obj = nil 
					if(action.tag =="lookat") then 
						enti = objLook
						obj = getEntityFromManagerById(objLook:GetEntityID())
						else
						obj = getEntityFromManager(action.tag)
						enti = Game.FindEntityByID(obj.id)
					end
					local stealth = false
					if(action.stealth == nil) then
						local state = Game.GetPlayer():GetPlayerStateMachineBlackboard():GetInt(Game.GetAllBlackboardDefs().PlayerStateMachine.Combat)
						if(state == 3) then
							stealth = true
						end
						else
						stealth = action.stealth
					end
					if(enti ~= nil) then
						if(enti:IsVehicle() ~= true) then
							InterruptBehavior(enti)
							HoldPosition(enti, action.timer, stealth)
						end
					end
				end
				
				if(action.name == "entity_stop_movement") then
					local enti = nil
					local obj = nil 
					
					obj = getEntityFromManager(action.tag)
					enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						
						InterruptBehavior(enti)
						
						
					end
				end
				
				if(action.name == "rotate_entity_to_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local enti2 = Game.GetPlayer()
						if(action.entity ~= "player") then
							local obj2 = getEntityFromManager(action.entity)
							enti2 = Game.FindEntityByID(obj2.id)
						end
						RotateTo(enti, enti2)
					end
				end
				if(action.name == "rotate_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						RotateEntityTo(enti, action.pitch, action.yaw, action.roll)
					end
				end
				
				if(action.name == "rotate_entity_to_position") then
					action.output = true
					local position = getPositionFromParameter(action)
					
					if(position.x ~= nil) then
						
						
						entityLookAtDirection(action.tag,position.x, position.y, position.z)
					end
				end
				
				if(action.name == "choose_target") then
					if(objLook ~= nil) then
						selectTarget = objLook:GetEntityID()
					end
				end
				if(action.name == "reset_target") then
					selectTarget = nil
				end
				if(action.name == "follow_entity_to_entity") then
					local enti = nil
					if(action.tag =="lookat") then 
						enti = objLook
						else
						local obj = getEntityFromManager(action.tag)
						enti = Game.FindEntityByID(obj.id)
					end
					local stealth = false
					if(enti ~= nil) then
						local enti2 = Game.GetPlayer()
						if(action.stealth == nil) then
							local state = Game.GetPlayer():GetPlayerStateMachineBlackboard():GetInt(Game.GetAllBlackboardDefs().PlayerStateMachine.Combat)
							if(state == 3) then
								stealth = true
							end
							else
							stealth = action.stealth
						end
						if(action.entity ~= "player") then
							if(action.entity =="lookat") then 
								local id = enti:GetEntityID()
								Cron.After(5, function(id)
									enti = Game.FindEntityByID(id)
									enti2 = objLook
									if(enti2 ~= nil) then
										FollowEntity(enti, enti2, action.move, stealth)
									end
								end)
								else
								local obj2 = getEntityFromManager(action.entity)
								enti2 = Game.FindEntityByID(obj2.id)
								FollowEntity(enti, enti2, action.move, stealth)
							end
							if(action.entity =="target") then 
								enti2 = Game.FindEntityByID(selectTarget)
								FollowEntity(enti, enti2, action.move, stealth)
							end
							else
							FollowEntity(enti, enti2, action.move, stealth)
						end
					end
				end
				
				if(action.name == "teleport_entity_to_entity_relative") then
					local isplayer = false
					if action.tag == "player" then
						isplayer = true
					end
					
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					
					if(enti ~= nil) then
						local positionVec4 = Game.GetPlayer():GetWorldPosition()
						
						local obj2 = getEntityFromManager(action.entity)
						local enti2 = Game.FindEntityByID(obj2.id)
						if(enti2 ~= nil) then
							positionVec4 = enti2:GetWorldPosition()
							
							positionVec4.x = positionVec4.x + action.x
							positionVec4.y = positionVec4.y + action.y
							positionVec4.z = positionVec4.z + action.z
							
							local rot =  GetSingleton('Quaternion'):ToEulerAngles(enti2:GetWorldOrientation())
							
							teleportTo(enti, positionVec4, rot,isplayer)
							else
							error("no entity for "..action.entity)
						end
						else
						error("no entity for "..action.tag)
					end
				end
				if(action.name == "teleport_entity_at_position") then
					local isplayer = false
					if action.tag == "player" then
						isplayer = true
					end
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local angle = 1
						if(action.angle ~= nil) then
							angle = action.angle
						end
						if(action.collision ~= nil and action.collision == true) then
							local filters = {
								'Static', -- Buildings, Concrete Roads, Crates, etc.
								'Terrain'
							}
							local from = enti:GetWorldPosition()
							local to = Vector4.new(
								action.x ,
								action.y ,
								action.z,
								1
							)
							local collision = false
							for _, filter in ipairs(filters) do
								local success, result = Game.GetSpatialQueriesSystem():SyncRaycastByCollisionGroup(from, to, filter, false, false)
								if success then
									collision = true
									logme(1,"collision"..filter)
								end
							end
							if(collision == false) then
								teleportTo(enti, Vector4.new( action.x, action.y, action.z,1), angle,isplayer)
								else
								if(action.pathfinding ~= nil and action.pathfinding == true) then
									local newpath =  giveGoodPath(from,to,action.axis)
									teleportTo(enti, newpath, angle,isplayer)
								end
							end
							else
							--logme(3,"angle.yaw = "..angle.yaw)
							teleportTo(enti, Vector4.new( action.x, action.y, action.z,1), angle,isplayer)
						end
					end
				end
				if(action.name == "teleport_entity_at_relative_position") then
					local isplayer = false
					if action.tag == "player" then
						isplayer = true
					end
					
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						local angle = 1
						if(action.angle ~= nil) then
							angle = action.angle
						end
						local positionVec4 = enti:GetWorldPosition()
						positionVec4.x = positionVec4.x + action.x
						positionVec4.y = positionVec4.y + action.y
						positionVec4.z = positionVec4.z + action.z
						teleportTo(enti, Vector4.new( positionVec4.x, positionVec4.y, positionVec4.z,1), angle,isplayer)
					end
				end
				if(action.name == "teleport_player_at_relative_position") then
					local playerpos = Game.GetPlayer():GetWorldPosition()
					TeleportPlayerToPosition(playerpos.x+action.x,playerpos.y+action.y,playerpos.z+action.z)
				end
				
				
				
				if(action.name == "entity_stop_fight") then
					InterruptCombat(action.tag)
				end
				if(action.name == "switch_primary_secondary_weapon_entity") then
					local enti = nil
					local obj = nil 
					if(action.tag =="lookat") then 
						enti = objLook
						obj = getEntityFromManagerById(objLook:GetEntityID())
						else
						obj = getEntityFromManager(action.tag)
						enti = Game.FindEntityByID(obj.id)
					end
					if(enti ~= nil and  enti:HasPrimaryOrSecondaryEquipment()) then
						if obj.usePrimary == nil or true then
							EquipPrimaryWeaponCommand(objlook, false)
							EquipSecondaryWeaponCommand(objlook, true)
							obj.usePrimary = false
							else
							EquipSecondaryWeaponCommand(objlook, false)
							EquipPrimaryWeaponCommand(objlook, true)
							obj.usePrimary = true
						end
					end
				end
				if(action.name == "equip_weapon_entity_from_current_player") then
					local enti = nil
					local obj = nil 
					if(action.tag =="lookat") then 
						enti = objLook
						obj = getEntityFromManagerById(objLook:GetEntityID())
						else
						obj = getEntityFromManager(action.tag)
						enti = Game.FindEntityByID(obj.id)
					end
					if(enti ~= nil and  enti:HasPrimaryOrSecondaryEquipment()) then
						local es = Game.GetScriptableSystemsContainer():Get(CName.new("EquipmentSystem"))
						local weapon = es:GetActiveWeaponObject(Game.GetPlayer(), 39)
						local weaponTDBID = weapon:GetItemID().tdbid
						EquipGivenWeapon(enti, weaponTDBID, true)
					end
				end
				
				if(action.name == "equip_item_on_slot") then
					local enti = nil
					local obj = nil 
					obj = getEntityFromManager(action.tag)
					enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil ) then
						
						if(action.tag =="player") then 
							Game.AddToInventory(action.item,1)  
							Game.GetTransactionSystem():AddItemToSlot(Game.GetPlayer(), TweakDBID.new("AttachmentSlots."..action.slot), ItemID.FromTDBID(TweakDBID.new(action.item)))
							else
							EquipGivenWeapon(enti, TweakDBID.new(action.item), true, "AttachmentSlots."..action.slot)
						end
						
						
					end
				end
				
				
				if(action.name == "unequip_item_on_slot") then
					local enti = nil
					local obj = nil 
					obj = getEntityFromManager(action.tag)
					enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil ) then
						
						if(action.tag =="player") then 
							Game.AddToInventory(action.item,1)  
							Game.GetTransactionSystem():RemoveItemFromSlot(Game.GetPlayer(), TweakDBID.new("AttachmentSlots."..action.slot), false,false,false)
							else
							UnEquipSlot(enti, true, "AttachmentSlots."..action.slot)
						end
						
						
					end
				end
				
				
				if(action.name == "equip_item") then
					
					equipItem(action.value)
					
				end
				
				if(action.name == "equip_transmog_item") then
					
					equipVisualItem(action.value)
					
				end
				
				if(action.name == "clear_transmog_slot") then
					
					clearVisualarea(action.value)
					
				end
				
				if(action.name == "unequip_item") then
					
					unequipItem(action.value)
					
				end
				
				if(action.name == "set_player_attribute") then
					
					setPlayerAttributes(action.value, action.score)
					
				end
				
				if(action.name == "set_player_skill") then
					
					setPlayerSkill(action.value, action.score)
					
				end
				
				if(action.name == "set_player_skill_progression") then
					
					setPlayerSkillProgression(action.value, action.score)
					
				end
				
				if(action.name == "set_player_perk") then
					
					setPlayerPerk(action.value, action.score)
					
				end
				
				
				
				if(action.name == "attitude_entity_against_entity") then
					if action.attitude == "hostile" then
						setAggressiveAgainst(action.tag, action.entity)
					end
					if action.attitude == "passive"   then
						setPassiveAgainst(action.tag, action.entity)
					end
					if action.attitude == "companion"   then
						setFollower(action.tag)
					end
					if action.attitude == "friendly"   then
						setFriendAgainst(action.tag, action.entity)
					end
					if action.attitude == "psycho" then
						setPsycho(action.tag, action.entity)
					end
				end
				
				if(action.name == "set_relation_between_attitude") then
					
					
					local EAIAttitude = Enum.new("EAIAttitude", "AIA_Hostile")
					
					
					if action.relation == "passive"   then
						EAIAttitude =Enum.new("EAIAttitude", "AIA_Neutral")
					end
					if action.relation == "friendly"   then
						EAIAttitude =Enum.new("EAIAttitude", "AIA_Friendly")
					end
					
					
					setAttitudeAgainstAttitude(action.attitude,action.target, EAIAttitude)
				end
				
				if(action.name == "set_relation_from_faction_to_attitude") then
					
					local faction = getFactionByTag(action.tag)
					
					
					if(faction ~= nil and faction.attitude_group ~= nil and #faction.attitude_group > 0) then
						
						for i,attitude in ipairs(faction.attitude_group) do
							
							local EAIAttitude = Enum.new("EAIAttitude", "AIA_Hostile")
							
							
							if action.relation == "passive"   then
								EAIAttitude =Enum.new("EAIAttitude", "AIA_Neutral")
							end
							if action.relation == "friendly"   then
								EAIAttitude =Enum.new("EAIAttitude", "AIA_Friendly")
							end
							
							setAttitudeAgainstAttitude(attitude,action.target, EAIAttitude)
						end
					end
					
				end
				
				if(action.name == "set_relation_from_faction_to_faction") then
					
					local faction = getFactionByTag(action.tag)
					
					local factiontarget = getFactionByTag(action.target)
					
					
					if(faction ~= nil and faction.attitude_group ~= nil and #faction.attitude_group > 0) and (factiontarget ~= nil and factiontarget.attitude_group ~= nil and #factiontarget.attitude_group > 0) then
						
						for i,attitude01 in ipairs(faction.attitude_group) do
							
							for i,attitude02 in ipairs(factiontarget.attitude_group) do
								
								
								
								local EAIAttitude = Enum.new("EAIAttitude", "AIA_Hostile")
								
								
								if action.relation == "passive"   then
									EAIAttitude =Enum.new("EAIAttitude", "AIA_Neutral")
								end
								if action.relation == "friendly"   then
									EAIAttitude =Enum.new("EAIAttitude", "AIA_Friendly")
								end
								
								setAttitudeAgainstAttitude(attitude01,attitude02, EAIAttitude)
								
								if action.target == getVariableKey("player","current_gang") and action.apply_player == true then
									
									Game.GetAttitudeSystem():SetAttitudeRelation(CName.new(attitude01), CName.new("player"), EAIAttitude)
									
								end
								
								
								
							end
						end
						
						
						
						
					end
					
				end
				
				
				if(action.name == "update_faction_relation_attitude") then
					
					for key01,gang01 in pairs(cyberscript.cache["faction"]) do
						
						for key02,gang02 in pairs(cyberscript.cache["faction"]) do
							
							local relation = getFactionRelation(gang01.data.tag,gang02.data.tag)
							
							if(relation == nil or relation == 0) then
								
								if(gang01.data ~= nil and gang01.data.attitude_group ~= nil and #gang01.data.attitude_group > 0) and (gang02.data ~= nil and gang02.data.attitude_group ~= nil and #gang02.data.attitude_group > 0) then
									
									for i,attitude01 in ipairs(gang01.data.attitude_group) do
										
										for i,attitude02 in ipairs(gang02.data.attitude_group) do
											
											
											
											local EAIAttitude = Enum.new("EAIAttitude", "AIA_Neutral")
											setAttitudeAgainstAttitude(attitude01,attitude02, EAIAttitude)
											
											if key02 == getVariableKey("player","current_gang") and action.apply_player == true then
												
												Game.GetAttitudeSystem():SetAttitudeRelation(CName.new(attitude01), CName.new("player"), EAIAttitude)
												
												
											end
										end
									end
								end
								
								
							end
							
							if(relation ~= nil and relation > 0) then
								
								if(gang01.data ~= nil and gang01.data.attitude_group ~= nil and #gang01.data.attitude_group > 0) and (gang02.data ~= nil and gang02.data.attitude_group ~= nil and #gang02.data.attitude_group > 0) then
									
									for i,attitude01 in ipairs(gang01.data.attitude_group) do
										
										for i,attitude02 in ipairs(gang02.data.attitude_group) do
											
											
											
											local EAIAttitude = Enum.new("EAIAttitude", "AIA_Friendly")
											setAttitudeAgainstAttitude(attitude01,attitude02, EAIAttitude)
											
											if key02 == getVariableKey("player","current_gang") and action.apply_player == true then
												
												Game.GetAttitudeSystem():SetAttitudeRelation(CName.new(attitude01), CName.new("player"), EAIAttitude)
												
												
											end
										end
									end
								end
								
								
							end
							
							if(relation ~= nil and relation < 0) then
								
								if(gang01.data ~= nil and gang01.data.attitude_group ~= nil and #gang01.data.attitude_group > 0) and (gang02.data ~= nil and gang02.data.attitude_group ~= nil and #gang02.data.attitude_group > 0) then
									
									for i,attitude01 in ipairs(gang01.data.attitude_group) do
										
										for i,attitude02 in ipairs(gang02.data.attitude_group) do
											
											
											
											local EAIAttitude = Enum.new("EAIAttitude", "AIA_Hostile")
											setAttitudeAgainstAttitude(attitude01,attitude02, EAIAttitude)
											
											
											if key02 == getVariableKey("player","current_gang") and action.apply_player == true then
												
												Game.GetAttitudeSystem():SetAttitudeRelation(CName.new(attitude01), CName.new("player"), EAIAttitude)
												
												
											end
											
										end
									end
								end
								
								
							end
							
							
						end
						
					end
					
				end
				
				
				
				
				if(action.name == "play_entity_voice") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						talk(enti,action.voice)
					end
				end
				if(action.name == "toggle_immortal_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						if(action.tag == "player") then
							if (action.immortal == true) then
								
								Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Invulnerable", CName.new("SecondHeart"))
								if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
									local veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
									if veh then
										Game.GetGodModeSystem():AddGodMode(veh:GetEntityID(), "Invulnerable", CName.new("Default"))
									end
								end
								else
								local hasSecondHeart = false
								local ssc = Game.GetScriptableSystemsContainer()
								local es = ssc:Get(CName.new('EquipmentSystem'))
								local espd = es:GetPlayerData(Game.GetPlayer())
								espd['GetItemInEquipSlot2'] = espd['GetItemInEquipSlot;gamedataEquipmentAreaInt32']
								for i=0,2 do
									if espd:GetItemInEquipSlot2("CardiovascularSystemCW", i).tdbid.hash == 3619482064 then
										hasSecondHeart = true
									end
								end
								if hasSecondHeart then
									Game.GetGodModeSystem():EnableOverride(Game.GetPlayer():GetEntityID(), "Immortal", CName.new("SecondHeart"))
									else
									Game.GetGodModeSystem():DisableOverride(Game.GetPlayer():GetEntityID(), CName.new("SecondHeart"))
								end
								if Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer()) then
									local veh = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
									if veh then
										Game.GetGodModeSystem():ClearGodMode(veh:GetEntityID(), CName.new("Default"))
									end
								end
								
							end
							else
							ToggleImmortal(enti, action.immortal)
						end
					end
					
					
					
				end
				
				if(action.name == "toggle_infinite_stamina") then
					InfiniteStamina(action.value)
					
				end
				if(action.name == "toggle_infinite_ammo") then
					if(action.value == true) then
						Game.GetInventoryManager().AddEquipmentStateFlag(Game.GetInventoryManager(),gameEEquipmentManagerState.InfiniteAmmo)
						local player = Game.GetPlayer()
						local activeWeapon = GameObject.GetActiveWeapon(player)
						-- The gist behind this is:
						-- Reload the weapon in 0 seconds, end the reload
						GameObject.GetActiveWeapon(player).StartReload(activeWeapon,0)
						GameObject.GetActiveWeapon(player).StopReload(activeWeapon,gameweaponReloadStatus.Standard)
						else
						Game.GetInventoryManager().RemoveEquipmentStateFlag(Game.GetInventoryManager(),gameEEquipmentManagerState.InfiniteAmmo)
						local player = Game.GetPlayer()
						local activeWeapon = GameObject.GetActiveWeapon(player)
						-- The gist behind this is:
						-- Reload the weapon in 0 seconds, end the reload
						GameObject.GetActiveWeapon(player).StartReload(activeWeapon,0)
						GameObject.GetActiveWeapon(player).StopReload(activeWeapon,gameweaponReloadStatus.Standard)
					end
					
				end
				if(action.name == "play_entity_facial") then
					
					
					local reaction = getExpression(action.value)
					
					makeFacial(action.tag,reaction)
					
				end
				if(action.name == "fake_lips_sync") then
					
					local actionlist = {}
					local possibility = {}
					local val = 30
					
					local actionb = deepcopy(cyberscript.actiontemplate["play_entity_facial"])
					actionb.value = "Surprise"
					actionb.tag = action.tag
					table.insert(actionlist,actionb)
					
					local actionb = deepcopy(cyberscript.actiontemplate["wait_tick"])
					actionb.value = val
					table.insert(actionlist,actionb)
					
					
					for i=1, (action.duration*3) do
						
						if(i%2==0) then
							possibility = {"Interested"}
							val = math.random(20,30)
							else
							
							
							possibility = {"Terrified","Fear"}
							val = math.random(50,70)
							
							
							
						end
						local actionb = deepcopy(cyberscript.actiontemplate["play_entity_facial"])
						actionb.value = possibility[math.random(1,#possibility)]
						actionb.tag = action.tag
						table.insert(actionlist,actionb)
						
						local actionb = deepcopy(cyberscript.actiontemplate["wait_tick"])
						actionb.value = val
						table.insert(actionlist,actionb)
						
					end
					
					local actionb = deepcopy(cyberscript.actiontemplate["reset_entity_facial"])
					actionb.tag = action.tag
					table.insert(actionlist,actionb)
					
					if(action.parallele ~= false)then
   						
						
						
   						runActionList(actionlist, "fake_lips_sync_async_action_"..tostring(math.random(1,987987)), "see",false,nil)
						
						else
						
						runSubActionList(actionlist, tag.."_fake_lips_sync_async_action_"..tostring(math.random(1,987987)) ,parent,source,false,exector)
   						result=false
					end
					
				end
				if(action.name == "reset_entity_facial") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						resetFacial(enti)
					end
				end
				if(action.name == "look_at_entity_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						if(action.entity == "player") then
							lookAtPlayer(enti)
							else
							lookAtEntity(enti,action.entity,action.duration)
						end
					end
				end
				if(action.name == "reset_lookat_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						resetLookAt(enti)
					end
				end
				if(action.name == "player_look_at_entity") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						print("tt")
						local post = enti:GetWorldPosition()
						playerLookAtDirection(post.x, post.y, post.z)
						
					end
				end
				if(action.name == "player_look_at_position") then
					playerLookAtDirection(action.x, action.y,action.z)
					
				end
				if(action.name == "player_look_at_rotation") then
					Game.GetPlayer():GetFPPCameraComponent().pitchMin = pitch - 0.01 -- Use pitchMin/Max to set pitch, needs to have a small difference between Min and Max
					Game.GetPlayer():GetFPPCameraComponent().pitchMax = pitch
					Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition() , EulerAngles.new(action.roll,action.pitch,action.yaw)) -- Set yaw when teleporting
				end
				if(action.name == "player_move_head_to_position") then
					
					local player = Game.GetPlayer()
					
					local direction = {}
					direction.x = action.x
					direction.y = action.y
					direction.z = action.z
					direction.w = 1
					
					local dirVector = diffVector(player:GetWorldPosition(), direction)
					local angle = GetSingleton('Vector4'):ToRotation(dirVector)
					
					local pitch = angle.pitch
					local yaw = angle.yaw 
					
					local oldangle = GetSingleton('Vector4'):ToRotation(player:GetWorldPosition())
					
					local how = angle.yaw -oldangle.yaw
					logme(10,how)
					local actionlist = {}
					for i=1,0-how do
						local newaction = {}
						newaction.name = "player_look_at_rotation"
						
						newaction.roll = angle.roll
						newaction.pitch = angle.pitch
						newaction.yaw = oldangle.yaw+i
						table.insert(actionlist,newaction)
						
						local newaction = {}
						newaction.name = "wait_second"
						
						newaction.value = 0.1
						table.insert(actionlist,newaction)
						
					end
					runSubActionList(actionlist, tag.."_forlist", tag,source,false,executortag)
				end
				if(action.name == "player_look_at_forward") then
					local position = getForwardPosition(Game.GetPlayer(),5)
					playerLookAtDirection(position.x, position.y,position.z)
					Game.GetPlayer():GetFPPCameraComponent().pitchMin = pitch - 0.01 -- Use pitchMin/Max to set pitch, needs to have a small difference between Min and Max
					Game.GetPlayer():GetFPPCameraComponent().pitchMax = pitch
					Game.GetTeleportationFacility():Teleport(Game.GetPlayer(), Game.GetPlayer():GetWorldPosition() , EulerAngles.new(0,0,yaw)) -- Set yaw when teleporting
				end
				if(action.name == "rotate_player_camera") then
					--EulerAngles.new(ROLL,PITCH, YAW)
					--https://en.wikipedia.org/wiki/Aircraft_principal_axes#/media/File:Yaw_Axis_Corrected.svg
					Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(90, 0, 0)))
				end
				if(action.name == "player_look_at_unlock") then
					freezeCamera =  false
				end
				if(action.name == "set_entity_appearance") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						--logme(3,"go")
						
						setAppearance(enti,action.appearance)
					end
				end
				if(action.name == "swap_character") then
					swapEntity(action.target,action.swap)
				end
				if(action.name == "swap_character_current_star") then
					if(currentStar ~= nil) then
						swapEntity(action.target,currentStar.TweakIDs)
					end
				end
				if(action.name == "change_character_preset") then
					changePreset(action.target,action.preset)
				end
				if(action.name == "freeze_player") then
					local blackboardDefs = Game.GetAllBlackboardDefs()
					local blackboardPSM = Game.GetBlackboardSystem():GetLocalInstanced(Game.GetPlayer():GetEntityID(), blackboardDefs.PlayerStateMachine)
					local test = blackboardPSM:GetInt(blackboardDefs.PlayerStateMachine.SceneTier)
					blackboardPSM:SetInt(blackboardDefs.PlayerStateMachine.SceneTier, 5, true) -- GameplayTier.Tier5_Cinematic
					times = Game.GetTimeSystem()
					times:SetIgnoreTimeDilationOnLocalPlayerZero(false)
					Game.GetTimeSystem():SetTimeDilation("cyberscript", 0.0000000000001)
				end
				if(action.name == "unfreeze_player") then
					local blackboardDefs = Game.GetAllBlackboardDefs()
					local blackboardPSM = Game.GetBlackboardSystem():GetLocalInstanced(Game.GetPlayer():GetEntityID(), blackboardDefs.PlayerStateMachine)
					blackboardPSM:SetInt(blackboardDefs.PlayerStateMachine.SceneTier, 1, true) -- GameplayTier.Tier1_FullGameplay 
					Game.GetTimeSystem():SetTimeDilation("cyberscript", 0)
				end
				if(action.name == "apply_effect") then
					if(action.tag == "player") then
						ApplyEffectOnPlayer(action.value)
						else
						local obj = getEntityFromManager(action.tag)
						local enti = Game.FindEntityByID(obj.id)
						
						StatusEffectHelper.ApplyStatusEffectForTimeWindow(enti, TweakDBID.new(action.value),obj.id, 0,1000)
					end
				end
				if(action.name == "remove_effect") then
					if(action.tag == "player") then
						RemoveEffectPlayer(action.value)
						else
						local obj = getEntityFromManager(action.tag)
						Game.RemoveStatusEffect(obj.id,TweakDBID.new(action.value))
					end
				end
				if(action.name == "set_timedilationforplayer") then
					TimeDilationHelper.SetTimeDilationOnPlayer(Game.GetPlayer(), "see_engine", action.value, 99999, "", "");
				end
				
				if(action.name == "ignore_timedilatationforplayer") then
					Game.GetTimeSystem():SetIgnoreTimeDilationOnLocalPlayerZero(action.value)  
				end
				
				if(action.name == "unset_timedilation_for_entity") then
					local obj = getEntityFromManager(action.tag)
					if(obj ~= nil ) then
						local enti = Game.FindEntityByID(obj.id)
						
						if enti ~= nil then
							TimeDilationHelper.UnsetIndividualTimeDilation(enti, "");
						end
					end
				end
				
				if(action.name == "set_timedilation") then
					Game.GetTimeSystem():SetTimeDilation("cyberscript", action.value)
					Game.GetTimeSystem():SetTimeDilation("cyberscript", action.value);
				end
				if(action.name == "set_timedilation_for_entity") then
					
					local obj = getEntityFromManager(action.tag)
					if(obj ~= nil ) then
						local enti = Game.FindEntityByID(obj.id)
						
						if enti ~= nil then
							
							TimeDilationHelper.SetIndividualTimeDilation(enti, "see_engine", action.value, 99999, "", "");
							
						end
					end
				end
				if(action.name == "change_camera_position") then
					local fppComp = Game.GetPlayer():GetFPPCameraComponent()
					fppComp:SetLocalPosition(Vector4:new(action.x, action.y, action.z, 1.0))
				end
				if(action.name == "change_camera_rotation") then
					local fppComp = Game.GetPlayer():GetFPPCameraComponent()
					fppComp:SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(action.roll, action.pitch, action.yaw)))
				end
				if(action.name == "add_camera_position") then
					local fppComp = Game.GetPlayer():GetFPPCameraComponent()
					local pos = fppComp:GetLocalPosition()
					pos.x = pos.x + action.x
					pos.y = pos.y + action.y
					pos.x = pos.z + action.z
					fppComp:SetLocalPosition(Vector4:new(pos.x, pos.y, pos.z, 1.0))
				end
				if(action.name == "add_camera_rotation") then
					local fppComp = Game.GetPlayer():GetFPPCameraComponent()
					local pos = fppComp:GetLocalOrientation()
					local rot = GetSingleton('Quaternion'):ToEulerAngles(pos)
					rot.yaw = rot.yaw + action.yaw
					rot.pitch = rot.pitch + action.pitch
					rot.roll = rot.roll + action.roll
					fppComp:SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(rot.roll, rot.pitch, rot.yaw)))
				end
				if(action.name == "reset_camera") then
					local fppComp = Game.GetPlayer():GetFPPCameraComponent()
					fppComp:SetLocalPosition(Vector4:new(0, 0, 0, 1.0))
					fppComp:SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(0, 0, 0)))
				end
				if(action.name == "execute_at_script_level") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						if(obj.scriptlevel == nil or obj.scriptlevel <= action.scriptlevel) then
							
							runSubActionList(action.action, tag.."_execute_at_level", tag,source,false,obj.tag)
							
						end
					end
					
				end
				
				if(action.name == "set_script_level") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						obj.scriptlevel = action.scriptlevel 
						
					end
					
				end
				
				if(action.name == "player_toggle_invisible") then
					PlayerToggleInvisible(action.value)
				end
				
				if(action.name == "player_toggle_v_component_visibility") then
					toggleVBodyComponent(action.value)
				end
				
				if(action.name == "spawn_item") then
					local chara = ""
					if(action.amount == nil) then
						action.amount = 1
					end
					if(action.amount == 0) then
						action.amount = math.random(1,6)
					end
					for i=1,action.amount do
						
						
						chara = action.path
						
						
						
						local tag = action.tag
						if(action.amount > 1) then
							tag = action.tag.."_"..i
						end
						local position = getPositionFromParameter(action)
						if(chara ~= "" and chara ~= nil and position.x ~= nil) then
							
							local spawnedItem = {}
							
							spawnedItem.Tag = tag
							spawnedItem.HouseTag = ""
							spawnedItem.ItemPath = chara
							spawnedItem.X = position.x
							spawnedItem.Y = position.y
							spawnedItem.Z = position.z
							
							spawnedItem.Yaw = action.yaw
							spawnedItem.Pitch = action.pitch
							spawnedItem.Roll = action.roll
							spawnedItem.Title = chara
							
							local angles = EulerAngles.new(spawnedItem.Yaw,spawnedItem.Pitch,spawnedItem.Roll)
							local posVec4 = Vector4.new(position.x, position.y, position.z,1)
							spawnedItem.entityId = spawnItem(spawnedItem, posVec4, angles)
							local entity = Game.FindEntityByID(spawnedItem.entityId)
							local components = checkForValidComponents(entity)
							if components then
								local visualScale = checkDefaultScale(components)
								spawnedItem.defaultScale = {
									x = visualScale.x * 100,
									y = visualScale.x * 100,
									z = visualScale.x * 100,
								}
								spawnedItem.scale = {
									x = visualScale.x * 100,
									y = visualScale.y * 100,
									z = visualScale.z * 100,
								}
							end
							if(action.isentity == nil or action.isentity == false) then
								
								
								
								table.insert(currentItemSpawned,spawnedItem)
								
								else
								
								local entity = {}
								entity.id = spawnedItem.entityId
								entity.tag = tag
								entity.tweak = chara
								entity.isprevention = false
								entity.scriptlevel = 0
								
								entity.isMP = false
								entity.name = tag
								cyberscript.EntityManager[tag]=entity
								
								
							end
							
							
							logme(10,"spawn item. item tweak : "..chara.." position : "..dump(spawnedItem))
							spdlog.error("spawn item. item tweak : "..chara.." position : "..dump(spawnedItem))
							else
							error("bad item or position. item tweak : "..chara.." position : "..dump(position))
						end
					end
				end
				
				if(action.name == "despawn_item") then
					for i=1,#currentItemSpawned do
						if(currentItemSpawned[i].Tag == action.tag) then
							despawnItem(currentItemSpawned[i].entityId)
						end
						
					end
				end
				
				if(action.name == "set_entity_stat") then
					--https://nativedb.red4ext.com/gamedataStatType
					--https://nativedb.red4ext.com/gameStatModifierType
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					
					if(enti ~= nil) then
						
						
						
						local newMod = gameConstantStatModifierData.new()
						newMod.statType = Enum.new('gamedataStatType', action.stat)
						newMod.modifierType = Enum.new('gameStatModifierType', action.modifierType)
						newMod.value = action.value
						
						Game.GetStatsSystem():AddModifier(obj.id,newmod)
					end
				end
				
				
				
				if(action.name == "for_entity_around_you") then
					
					player = Game.GetPlayer()
					targetingSystem = Game.GetTargetingSystem()
					parts = {}
					local success= false
					searchQuery = Game["TSQ_ALL;"]() -- Search ALL objects
					searchQuery.maxDistance = action.range
					success, parts = targetingSystem:GetTargetParts(Game.GetPlayer(), searchQuery)
					
					cyberscript.GroupManager["temp_around_group"] = {}
					cyberscript.GroupManager["temp_around_group"].tag = "temp_around_group"
					cyberscript.GroupManager["temp_around_group"].entities = {}
					
					
					for _, v in ipairs(parts) do
						local newent = v:GetComponent(v):GetEntity() 
						
						local goodEntity = false
						
						if(action.filter ~= nil and #action.filter > 0) then 
							
							
							local entName = newent:ToString()
							local entAppName = Game.NameToString(newent:GetCurrentAppearanceName())
							local entDispName = newent:GetDisplayName()
							
							if(entName ~= nil and entAppName ~= nil)then
								for i,filter in ipairs(action.filter) do
									
									if(goodEntity == false and string.match(entName, filter) or string.match(entAppName, filter) or string.match(entDispName, filter))then 
										goodEntity = true
									end
								end
							end
							
							
							
							else
							
							goodEntity = true
							
						end
						
						
						local tag = "scripted_around_"..math.random(0,9999)
						local obj = getEntityFromManager(tag)
						
						if (obj.id == nil and goodEntity == true) then
							
							
							local entity = {}
							entity.id = newent:GetEntityID()
							entity.tag = tag
							entity.tweak = "None"
							entity.iscompanion = false
							
							cyberscript.EntityManager[tag]=entity
							if(action.group == nil or action.group == "") then
								
								table.insert(cyberscript.GroupManager["temp_around_group"].entities,entity.tag)
								
								else
								
								
								if(cyberscript.GroupManager[action.group] ~= nil) then
									table.insert(cyberscript.GroupManager[action.group].entities,entity.tag)
									else
									
									error("no group founded")
									
								end
								
							end
							obj = entity
							
							if(#action.action > 0) then
								
								runSubActionList(action.action, tag.."_forentitylist",parent,source,false,entity.tag,false)
							end
						end
						
						
						
					end
					
					
				end
				
				
			end
			
			if scannerregion then
				
				if(action.name == "set_scannerdata") then
					
					
					
					ScannerInfoManager[action.tag] = {}
					ScannerInfoManager[action.tag].primaryname = getLang(action.primaryname)
					ScannerInfoManager[action.tag].secondaryname = getLang(action.secondaryname)
					ScannerInfoManager[action.tag].level = action.level
					ScannerInfoManager[action.tag].rarity = action.rarity
					ScannerInfoManager[action.tag].faction = action.faction
					ScannerInfoManager[action.tag].networkstate = ""
					ScannerInfoManager[action.tag].text = getLang("cyberscript_scanner_"..action.text)
					--	--print(action.text)
					ScannerInfoManager[action.tag].attitude = action.attitude
					
					if(action.bounty ~= nil) then
						ScannerInfoManager[action.tag].bounty = action.bounty
						ScannerInfoManager[action.tag].bounty.issuedby = getLang(action.bounty.issuedby)
					end
					
					
					
					
					
					
				end
				if(action.name == "give_reward_from_scannerdata") then
					if(ScannerInfoManager[action.tag] ~= nil and ScannerInfoManager[action.tag].bounty ~= nil) then
						
						local player = Game.GetPlayer()
						local ts = Game.GetTransactionSystem()
						local tid = TweakDBID.new("Items.money")
						local itemid = ItemID.new(tid)
						local amount = tonumber(ScannerInfoManager[action.tag].bounty.reward)
						
						local result = ts:GiveItem(player, itemid, amount)
						
						Game.GetStatPoolsSystem():RequestChangingStatPoolValue(Game.GetPlayer():GetEntityID(), 948, ScannerInfoManager[action.tag].bounty.streetreward, Game.GetPlayer(), true, false)
						
						
						
					end
					
				end
				
				if(action.name == "edit_scannerdata") then
					
					
					if(
						action.prop == "primaryname" 
						or action.prop == "secondaryname" 
						or action.prop == "text" 
						or action.prop == "level" 
						or action.prop == "rarity"
						or action.prop == "faction"
						or action.prop == "attitude"
					) then
					
					if('string' == type(action.value)) then
						
						ScannerInfoManager[action.tag][action.prop] = getLang(action.value)
						else
						
						
						
						
						ScannerInfoManager[action.tag][action.prop] = action.value
					end
					
					end
					
					
					if(
						action.prop == "danger" 
						or action.prop == "reward" 
						or action.prop == "streetreward" 
						or action.prop == "issuedby"
					) then
					
					if(ScannerInfoManager[action.tag].bounty == nil) then
						ScannerInfoManager[action.tag].bounty = {}
						ScannerInfoManager[action.tag].bounty.danger = 0
						ScannerInfoManager[action.tag].bounty.reward = 0
						ScannerInfoManager[action.tag].bounty.streetreward = 0
						ScannerInfoManager[action.tag].bounty.issuedby = "Unknown"
						ScannerInfoManager[action.tag]["bounty"]["transgressions"] = {}
						ScannerInfoManager[action.tag]["bounty"]["customtransgressions"] = {}
						
					end
					
					if('string' == type(action.value)) then
						
						ScannerInfoManager[action.tag]["bounty"][action.prop] = getLang(action.value)
						else
						
						if(action.prop == "reward" or action.prop == "streetreward" ) then
							if(action.operator == "+") then
								ScannerInfoManager[action.tag]["bounty"][action.prop] = ScannerInfoManager[action.tag]["bounty"][action.prop] + action.value
							end
							if(action.operator == "-") then
								ScannerInfoManager[action.tag]["bounty"][action.prop] = ScannerInfoManager[action.tag]["bounty"][action.prop] - action.value
							end
							if(action.operator == "*") then
								ScannerInfoManager[action.tag]["bounty"][action.prop] = ScannerInfoManager[action.tag]["bounty"][action.prop] * action.value
							end
							if(action.operator == "/") then
								ScannerInfoManager[action.tag]["bounty"][action.prop] = ScannerInfoManager[action.tag]["bounty"][action.prop] / action.value
							end
							if(action.operator == "positive") then
								if(ScannerInfoManager[action.tag]["bounty"][action.prop] > 0) then
									ScannerInfoManager[action.tag]["bounty"][action.prop] = 0 + ScannerInfoManager[action.tag]["bounty"][action.prop]
									else
									ScannerInfoManager[action.tag]["bounty"][action.prop] = 0 - ScannerInfoManager[action.tag]["bounty"][action.prop]
								end
							end
							if(action.operator == "negative") then
								if(ScannerInfoManager[action.tag]["bounty"][action.prop] > 0) then
									ScannerInfoManager[action.tag]["bounty"][action.prop] = 0 - ScannerInfoManager[action.tag]["bounty"][action.prop]
									else
									ScannerInfoManager[action.tag]["bounty"][action.prop] = 0 + ScannerInfoManager[action.tag]["bounty"][action.prop]
								end
							end
							if(action.operator == "random") then
								ScannerInfoManager[action.tag]["bounty"][action.prop] = math.random(action.min,action.max)
							end
							
							if(action.operator == "" or action.operator == "=" or action.operator == nil) then
								ScannerInfoManager[action.tag]["bounty"][action.prop] = action.value
							end
							else
							ScannerInfoManager[action.tag]["bounty"][action.prop] = action.value
						end
						
						
					end
					
					
					end
					
					if(
						action.prop == "transgressions" 
						or action.prop == "customtransgressions" 
						
					) then
					
					if(ScannerInfoManager[action.tag].bounty == nil) then
						ScannerInfoManager[action.tag].bounty = {}
						ScannerInfoManager[action.tag].bounty.danger = 0
						ScannerInfoManager[action.tag].bounty.reward = 0
						ScannerInfoManager[action.tag].bounty.streetreward = 0
						ScannerInfoManager[action.tag].bounty.issuedby = "Unknown"
						ScannerInfoManager[action.tag]["bounty"]["transgressions"] = {}
						ScannerInfoManager[action.tag]["bounty"]["customtransgressions"] = {}
						
					end
					
					
					
					ScannerInfoManager[action.tag]["bounty"][action.prop] = action.value
					
					
					
					end
					
					
					
					
					
					
					
				end
				
				if(action.name == "delete_scannerdata") then
					
					
					ScannerInfoManager[action.tag] = nil
					
					
					
					
					
				end
				
				
			end
			
			if animationregion then
				if action.name == "play_anim_entity" then
					
					local angle = nil
					
					if(action.yaw ~= nil and action.roll ~= nil and action.pitch ~= nil ) then
						
						angle = {}
						angle.yaw = action.yaw
						angle.roll = action.pitch
						angle.roll = action.pitch
						
						
					end
					
					
					spawnAnimationWorkspot(action.tag,action.anim,"cyberscript_workspot_base",action.isinstant,action.unlockcamera,angle)
				end
				
				if action.name == "play_custom_anim_entity" then
					
					local angle = nil
					
					if((action.angle == true or action.angle == nil) and action.yaw ~= nil and action.roll ~= nil and action.pitch ~= nil ) then
						
						angle = {}
						angle.yaw = action.yaw
						angle.pitch = action.pitch
						angle.roll = action.roll
						
						
					end
					
					spawnCustomAnimationWorkspot(action.tag,action.ent,action.anim,action.workspot,action.isinstant,action.unlockcamera,angle)
				end
				
				
				
				if action.name == "change_anim_entity" then
					
					
					
					changeWorkSpotAnims(action.tag,action.anim,action.isinstant)
				end
				
				if action.name == "change_anim_entity_workspot" then
					
					
					changeWorkSpot(action.tag,action.workspottag,action.workspot,action.unlockcamera)
					
					
				end
				
				if action.name == "stop_anim_entity" then
					
					
					
					stopWorkSpotAnims(action.tag)
				end
			end
			
			if logicregion then
				if(action.name == "if") then
					checkIf(action,tag,source,executortag)
					result = false
				end
				if(action.name == "lightif") then
					local trigger = action.trigger
					if(checkTrigger(trigger)) then
						for i=1,#action.if_action do
							local actiontodo = action.if_action[i]
							executeAction(actiontodo,tag,parent,index,source,executortag)
						end
						else
						for i=1,#action.else_action do
							local actiontodo = action.else_action[i]
							actiontodo(actiontodo,tag,parent,index,source,executortag)
						end
					end
				end
				if(action.name == "for") then
					local actionlist = {}
					if(action.amount > 0) then
						for i=1,action.amount do
							for y=1, #action.action do 
								table.insert(actionlist,action.action[y])
							end
						end
						
						--logme(3,#actionlist)
						--doActionofIndex(actionlist,"interact",listaction,currentindex)
						runSubActionList(actionlist, tag.."_forlist", tag,source,false,executortag)
						result = false
					end
				end
				if(action.name == "clean_thread") then
					workerTable[action.tag] = nil
				end
				if(action.name == "wait") then
					local temp = getGameTime()
					local nexttemp = temp
					nexttemp.min = nexttemp.min + action.value
					if(nexttemp.min > 60) then
						nexttemp.min = nexttemp.min-60
						nexttemp.hour = nexttemp.hour+1
					end
					if(nexttemp.hour == 25)then
						nexttemp.hour = 1
					end
					if(nexttemp.hour == 0)then
						nexttemp.hour = 24
					end
					nexttemp.hour = nexttemp.hour
					action.hour = nexttemp.hour
					action.min = nexttemp.min
					result = false
				end
				if(action.name == "wait_second") then
					local temp = os.time(os.date("!*t"))+0 
					--logme(3,temp)
					local nexttemp = temp
					--logme(3,math.ceil((action.value*60)))
					nexttemp =nexttemp +  math.ceil(action.value)
					--logme(3,nexttemp)
					action.tick = nexttemp
					result = false
				end
				if(action.name == "wait_tick") then
					local temp = tick
					--logme(3,temp)
					local nexttemp = temp
					--logme(3,math.ceil((action.value*60)))
					nexttemp =nexttemp + action.value
					--logme(3,nexttemp)
					action.tick = nexttemp
					result = false
				end
				if(action.name == "wait_for_trigger") then
					result = false
				end
				if(action.name == "wait_for_framework") then
					
					result = false
				end
				if(action.name == "wait_for_ai_answer") then
					
					result = false
				end
				if(action.name == "wait_for_target") then
					result = false
				end
				if(action.name == "wait_for_selection") then
					enableEntitySelection = true
					entitySelectionIsVehicule = action.isvehicule
					selectionSlot = action.slot
					result = false
				end
				if(action.name == "clean_selection") then
					if(action.slot == 1) then
						local obj = getEntityFromManager("selection")
						obj.id = nil
					end
					if(action.slot == 2) then
						local obj = getEntityFromManager("selection2")
						obj.id = nil
					end
					if(action.slot == 3) then
						local obj = getEntityFromManager("selection3")
						obj.id = nil
					end
					if(action.slot == 4) then
						local obj = getEntityFromManager("selection4")
						obj.id = nil
					end
					if(action.slot == 5) then
						local obj = getEntityFromManager("selection5")
						obj.id = nil
					end
				end
				if(action.name == "clean_all_selection") then
					local obj = getEntityFromManager("selection")
					obj.id = nil
					obj = getEntityFromManager("selection2")
					obj.id = nil
					obj = getEntityFromManager("selection3")
					obj.id = nil
					obj = getEntityFromManager("selection4")
					obj.id = nil
					obj = getEntityFromManager("selection5")
					obj.id = nil
				end
				if(action.name == "do_random_event")then
					local tago = math.random(1,#action.events)
					local boj = cyberscript.cache["event"][action.events[tago]]
					if( boj ~= nil) then
						local event = boj.data
						if(action.bypass ~= nil and action.bypass == true) then
							logme(3,"Doing event : "..event.name)
							if(action.parallele == nil or action.parallele == false)then
								runSubActionList(event.action, tag.."_event_"..action.value, tag,source,false,executortag)
								result=false
								else
								runActionList(event.action, action.value, tag,source,false,executortag)
							end
							else
							local trigger = event.trigger 
							if(checkTriggerRequirement(event.requirement,trigger))then
								--logme(3,"check for "..data2.name)
								logme(3,"Doing event : "..event.name)
								if(action.parallele == nil or action.parallele == false)then
									runSubActionList(event.action, tag.."_event_"..action.value, tag,source,false,executortag)
									result=false
									else
									runActionList(event.action, action.value, tag,source,false,executortag)
								end
								else
								logme(3,"can't do event : "..event.name)
							end
						end
					end
					
				end
				if(action.name == "while_one") then
					result = false
				end
				if(action.name == "do_event") then
					local boj = cyberscript.cache["event"][action.value]
					logme(3,action.value)
					if( boj ~= nil) then
						local event = boj.data
						
						
						if(action.bypass ~= nil and action.bypass == true) then
							logme(3,"Doing event : "..event.name)
							if(action.parallele == nil or action.parallele == false)then
								runSubActionList(event.action, tag.."_event_"..action.value, tag,source,false,executortag)
								result=false
								else
								runActionList(event.action, action.value, tag,source,false,executortag)
							end
							
							else
							local trigger = event.trigger
							if(checkTriggerRequirement(event.requirement,trigger))then
								--logme(3,"check for "..data2.name)
								logme(3,"Doing event : "..event.name)
								if(action.parallele == nil or action.parallele == false)then
									runSubActionList(event.action, tag.."_event_"..action.value, tag,source,false,executortag)
									result=false
									else
									runActionList(event.action, action.value, tag,source,false,executortag)
								end
								else
								logme(3,"can't do event : "..event.name)
							end
						end
						
					end
					
				end
				if(action.name == "do_function") then
					local boj = cyberscript.cache["functions"][action.value]
					if( boj ~= nil) then
						local event = boj.data
						if( boj ~= nil) then
							local exector = executortag
							local bypassmenu = false
							if action.bypassmenu ~= nil then bypassmenu = action.bypassmenu end
							if(action.applyto ~= nil and action.applyto ~= "")then
								exector = action.applyto
							end
							
							if(action.repeats == nil or action.repeats < 2) then
								if(action.parallele == nil or action.parallele == false)then
									
									
									runSubActionList(event.action, tag.."_event_"..action.value, tag,source,false,exector,bypassmenu)
									
									result=false
									else
									runActionList(event.action,action.value,source,false,exector,bypassmenu)
									
									
								end
								else
								
								local actionlist = {}
								
								for i=1,action.repeats do
									for y=1, #event.action do 
										table.insert(actionlist,event.action[y])
									end
								end
								
								
								if(action.parallele == nil or action.parallele == false)then
									
									runSubActionList(actionlist, tag.."_event_"..action.value, tag,source,false,exector,bypassmenu)
									
									result=false
									else
									
									runActionList(actionlist,action.value,source,false,exector,bypassmenu)
									
									
								end
								
								
							end
						end
						
					end
					
				end
				if(action.name == "goto") then
					local index = workerTable[tag]["index"]
					local list = workerTable[tag]["action"]
					local parent = workerTable[tag]["parent"]
					local pending = workerTable[tag]["pending"]	
					
					if(list[index].parent == true) then
						logme(3,"Go to"..action.index.." of "..parent)
						workerTable[parent]["index"] = action.index-1
						workerTable[tag]["index"] = workerTable[tag]["index"]+1
						workerTable[parent]["pending"] =  false
						tag = parent
						else
						logme(3,"Go to"..action.index.." of "..tag)
						workerTable[tag]["index"] = action.index 
					end
				end
				
				
				if(action.name == "goto_alias") then
					
					local index = workerTable[tag]["index"]
					local list = workerTable[tag]["action"]
					local parent = workerTable[tag]["parent"]
					local pending = workerTable[tag]["pending"]	
					
					
					for i,v in ipairs(list) do
						
						if(action.tag == v.alias) then
							
							if(list[index].parent == true) then
								logme(3,"Go to"..i.." of "..parent.."(alias :"..v.tag..")")
								workerTable[parent]["index"] = i-1
								workerTable[tag]["index"] = workerTable[tag]["index"]+1
								workerTable[parent]["pending"] =  false
								tag = parent
								else
								logme(3,"Go to"..i.." of "..tag.."(alias :"..v.tag..")")
								workerTable[tag]["index"] = i
							end
							
						end
						
					end
					
				end
				
				if(action.name == "do_random_function")then
					local tago = math.random(1,#action.funcs)
					logme(1,action.funcs[tago])
					local boj = cyberscript.cache["functions"][action.funcs[tago]]
					if( boj ~= nil) then
						
						
						local exector = executortag
						
						
						if(action.applyto ~= nil and action.applyto ~= "")then
							exector = action.applyto
						end
						
						if(action.parallele == nil or action.parallele == false)then
							runSubActionList(boj.data.action, tag.."_event_"..tago,parent,source,false,exector)
							result=false
							else
							runActionList(boj.data.action,tago,source,false,exector)
						end
					end
					
				end
				
				
				if(action.name == "subscribe_event_to_direct_execution") then
					local boj = cyberscript.cache["event"][action.tag]
					
					if( boj ~= nil) then
						local event = boj.data
						local trigger = event.trigger
						if(checkTriggerRequirement(event.requirement,trigger))then
							local obj = {}
							obj.actionlist = event.action
							obj.tag = event.tag
							obj.after = action.after
							
							
							directWorkerTable[action.tag] = obj
						end
						
					end
					
					
					
					
					
				end
				
				if(action.name == "subscribe_actionlist_to_direct_execution") then
					local obj = {}
					obj.actionlist = action.action
					obj.tag = action.tag
					obj.after = action.after
					directWorkerTable[action.tag] = obj
					
				end
				
				if(action.name == "subscribe_function_to_direct_execution") then
					local boj = cyberscript.cache["functions"][action.tag]
					
					if( boj ~= nil) then
						local functio = boj.data
						
						local obj = {}
						obj.actionlist = functio.action
						obj.tag = event.tag
						obj.after = action.after
						
						
						directWorkerTable[action.tag] = obj
						
						
					end
					
					
					
					
					
				end
				
				if(action.name == "unsubscribe_from_direct_execution") then
					
					directWorkerTable[action.tag] = nil
					
				end
				
				if(action.name == "subscribe_actionlist_to_direct_action") then
					local obj = {}
					obj.actionlist = action.action
					obj.tag = action.tag
					obj.after = action.after
					directActionsWorkerTable[action.tag] = obj
					
				end
				
				
				
				
				if(action.name == "subscribe_event_to_direct_action") then
					local boj = cyberscript.cache["event"][action.tag]
					
					if( boj ~= nil) then
						local event = boj.data
						local trigger = event.trigger
						if(checkTriggerRequirement(event.requirement,trigger))then
							local obj = {}
							obj.actionlist = event.action
							obj.tag = event.tag
							obj.after = action.after
							
							
							directActionsWorkerTable[action.tag] = obj
						end
						
					end
					
					
					
					
					
				end
				
				if(action.name == "subscribe_function_to_direct_action") then
					local boj = cyberscript.cache["functions"][action.tag]
					
					if( boj ~= nil) then
						local functio = boj.data
						
						local obj = {}
						obj.actionlist = functio.action
						obj.tag = event.tag
						
						
						
						directActionsWorkerTable[action.tag] = obj
						
						
					end
					
					
					
					
					
				end
				
				if(action.name == "unsubscribe_from_direct_action") then
					
					directActionsWorkerTable[action.tag] = nil
					
				end
				
				if(action.name == "register_garage_spawn_position") then
				
				
					cyberscript.PositionManager[action.tag] = {}
					cyberscript.PositionManager[action.tag].pending = true
					
					local vehicleSystem = Game.GetVehicleSystem()
				
					local garageVehicleId = GetSingleton('vehicleGarageVehicleID'):Resolve("Vehicle.v_standard2_archer_hella_player")
				
				
				
					vehicleSystem:TogglePlayerActiveVehicle(garageVehicleId, 'Car', true)
				
					vehicleSystem:SpawnPlayerVehicle('Car')
					
					
					Cron.After(0.3,function()
						
						Game.GetVehicleSystem():DespawnPlayerVehicle(garageVehicleId)
						cyberscript.EntityManager["called_garage"] = nil
						
						local inkSystem = Game.GetInkSystem();
						local layers = inkSystem:GetLayers();

						for i,layer in ipairs(layers) do
						  for j,controller in ipairs(layer:GetGameControllers()) do
								
								if(NameToString(controller:GetClassName()) == "VehicleSummonWidgetGameController") then
									GameController[NameToString(controller:GetClassName())] = controller
									
								end
							
						  end
						end
		
						GameController["VehicleSummonWidgetGameController"].rootWidget:SetVisible(false)
						--print(dump(cyberscript.PositionManager[action.tag]))

					end)
					
				end
				
				
				
			
			
			if(action.name == "register_position") then
				
					local position = {}
					local position = getPositionFromParameter(action)
					cyberscript.PositionManager[action.tag] = {}
					cyberscript.PositionManager[action.tag].x = position.x
					cyberscript.PositionManager[action.tag].y = position.y
					cyberscript.PositionManager[action.tag].z = position.z
					cyberscript.PositionManager[action.tag].pending = false
					
					
				end
				
				if(action.name == "delete_position") then
				
					
					cyberscript.PositionManager[action.tag] = nil
					
				end
				
			end
			
			if uiregion then
				if(action.name == "show_texture") then
					local frame = {}
					frame.texture = ImGui.LoadTexture(getTextureByTag(action.tag))
					frame.tag = action.tag
					frame.size = {}
					frame.size.x = action.sizeX
					frame.size.y = action.sizeY
					frame.position = {}
					frame.position.x = action.positionX
					frame.position.y = action.positionY
					frame.bgcolor = action.bgcolor
					frame.bgopacity = action.bgopacity
					frame.bordercolor = action.bordercolor
					frame.borderopacity = action.borderopacity
					frame.title = action.title
					frame.titlecolor = action.titlecolor
					
					frame.titleopacity = 0
					
					if(action.showtitle == true) then
						frame.titleopacity = 1
					end
					
					currentLoadedTexture[action.tag] = frame
				end
				if(action.name == "hide_texture") then
					currentLoadedTexture[action.tag] = nil
				end
				if(action.name == "set_scroll_speed") then
					ScrollSpeed = action.value
				end
				if(action.name == "reset_scroll_speed") then
					ScrollSpeed = 0.002
				end
				if(action.name == "update_mod_setting") then
					updateUserSetting(action.tag,action.value)
				end
				if(action.name == "setup_gang_player_affinity") then
					GangAffinityCalculator()
				end
				if(action.name == "setup_gang_rival_affinity") then
					initGangRelation()
				end
				if(action.name == "setup_gang_district_affinity") then
					initGangDistrictScore()
				end
				if(action.name == "open_interface") then
					currentInterface = cyberscript.cache["interfaces"][action.tag].data
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
				
				
				if(action.name == "open_shard") then
					
					local shard = cyberscript.cache["shard"][action.tag]
					
					if(shard ~= nil) then shard = cyberscript.cache["shard"][action.tag].data end
					
					if(shard ~= nil) then
						
						checkContext(shard)
						Activatedshard(shard)
						
					end
				end
				
				if(action.name == "spawn_inkwidget_entity") then
					
					spawnWidgetEnt(action.tag, action.x, action.y ,action.z)
					
				end
				
				
				if(action.name == "apply_interface_to_inkwidget_entity") then
					
					if(cyberscript.EntityManager[action.entity] ~= nil and cyberscript.cache["interfaces"][action.tag] ~= nil) then
						
						cyberscript.EntityManager[action.entity].interface = action.tag
						cyberscript.EntityManager[action.entity].widget :RemoveAllChildren()
						makeCustomInterface(cyberscript.EntityManager[action.entity].widget,cyberscript.cache["interfaces"][action.tag].data)
						
						else
						--print("no apply")
						-- --print(tostring(GameDump(displayHUD[action.parent])))
						-- --print(tostring(dump(cyberscript.cache["interfaces"][action.tag])))
						
					end
				end
				
				if(action.name == "clear_interface_to_inkwidget_entity") then
					
					if(cyberscript.EntityManager[action.tag] ~= nil) then
						
						cyberscript.EntityManager[action.tag].interface = nil
						cyberscript.EntityManager[action.tag].widget :RemoveAllChildren()
						else
						--print("no apply")
						-- --print(tostring(GameDump(displayHUD[action.parent])))
						-- --print(tostring(dump(cyberscript.cache["interfaces"][action.tag])))
						
					end
				end
				
				if(action.name == "apply_interface_to_hud") then
					
					if(displayHUD[action.parent] ~= nil and cyberscript.cache["interfaces"][action.tag] ~= nil) then
						
						makeCustomInterface(displayHUD[action.parent],cyberscript.cache["interfaces"][action.tag].data)
						
						else
						--print("no apply")
						-- --print(tostring(GameDump(displayHUD[action.parent])))
						-- --print(tostring(dump(cyberscript.cache["interfaces"][action.tag])))
						
					end
				end
				
				
				if(action.name == "clear_interface") then
					
					if(currentInterfaceWidget[action.tag] ~= nil and currentInterfaceWidget[action.tag].parent ~= nil) then
						
						
						currentInterfaceWidget[action.tag].parent:RemoveChildByName(currentInterfaceWidget[action.tag].controls[1].tag)
						currentInterfaceWidget[action.tag] = nil
						
						
					end
				end
				
				if(action.name == "start_effect") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						GameObjectEffectHelper.StartEffectEvent(enti, action.value)
					end
				end
				if(action.name == "stop_effect") then
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						GameObjectEffectHelper.StopEffectEvent(enti, action.value)
						GameObjectEffectHelper.BreakEffectLoopEvent(enti, action.value)
					end
				end
				
				if(action.name == "effect_tester") then
					
					local actionlist = {}
					for i=1,#listFX do
						
						
						
						local actiond = {}
						actiond.name = "start_effect"
						actiond.value = listFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "simple_message"
						actiond.value = listFX[i]
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "stop_effect"
						actiond.value = listFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						
					end
					
					runSubActionList(actionlist, tag.."_effect_tester", tag,source,false,executortag)
				end
				
				if(action.name == "effect_player_tester") then
					
					local actionlist = {}
					for i=1,#transistionFX do
						
						
						
						local actiond = {}
						actiond.name = "start_effect"
						actiond.value = transistionFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "simple_message"
						actiond.value = transistionFX[i]
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "stop_effect"
						actiond.value = transistionFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						
					end
					
					runSubActionList(actionlist, tag.."_effect_tester", tag,source,false,executortag)
				end
				
				if(action.name == "effect_npc_tester") then
					
					local actionlist = {}
					for i=1,#npcFX do
						
						
						
						local actiond = {}
						actiond.name = "start_effect"
						actiond.value = npcFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "simple_message"
						actiond.value = npcFX[i]
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "stop_effect"
						actiond.value = npcFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						
					end
					
					runSubActionList(actionlist, tag.."_effect_tester", tag,source,false,executortag)
				end
				
				if(action.name == "effect_car_tester") then
					
					local actionlist = {}
					for i=1,#carFX do
						
						
						
						local actiond = {}
						actiond.name = "start_effect"
						actiond.value = carFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "simple_message"
						actiond.value = carFX[i]
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "stop_effect"
						actiond.value = carFX[i]
						actiond.tag = action.tag
						
						table.insert(actionlist,actiond)
						
						actiond = {}
						actiond.name = "wait_second"
						actiond.value = 2
						
						table.insert(actionlist,actiond)
						
						
					end
					
					runSubActionList(actionlist, tag.."_effect_tester", tag,source,false,executortag)
				end
				
				if(action.name == "change_interface_label_text") then
					
					if(currentInterfaceWidget ~= nil) then
						currentInterfaceWidget[action.tag].ink:SetText(action.value)
					end
				end
				if(action.name == "change_interface_cart") then
					if(currentInterfaceWidget ~= nil) then
						currentInterfaceWidget[action.tag].ink:SetText("Cart Total : "..CartPrice)
					end
				end
				if(action.name == "open_radio") then
					if GameController["PopupsManager"] then
						openRadio()
						else
						Game.GetPlayer():SetWarningMessage("Open and close radio from vehicule before or reload an save to call the popup.")
					end
				end
				if(action.name == "set_datapack_group") then
					
					for i = 1, #currentInteractGroup do 
						if(action.value == currentInteractGroup[i]) then
							currentInteractGroupIndex = i
						end
					end
				end
				if(action.name == "set_datapack_group_index") then
					
					
					currentInteractGroupIndex = action.value
				end
				
				if(action.name == "set_selected_item") then
					Keystone_currentSelectedItem = action.value
					setVariable("Keystone_currentSelectedItem","title", action.value)
				end
				if(action.name == "set_selected_keystone_datapack") then
					
					for k,v in ipairs(arrayDatapack3) do 
						
						if v.tag == action.value then
							
							Keystone_currentSelectedDatapack = v
							--print("select datapack")
						end
						
					end
					
					
					setVariable("Keystone_currentSelectedDatapack","name",Keystone_currentSelectedDatapack.name)
					local desctab = splitByChunk(Keystone_currentSelectedDatapack.desc, 75)
					local descc = ""
					
					for y=1,#desctab do
						
						
						descc = descc.."\n"..desctab[y]
					end
					
					
					
					setVariable("Keystone_currentSelectedDatapack","desc",descc)
					
					setVariable("Keystone_currentSelectedDatapack","tag",Keystone_currentSelectedDatapack.tag)
					
					setVariable("Keystone_currentSelectedDatapack","author",Keystone_currentSelectedDatapack.author)
					
					setVariable("Keystone_currentSelectedDatapack","file",Keystone_currentSelectedDatapack.file)
					
					setVariable("Keystone_currentSelectedDatapack","version",Keystone_currentSelectedDatapack.version)
					
					setVariable("Keystone_currentSelectedDatapack","data",Keystone_currentSelectedDatapack.data)
					
					local localversion = CurrentDownloadedVersion(Keystone_currentSelectedDatapack.tag)
					local serverversion = GetDatapackOnlineVersion(Keystone_currentSelectedDatapack.tag)
					
					setVariable("Keystone_currentSelectedDatapack","serverversion",serverversion)
					
					setVariable("Keystone_currentSelectedDatapack","localversion",localversion)
					
					setVariable("Keystone_currentSelectedDatapack","isessential",tostring(#Keystone_currentSelectedDatapack.flags > 0  and table_contains(Keystone_currentSelectedDatapack.flags,"essential",false) == true and table_contains(Keystone_currentSelectedDatapack.flags,"debug",false) == false))
					
					setVariable("Keystone_currentSelectedDatapack","isdownloaded",tostring(isDatapackDownloaded(Keystone_currentSelectedDatapack.tag)))
					
					setVariable("Keystone_currentSelectedDatapack","canbedownload",tostring(DatapackChecker(Keystone_currentSelectedDatapack) == true))
					
					setVariable("Keystone_currentSelectedDatapack","needupdate",tostring((localversion~=serverversion and checkVersionNumber(localversion,serverversion) == true)))
					
					
				end
				
				if(action.name == "refreshBrowser") then
					CurrentAddress = action.address
					
					
					if(LastBrowserSubaddress == nil) then LastBrowserSubaddress = "home" end
					
					
					if(action.subaddress == "previous")then --go back to previous
						
						BrowserCybserscript = LastBrowserSubaddress
						
						else
						
						if(action.subaddress ~= "refresh")then --go back to previous
							
							
							
							if(BrowserCybserscript ~= action.subaddress) then --case of refresh
								
								LastBrowserSubaddress = BrowserCybserscript
								
							end
							
							BrowserCybserscript = action.subaddress
						end
						
					end
					
					
					
					
					
					GameController["BrowserController"]:LoadWebPage(action.address)
				end
				
				if(action.name == "open_datapack_group_ui") then
					
					ActivatedGroup()
				end
				
				if(action.name == "open_datapack_group_ui2") then
					
					ActivatedGroup2()
				end
				if(action.name == "open_menu") then
					local startHub = StartHubMenuEvent.new()
					startHub:SetStartMenu(action.value)
					Game.GetUISystem():QueueEvent(startHub)
				end
				
				
				if(action.name == "close_menu") then
					local closeHub = ForceCloseHubMenuEvent.new()
					Game.GetUISystem():QueueEvent(closeHub)
				end
				if(action.name == "close_interface") then
					--	openInterface = false
					ScrollSpeed = getUserSetting("ScrollSpeed")
					currentInterface = nil
					buttonsData = {}
					UIPopupsManager.ClosePopup()
				end
				if(action.name == "lock_conversation" or action.name == "lock_message") then
					setScore(action.tag,"unlocked",0)
				end
				if(action.name == "unlock_conversation" or action.name == "unlock_message") then
					setScore(action.tag,"unlocked",1)
				end
				
				if(action.name == "open_map_menu_to_position") then
					local startHub = StartHubMenuEvent.new()
					
					local userData = MapMenuUserData.new()
					userData.moveTo = Vector3.new(action.x, action.y, action.z)
					
					startHub:SetStartMenu("world_map",nil,userData)
					Game.GetUISystem():QueueEvent(startHub)
					
					
				end
				
				if(action.name == "show_hack_animation") then
					
					
					
					
					
					GameController["HUDProgressBarController"]:OnActivated(true)
					GameController["HUDProgressBarController"]:UpdateTimerHeader(getLang(action.value))
					
				end
				
				if(action.name == "change_hack_animation_percent") then
					
					if(action.text ~= nil and action.text ~= "") then
						
						GameController["HUDProgressBarController"]:UpdateTimerHeader(getLang(action.text))
						
					end
					GameController["HUDProgressBarController"]:UpdateTimerProgress((action.value/100))
					
				end
				
				if(action.name == "hide_hack_animation") then
					
					
					GameController["HUDProgressBarController"]:OnActivated(false)
					GameController["HUDProgressBarController"]:UpdateTimerProgress((0/100))
					
				end
				
				
				
			end
			
			if avregion then
				if(action.name == "vehicule_autodrive_activate") then
					local mappin = {}
					mappin.x = action.x
					mappin.y = action.y
					mappin.z = action.z+5
					local actionlist = {}
					
					local obj = getEntityFromManager(action.tag)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						
						
						local myPos = enti:GetWorldPosition()
						local newPos = myPos
						local angle = enti:GetWorldOrientation():ToEulerAngles()
						
						local tempangle = {}
						tempangle.roll = 0
						tempangle.pitch = 0
						tempangle.yaw = 0
						
						local numbertimes = 0
						local zpath=action.zfly
						
						
						
						newaction = {}
						newaction.name = "wait_second"
						newaction.value = 0.5
						table.insert(actionlist,newaction)
						
						if(action.isAV == true) then
							local ztimes = action.zfly - myPos.z
							local zpos = deepcopy(newPos.z,nil)
							numbertimes = ztimes / zpath
							
							for i=1,ztimes  do 
								
								
								zpos = zpos + 1
								
								local newaction = {}
								newaction.name = "teleport_entity_at_position"
								newaction.tag = action.tag
								newaction.x = newPos.x
								newaction.y = newPos.y
								newaction.z = zpos
								newaction.angle = angle
								newaction.collision = false
								newaction.pathfinding = false
								newaction.axis = "z"
								table.insert(actionlist,newaction)
							end
						end
						
						
						local destination = Vector4.new(mappin.x, myPos.y, myPos.z,1)			
						local dirVector = diffVector(myPos, destination)
						local myyaw = 0
						local vdepart = LVector.new(myPos.x,myPos.y)
						local varrive = LVector.new(mappin.x,mappin.y)
						local diag = varrive-vdepart
						local point = action.speed
						local newangle = GetSingleton('Vector4'):ToRotation(dirVector)
						local numtimes = diag*(1/point)
						local path = deepcopy(vdepart,nil)
						for i = 1,point do
							path = path+numtimes
							
							
							local newaction = {}
							newaction.name = "teleport_entity_at_position"
							newaction.tag = action.tag
							newaction.x = path.x
							newaction.y = path.y
							newaction.z = action.zfly
							newaction.angle = angle
							newaction.pathfinding = action.pathfinding
							newaction.collision = false
							newaction.axis = "x"
							table.insert(actionlist,newaction)
						end
						
						newaction = {}
						newaction.name = "wait_second"
						newaction.value = 0.5
						table.insert(actionlist,newaction)
						
						if(action.isAV == true) then
							
							local ztimes = action.zfly - mappin.z - 3
							local zpos = deepcopy(ztimes,nil)
							numbertimes = ztimes
							
							for i=1,numbertimes  do 
								
								
								zpos = zpos - 1
								
								local newaction = {}
								newaction.name = "teleport_entity_at_position"
								newaction.tag = action.tag
								newaction.x = path.x
								newaction.y = path.y
								newaction.z = zpos
								newaction.angle = angle
								newaction.collision = true
								newaction.pathfinding = false
								newaction.axis = "z"
								table.insert(actionlist,newaction)
							end
							
							
						end
						
						
						runSubActionList(actionlist, tag.."_av_autodrive_activate", tag,source,false,executortag)
						result = false
					end
				end
				if(action.name == "vehicule_autodrive_activate_custom_mappin") then
					if(mappinManager["selected_mappin"] ~= nil) then
						
						local mappin = mappinManager["selected_mappin"].position
						local actionlist = {}
						
						local obj = getEntityFromManager(action.tag)
						local enti = Game.FindEntityByID(obj.id)
						local myPos = enti:GetWorldPosition()
						local newPos = myPos
						local angle = enti:GetWorldOrientation():ToEulerAngles()
						
						local tempangle = {}
						tempangle.roll = 0
						tempangle.pitch = 0
						tempangle.yaw = 0
						
						local numbertimes = 0
						local zpath=action.zfly
						
						
						
						
						newaction = {}
						newaction.name = "wait_second"
						newaction.value = 0.5
						table.insert(actionlist,newaction)
						
						if(action.isAV == true) then
							local ztimes = action.zfly - myPos.z
							local zpos = deepcopy(newPos.z,nil)
							numbertimes = ztimes / zpath
							
							for i=1,ztimes  do 
								
								
								zpos = zpos + 1
								
								local newaction = {}
								newaction.name = "teleport_entity_at_position"
								newaction.tag = action.tag
								newaction.x = newPos.x
								newaction.y = newPos.y
								newaction.z = zpos
								newaction.angle = angle
								newaction.collision = false
								newaction.pathfinding = false
								newaction.axis = "z"
								table.insert(actionlist,newaction)
							end
						end
						
						
						local destination = Vector4.new(mappin.x, mappin.y, myPos.z,1)			
						local dirVector = diffVector(myPos, destination)
						local myyaw = 0
						local vdepart = LVector.new(myPos.x,myPos.y)
						local varrive = LVector.new(mappin.x,mappin.y)
						local diag = varrive-vdepart
						local point = action.speed
						local newangle = GetSingleton('Vector4'):ToRotation(dirVector)
						local numtimes = diag*(1/point)
						local path = deepcopy(vdepart,nil)
						for i = 1,point do
							path = path+numtimes
							
							
							local newaction = {}
							newaction.name = "teleport_entity_at_position"
							newaction.tag = action.tag
							newaction.x = path.x
							newaction.y = path.y
							newaction.z = action.zfly
							newaction.angle = angle
							newaction.pathfinding = action.pathfinding
							newaction.collision = false
							newaction.axis = "x"
							table.insert(actionlist,newaction)
						end
						
						newaction = {}
						newaction.name = "wait_second"
						newaction.value = 0.5
						table.insert(actionlist,newaction)
						
						if(action.isAV == true) then
							
							local ztimes = action.zfly - mappin.z - 3
							local zpos = deepcopy(ztimes,nil)
							numbertimes = ztimes
							
							for i=1,numbertimes  do 
								
								
								zpos = zpos - 1
								
								local newaction = {}
								newaction.name = "teleport_entity_at_position"
								newaction.tag = action.tag
								newaction.x = path.x
								newaction.y = path.y
								newaction.z = zpos
								newaction.angle = angle
								newaction.collision = true
								newaction.pathfinding = false
								newaction.axis = "z"
								table.insert(actionlist,newaction)
							end
							
							
						end
						
						
						runSubActionList(actionlist, tag.."_av_autodrive_activate__custom_mappin", tag,source,false,executortag)
						result = false
					end
				end
				if(action.name == "toggle_av_engine") then
					local obj = getEntityFromManager(action.tag)
					if(obj ~= nil) then
						if(obj.isAV == true) then
							obj.isAV = false
							else
							obj.isAV = true
						end
					end
				end
				if(action.name == "toggle_av_engine_for_current_drived_vehicule") then
					local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
					if (inVehicule) then
						local vehicule = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
						if(vehicule ~= nil) then
							local obj = getEntityFromManagerById(vehicule:GetEntityID())
							if(obj.id == nil) then
								local entity = {}
								entity.id = vehicule:GetEntityID()
								entity.tag = "vehicule_"..math.random(1,9999)
								entity.tweak = "nope"
								entity.takenSeat = {}
								entity.isAV = false
								local group = getGroupfromManager("AV")
								entity.availableSeat = GetSeats(vehicule)
								entity.driver = "player"
								cyberscript.EntityManager[entity.tag]=entity
								--logme(3,"new "..entity.tag)
								obj = entity
							end
							logme(3,obj.tag)
							local obj = getTrueEntityFromManager(obj.tag)
							if(obj.isAV == true) then
								obj.isAV = false
								
								for i=1, #cyberscript.GroupManager["AV"].entities do 
									local entityTag = cyberscript.GroupManager["AV"].entities[i]
									if(entityTag == obj.tag) then
										table.remove(cyberscript.GroupManager["AV"].entities,i)
									end
								end
								--logme(3,"removedAV"..obj.tag)
								else
								
								obj.isAV = true
								if(cyberscript.GroupManager["AV"].entities == nil) then
									cyberscript.GroupManager["AV"].entities = {}
								end
								logme(3,"addedAV"..obj.tag)
								table.insert(cyberscript.GroupManager["AV"].entities,obj.tag)
							end
						end
					end
				end
			end
			
			if customnpcregion then 
				
				if(action.name == "npc_custom_edit_custom_npc") then
					local npc =  getCustomNPCbyTag(action.tag)
					npc.spawnforced=true
					npc.dospawnaction=action.dospawnaction
					npc.doroutineaction=action.doroutineaction
					npc.dodeathaction=action.dodeathaction
					npc.dodespawnaction=action.dodespawnaction
					npc.repeat_routine = action.repeat_routine
					npc.auto_despawn = action.auto_despawn
					if(action.replacelocation == true) then
						npc.workinglocation.x = action.x
						npc.workinglocation.y = action.y
						npc.workinglocation.z = action.z
						npc.workinglocation.range = action.range
					end
					if(action.appeareance ~= nil and action.appeareance ~= "") then
						npc.appeareance = action.appearance
					end
				end
				if(action.name == "npc_custom_despawn_custom_npc") then
					local npc =  getCustomNPCbyTag(action.tag)
					npc.isspawn=false
					npc.init=false
					npc.appearancesetted = nil
					npc.spawnforced=false
					npc.dospawnaction=true
					npc.doroutineaction=true
					npc.dodeathaction=true
					npc.dodespawnaction=true
					npc.workinglocation = npc.location
					if(workerTable[npc.tag.."_spawn"] ~= nil) then
						workerTable[npc.tag.."_spawn"] = nil
					end
					if(workerTable[npc.tag.."_death"] ~= nil) then
						workerTable[npc.tag.."_death"] = nil
					end
					if(workerTable[npc.tag.."_routine"] ~= nil) then
						workerTable[npc.tag.."_routine"] = nil
					end
					despawnEntity(npc.tag)
					if(workerTable[npc.tag.."_despawn"] == nil and #npc.despawnaction > 0) then
						runActionList(npc.despawnaction, npc.tag.."_despawn", "interact",false,npc.tag)
					end
				end
				if(action.name == "npc_custom_set_autodespawn") then 
					local npc = getCustomNPCByTag(action.tag)
					npc.auto_despawn = action.value
				end
				if(action.name == "npc_custom_set_autoroutine") then 
					local npc = getCustomNPCByTag(action.tag)
					npc.repeat_routine = action.value
				end
				if(action.name == "npc_custom_copy") then 
					local npc =  getCustomNPCbyTag(action.sourcetag)
					local newnpc =	deepcopy(npc, newnpc)
					newnpc.tag = action.newtag
					newnpc.name = action.newname
					addCustomNPC(newnpc)
				end
			end
			
			
			
			if scene then 
				if(action.name == "show_braindance_ui") then
					
					if(GameController["BraindanceGameController"] ~= nil) then
						local root = GameController["BraindanceGameController"].rootWidget 
						
						
						
						root:SetVisible(true)
						
						GameController["BraindanceGameController"].PlayLibraryAnimation(CName("SHOW"))
						
						
					end
					
				end
				
				if(action.name == "bound_scene_to_braindance") then
					
					if(GameController["BraindanceGameController"] ~= nil and currentScene ~= nil) then
						local margin = inkMargin.new({ top = -45})
						inkWidgetRef.SetMargin(GameController["BraindanceGameController"].cursorPoint, margin)
						local margin = inkMargin.new({ left = 0})
						inkWidgetRef.SetMargin(GameController["BraindanceGameController"].currentTimerMarker, margin)
						inkTextRef.SetText(GameController["BraindanceGameController"].currentTimerText, "0 : 0")
						currentScene.isbraindance = true
						
						
						
					end
					
				end
				
				if(action.name == "unbound_scene_to_braindance") then
					
					if(GameController["BraindanceGameController"] ~= nil and currentScene ~= nil) then
						local margin = inkMargin.new({ top = -45})
						inkWidgetRef.SetMargin(GameController["BraindanceGameController"].cursorPoint, margin)
						currentScene.isbraindance = false
						
						
						
					end
					
				end
				
				if(action.name == "hide_braindance_ui") then
					
					if(GameController["BraindanceGameController"] ~= nil) then
						local root = GameController["BraindanceGameController"].rootWidget 
						
						
						
						root:SetVisible(false)
						
						
						
						
					end
					
				end
				
				
				
				
				
				if(action.name == "load_scene") then
					
					local scene = cyberscript.cache["scene"][action.tag]
					
					if(scene ~= nil) then
						
						currentScene = scene.data
						currentScene.index = 0
						if(GameController["BraindanceGameController"] ~= nil and currentScene.isbraindance == true) then
							
							local root = GameController["BraindanceGameController"].rootWidget 
							
							
							
							
							root:SetVisible(true)
							
							GameController["BraindanceGameController"].PlayLibraryAnimation(CName("SHOW"))
							
							local margin = inkMargin.new({ top = -45})
							inkWidgetRef.SetMargin(GameController["BraindanceGameController"].cursorPoint, margin)
							local margin = inkMargin.new({ left = 0})
							inkWidgetRef.SetMargin(GameController["BraindanceGameController"].currentTimerMarker, margin)
							inkTextRef.SetText(GameController["BraindanceGameController"].currentTimerText, "0 : 0")
							
							
							
							
						end
						else
						
						error("No scene founded for the tag "..action.tag)
						
						
					end
					
				end
				
				if(action.name == "unload_scene") then
					
					
					
					if(currentScene ~= nil) then
						
						currentScene = nil
						
						
						
						
					end
				end
				
				if(action.name == "play_scene") then
					
					
					
					if(currentScene ~= nil) then
						
						
						
						
						runActionList(currentScene.reset_action, currentScene.tag.."_reset", "interact",false,"scene")
						
						local actionlist = {}
						
						local actiontd = {}
						actiontd.name = "wait_for_trigger"
						actiontd.trigger = {}
						actiontd.trigger.name = "event_is_finished"
						actiontd.trigger.tag = currentScene.tag.."_reset"
						
						table.insert(actionlist,actiontd)
						
						for i=1,#currentScene.init_action do
							
							table.insert(actionlist,currentScene.init_action[i])
							
						end
						
						
						runActionList(actionlist, currentScene.tag.."_init", "interact",false,"scene")
						
						
						actionlist = {}
						
						actiontd = {}
						actiontd.name = "wait_for_trigger"
						actiontd.trigger = {}
						actiontd.trigger.name = "event_is_finished"
						actiontd.trigger.tag = currentScene.tag.."_init"
						
						table.insert(actionlist,actiontd)
						
						for i=1,#currentScene.step do
							
							
							local step = currentScene.step[i]
							
							
							
							for y=1,#step.action do
								
								table.insert(actionlist,step.action[y])
								
							end
							
						end
						
						
						for i=1,#currentScene.end_action do
							
							table.insert(actionlist,currentScene.end_action[i])
							
						end
						
						
						runActionList(actionlist, currentScene.tag.."_full", "interact",false,"scene")
						else
						
						error("No scene loaded")
						
					end
				end
				
				if(action.name == "reset_scene") then
					
					
					
					if(currentScene ~= nil) then
						
						
						
						
						runActionList(currentScene.reset_action, currentScene.tag.."_reset", "interact",false,"scene")
						currentScene.index = 0
						
					end
				end
				
				if(action.name == "init_scene") then
					
					
					
					if(currentScene ~= nil) then
						
						
						
						
						runActionList(currentScene.init_action, currentScene.tag.."_init", "interact",false,"scene")
						currentScene.index = 0
						else
						
						error("No scene loaded")
					end
				end
				
				if(action.name == "play_scene_step_index") then
					
					
					
					if(currentScene ~= nil) then
						
						
						
						if(currentScene.step[action.value] ~= nil) then
							if (currentScene.isbraindance == true) then 
								
								GameController["BraindanceGameController"].currentTime = (100/#currentScene.step * action.value)/100
								GameController["BraindanceGameController"]:SetBraindanceProgress()
								
							end
							runActionList(currentScene.step[action.value].action, currentScene.tag.."_"..action.value, "interact",false,"scene")
							currentScene.index = action.value
						end
						
					end
				end
				
				if(action.name == "play_scene_step_by_tag") then
					
					
					
					if(currentScene ~= nil) then
						
						
						for i=1,#currentScene.step do
							if(currentScene.step[i].tag == action.tag) then
								if (currentScene.isbraindance == true) then 
									
									GameController["BraindanceGameController"].currentTime = (100/#currentScene.step * i)/100
									GameController["BraindanceGameController"]:SetBraindanceProgress()
									
								end
								runActionList(currentScene.step[i].action, currentScene.tag.."_"..i, "interact",false,"scene")
								currentScene.index = i
							end
						end
						
					end
				end
				
				if(action.name == "play_next_scene_step") then
					
					
					
					if(currentScene ~= nil) then
						
						
						local index = currentScene.index +1
						
						if(currentScene.step[index] ~= nil) then
							if (currentScene.isbraindance == true) then 
								
								GameController["BraindanceGameController"].currentTime = (100/#currentScene.step * index)/100
								GameController["BraindanceGameController"]:SetBraindanceProgress()
								
							end
							
							runActionList(currentScene.step[index].action, currentScene.tag.."_"..index, "interact",false,"scene")
							currentScene.index = index
							
						end
						
					end
				end
				
				if(action.name == "play_previous_scene_step") then
					
					
					
					if(currentScene ~= nil) then
						
						
						local index = currentScene.index -1
						
						if(currentScene.step[index] ~= nil) then
							if (currentScene.isbraindance == true) then 
								
								GameController["BraindanceGameController"].currentTime = (100/#currentScene.step * index)/100
								GameController["BraindanceGameController"]:SetBraindanceProgress()
								
							end
							runActionList(currentScene.step[index].action, currentScene.tag.."_"..index, "interact",false,"scene")
							currentScene.index = index
							
						end
						
					end
				end
				
				
				
				
				
				if(action.name == "spawn_camera") then
					local position = {}
					local position = getPositionFromParameter(action)
					
					
					local angle = {}
					angle.roll = action.roll
					angle.pitch = action.pitch
					angle.yaw = action.yaw
					
					spawnCamera(action.tag,position,action.surveillance,angle)
					
				end
				
				if(action.name == "move_camera") then
					local position = {}
					local position = getPositionFromParameter(action)
					
					local angle = {}
					angle.roll = action.roll
					angle.pitch = action.pitch
					angle.yaw = action.yaw
					
					moveCamera(action.tag,position,angle)
				end
				
				if(action.name == "activate_camera") then
					enableCamera(action.tag)
				end
				
				if(action.name == "stop_camera") then
					stopCamera(action.tag)
				end
				
				
				
				
				
			end
			
			if hudregion then 
				
				if(action.name == "change_hud_visibility") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						
						cyberscript.cache["hud"][v.tag].data.visible = action.value
						
					end
					
				end
				
				if(action.name == "change_hud_margin") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						if(cyberscript.cache["hud"][v.tag].data.margin == nil) then cyberscript.cache["hud"][v.tag].data.margin = {} end
						cyberscript.cache["hud"][v.tag].data.margin.top = action.top
						cyberscript.cache["hud"][v.tag].data.margin.left = action.left
						
					end
					
				end
				
				if(action.name == "change_hud_color") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						if(cyberscript.cache["hud"][v.tag].data.color == nil) then cyberscript.cache["hud"][v.tag].data.color = {} end
						
						cyberscript.cache["hud"][v.tag].data.color.red = action.red
						cyberscript.cache["hud"][v.tag].data.color.green = action.green
						cyberscript.cache["hud"][v.tag].data.color.blue = action.blue
						
					end
					
				end
				
				if(action.name == "change_hud_fontfamily") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						
						
						cyberscript.cache["hud"][v.tag].data.fontfamily = action.value
						
					end
					
				end
				
				if(action.name == "change_hud_fontstyle") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						
						
						cyberscript.cache["hud"][v.tag].data.fontstyle = action.value
						
					end
					
				end
				
				if(action.name == "change_hud_fontsize") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						
						
						cyberscript.cache["hud"][v.tag].data.fontsize = action.value
						
					end
					
				end
				
				if(action.name == "change_hud_text") then
					
					if (cyberscript.cache["hud"][v.tag] ~= nil) then
						
						
						cyberscript.cache["hud"][v.tag].data.text = action.value
						
					end
					
				end
				
			end
			
			if airegion then
				if(action.name == "setup_ai_context") then
					
					AIhandler[action.aitag] = {}
					AIhandler[action.aitag].context = action.value
					
				end
				
				if(action.name == "flush_ai") then
					FlushChat(action.aitag)
					AIhandler[action.aitag] = nil
					
				end
				
				if(action.name == "ask_ai") then
					setupAIkey(action.aitag)
					if(ScheduleChatCompletionRequest ~= null) then
						ScheduleChatCompletionRequest(action.aitag,{
							{"User", action.value}
						});
						else
						print("ai not found")
					end
					
				end
				
				if(action.name == "ask_ai_with_context") then
					setupAIkey(action.aitag)
					if(ScheduleChatCompletionRequest ~= null) then
						ScheduleChatCompletionRequest(action.aitag,{
							{"User", action.value},
							getAIContextOrDefault(action.aitag)
						});
						else
						print("ai not found")
					end
					
				end
				if(action.name == "ask_ai_from_item") then
					setupAIkey(action.aitag)
					if(ScheduleChatCompletionRequest ~= null and
					cyberscript.cache["ai"][action.tag]~=nil) then
					local contextAI = {}
					
					for i,con in ipairs(cyberscript.cache["ai"][action.tag].data.contexts) do
						local item = {}
						checkContext(con)
						table.insert(item,con.context_type)
						table.insert(item,con.value)
						table.insert(contextAI,item)
					end
					print(dump(contextAI))
					ScheduleChatCompletionRequest(action.aitag,contextAI);
					else
					print("ai not found")
					end
					
				end
				
				if(action.name == "ask_ai_from_item_with_value") then
					setupAIkey(action.aitag)
					if(ScheduleChatCompletionRequest ~= nil and
					cyberscript.cache["ai"][action.tag]~=nil) then
					local contextAI = {}
					
					for i,con in ipairs(cyberscript.cache["ai"][action.tag].data.contexts) do
						local item = {}
						checkContext(con)
						table.insert(item,con.context_type)
						table.insert(item,con.value)
						table.insert(contextAI,item)
					end
					
					local item = {}
					table.insert(item,"User")
					table.insert(item,action.value)
					table.insert(contextAI,item)
					
					print(dump(contextAI))
					
					ScheduleChatCompletionRequest(action.aitag,contextAI);
					else
					print("ai not found")
					end
					
				end
				
				if(action.name == "ask_ai_from_item_with_new_contexts") then
					setupAIkey(action.aitag)
					if(ScheduleChatCompletionRequest ~= nil and
					cyberscript.cache["ai"][action.tag]~=nil) then
					local contextAI = {}
					
					for i,con in ipairs(cyberscript.cache["ai"][action.tag].data.contexts) do
						local item = {}
						checkContext(con)
						table.insert(item,con.context_type)
						table.insert(item,con.value)
						table.insert(contextAI,item)
					end
					
					for i,con in ipairs(action.contexts) do
						checkContext(con)
						local item = {}
						table.insert(item,con.context_type)
						table.insert(item,con.value)
						table.insert(contextAI,item)
					end
					
					print(dump(contextAI))
					
					ScheduleChatCompletionRequest(action.aitag,contextAI);
					else
					print("ai not found")
					end
					
				end
				
				if(action.name == "get_ai_answer_in_score") then
					
					if(ScheduleChatCompletionRequest ~= null) then
						setVariable(action.variable,action.key,AIhandler[action.aitag].answer)
						else
						print("ai not found")
					end
					
				end
				
				
				if(action.name == "set_choice_from_ai") then
					--logme(3,"is logme(10,source)
					local usedial =  {}
					
					usedial.desc = ""
					usedial.speaker = "V"
					
					usedial.header = {}
					usedial.header.version = 3
					
					usedial.requirement = {}
					usedial.trigger = {}
					usedial.context = {}
					
					usedial.options = {}
					
					print(getAIAnswerOrDefault(action.aitag))
					local item = json.decode(getAIAnswerOrDefault(action.aitag))
					
					
					
					if(item.questions ~= nil) then
						
						_,n = item.answer:gsub("%S+","")
						
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = action.speaker
						actionss.target = "player"
						actionss.duration = math.ceil(n*0.2)
						actionss.title = item.answer
						local actionlist = {}
						table.insert(actionlist,actionss)
						
						
						
						for i,v in ipairs(item.questions) do
							local answer = {}
							answer.requirement = {}
							answer.trigger = {}
							answer.context = {}
							answer.description = v
							answer.style = {}
							answer.style.color = {}
							answer.action = {}
							
							local actionss = {}
							actionss.name = "ask_ai"
							actionss.tag = "dialog_template"
							actionss.value = v
							actionss.aitag = action.aitag
							
							table.insert(answer.action,actionss)
							
							local actionss = {}
							actionss.name = "subtitle"
							actionss.type = 1
							actionss.speaker = "V"
							actionss.target = "player"
							actionss.duration = 5
							actionss.title = v
							table.insert(answer.action,actionss)
							
							local actionss = {}
							actionss.name = "wait_for_ai_answer"
							
							actionss.aitag = action.aitag
							
							table.insert(answer.action,actionss)
							
							local actionss = {}
							actionss.name = "set_choice_from_ai"
							actionss.speaker = action.speaker
							actionss.aitag = action.aitag
							
							table.insert(answer.action,actionss)
							
							
							table.insert(usedial.options,answer)
						end
						
						
						
						local answer = {}
						answer.requirement = {}
						answer.trigger = {}
						answer.context = {}
						answer.description = "Tell me more about it."
						answer.style = {}
						answer.style.color = {}
						answer.action = {}
						
						local actionss = {}
						actionss.name = "ask_ai"
						actionss.tag = "dialog_template"
						actionss.value = "Tell me more about it."
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = "V"
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "Tell me more about it."
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "wait_for_ai_answer"
						
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "set_choice_from_ai"
						actionss.speaker = action.speaker
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						table.insert(usedial.options,answer)
						
						local answer = {}
						answer.requirement = {}
						answer.trigger = {}
						answer.context = {}
						answer.description = "Wait... Can you repeat what you said ?"
						answer.style = {}
						answer.style.color = {}
						answer.action = {}
						
						local actionss = {}
						actionss.name = "ask_ai"
						actionss.tag = "dialog_template"
						actionss.value = "Wait... Can you repeat what you said ?"
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = "V"
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "Wait... Can you repeat what you said ?"
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "wait_for_ai_answer"
						
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "set_choice_from_ai"
						actionss.speaker = action.speaker
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						table.insert(usedial.options,answer)
						
						
						local answer = {}
						answer.requirement = {}
						answer.trigger = {}
						answer.context = {}
						answer.description = "Got someone for that ?"
						answer.style = {}
						answer.style.color = {}
						answer.action = {}
						
						local actionss = {}
						actionss.name = "ask_ai_from_item"
						actionss.tag = "quest"
						
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = "V"
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "Got someone for that ?"
						table.insert(answer.action,actionss)
						
						
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = action.speaker
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "I will send you the informations later. Walls got mics here."
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = "V"
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "Thanks !"
						table.insert(answer.action,actionss)
						
						local actionss = {}
						actionss.name = "wait_for_ai_answer"
						
						actionss.aitag = action.aitag
						
						table.insert(answer.action,actionss)
						
						table.insert(usedial.options,answer)
						
						
						
						local answer = {}
						answer.requirement = {}
						answer.trigger = {}
						answer.context = {}
						answer.description = "We talk later."
						answer.style = {}
						answer.style.color = {}
						answer.action = {}
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = "V"
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "We talk later."
						table.insert(answer.action,actionss)
						local actionss = {}
						actionss.name = "subtitle"
						actionss.type = 1
						actionss.speaker = action.speaker
						actionss.target = "player"
						actionss.duration = 5
						actionss.title = "See ya around !"
						table.insert(answer.action,actionss)
						local actionss = {}
						actionss.name = "flush_ai"
						actionss.aitag = action.aitag
						table.insert(answer.action,actionss)
						
						table.insert(usedial.options,answer)
						local actionss = {}
						actionss.name = "set_generated_dialog"
						actionss.item = usedial
						
						table.insert(actionlist,actionss)
						runSubActionList(actionlist, tag.."_event_", tag,source,false,exector,bypassmenu)
						
						
						
						else
						
						print("Noep")
					end
					
					
				end
				
				
				if(action.name == "create_quest_from_ai") then
					
					local questos = json.decode(getAIAnswerOrDefault(action.aitag))
					local data = {}
					local missiontag = "ai_quest_tag_"..math.random(1,99999)
					
					cyberscript.cache["mission"][missiontag] = {}
					cyberscript.cache["mission"][missiontag].data = {}
					cyberscript.cache["mission"][missiontag].file = "datapack/".."cyberai".."/".."mission".."/"..missiontag..".json"
					cyberscript.cache["mission"][missiontag].datapack = "cyberai"
					cyberscript.cache["mission"][missiontag].scripttype = "mission"
					
					local quest = {}
					quest.header = {}
					quest.header.version = 1
					
					quest.tag = missiontag
					quest.objectives = {}
					
					for i,aiobj in ipairs(questos.objectives) do
						
						local objective = {}
						
						
						
						objective.resume_action = {}
						objective.extra  = {}
						objective.action = {}
						objective.tag = missiontag.."_".."obj_"..i
						objective.title = aiobj.title
						objective.id = missiontag.."_".."obj_"..i
						objective.trigger =  {}
						objective.state = {}
						objective.failaction = {}
						objective.isOptional = false
						objective.isoptionnal = false
						objective.requirement ={}
						objective.unlock = {}
						
						
						table.insert(quest.objectives,objective)
						
						
					end
					
					
					
					quest.district = EgamedataDistrict[questos.place]
					
					quest.failure_condition = {}
					quest.failure_condition.player_death = {}
					quest.failure_condition.player_death.name = "player_death"
					quest.failure_condition.player_death.helperTitle = "Player : is Dead"
					quest.failure_condition.player_death.helper = "This trigger will be triggered when you are dead"
					quest.failure_condition_requirement = {}
					quest.failure_condition_requirement[1] = {"player_death"}
					quest.failure_action = {}
					
					
					quest.trigger_condition = {}
					quest.trigger_condition.auto = {}
					quest.trigger_condition.auto.name = "auto"
					quest.trigger_condition.auto.helperTitle = "auto"
					quest.trigger_condition.auto.helper = "auto"
					quest.trigger_condition_requirement = {}
					quest.trigger_condition_requirement[1] = {"auto"}
					
					quest.failure_action = {}
					
					quest.extra ={}
					quest.context = {}
					
					
					quest.end_action = {}
					quest.reset_action = {}
					
					quest.unlock_action = {}
					quest.content = questos.description
					quest.recommandedlevel = 5
					quest.title = questos.title
					quest.questtype = 2
					quest.recurrent = false
					
					quest.alreadyStart = false
					quest.column = 1
					quest.row = 1
					
					
					cyberscript.cache["mission"][missiontag].data = quest
					
					pcall(function()				
						QuestManager.RemoveQuest(missiontag)
						setScore(missiontag,"Score",nil)
						QuestManager.MarkQuestAsInactive(missiontag)
						QuestManager.MarkAllObjectiveOfQuestAs(missiontag,1)
						QuestManager.MarkQuestAsUnVisited(missiontag)
					end)
					loadQuestToUI(quest)  
				end
				
				if(action.name == "set_generated_dialog") then
					print(dump(action.item))
					createDialog(action.item)	
					
				end
				if(action.name == "ai_phone_notification") then
					local itemjson = json.decode(getAIAnswerOrDefault(action.aitag))
					
					print("mar1"..itemjson.answer)
					
					if(itemjson.questions ~= nil) then
						local test = getLang(action.speaker)
						local openAction = OpenMessengerNotificationAction.new()
						openAction.eventDispatcher = GameController["JournalNotificationQueue"]
						local userData = PhoneMessageNotificationViewData.new()
						userData.title = test
						print("mar2"..itemjson.answer)
						userData.SMSText = itemjson.answer
						userData.action = openAction
						userData.animation = CName('notification_phone_MSG')
						userData.soundEvent = CName('PhoneSmsPopup')
						userData.soundAction = CName('OnOpen')
						currentPhoneDialogPopup = gameJournalPhoneMessage.new()
						currentPhoneDialogPopup.sender = 1
						currentPhoneDialogPopup.text = itemjson.answser
						currentPhoneDialogPopup.delay = -9999
						currentPhoneDialogPopup.id = test
						
						
						
						
						
						if(AIconversation[action.conversation] == nil and action.conversation ~= "") then 
							AIconversation[action.conversation] = {} 
							AIconversation[action.conversation].unlock = true
							AIconversation[action.conversation].speaker = action.speaker 
							AIconversation[action.conversation].message = {}
						end
						
						
						
						
						
						AIconversation[action.conversation].tag = action.conversation
						
						local message = {}
						message.tag = action.conversation.."_"..(#AIconversation[action.conversation].message+1)
						
						message.text= itemjson.answer
						message.unlock = true
						message.readed = true
						message.unlocknext = ""
						message.sender = 0
						message.choices = {}
						
						for i,v in ipairs(itemjson.questions) do
							local answer = {}
							answer.action_bypassmenu_execution = false
							answer.tag = action.conversation.."_"..(#AIconversation[action.conversation].message+1).."_".."choice"..i
							
							answer.unlocknext = ""
							answer.text = v
							answer.trigger = {}
							answer.context = {}
							answer.action = {}
							answer.requirement = {}
							
							local actionss = {}
							actionss.name = "ask_ai_from_item_with_value"
							actionss.tag = "dialog_template"
							actionss.value = v
							actionss.aitag = action.aitag
							
							table.insert(answer.action,actionss)
							
							local actionss = {}
							actionss.name = "wait_for_ai_answer"
							actionss.aitag = action.aitag
							table.insert(answer.action,actionss)
							
							local actionss = {}
							actionss.name = "add_v_message_to_ai_phone"
							actionss.value = v
							actionss.conversation = action.conversation
							table.insert(answer.action,actionss)
							
							
							
							
							
							local actionss = {}
							actionss.name = "ai_phone_notification"
							actionss.speaker = action.speaker
							actionss.duration = 5
							actionss.conversation = action.conversation
							table.insert(answer.action,actionss)
							
							
							table.insert(message.choices,answer)
						end
						
						
						table.insert(AIconversation[action.conversation].message,message)
						currentPhoneConversation = AIconversation[action.conversation] 
						currentPhoneConversation.currentchoices = {}
						currentPhoneConversation.loaded = 0	
						currentPhoneConversation.speaker = action.speaker
						
						
						print(dump(currentPhoneConversation))
						
						
						local notificationData = gameuiGenericNotificationData.new()
						notificationData.time = action.duration
						notificationData.widgetLibraryItemName = CName('notification_message')
						notificationData.notificationData = userData
						GameController["JournalNotificationQueue"]:AddNewNotificationData(notificationData)
						
						
					end
				end
				
				if(action.name == "add_v_message_to_ai_phone") then
					if(AIconversation[action.conversation] == nil and action.conversation ~= "") then 
						AIconversation[action.conversation] = {} 
						AIconversation[action.conversation].unlock = true
						AIconversation[action.conversation].speaker = action.speaker 
						AIconversation[action.conversation].message = {}
					end
					
					
					
					
					
					AIconversation[action.conversation].tag = action.conversation
					
					local message = {}
					message.tag = action.conversation.."_"..(#AIconversation[action.conversation].message+1)
					
					message.text= action.value
					message.unlock = true
					message.readed = true
					message.unlocknext = ""
					message.sender = 1
					message.choices = {}
				end
				
				
			end
			
		end)
		
		if status == false then
			
			
			logme(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty(action)).." tag "..tag.." parent "..parent.." index "..index,true)
			if(action.fail_action ~= nil and #action.fail_action > 0) then
				runActionList(action.fail_action, tag.."_failure", source,false,executortag)
				
			end
			
			
			
		end
		
   		if(action.output == true) then 
   			
   			logme(1,action.name,true)
   			logme(1,dump(action),true)
   			logme(1,tostring(result),true)
   			
		end
   		
	end
   	
   	return result
end	


function getPositionFromParameter(action)
	local position = {}
	
	
	if(action.position == "at") then
		position.x = action.x
		position.y = action.y
		position.z = action.z
	end
	if(action.position == "manager") then
		if(cyberscript.PositionManager[action.position_tag] ~= nil and cyberscript.PositionManager[action.position_tag].pending == false) then
			position.x = cyberscript.PositionManager[action.position_tag].x
			position.y = cyberscript.PositionManager[action.position_tag].y
			position.z = cyberscript.PositionManager[action.position_tag].z
			
			if(cyberscript.PositionManager[action.position_tag].fromgarage ~= nil and cyberscript.PositionManager[action.position_tag].fromgarage == true) then
			action.yaw = cyberscript.PositionManager[action.position_tag].yaw
			action.pitch = cyberscript.PositionManager[action.position_tag].pitch
			action.roll = cyberscript.PositionManager[action.position_tag].roll
			end
			
		end
	end
	if(action.position == "relative_to_entity") then
		local positionVec4 = {}
		local entity = nil
		
		local obj = getEntityFromManager(action.position_tag)
		if(obj.id ~= nil ) then 
			entity = Game.FindEntityByID(obj.id)
			if(entity ~= nil ) then 
				positionVec4 = entity:GetWorldPosition()
				
				if(action.position_spawnlocation ~= nil and action.position_spawnlocation == true) then
					
					if(obj.spawnlocation ~= nil) then
						positionVec4 = obj.spawnlocation
						else
						positionVec4.x = 0
						positionVec4.y = 0
						positionVec4.z = 0
					end
				end
				
				if(action.position_way ~= nil and (action.position_way ~= "" or action.position_way ~= "normal")) then
					if(action.position_way == "behind") then
						positionVec4 = getBehindPosition(entity,action.position_distance)
					end
					if(action.position_way == "forward") then
						positionVec4 = getForwardPosition(entity,action.position_distance)
						
					end
					
					if(action.position_way == "forward_relative") then
						positionVec4 = getForwardPosition2(entity,action.position_distance,action)
						
					end
				end
				
				
				position.x = positionVec4.x
				position.y = positionVec4.y
				position.z = positionVec4.z
			end
		end
	end
	if(action.position == "player_look_at") then
		local positionVec4 = getForwardPosition(Game.GetPlayer(),action.position_lookatdistance)
		position.x = positionVec4.x
		position.y = positionVec4.y
		position.z = positionVec4.z
	end
	
	
	if(action.position == "node") then
		
		local node = nil
		
		if(action.position_tag == "current")then
			
			
			local position = Game.GetPlayer():GetWorldPosition()
			local range = 70
			if(action.position_range ~= nil) then
				range = action.position_range
			end
			node = getNodefromPosition(position.x,position.y,position.z,range)
			
			
			else
			
			node = getNode(action.position_tag)
			
		end
		
		
		if node ~= nil then
			if(action.position_node_usegameplay == true) then
				position.x = node.gameplay_x
				position.y = node.gameplay_y
				position.z = node.gameplay_z
				else
				position.x = node.x
				position.y = node.y
				position.z = node.z
			end
			else
			error(getLang("see_action_nonode")..action.position_tag)
		end
	end
	if(action.position == "poi") then
		
		
		if(action.position_poi_district == "current") then
			action.position_poi_district = currentDistricts2.EnumName
		end
		
		if(action.position_poi_district== "random") then
			action.position_poi_district = arrayDistricts[math.random(1,#arrayDistricts)].EnumName
		end
		
		
		if(action.position_poi_subdistrict == "current") then
			
			
			if(currentDistricts2.districtLabels ~=nil and #currentDistricts2.districtLabels > 1) then
				
				action.position_poi_subdistrict = currentDistricts2.districtLabels[2]
				
				else
				
				action.position_poi_district = currentDistricts2.EnumName
				
			end
		end
		
		if(action.position_poi_subdistrict == "random") then
			local district = arrayDistricts[math.random(1,#arrayDistricts)]
			action.position_poi_subdistrict = district.SubDistrict[math.random(1,#district.SubDistrict)]
		end
		
		local range = 70
		if(action.position_range ~= nil) then
			range = action.position_range
		end
		if action.position_poi_search == nil then action.position_poi_search = "type" end
		if action.position_poi_searchdistance == nil then action.position_poi_searchdistance = "random" end
		local currentpoi = nil
		currentpoi = FindPOI(action.position_tag,action.position_poi_district,action.position_poi_subdistrict,action.position_poi_is_for_car,action.position_poi_type,action.position_poi_use_location_tag,action.position_poi_from_position,range,action.position_poi_from_position_x,action.position_poi_from_position_y,action.position_poi_from_position_z,action.position_poi_search,action.position_poi_searchdistance)
		if(currentpoi ~= nil) then
			position.x = currentpoi.x
			position.y = currentpoi.y
			position.z = currentpoi.z
			
		end
	end
	
	if(action.position == "current_poi") then
		
		
		
		if(currentPOI ~= nil) then
			
			if(
				
				(action.position_poi_is_for_car == nil or action.position_poi_is_for_car == "" or (action.position_poi_is_for_car ~= nil and action.position_poi_is_for_car == currentPOI.inVehicule)) and
				(action.type == nil or action.type == "" or (action.type ~= nil and action.type == currentPOI.type)) and
				(action.district == nil or action.district == "" or (action.district ~= nil and action.district == currentPOI.district)) and
				(action.subdistrict == nil or action.subdistrict == "" or (action.subdistrict ~= nil and action.subdistrict == currentPOI.subdistrict))
				
			) then
			
			position.x = currentpoi.x
			position.y = currentpoi.y
			position.z = currentpoi.z
			
			else
			error("can't find current poi")
			end
		end
	end
	if(action.position == "mappin") then
		
		
		if(action.position_tag == "current")then
			if(ActivecustomMappin ~= nil)then
				local mappin = ActivecustomMappin:GetWorldPosition()
				position.x = mappin.x
				position.y = mappin.y
				position.z = mappin.z
				else
				error(getLang("see_action_nocurrentmappin"))
			end
			else
			local mappin = getMappinByTag(action.position_tag)
			if(mappin)then
				position.x = mappin.position.x
				position.y = mappin.position.y
				position.z = mappin.position.z
				else
				error(getLang("see_action_nomappin")..action.position_tag)
			end
		end
	end
	if(action.position == "fasttravel") then
		local markerref = nil
		local tempos = nil
		
		if(action.position_tag == "current")then
			
			if(ActiveFastTravelMappin ~= nil)then
				position.x = ActiveFastTravelMappin.position.x
				position.y = ActiveFastTravelMappin.position.y
				position.z = ActiveFastTravelMappin.position.z
				else
				error(getLang("see_action_nocurrentfasttravel"))
			end
			
			else
			
			
			for j=1, #mappedFastTravelPoint do
				local point = mappedFastTravelPoint[j]
				if(point.markerref == action.position_tag) then
					markerref = point.markerrefdata
					tempos = point.position
					break
				end
			end
			
			if(markerref)then
				position.x = tempos.x
				position.y = tempos.y
				position.z = tempos.z
				else
				error(getLang("see_action_nofasttravel")..action.position_tag)
			end	
			
			
		end
		
	end
	if(action.position == "custom_place") then
		local house = nil
		
		if(action.position_tag == "current")then
			if(currentHouse ~= nil) then
				if(action.position_house_way == "default") then
					position.x = currentHouse.x
					position.y = currentHouse.y
					position.z = currentHouse.z
				end
				if(action.position_house_way == "Enter") then
					position.x = currentHouse.enter_x
					position.y = currentHouse.enter_y
					position.z = currentHouse.enter_z
				end
				if(action.position_house_way == "Exit") then
					position.x = currentHouse.exit_x
					position.y = currentHouse.exit_y
					position.z = currentHouse.exit_z
				end
				else
				error("can't find an current custom place")
			end
			else
			house = getHouseByTag(action.position_tag)
			if(house ~= nil) then
				if(action.position_house_way == "default") then
					position.x = house.x
					position.y = house.y
					position.z = house.z
				end
				if(action.position_house_way == "enter") then
					position.x = house.enter_x
					position.y = house.enter_y
					position.z = house.enter_z
				end
				if(action.position_house_way == "exit") then
					position.x = house.exit_x
					position.y = house.exit_y
					position.z = house.exit_z
				end
				else
				error("can't find an custom place with tag : "..action.position_tag)
			end
		end
		
		
		
	end
	if(action.position == "custom_room") then
		local room =nil
		if(action.position_tag == "current")then
			
			if(currentRoom ~= nil) then
				position.x = currentRoom.x
				position.y = currentRoom.y
				position.z = currentRoom.z
				else
				error("can't find an current custom room")
			end		
			
			else
			getRoomByTag(action.position_tag,action.position_house_tag)
			if(room ~= nil) then
				position.x = room.x
				position.y = room.y
				position.z = room.z
				else
				error("can't find an custom room with tag : "..action.position_tag.." for the house with tag :"..action.position_house_tag)
			end
			
		end
		
	end
	
	local positiontemp = deepcopy(position,nil)
	
	if(positiontemp.x ~= nil and action.position ~= "at"  and action.position_way ~= "forward_relative") then
		positiontemp.x = positiontemp.x + action.x
		positiontemp.y = positiontemp.y + action.y
		positiontemp.z = positiontemp.z + action.z
		
	end
	
	return positiontemp
	
end

function GeneratefromContext(context)
	
	local text = context.text
	
	if context.alpha == nil or context.alpha == false then
		
		for k,v in pairs(context.values)do
			
			if v.trigger == nil or checkTriggerRequirement(v.requirement,v.trigger)then
				
				if(v.action ~= nil and #v.action > 0) then
					
					runActionList(v.action, k, "see", false,"see",false)					
				end
				
				local status, retval = pcall(function()
					local value = GenerateTextFromContextValues(context, v)
					
					if((type(value) == "number" or type(value) == "string" or type(value) == "boolean") and v.type ~= "object" and v.type ~= "list") then
						text = text:gsub("##"..k, tostring(value)) 
						
						else
						
						text = value
						
					end
				end)
				
				if status == false then
					
					logme(1,getLang("see_context_error") .. retval.." Context : "..tostring(JSON:encode_pretty(context)),true)				
					if(context.fail_action ~= nil and #context.fail_action > 0) then
						runActionList(context.fail_action, "context_failure", "see",false,nil)
						
					end
					
				end
			end
		end
		
		else
		
		for k,v in orderedPairs(context.values)do
			
			if v.trigger == nil or checkTriggerRequirement(v.requirement,v.trigger)then
				
				if(v.action ~= nil and #v.action > 0) then
					
					runActionList(v.action, k, "see", false,"see",false)					
				end
				
				
				local value = GenerateTextFromContextValues(context, v)
				
				if((type(value) == "number" or type(value) == "string" or type(value) == "boolean") and v.type ~= "object" and v.type ~= "list") then
					text = text:gsub("##"..k, tostring(value)) 
					
					else
					
					text = value
					
				end
			end
		end
		
		
	end
	
	
	
	
	if(context.type ~= nil and context.type =="number") then
		if (text ~= "") then
			
			local funcs = loadstring("return " .. tostring(text),"")
			
			local res,msg = pcall(function() 
				
				text = tonumber(funcs())
			end)
			
			if res == false then
				
				text = tonumber("")
				
			end
			
			else
			
			text = tonumber(text)
		end
	end
	
	if(context.type ~= nil and context.type =="text") then
		text = tostring(text)
	end
	
	if(context.type ~= nil and context.type =="funcs") then
		if (text ~= "") then
			
			local funcs = loadstring("return " .. tostring(text),"")
			
			local res,msg = pcall(function() 
				
				text = tostring(funcs())
			end)
			
			if res == false then
				
				text = tostring("")
				
			end
			
			else
			
			text = tostring(text)
		end
	end
	
	if(context.type ~= nil and context.type =="boolean") then
		text = toboolean(text)
	end
	
	return text
	
end

function GenerateTextFromContextValues(context, v)
	
	local value = ""
	
	if(v.context_value ~= nil) then
		
		v[v.replace] = GenerateTextFromContextValues(context, context.values[v.context_value])
		
	end
	
	if(v.type == "current_district") then
		
		if(v.prop == "tag") then
			value = getVariable("current_district","tag")
		end
		
		if(v.prop == "state") then
			value = getVariable("current_district","state")
		end
		
		if(v.prop == "subdistrict") then
			value = getVariable("current_district","subdistrict_enum")
		end
		
	end
	
	if(v.type == "group") then
		
		local group = getGroupfromManager(v.tag)
		if(group ~= nil) then
			
			value = #group.entities
			
			
		end
	end
	
	if(v.type == "faction") then
		
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["faction"], v.searchprops, v.searchvalue,"data")[v.prop]
			
			else
			if(v.tag == "random") then
				
				
				
				value = getRandomPairfromTable(cyberscript.cache["faction"]).value.data[v.prop]
				else
				if(v.tag == "player") then
					v.tag = getVariableKey("player","current_gang")
					value = cyberscript.cache["faction"][v.tag].data[v.prop]
					
					else
					value = cyberscript.cache["faction"][v.tag].data[v.prop]
				end
				
			end
			
			
			
		end
	end
	
	if(v.type == "shard") then
		
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["shard"], v.searchprops, v.searchvalue,"data")[v.prop]
			
			else
			if(v.tag == "random") then
				
				
				
				value = getRandomPairfromTable(cyberscript.cache["shard"]).value.data[v.prop]
				else
				
				value = cyberscript.cache["shard"][v.tag].data[v.prop]
				
			end
			
			
			
		end
	end
	
	if(v.type == "player") then
		
		if(v.key == "item_amount") then
			
			value = getStackableItemAmount(v.value)
			
			
		end
		
		if(v.key == "item_is_equipped") then
			
			value = tostring(isEquipped(v.value))
			
			
		end
		
		if(v.key == "query_equipped_item") then
			
			value = tostring(haveOneEquippedMatch(v.value))
			
			
		end
		
		if(v.key == "skill") or (v.key == "perk") or (v.key == "attribute") then
			value = getAtttribute(v.key, v.value)
		end
		
		if(v.key == "combatstate") then
			local player = Game.GetPlayer()
			local state = player:GetCurrentCombatState()
			
			value = EnumInt(state)
		end
		
		if(v.key == "current_gang") then
			
			value = getVariableKey("player","current_gang")
			
		end
		
		if(v.key == "lifepath") then
			local player = Game.GetPlayer()
			local scriptableSystemsContainer = Game.GetScriptableSystemsContainer()
			local playerDevSystem = scriptableSystemsContainer:Get(CName.new('PlayerDevelopmentSystem'))
			local path = playerDevSystem:GetLifePath(player)
			
			value = EnumInt(path)
		end
	end
	
	if(v.type == "corpo") then
		
		
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["corpo"], v.searchprops, v.searchvalue,nil)[v.prop]
			
			else
			
			if(v.tag ~= "random") then
				if(cyberscript.cache["corpo"][v.tag] ~= nil) then
					
					value = cyberscript.cache["corpo"][v.tag][v.prop]
				end
				else
				local corpo = getRandomPairfromTable(cyberscript.cache["corpo"])
				
				if(corpo ~= nil) then
					
					value =corpo[v.prop]
				end
				
			end
		end
	end
	
	if(v.type == "lang") then
		value = getLang(v.tag)
		
	end
	
	if(v.type == "random_lang") then
		
		
		local index = math.random(1,#v.list)
		
		value = getLang(v.list[index])
		
		
		
	end
	
	if(v.type == "district_leader" or v.type == "subdistrict_leader") then
		local gangs = getGangfromDistrict(v.tag,0)
		if(#gangs > 0) then
			
			value = cyberscript.cache["faction"][gangs[1].tag].data[v.prop]
			
			
		end
	end
	
	if(v.type == "current_district_leader") then
		local gangs = getGangfromDistrict(currentDistricts2.Tag,0)
		if(#gangs > 0) then
			value = cyberscript.cache["faction"][gangs[1].tag].data[v.prop]
			
		end
	end
	
	if(v.type == "current_subdistrict_leader") then
		local gangs = {}
		for j, test in ipairs(currentDistricts2.districtLabels) do
			if j > 1 then
				gangs = getGangfromDistrict(test,0)
				if(#gangs > 0) then
					break
				end
			end
		end
		
		if(#gangs > 0) then
			value = cyberscript.cache["faction"][gangs[1].tag].data[v.prop]
			
		end
	end
	
	if(v.type == "district_rival" or v.type == "subdistrict_rival") then
		local gangs = {}
		
		if(v.tag == "player") then
			
			v.tag = getVariableKey("player","current_gang")
			
		end
		
		local gangs = getGangRivalfromDistrict(v.tag,v.district,0)
		
		if(#gangs > 0) then
			value = cyberscript.cache["faction"][gangs[1].tag].data[v.prop]
			
		end
	end
	
	if(v.type == "current_district_rival") then
		
		local gangs = {}
		
		if(v.tag == "player") then
			
			v.tag = getVariableKey("player","current_gang")
			
		end
		
		local gangs = getGangRivalfromDistrict(v.tag,currentDistricts2.Tag,0)
		if(#gangs > 0) then
			value = cyberscript.cache["faction"][gangs[1].tag].data[v.prop]
			
		end
	end
	
	if(v.type == "current_subdistrict_rival") then
		
		local gangs = {}
		
		if(v.tag == "player") then
			
			v.tag = getVariableKey("player","current_gang")
			
		end
		
		
		for j, test in ipairs(currentDistricts2.districtLabels) do
			if j > 1 then
				gangs = getGangRivalfromDistrict(v.tag,test,0)
				if(#gangs > 0) then
					break
				end
			end
		end
		if(#gangs > 0) then
			value = cyberscript.cache["faction"][gangs[1].tag].data[v.prop]
			
		end
	end
	
	if(v.type == "entity") then
		--	--print(v.tag)
		local obj = getEntityFromManager(v.tag)
		if(obj.id ~= nil) then
			local enti = Game.FindEntityByID(obj.id)	
			if(enti ~= nil) then
				
				if(v.key == "position") then
					
					local pos = enti:GetWorldPosition()
					local obj = {}
					
					obj.x = pos.x
					obj.y = pos.y
					obj.z = pos.z
					
					--	--print(dump(obj))
					
					value = obj[v.prop]
					
				end
				
				if(v.key == "distance") then
					
					if(v.target == "entity") then
						local obj = getEntityFromManager(v.targettag)
						if(obj.id ~= nil) then
							local enti = Game.FindEntityByID(obj.id)	
							if(enti ~= nil) then
								local pos = enti:GetWorldPosition()
								value = getDistance(pos, mappinManager[v.tag]["position"])
							end
							
							
						end
						
					end			
					
					
					if(v.target == "mappin") then
						local obj = getMappinByTag(v.targettag)
						if(obj ~= nil) then
							
							value = getDistance(obj.position, mappinManager[v.tag]["position"])
							
							
						end
						
					end			
					
					
					
				end
				
				if(v.key == "head_position") then
					
					
					local components =  enti:FindComponentByName("Item_Attachment_Slot")
					----print("compo"..GameDump(components))
					if(components~= nil) then
						local _,head =  components:GetSlotTransform("Head")
						--	--print("head"..GameDump(head))
						if(head ~= nil) then
							--	--print("yyyy")
							local pos =  head:GetWorldPosition():ToVector4()
							local pos2 = head:GetForward()
							local pos3 =  head:GetInverse():GetWorldPosition():ToVector4()
							local obj = {}
							
							obj.x = pos.x-(pos2.x*0.25)
							obj.y = pos.y-(pos2.y*0.25)
							obj.z = pos.z
							
							--	--print(dump(obj))
							value = obj[v.prop]
						end
						
					end
					
					
					
				end
				
				if(v.key == "look_at") then
					if v.distance == nil then v.distance =0 end
					local playerPos, playerAngle = targetS:GetCrosshairData(Game.GetPlayer())
					local playerFootPos = Game.GetPlayer():GetWorldPosition()
					playerPos.z = playerPos.z + 0.5
					local playerDeltaWorldPos = Delta(playerPos, playerFootPos)
					playerDeltaWorldPos.w = 1
					local playerOldPos = playerPos
					local playerDeltaPos = Delta(playerOldPos, playerPos)
					local phi = math.atan2(playerAngle.y, playerAngle.x)
					-- if (objPush == true) then
					-- objectDist = objectDist + 0.5
					-- objPush = false
					-- end
					-- if (objPull == true) then
					-- objectDist = objectDist - 0.5
					-- objPull = false
					-- end
					local poss = Vector4.new(((v.distance * math.cos(phi)) + playerPos.x), ((v.distance * math.sin(phi)) + playerPos.y), (v.distance * math.sin(playerAngle.z) + playerPos.z),1)
					local obj = Vector4Add(playerDeltaWorldPos, poss)
					
					
					value = obj[v.prop]
					
				end
				
				if(v.key == "head_orientation") then
					
					local components =  enti:FindComponentByName("Item_Attachment_Slot")
					
					if(components~= nil) then
						local _,head =  components:GetSlotTransform("Head")
						
						if(head ~= nil) then
							
							local angle = head:GetOrientation():ToEulerAngles()
							local obj = {}
							
							obj.yaw = angle.yaw
							obj.pitch = angle.pitch
							obj.roll = angle.roll
							----print(dump(obj))
							value = obj[v.prop]
						end
						
					end
					
				end
				
				if(v.key == "forward") then
					local pos = enti:GetWorldPosition()
					local pos2 = enti:GetWorldForward()
					local obj = {}
					
					if v.coef == nil then v.coef = 1 end
					
					-- if testcoef == nil then testcoef = 1 end
					-- v.coef = testcoef
					obj.x = pos.x+(pos2.x*v.coef)
					obj.y = pos.y+(pos2.y*v.coef)
					obj.z = pos.z+(pos2.z*v.coef)
					value = obj[v.prop]
					
				end
				
				if(v.key == "orientation") then
					
					local qat = enti:GetWorldOrientation()
					local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
					local obj = {}
					
					obj.yaw = angle.yaw
					obj.pitch = angle.pitch
					obj.roll = angle.roll
					
					value = obj[v.prop]
					
					
				end
				
				if(v.key == "tag") then
					
					
					value = obj.tag
					
				end
				
				if(v.key == "appearance") then
					
					
					value = Game.NameToString(enti:GetCurrentAppearanceName())
					
				end
				
				if(v.key == "tweak") then
					
					
					value = tostring(obj.tweak)
					
				end
				
				if(v.key == "context") then
					
					
					value = Game.NameToString(enti:GetCurrentContext())
					
				end
				
				if(v.key == "displayname") then
					
					
					value = Game.NameToString(enti:GetDisplayName())
					
				end
				
				if(v.key == "fullname") then
					
					
					value = enti:GetTweakDBFullDisplayName(false)
					
				end
				
				if(v.key == "gang") then
					
					value = getGangForEntity(enti)
					
					
				end
				
				if(v.key == "group") then
					local group = getEntityGroupfromEntityTag(obj.tag)
					if(group ~= nil) then
						
						value = group.tag
						
						
					end
				end
				
				if(v.key == "radio_index") then
					local ps = enti:GetDevicePS()
					value = ps.activeStation
				end
				
				if(v.key == "radio_name") then
					local ps = enti:GetDevicePS()
					local stations = {
						[0] = "89.3 - Radio Vexelstrom",
						[1] = "92.9 - Night FM",
						[2] = "101.9 - The Dirge",
						[3] = "103.5 - Radio Pebkac",
						[4] = "88.9 - Pacific Dreams",
						[5] = "107.3 - Morro Rock Radio",
						[6] = "98.7 - Body Heat Radio",
						[7] = "106.9 - 30 Principales",
						[8] = "96.1 - Ritual FM",
						[9] = "95.2 - Samizdat Radio",
						[10] = "91.9 - Royal Blue Radio",
						[11] = "89.7 - Growl FM",
						[12] = "107.5 - Dark Star",
						[13] = "99.9 - Impulse",
					}
					value = stations[ps.activeStation]
				end
				else
				--spdlog.error("Context : No Entity Founded for "..v.tag)
			end
			else
			--spdlog.error("Context : No Entity Founded for "..v.tag)
		end
	end
	
	if(v.type == "mappin") then
		
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(mappinManager, v.searchprops, v.searchvalue,nil)[v.prop]
			
			else
			if(v.tag ~= "random") then
				if(v.prop == "distance") then
					
					if(v.target == "entity") then
						local obj = getEntityFromManager(v.targettag)
						if(obj.id ~= nil) then
							local enti = Game.FindEntityByID(obj.id)	
							if(enti ~= nil) then
								local pos = enti:GetWorldPosition()
								value = getDistance(pos, mappinManager[v.tag]["position"])
							end
							
							
						end
						
					end			
					
					
					if(v.target == "mappin") then
						local obj = getMappinByTag(v.targettag)
						if(obj ~= nil) then
							
							value = getDistance(obj.position, mappinManager[v.tag]["position"])
							
							
						end
						
					end			
					
					
					
				end
				
				if(v.prop ~= "distance") then
					if(v.prop == "x" or v.prop =="y" or v.prop == "z") then
						value = mappinManager[v.tag]["position"][v.prop]
						
						
						
						else
						value = mappinManager[v.tag][v.prop]
						
						
					end
				end
				
				else
				
				
				if(v.prop == "x" or v.prop =="y" or v.prop == "z") then
					value = getRandomPairfromTable(mappinManager).value["position"][v.prop]
					
					
					
					else
					value = getRandomPairfromTable(mappinManager).value[v.prop]
					
					
				end
				
			end
		end
	end
	
	if(v.type == "fixer") then
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["fixer"], v.searchprops, v.searchvalue,"data")[v.prop]
			
			else
			if(v.tag ~= "random") then
				value = cyberscript.cache["fixer"][v.tag].data[v.prop]
				
				else
				value = getRandomPairfromTable(cyberscript.cache["fixer"]).value.data[v.prop]
				
			end
		end
	end
	
	if(v.type == "current_fixer" and  currentfixer ~= nil) then
		
		
		value = currentfixer[v.prop]
		
		
	end 
	
	
	if(v.type == "place") then
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["place"], v.searchprops, v.searchvalue,"data")[v.prop]
			
			else
			if(v.tag ~= "random") then
				value = cyberscript.cache["place"][v.tag].data[v.prop]
				
				else
				value = getRandomPairfromTable(cyberscript.cache["place"]).value.data[v.prop]
				
			end
		end
	end
	
	if(v.type == "current_sound" and cyberscript.soundmanager[v.tag] ~= nil) then
		
		value = cyberscript.soundmanager[v.tag][v.prop]
		
	end
	
	if(v.type == "current_radio" and currentRadio ~= nil) then
		
		value = currentRadio[v.prop]
		
	end
	
	
	if(v.type == "sound" and cyberscript.cache["sound"][v.tag] ~=nil) then
		
		value = cyberscript.cache["sound"][v.tag].sound[v.prop]
		
	end
	
	
	if(v.type == "radio" and cyberscript.cache["radio"][v.tag] ~=nil) then
		
		value = cyberscript.cache["radio"][v.tag].data[v.prop]
		
	end
	
	if(v.type == "current_radio" and currentRadio ~= nil) then
		
		value = currentRadio[v.prop]
		
	end
	
	if(v.type == "current_place" and  currentHouse ~= nil) then
		
		value = currentHouse[v.prop]
		
	end
	
	if(v.type == "current_room" and currentRoom ~= nil) then
		
		value = currentRoom[v.prop]
		
	end
	
	if(v.type == "current_poi" and currentPOI ~= nil) then
		----print(dump(currentPOI))
		
		value = currentPOI[v.prop]
	end
	
	if(v.type == "poi") then
		
		
		
		local currentpoi = nil
		currentpoi = FindPOI(v.argument.position_tag,v.argument.position_poi_district,v.argument.position_poi_subdistrict,v.argument.position_poi_is_for_car,v.argument.position_poi_type,v.argument.position_poi_use_location_tag,v.argument.position_poi_from_position,v.argument.position_range,v.argument.position_poi_from_position_x,v.argument.position_poi_from_position_y,v.argument.position_poi_from_position_z,v.argument.position_poi_search,v.argument.position_poi_searchdistance)
		if(currentpoi ~= nil) then
			
			value = currentpoi[v.prop]
			
		end
		
		
		
		
	end
	
	if(v.type == "node") then
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["node"], v.searchprops, v.searchvalue,"data")[v.prop]
			
			else
			if(v.tag ~= "random") then
				value = cyberscript.cache["node"][v.tag].data[v.prop]
				
				else
				value = getRandomPairfromTable(cyberscript.cache["node"]).value.data[v.prop]
				
			end
		end
	end
	
	if(v.type == "custom_npc") then
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.cache["npc"], v.searchprops, v.searchvalue,"data")[v.prop]
			
			else
			if(v.tag ~= "random") then
				
				if(v.prop == "x" or v.prop =="y" or v.prop == "z") then
					value = cyberscript.cache["npc"][v.tag].data["location"][v.prop]
					
					
					else
					value = cyberscript.cache["npc"][v.tag].data[v.prop]
					
					
				end
				
				
				else
				
				
				if(v.prop == "x" or v.prop =="y" or v.prop == "z") then
					value = getRandomPairfromTable(cyberscript.cache["npc"]).value.data["location"][v.prop]
					
					
					else
					value = getRandomPairfromTable(cyberscript.cache["npc"]).value.data[v.prop]
					
					
				end
			end
		end
	end
	
	if(v.type == "npc") then
		if(v.searchprops ~= nil) then
			
			value = SearchinTable(cyberscript.entitieshash, v.searchprops, v.searchvalue,nil)[v.prop]
			
			else
			
			
			local npc = getNPCByName(v.tag)
			
			if(npc ~= nil) then
				value = npc[v.prop]
			end
			
			
			
			
			
			
			
			
			
		end
	end
	
	
	
	if(v.type == "variable" or v.type == "score") then
		value = getVariableKey(v.variable,v.key)
		
		if(isArray(value))then
			if(v.index == nil) then
				local index = math.random(1,#value)
				
				value = value[index]
				
				
				else
				value = value[v.index]
			end
		end
		
		
		
	end
	
	if(v.type == "random_variable_key" or v.type == "random_score_key") then
		value = getRandomPairfromTable(currentSave.Variable[v.variable]).value
		
		
	end
	
	if(v.type == "text")then
		
		
		
		
		
		value = v.value
		
	end
	
	if(v.type == "random_text") then
		
		if(#v.list > 1) then
		local index = math.random(1,#v.list)
		
		value = v.list[index]
		
		else
		
		value = v.list[1]
		end
		
		
	end
	
	if(v.type == "number")then
		
		
		
		
		
		value = tonumber(v.value)
		
	end
	
	if(v.type == "random_number") then
		
		if(#v.list > 1) then
		local index = math.random(1,#v.list)
		
		value = v.list[index]
		
		
		else
		
		value = v.list[1]
		end
		
		
	end
	
	if(v.type == "random_math" or v.type == "random_range") then
		
		
		local index = math.random(v.min,v.max)
		
		value = index
		
		
		
		
	end
	
	if(v.type == "scannerdata" and ScannerInfoManager[v.tag] ~= nil)then
		
		
		
		if(v.prop == "primaryname" or v.prop == "secondaryname" or v.prop == "text" or v.prop == "entityname") then
			
			
			
			value = ScannerInfoManager[v.tag][v.prop]
			
			
			
		end
		
		if(v.prop == "level" or v.prop == "rarity" or v.prop == "attitude") then
			
			
			
			value = ScannerInfoManager[v.tag][v.prop]
			
			
			
		end
		
		
		if(v.prop == "reward" or v.prop == "streetreward" or v.prop == "danger" and ScannerInfoManager[v.tag]["bounty"] ~= nil) then
			
			
			
			value = ScannerInfoManager[v.tag]["bounty"][v.prop]
			
			
			
		end
		
		
		if(v.prop == "issuedby" and ScannerInfoManager[v.tag]["bounty"] ~= nil ) then
			
			
			
			value = ScannerInfoManager[v.tag]["bounty"][v.prop]
			
			
			
		end
		
		
		
		
		
		if(v.prop == "customtransgressions" or v.prop == "transgressions" and ScannerInfoManager[v.tag]["bounty"] ~= nil and #ScannerInfoManager[v.tag]["bounty"][v.prop] > 0) then
			
			if(v.index == nil) then
				local index = math.random(1,#ScannerInfoManager[v.tag]["bounty"][v.prop])
				
				value = ScannerInfoManager[v.tag]["bounty"][v.prop][index]
				else
				
				value = ScannerInfoManager[v.tag]["bounty"][v.prop][v.index]
			end
		end
		
		
		
		
		
		
		
	end
	
	if(v.type == "current_scannerdata" and currentScannerItem ~= nil)then
		
		if(v.prop == "primaryname" or v.prop == "secondaryname" or v.prop == "text" or v.prop == "entityname") then
			
			
			
			value = currentScannerItem[v.prop]
			
			
			
		end
		
		if(v.prop == "level" or v.prop == "rarity" or v.prop == "attitude") then
			
			
			
			value = currentScannerItem[v.prop]
			
			
			
		end
		
		
		if(v.prop == "reward" or v.prop == "streetreward" or v.prop == "danger" and currentScannerItem["bounty"] ~= nil) then
			
			
			
			value = currentScannerItem["bounty"][v.prop]
			
			
			
		end
		
		
		if(v.prop == "issuedby" and currentScannerItem["bounty"] ~= nil ) then
			
			
			
			value = currentScannerItem["bounty"][v.prop]
			
			
			
		end
		
		
		
		
		
		if(v.prop == "customtransgressions" or v.prop == "transgressions" and currentScannerItem["bounty"] ~= nil and #currentScannerItem["bounty"][v.prop] > 0) then
			
			
			if(v.index == nil) then
				local index = math.random(1,#ScannerInfoManager[v.tag]["bounty"][v.prop])
				
				value = currentScannerItem[v.prop][index]
				else
				
				value = currentScannerItem[v.prop][v.index]
			end
			
		end
		
		
		
		
		
		
		
	end
	
	if(v.type == "corpo_news")then
		if(#corpoNews > 0) then
			local id = math.random(1,#corpoNews)
			value = corpoNews[id]
			else
			value = "No News, please connect to Keystone on PC first."
		end
	end
	
	if(v.type == "stock") then
		
		
		if(arrayMarket ~= nil and #arrayMarket > 0) then
			
			for k,stock in ipairs(arrayMarket) do
				
				if(stock.tag == v.tag) then
					
					value = stock[v.prop]
					
				end
				
			end
			
		end
		
		
	end
	
	if(v.type == "object") then
		
		value = v.value
		
	end
	
	if(v.type == "trigger") then
		value = checkTrigger(v.trigger)
	end
	
	if(v.type == "action") then
		local status, result = pcall(executeAction(v.action,"context_action_"..tostring(math.random(1,99999)),"",1,"interact","see"))
		
		value = status
	end
	
	
	if(v.type == "list") then
		local list = {}
		for key,item in pairs(v.items)do
			
			
			
			if item.trigger == nil or checkTriggerRequirement(item.requirement,item.trigger) then
				local result = GenerateTextFromContextValues(context, item)
				
				table.insert(list,result)
				
			end
			
			value = list
			
		end
	end
	
	if(value == nil) then value = "" end
	
	local obj = deepcopy(value,nil)
	
	value = obj
	
	
	if(v.outputtype ~= nil and v.outputtype =="number") then
		value = tonumber(value)
	end
	
	if(v.outputtype ~= nil and v.outputtype =="text") then
		value = tostring(value)
	end
	
	if(v.outputtype ~= nil and v.outputtype =="boolean") then
		value = toboolean(value)
	end
	
	
	return value
	
end		
function getDistance(objA, objB)
	-- Get the length for each of the components x and y
	local xDist = objB.x - objA.x
	local yDist = objB.y - objA.y
	
	return math.sqrt( (xDist ^ 2) + (yDist ^ 2) ) 
end

function toboolean(str)
	local bool = false
	if str == "true" then
		bool = true
	end
	return bool
end																																