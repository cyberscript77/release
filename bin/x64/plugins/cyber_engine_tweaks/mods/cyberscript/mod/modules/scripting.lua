logme(1,"CyberScript: scripting module loaded")
cyberscript.module = cyberscript.module +1

---Main Function---
seerefresh  = true
mainrefresh  = true
refreshModVariabletg = true
mainrefreshstep1 = true
mainrefreshstep2 = true
mainrefreshstep3 = true
mainrefreshstep4 = true
mainrefreshstep5 = true
mainrefreshstep6 = true
mainrefreshstep7 = true
mainrefreshstep8 = true

function mainThread(active)-- update event when mod is ready and in game (main thread for execution)
	
	if active then
	
		
			
		--Pause Menu and Ambush timer
		if(inMenu) then
			if(GameController["SubtitlesGameController"] ~= nil) then
				pcall(function() GameController["SubtitlesGameController"]:Cleanup() end)
			end
			
			if(open1menu == nil) then
				
				local activeData = CodexListSyncData.new()
				local gameshards = CodexUtils.GetShardsDataArray(GameInstance.GetJournalManager(), activeData)
				if gameshardscompiled == nil then gameshardscompiled = {} end
				for i,v in pairs(gameshards) do
					if gameshardscompiled[v.data.title] == nil then gameshardscompiled[v.data.title] = true end
					
					
				end		
				
				open1menu = true
			end
			
			if(ActiveMenu == "PauseMenu" ) then
				if(ExecPauseMenu == false and getUserSetting("AutoRefreshDatapack") == true) then
					ExecPauseMenu =  true
					
					loadModule()
					
					LoadDataPackCache()
					
					
				end
				else
				if(ExecPauseMenu == true) then
					ExecPauseMenu =  false
				end
			end
			else
			open1menu = nil
			if(ExecPauseMenu == true) then
				ExecPauseMenu =  false
			end
			
		end
		
		
		
		
		if mainrefreshstep1 then
			--AutoAmbush (disable ambush event when MainQuest or SideQuest is active)
		if (AutoAmbush == 1) then 
			-- MainQuest = 0,
			-- SideQuest = 1,
			-- MinorQuest = 2,
			-- StreetStory = 3,
			-- Contract = 4,
			-- VehicleQuest = 5
			local objective = Game.GetJournalManager():GetTrackedEntry()
			if objective ~= nil then
				local phase = Game.GetJournalManager():GetParentEntry(objective)
				local quest = Game.GetJournalManager():GetParentEntry(phase)
				
				if(string.match(tostring(quest:GetType()), "MainQuest") or string.match(tostring(quest:GetType()), "SideQuest"))then
					if(AmbushEnabled ~= 0)then
						AmbushEnabled = 0
						updateUserSetting("AmbushEnabled",AmbushEnabled)
					end
					else
					if(AmbushEnabled ~= 1)then
						AmbushEnabled = 1
						updateUserSetting("AmbushEnabled",AmbushEnabled)
					end
					end
				
			end
			
		end
		
		--refresh global variable
		refreshModVariable(refreshModVariabletg)
		--refresh widget controller
		refreshUIWidgetController(true)
		
		
		
		
		--Targeted entity
		objLook = Game.GetTargetingSystem():GetLookAtObject(Game.GetPlayer(),false,false)
		if(objLook ~= nil) then
			pcall(function()
				if(objLook ~= nil) then
					
					
					
					
					if(objLook ~= nil) then
						tarName = objLook:ToString()
						--	logme(10,tostring(objLook:GetHighLevelStateFromBlackboard()))
						if(string.match(tarName, "NPCPuppet"))then
							-- objLook:MarkAsQuest(true)
							-- logme(10,GameDump(objLook:GetCurrentOutline()))
							appName = Game.NameToString(objLook:GetCurrentAppearanceName())
							targName = tostring(objLook:GetTweakDBDisplayName(true))
							openCompanion, gangscore, lookatgang = checkAttitudeByGangScore(objLook)
							
							
						end
						
						local obj = getEntityFromManagerById(objLook:GetEntityID(),true)
						
						if(obj.id ~= nil and obj.tag ~= "lookatnpc") then
							cyberscript.EntityManager["lookatentity"].tag = obj.tag
							cyberscript.EntityManager["lookatnpc"].id = nil
							cyberscript.EntityManager["lookatnpc"].tweak = "None"
							if obj.isquest == nil then obj.isquest = false end
							
							objLook:MarkAsQuest(obj.isquest)
							
							else
							
							
							cyberscript.EntityManager["lookatentity"].tag = ""
							
							if cyberscript.EntityManager["lookatnpc"].isquest == nil then cyberscript.EntityManager["lookatnpc"].isquest = false end
							
							objLook:MarkAsQuest(cyberscript.EntityManager["lookatnpc"].isquest)
							
							pcall(function ()
								if(objLook:GetRecordID() ~= nil and objLook:GetRecordID().hash ~= nil and cyberscript.entitieshash[tostring(objLook:GetRecordID().hash)] ~= nil) then
									
									
									cyberscript.EntityManager["lookatnpc"].tweak =  cyberscript.entitieshash[tostring(objLook:GetRecordID().hash)].entity_tweak
									
								end
							end)
							
							--	cyberscript.EntityManager["lookatnpc"].id = nil
							cyberscript.EntityManager["lookatnpc"].id = objLook:GetEntityID()
							
						end
						
						
						
						
						
						-- end
						
						objLookIsVehicule = objLook:IsVehicle()
						local obj = getEntityFromManagerById(objLook:GetEntityID())
						
						else
						
						openCompanion = false
						objLookIsVehicule = false
					end
					else
					
					if(cyberscript.EntityManager["lookatnpc"].id ~= nil) then
						cyberscript.EntityManager["lookatnpc"].id = nil
						cyberscript.EntityManager["lookatnpc"].tweak = "None"
						currentScannerItem = nil
						cyberscript.EntityManager["lookatentity"].tag = ""
						openCompanion = false
						objLookIsVehicule = false
					end
				
					
					
				end
			end)
		end
		
		
		
		
		--Vehicle
		local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
		if (inVehicule) then
			
			local vehicule = Game['GetMountedVehicle;GameObject'](Game.GetPlayer())
			if(vehicule ~= nil) then
				local obj = getEntityFromManagerById(vehicule:GetEntityID())
				inVehiculeTweak = ""
				
				local isThiscar = (obj.id ~= nil and obj.isAV == true)
				
						
						cyberscript.EntityManager["current_car"] = deepcopy(obj)
								cyberscript.EntityManager["current_car"].tag = "current_car"
						cyberscript.EntityManager["current_car"].id = vehicule:GetEntityID()
						
				
				if isThiscar then
					AVisIn = true
					
					
					CurrentAVEntity =  vehicule
					local fppComp = Game.GetPlayer():GetFPPCameraComponent()
					
					local bool = false
					-- bool = IsPlaying("env")
					-- if(bool == false) then
					-- local sound = getSoundByNameNamespace("av_engine.mp3","av")
					-- if(sound ~= nil) then
					-- local path = cyberscript.soundpath..sound.path
					-- PlaySound(sound.name,path,"env",100)
					-- end
					-- end
					
					
					end
				
			end
		
			--AV
			refreshAV()
		
		else
		
			
			if(cyberscript.EntityManager["current_car"] and cyberscript.EntityManager["current_car"].id ~= nil) then
				cyberscript.EntityManager["current_car"].id = nil
			end
			
		end
		
		
		end
		
		
		if mainrefreshstep3 then
		--POI Correction (deprecated)
		if wantcorrectpoi == true then
			
			CorrectAllPOI()
			
		end
		
		end
		
		if mainrefreshstep4 then
		--Ambush
		if (tick % (AmbushMin*60*60) == 0) then --every X second
			
			if(isEmpty(cyberscript.cache["event"]) == false) then
				checkAmbush()
			end
			
		end
		
		--Timer
		if(currentTimer ~= nil) then
			
			ticktimer = ticktimer +1
			local texttimer = currentTimer.message.." : "..tostring(math.ceil((ticktimer/60))).." seconds"
			
			if(currentTimer.type == "remaning") then
				
				
				texttimer =  currentTimer.message.." : "..tostring(currentTimer.value - math.ceil((ticktimer/60))).." seconds"
				
				
				
			end
			
			setVariable("current_timer","text",texttimer)
			
			else
			setVariable("current_timer","text","")
		end
		
		
		end
		
		if mainrefreshstep5 then
		--Timers 
		if (tick % 6 == 0) then --every 0.5 second
			if itemsdirectmod ~= nil and itemsdirectmod.state == true then
				
				-- playerPos, playerAngle = targetS:GetCrosshairData(Game.GetPlayer())
				-- playerFootPos = Game.GetPlayer():GetWorldPosition()
				-- playerPos.z = playerPos.z+0.5
				-- playerDeltaWorldPos = Delta(playerPos, playerFootPos)
				-- playerDeltaWorldPos.w = 1
				-- if (playerOldPos == nil) then
					-- playerOldPos = playerPos
				-- end
				-- playerDeltaPos = Delta(playerOldPos, playerPos)
				-- phi = math.atan2(playerAngle.y, playerAngle.x)
				-- -- if (objPush == true) then
				-- -- objectDist = objectDist + 0.5
				-- -- objPush = false
				-- -- end
				-- -- if (objPull == true) then
				-- -- objectDist = objectDist - 0.5
				-- -- objPull = false
				-- -- end
				-- poss = Vector4.new(((objectDist * math.cos(phi)) + playerPos.x), ((objectDist * math.sin(phi)) + playerPos.y), (objectDist * math.sin(playerAngle.z) + playerPos.z),1)
				-- --poss = Vector4Add(targetDeltaPos, poss)
				local offset = {}
				local testts, playerAngle = targetS:GetCrosshairData(Game.GetPlayer())
				offset.x = -0.5
				offset.y = 2
				offset.z = 1
				local offsetpos = getForwardPosition2(Game.GetPlayer(),3,offset)
				print("offsetpos"..dump(offsetpos))
				local poss = offsetpos
				poss.z = poss.z + offset.z +  playerAngle.z
				print(dump(poss))
				-- poss.x = poss.x + playerDeltaPos.x
				-- poss.y = poss.y + playerDeltaPos.y
				-- poss.z = poss.z + playerDeltaPos.z
				
				-- print(dump(poss))
				local angless = Game.GetPlayer():GetWorldOrientation():ToEulerAngles()
				--local angless = EulerAngles.new(itemsdirectmod.target.Roll, itemsdirectmod.target.Pitch,  itemsdirectmod.target.Yaw)
				
				
				if(itemsdirectmod.target.X ~= poss.x and itemsdirectmod.target.Y ~= poss.y ) then
					
					updateItemPosition(itemsdirectmod.target, poss, angless, true)
					
				end
				
				
				
				
				
			end
			
			
			if(isEmpty(arrayBoundedEntity) == false) then
				for k,v in pairs(arrayBoundedEntity) do
					
					
					
					local obj = getEntityFromManager(k)
					local enti = Game.FindEntityByID(obj.id)
					if(enti ~= nil) then
						
						local anchorobj = getEntityFromManager(v.anchor)
						local anchorenti = Game.FindEntityByID(anchorobj.id)
						if(anchorenti ~= nil) then
							
							local position = anchorenti:GetWorldPosition()
							
							local qat = anchorenti:GetWorldOrientation()
							local rotation = GetSingleton('Quaternion'):ToEulerAngles(qat)
							
							if(v.copyrotation == false) then
								
								qat = enti:GetWorldOrientation()
								rotation = GetSingleton('Quaternion'):ToEulerAngles(qat)
								
							end
							
							
							
							
							
							local isplayer = false
							if k == "player" then
								isplayer = true
							end
							
							position.x = position.x + v.x
							position.y = position.y + v.y
							position.z = position.z + v.z
							
							rotation.yaw = rotation.yaw + v.yaw
							rotation.pitch = rotation.pitch + v.pitch
							rotation.roll = rotation.roll + v.roll
							
							if(
								(
									arrayBoundedEntity[k].lastposition.x ~= position.x or
									arrayBoundedEntity[k].lastposition.y ~= position.y or 
									arrayBoundedEntity[k].lastposition.z  ~= position.z
								) 
								or
								(
									v.copyrotation == true and (
										
										arrayBoundedEntity[k].lastorientation.yaw ~= rotation.yaw or
										arrayBoundedEntity[k].lastorientation.pitch ~= rotation.pitch or 
										arrayBoundedEntity[k].lastorientation.roll  ~= rotation.roll
									)
								)
								
								
							) then
							
							
							arrayBoundedEntity[k].lastposition.x = position.x
							arrayBoundedEntity[k].lastposition.y = position.y
							arrayBoundedEntity[k].lastposition.z = position.z
							
							
							
							arrayBoundedEntity[k].lastorientation.yaw = rotation.yaw
							arrayBoundedEntity[k].lastorientation.pitch = rotation.pitch
							arrayBoundedEntity[k].lastorientation.roll = rotation.roll
							
							
							
							if(v.isitem == true) then
								local item = {}
								
								enti:GetEntity():Destroy()
								
								local transform = Game.GetPlayer():GetWorldTransform()
								transform:SetPosition(position)
								transform:SetOrientationEuler(rotation)
								cyberscript.EntityManager[k].id = exEntitySpawner.Spawn(obj.tweak, transform)
								
								else
								
								teleportTo(objlook, position, rotation, isplayer)
							end
							
							
							
							end
							
							
						end
						
						else
						
						--arrayBoundedEntity[k] = nil
						
					end
					
					
				end
			end
			--TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
			--POI Location
			if(getUserSetting("AutoCheckPOI") == true) then
				
				currentPOI = FindPOI("",getVariableKey("current_district","enum"),getVariableKey("current_district","subdistrict_enum"),inVehicule,nil,false,true,getUserSetting("CurrentPOIDetectionRange"),nil,nil,nil,"district","near")
				
			end
			refreshUIWidget()
			
			if curPos ~= nil and displayHUD["main_root_default"] ~= nil then
				
					
					
					
					
					for k,v in pairs(cyberscript.cache["hud"]) do
						if(v.data.requirement == nil or checkTriggerRequirement(v.data.requirement,v.data.trigger))then
							if(v.data.type == "widget" or v.data.type == "container")then
								
								checkContext(v.data)
								
							end
							if(v.data.type == "widget" and displayHUD[k] ~= nil) then
							
								displayHUD[k]:SetText(v.data.text)
								displayHUD[k]:SetFontFamily(v.data.fontfamily)
								displayHUD[k]:SetFontStyle(v.data.fontstyle)
								displayHUD[k]:SetFontSize(v.data.fontsize)
								displayHUD[k]:SetTintColor(gamecolor(v.data.color.red,v.data.color.green,v.data.color.blue,1))
								displayHUD[k]:SetMargin(inkMargin.new({ top = v.data.margin.top, left = v.data.margin.left}))
								displayHUD[k]:SetVisible(v.data.visible)
								
							end
							
							if(v.data.type == "container" and displayHUD[k] ~= nil) then
								
								displayHUD[k]:SetMargin(inkMargin.new({ top = v.data.margin.top, left = v.data.margin.left}))
							
								displayHUD[k]:SetVisible(v.data.visible)
								
								
							end
						end
						
					end
					
					
					for k,v in pairs(cyberscript.cache["hud"]) do
						if(v.data.type == "theme" )then
							
							if(v.data.theme ~= nil) then
								for i,thme in ipairs(v.data.theme) do
									
									if( displayHUD[thme.target] ~= nil) then
										
										
										if(thme.requirement == nil or checkTriggerRequirement(thme.requirement,thme.trigger))then
											checkContext(thme)
											
											
											
											
											if(thme.fontfamily ~= nil) then displayHUD[thme.target]:SetFontFamily(thme.fontfamily) end
											if(thme.fontstyle ~= nil) then displayHUD[thme.target]:SetFontStyle(thme.fontstyle) end
											if(thme.fontsize ~= nil) then displayHUD[thme.target]:SetFontSize(thme.fontsize) end
											if(thme.color ~= nil) then displayHUD[thme.target]:SetTintColor(gamecolor(thme.color.red,thme.color.green,thme.color.blue,1)) end
											if(thme.margin ~= nil) then displayHUD[thme.target]:SetMargin(inkMargin.new({ top = thme.margin.top, left = thme.margin.left})) end
											if(thme.text ~= nil) then displayHUD[thme.target]:SetText(thme.text) end
											if(thme.visible ~= nil) then displayHUD[thme.target]:SetVisible(thme.visible) end
											if(thme.anchor ~= nil) then displayHUD[thme.target]:SetAnchor(thme.anchor) end
											if(thme.parent ~= nil) then displayHUD[thme.target]:Reparent(displayHUD[thme.parent]) end
											if(thme.scrollspeed ~= nil) then displayHUD[thme.target]:SetScrollTextSpeed(thme.scrollspeed) end
										end
									end
									
								end
								
								else
								if( displayHUD[v.data.target] ~= nil) then
									if(v.data.requirement == nil or checkTriggerRequirement(v.data.requirement,v.data.trigger))then
										checkContext(v.data)
										
										if(v.data.fontfamily ~= nil) then displayHUD[v.data.target]:SetFontFamily(v.data.fontfamily) end
										if(v.data.fontstyle ~= nil) then displayHUD[v.data.target]:SetFontStyle(v.data.fontstyle) end
										if(v.data.fontsize ~= nil) then displayHUD[v.data.target]:SetFontSize(v.data.fontsize) end
										if(v.data.color ~= nil) then displayHUD[v.data.target]:SetTintColor(gamecolor(v.data.color.red,v.data.color.green,v.data.color.blue,1)) end
										if(v.data.margin ~= nil) then displayHUD[v.data.target]:SetMargin(inkMargin.new({ top = v.data.margin.top, left = v.data.margin.left})) end
										if(v.data.text ~= nil) then displayHUD[v.data.target]:SetText(v.data.text) end
										if(v.data.visible ~= nil) then displayHUD[v.data.target]:SetVisible(v.data.visible) end
										if(v.data.anchor ~= nil) then displayHUD[v.data.target]:SetAnchor(v.data.anchor) end
										if(v.data.parent ~= nil) then displayHUD[v.data.target]:Reparent(v.data.parent) end
										if(v.data.scrollspeed ~= nil) then displayHUD[v.data.target]:SetScrollTextSpeed(v.data.scrollspeed) end
									end
								end
							end
							
							
							
						end
					end
					
					
					if(currentDistricts2 ~= nil)then
						
						
						
						
						
							if(displayHUD["factionwidget"]~= nil)then
								displayHUD["factionwidget"]:RemoveAllChildren()
								
								displayHUD["factionwidget"]:SetVisible(((not inScanner) and GameController["HUDManager"].state == HUDState.ACTIVATED ))
							
								if(currentDistricts2.districtLabels ~= nil and #currentDistricts2.districtLabels > 0) then
									local gangslist = {}
									if(#currentDistricts2.districtLabels > 1) then
										local gangs = getGangfromDistrict(currentDistricts2.districtLabels[2],20)
										
										if(#gangs > 0) then
											for i=1,#gangs do
												if(getScoreKey("Affinity",gangs[i].tag) ~= nil) then
													table.insert(gangslist,gangs[i])
													
												end
											end
										end
										else
										local gangs = getGangfromDistrict(currentDistricts2.districtLabels[1],20)
										
										if(#gangs > 0) then
											for i=1,#gangs do
												if(getScoreKey("Affinity",gangs[i].tag) ~= nil) then
													table.insert(gangslist,gangs[i])
													
												end
											end
										end
										
									end
									
									if(#gangslist > 0) then
										for i,v in ipairs(gangslist) do
											
											
											local gang = getFactionByTag(v.tag)
											
											local top = (i*50)
											locationWidgetPlace_top = locationWidgetFactionDisctrict_top + (i*50) + 50
											
											local isleader = (i==1)
											
											displayGangScoreWidget(getScoreKey("Affinity",v.tag),gang.name,displayHUD["factionwidget"],top,isleader)
											
											
										end
										
									end
									
									
									
								end
							
							end
						
						
						
						
					end
					
					if displayHUD["main_root_default"].name ~= nil and displayHUD["main_root_default"]:IsA('inkWidget') then
						
						displayHUD["main_root_default"]:SetVisible(true)
						
						
						
						
						
						
					end
					
					else
					if displayHUD["main_root_default"] ~= nil then
						
							for k,v in pairs(cyberscript.cache["hud"]) do
						if(v.data.requirement == nil or checkTriggerRequirement(v.data.requirement,v.data.trigger))then
							if(v.data.type == "widget" or v.data.type == "container")then
								
								checkContext(v.data)
								
							end
							if(v.data.type == "widget" and displayHUD[k] ~= nil  and displayHUD[k].visible == true) then
							
								
								displayHUD[k]:SetVisible(false)
								
							end
							
							if(v.data.type == "container" and displayHUD[k] ~= nil) then
								
								
								displayHUD[k]:SetVisible(v.data.visible)
								
								
							end
						end
						
					end
						displayHUD["main_root_default"]:SetVisible(false)
					end
				
				
			end	
			
			if(isEmpty(cyberscript.soundmanager) == false) then
				for k,v in pairs(cyberscript.soundmanager) do
					
					if(v.isplaying == true and v.endplaying ~=nil) then
						
						if( os.time(os.date("!*t")) >=v.endplaying+1) then
							
							if(v.needrepeat == false) then
								
								Stop(v.tag)
								
								else
								
								local obj = deepcopy(v,nil)
								Stop(v.tag)
								PlaySound(obj.tag,obj.isradio,obj.needrepeat)
								
								
							end
						end
						
						
					end
					
					
					
				end
			end
			
			if(isEmpty(cyberscript.EntityManager) == false) then
				for k,v in pairs(cyberscript.EntityManager) do
					
					if(v.spawntimespan ~= nil and v.spawntimespan ~= v.despawntimespan) then
						
						if( os.time(os.date("!*t"))+1 >=v.despawntimespan) then
							
							despawnEntity(k)
						end
						
						
					end
					
					
					
				end
			end
			
		end
		end
		
		if mainrefreshstep6 then
		if (tick % 60 == 0) then --every 1 second
			if(isEmpty(cyberscript.cache["event"]) == false) then
				doTriggeredEvent()
			end
			
			if(isEmpty(cyberscript.cache["npc"]) == false) then
				checkNPC()
				
			end
			
			if(isEmpty(cyberscript.cache["fixer"]) == false) then
				checkFixer()
			end
			
			if activeMetroDisplay == true then
				MetroCurrentTime = MetroCurrentTime - 1
				logme(10,MetroCurrentTime)
				if MetroCurrentTime <= 0 then
					activeMetroDisplay = false
				end
			end
			
			for k,v in pairs(AIhandler) do
			
				local cacheaiLoadinganswer = GetAnswer(k)
				
				if(cacheaiLoadinganswer ~= nil and cacheaiLoadinganswer ~= "") then
					logme(1,k)
					logme(1,cacheaiLoadinganswer)
					AIhandler[k].answer = cacheaiLoadinganswer
					
				end
			end
		
			
		end
		end
		
		if mainrefreshstep7 then
		if (tick % 120 == 0) then --every 2 second
			playRadio()
			-- if(GameController["PhoneHotkeyController"] ~= nil) then
			-- 	PhoneHotkeyController_UpdateData(GameController["PhoneHotkeyController"])
			-- end
		end
		end
		
		if mainrefreshstep8 then
		if (tick % 180 == 0) then --every 3 second
			
			
			
			
			if(npcStarSpawn) then
				if(timerDespawn ~= nil) then
					local currentime = getGameTime()
					if(currentime.day > timerDespawn.day or currentime.hour > timerDespawn.hour) then
						despawnEntity("current_star")
						timerDespawn = nil
						npcStarSpawn = nil
					end
				end
			end
		end
		
		
		if (tick % 1800 == 0) then --every 30 second
			
			
					local activeData = CodexListSyncData.new()
					local gameshards = CodexUtils.GetShardsDataArray(GameInstance.GetJournalManager(), activeData)
					if gameshardscompiled == nil then gameshardscompiled = {} end
					for i,v in pairs(gameshards) do
						if gameshardscompiled[v.data.title] == nil then gameshardscompiled[v.data.title] = true end
						
						
					end	
		end
		
		end
		
		
		
		
		-- if(collectgarbage("count") > 500000) then
			
			-- collectgarbage("collect")
		-- end
	end
	
	
end

function inGameInit() -- init some function after save loaded
	loadHUD()
	
	LoadDataPackCache()
	candrwMapPinFixer= false
	cancheckmission = true
	choiceHubData =  gameinteractionsvisInteractionChoiceHubData.new()
	choiceHubData.active =true 
	choiceHubData.flags = EVisualizerDefinitionFlags.Undefined
	choiceHubData.title = "possibleInteractList" --'Test Interaction Hub'
	
	loadUIsetting()
	
	
	local inkSystem = Game.GetInkSystem();
	local layers = inkSystem:GetLayers();

	for i,layer in ipairs(layers) do
	  for j,controller in ipairs(layer:GetGameControllers()) do
		if(GameController[NameToString(controller:GetClassName())] == nil) then
			GameController[NameToString(controller:GetClassName())] = controller
		end
		
	  end
	end
	
	
	theme = CPS.theme
	color = CPS.color
	cyberscript.GroupManager = {}
	cyberscript.EntityManager = {}
	--Game.GetTimeSystem():SetTimeDilation("cyberscript", 0)
	
  doInitEvent()

	
	local entity = {}
	entity.id = Game.GetPlayer():GetEntityID()
	entity.tag = "player"
	entity.tweak = "player"
	cyberscript.EntityManager[entity.tag] = entity
	
	if (Immortal) then
					
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
		
		
		
		InfiniteStamina(InfiniteStaminas)
		
	
			
		
			
	
	draw = true
	
	despawnAll()
	local codewareIsInstalled,message = pcall(function()
		Game.GetDynamicEntitySystem()
	end)
	if(codewareIsInstalled == true) then
	local storedentity =  Game.GetDynamicEntitySystem():GetTaggedIDs("CyberScript")
	print("storedentity"..dump(storedentity))
	for i,entid in ipairs(storedentity) do
		
		local tags = Game.GetDynamicEntitySystem():GetTags(entid)
		--print("tags"..dump(tags))
		
		local tagsString = {}
		
		for k,v in ipairs(tags) do
		  	
		--	print("vs"..Game.NameToString(v))
		  	table.insert(tagsString,Game.NameToString(v))
		
		end
		print("tagsString"..dump(tagsString))
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
		logme(1,"entid "..dump(entid))
		if(cstag ~= "" and Game.FindEntityByID(entid):GetRecordID() ~= nil and cyberscript.entitieshash[tostring(Game.FindEntityByID(entid):GetRecordID().hash)] ~= nil)then
		
			local entity = {}
			entity.id = entid
			entity.spawntimespan = os.time(os.date("!*t"))+0
			entity.despawntimespan = os.time(os.date("!*t"))+0
			entity.tag = cstag
			entity.isitem = false
			entity.tweak = cyberscript.entitieshash[tostring(Game.FindEntityByID(entid):GetRecordID().hash)].entity_tweak
			--	print("tweak"..entity.tweak)
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
	
	else
	
	print("no codeware founded")
	
	end
	if(showcyberscriptfixeronmap) then
		setNewFixersPoint()
	end
	setCustomLocationPoint() 
	
	--createInteraction(true)
	local blackboardDefs = Game.GetAllBlackboardDefs()
	local blackboardPSM = Game.GetBlackboardSystem():GetLocalInstanced(Game.GetPlayer():GetEntityID(), blackboardDefs.PlayerStateMachine)
	blackboardPSM:SetInt(blackboardDefs.PlayerStateMachine.SceneTier, 1, true) -- GameplayTier.Tier1_FullGameplay 
	--Game.GetTimeSystem():SetTimeDilation("cyberscript", 0)
	 
	
	currentObjectiveId = 0
	inkCompoundRef.RemoveAllChildren(GameController["QuestTrackerGameController"].ObjectiveContainer)
	local activeData = CodexListSyncData.new()
					local gameshards = CodexUtils.GetShardsDataArray(GameInstance.GetJournalManager(), activeData)
					gameshardscompiled = {}
					for i,v in pairs(gameshards) do
						if gameshardscompiled[v.data.title] == nil then gameshardscompiled[v.data.title] = true end
						
						
					end	
	
pcall(function()
	Game.GetSettingsSystem():GetVar("/gameplay/performance", "CrowdDensity"):SetValue("High")
	cyberscript.language = Game.GetSettingsSystem():GetVar("/language", "OnScreen"):GetValue().value
end)
	print(getLang("seestarted"))
end


function SEERefresh(active) 
	if active == true then
		executeRealTimeActions(false)
		executeRealTimeScript(false)
		if (autoScript == true) then
			CompileCachedThread()
			ScriptExecutionEngine()
		end
		QuestThreadManager()
		executeRealTimeActions(true)
		executeRealTimeScript(true)
	end
end


function refresh(delta) -- update event (include thread refresh action and QuestThreadManager)
	
	if(isGameLoaded == false) then
		isGameLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():IsPreGame()
	end
	if(ModIsLoaded) then
		if isGameLoaded  then
			if initFinished then
				tick = tick +1
				if(tick > 10000000)then
				tick = 100
				end
				local firstLaunch = tick
				Cron.Update(delta)
				if(tick > 60)then
					if(tick >= 61 and tick <= 62 and draw == false)then
						local datapackresult,datapackerror  = pcall(function()
							DatapackLoading()
							LoadDataPackCache()
							end)
							
							if datapackresult == false then
								
								
							logme(1,"!!!!! CYBERSCRIPT : ERROR IN DATAPACK LOADING" .. datapackerror)
								
							end
						inGameInit() --first playable frame
						
					end
					
					if(hotreload == true and inMenu == false) then
							hotreload = false
							Game.GetPlayer():SetWarningMessage(getLang("CyberScript : Hot Reload in progress..."))
							loadModule()
							
							Game.GetPlayer():SetWarningMessage(getLang("CyberScript : Hot Reload finished !"))
							
					else
				
						if saveLocationEnabled then
							savePath(recordRotation,recordRelative,recordRotationOnly)
						end
						
						if playLocationEnabled then
							playPath()
							playtick = playtick+1
						end
						
						SEERefresh(seerefresh) 
												
						mainThread(mainrefresh)
					
					end
				
				else
					draw = false
				end
			else
				if Game.GetPlayer() and initFinished == false and GameUI.IsLoading() == false then
					
					if(nativeSettings ~= nil) then
						nativesettingEnabled = true
					end
					
					initFinished = true
					draw = true
				end	
			end
		end
	end
end


function executeRealTimeScript(after)
	
	for key,value in pairs(directWorkerTable) do --actualcode
		
		if((value.after == nil and after == false) or (value.after ~= nil and value.after == after)) then
			if workerTable[key] == nil then
				runActionList(value.actionlist,value.tag,"interact",false,"nothing")
			end
		end
	end
	
	
end


function executeRealTimeActions(after)
	
	for key,value in pairs(directActionsWorkerTable) do --actualcode
		if((value.after == nil and after == false) or (value.after ~= nil and value.after == after)) then
		
		for i,v in ipairs(value.actionlist) do
			
			
				local status, retval = pcall(executeAction,v,key,"",i,"interact","see_engine")
				
				
				
				if status == false then
					
					
					logme(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((value.actionlist[i]))).." tag "..key.." parent ".."".." index "..i)
					logme(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((value.actionlist[i]))).." tag "..key.." parent ".."".." index "..i)
					--Game.GetPlayer():SetWarningMessage("CyberScript Scripting error, check the log for more detail")
					
				end
			end
			
			
		end
	end
	
	
end


--Script Execution Engine
function CompileCachedThread()
	workerTableKey = {}
	if(workerTable ~= nil)then
		
		for k in pairs(workerTable) do
			table.insert(workerTableKey, k)
		end
		
	end
	
end

function ScriptExecutionEngine()
	
	
	if(workerTable ~= nil )then
		
		
		
		for i,v in ipairs(workerTableKey) do 
			local k = workerTableKey[i]
			if(workerTable[k] ~= nil) then
				
				if(GameUI.IsMenu() == false or (workerTable[k]["bypassMenu"] ~= nil and workerTable[k]["bypassMenu"] == true)) then
					local index = workerTable[k]["index"]
					local list = workerTable[k]["action"]
					local parent = workerTable[k]["parent"]
					local pending = workerTable[k]["pending"]
					
					-- logme(4,k)
					-- logme(4,list)
					-- logme(4,index)
					
					if(workerTable[k]["index"] > #workerTable[k]["action"] and workerTable[k]["pending"] == false and workerTable[k]["started"] == true) then
						
						if workerTable[k]["parent"] ~= nil and workerTable[k]["parent"] ~= ""then
							
							if(workerTable[workerTable[k]["parent"]] ~= nil) then
								workerTable[workerTable[k]["parent"]]["pending"] = false
								workerTable[workerTable[k]["parent"]]["last_update"] =tostring(os.date("%x %X", os.time()))
								workerTable[workerTable[k]["parent"]]["index"] = workerTable[workerTable[k]["parent"]]["index"] + 1
							end
						end
						
						if workerTable[k]["children"] == "" then
							
							--
							
							if(workerTable[k].quest == nil)then
								workerTable[k] = nil
								workerTableKey[i] = nil
								else
								workerTable[k].disabled = true
							end
							
							else
							
							if workerTable[workerTable[k]["children"]] == nil then
								
								--workerTable[k] = nil
								--workerTableKey[i] = nil
								--		workerTable[k].disabled = true
								if(workerTable[k].quest == nil or workerTable[k].quest == false)then
									workerTable[k] = nil
									workerTableKey[i] = nil
									else
									workerTable[k].disabled = true
								end
							end
							
						end
						
						
					end
					
					if(workerTable[k] ~= nil) then
						
						if(index <= #list and workerTable[k].disabled == false) then
							workerTable[k]["started"] = true
							if(pending == false) then
								
								if(workerTable[k]["index"] ~= nil) then
									
									if(list[index].name == "goto") then
										
										if(list[index].parent == true) then
											logme(4,"Go to"..list[index].index.." of "..parent)
											
											workerTable[parent]["index"] = list[index].index-1
											workerTable[k]["index"] = workerTable[k]["index"]+1
											workerTable[parent]["pending"] =  false
											k = parent
											else
											logme(4,"Go to"..list[index].index.." of "..k)
											
											
											workerTable[k]["index"] = list[index].index 
										end
										
										else
										local isfinish = false
										
										
										local action = list[index]
										
										if(forcecrashSEE == false) then
											
											local status, retval = pcall(executeAction,action,k,parent,workerTable[k]["index"],workerTable[k]["source"],workerTable[k]["executortag"])
											
											
											
											if status == false then
												
												
												logme(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((list[index]))).." tag "..k.." parent "..parent.." index "..workerTable[k]["index"],true)
												logme(1,getLang("scripting_error") .. retval.." Action : "..tostring(JSON:encode_pretty((list[index]))).." tag "..k.." parent "..parent.." index "..workerTable[k]["index"],true)
												--Game.GetPlayer():SetWarningMessage("CyberScript Scripting error, check the log for more detail")
												workerTable[k] =  nil
												else
												isfinish = retval
												
											end
											
											else
											
											executeAction(action,k,parent,workerTable[k]["index"],workerTable[k]["source"],workerTable[k]["executortag"])
											isfinish = true
										end
										
										
										
										if(workerTable[k] ~= nil) then
											if(isfinish == true) then
												
												
												workerTable[k]["index"] = workerTable[k]["index"]+1
												
												--logme(4,"action finished")
												workerTable[k]["pending"] = false
												workerTable[k]["last_update"] =tostring(os.date("%x %X", os.time()))
												else
												
												workerTable[k]["pending"] = true
												
												
												
												
											end
											
											
										end
										
									end
									
									else
									
									--	workerTable[k] =  nil
									--workerTable[k].disabled = true
									--	workerTableKey[i] = nil
									if(workerTable[k].quest == nil)then
										workerTable[k] = nil
										workerTableKey[i] = nil
										else
										workerTable[k].disabled = true
									end
								end
								else
								
								
								local actionisgood = checkWaitingAction(list[index],k,parent,index)
								
								workerTable[k]["pending"] = (actionisgood ~= pending)
								
								if(workerTable[k]["pending"] == false) then
									workerTable[k]["last_update"] =tostring(os.date("%x %X", os.time()))
									workerTable[k]["index"] = workerTable[k]["index"]+1
								end
								
								
								
								
							end
							
							
						end
					end
					
				end
			end
			
		end
		
		
		
		
	end
	
end

function checkWaitingAction(action,tag,parent,index)
	
	
	
	result = false
	
	
	if(action.name == "wait") then
		
		local temp = getGameTime()
		
		if(temp.hour > action.hour or (temp.hour == action.hour and temp.min > action.min)) then
			result = true
		end
		
		
		
		
	end
	if(action.name == "wait_tick") then
		
		if(tick  >= action.tick) then
			result = true
		end
		
		
		
	end
	
	
	
	if(action.name == "wait_second") then
		
		if(os.time(os.date("!*t"))+0  >= action.tick) then
			result = true
		end
		
		
		
	end
	
	
	if(action.name == "subtitle" or action.name == "random_subtitle" or 
		action.name == "play_random_custom_sound_with_subtitle" or
		action.name == "play_custom_sound_with_subtitle"  ) then
		
		if(os.time(os.date("!*t"))+0  >= action.tick) then
			result = true
			GameController["SubtitlesGameController"]:Cleanup()
		end
		
		
		
	end
	
	if(action.name == "npc_chat" or action.name == "random_npc_chat" or 
		action.name == "play_custom_sound_with_subtitle_as_chat") then
		
		if(os.time(os.date("!*t"))+0  >= action.tick) then
			result = true
			GameController["ChattersGameController"]:Cleanup()
			
		end
		
		
		
	end
	
	
	if(action.name == "fade_in") then
		
		
		
		isFadeIn = true
		--logme(4,opacity)
		
		
		if(os.time(os.date("!*t"))+0  >= action.tick) then
			
			
			opacity = 1
			
			
			
			result = true
			
			else
			local fadeincursor = tonumber(action.tick)
			
			
			
			local currentcursor = tonumber(os.time(os.date("!*t"))+0 )
			
			
			--logme(4,fadeincursor)
			--logme(4,currentcursor)
			
			
			opacity = (100/(fadeincursor-currentcursor))
			
			
		end	
	end
	
	if(action.name == "fade_out") then
		
		
		
		
		--logme(4,opacity)
		
		
		if(os.time(os.date("!*t"))+0  >= action.tick) then
			
			
			opacity = 0
			isFadeIn = false
			
			
			result = true
			
			else
			local fadeoutcursor = tonumber(action.tick)
			
			
			
			local currentcursor = tonumber(os.time(os.date("!*t"))+0 )
			
			
			--logme(4,fadeincursor)
			--logme(4,currentcursor)
			
			
			opacity = 1 - (100/(fadeoutcursor-currentcursor))
			
			
		end	
	end
	
	if(action.name == "wait_for_trigger") then
		
		
		local trigger = action.trigger
		result = checkTrigger(trigger)
		
	end
	
	if(action.name == "wait_for_framework") then
		
		
		
		result = (waiting == false)
		------print("wait_for_framework "..tostring(waiting).." "..tostring(result))
		
	end
	
	if(action.name == "wait_for_ai_answer") then
		
		
		
		result = (getAIAnswerOrDefault(action.aitag) ~= nil)
		------print("wait_for_framework "..tostring(waiting).." "..tostring(result))
		
	end
	
	
	
	if(action.name == "wait_for_target") then
		
		if(selectTarget ~= nil) then
			
			result =  true
			
		end
		
		
	end
	
	if(action.name == "wait_for_selection") then
		
		result = selectedEntity
		
		
	end
	
	
	if(action.name == "while_one") then
		
		local trigger = action.trigger
		result = checkTrigger(trigger)
		logme(4,"while one "..tostring(result))
		executeAction(action.action,tag,parent,index,source,executortag)
		
		
	end
	
	if(action.name == "finish_mission") then
		
		if currentQuest ~= nil and currentQuest.tag == action.tag then
			
			result = true
			canDoEndAction = true
			
			else
			
			if currentQuest == nil or (currentQuest ~= nil and currentQuest.tag ~= action.tag) then
				
				result = false
				
				
			end
			
		end
		
	end
	
	return result
end

function cleanThreadManager()
	if GameUI.IsDetached() then
	workerTable = {}
	actionistaken = false
	end
	
	local count = 0
	if(#workerTable > 0 ) then
		
		for i=1, #workerTable do
			
			if workerTable[i].active == false then
				count = count + 1
			end
			
		end
		
		
		if(count == #workerTable) then
			----logme(4,"clean worker table")
			workerTable = {}
			actionistaken = false
		end
		
	end
	
end




--requirement
function checkTriggerRequirement(requirement,triggerlist)
	
	local result = false
	
	if GameUI.IsLoading() == false and requirement ~= nil then
		
		for i=1, #requirement do --pour chaque requirement de la quete
			
			local requirementcondition = requirement[i]
			local count = 0
			
			for y =1,#requirementcondition do --pour chaque condition du requirement en cours
				
				
				if(result == false) then --si un requirement n'a pas été validé déja
					----print(requirementcondition[y])
					local trigger = triggerlist[requirementcondition[y]]
					
					local triggerIsOk = checkTrigger(trigger) --on evalue le trigger
					----print(trigger.name.." "..dump(trigger).." "..tostring(triggerIsOk))
					if(triggerIsOk) then --on incrémente le compteur si le trigger est ok
						
						
						count = count +1
					end
					
					
				end
				
				
				
				
			end
			
			if(count == #requirementcondition) then --si le compteur de bon trigger est egale a la totalité du requirementcondition, c'est que tout les parametres sont requis pour ce requirement
				result = true
			end
			
			
			
			
			
		end	
		
		if(#requirement == 0) or (requirement == nil and triggerlist == nil) then
			result = true
			
		end
		
	end
	
	return result
end

function testTriggerRequirement(requirement,triggerlist, number)
	local result = false
	if number == nil then number = 10 end
	for i=1, #requirement do --pour chaque requirement de la quete
		
		local requirementcondition = requirement[i]
		
		local count = 0
		logme(number,"Requirement : "..#requirementcondition)
		logme(number,dump(requirementcondition))
		for y =1,#requirementcondition do --pour chaque condition du requirement en cours
			
			logme(number,"Requirement : "..requirementcondition[y])
			if(result == false) then --si un requirement n'a pas été validé déja
				logme(number,"Trigger : "..requirementcondition[y])
				local trigger = triggerlist[requirementcondition[y]]
				logme(number,"Trigger : ")
				logme(number,trigger.name)
				
				local triggerIsOk = checkTrigger(trigger) --on evalue le trigger
				logme(number,triggerIsOk)
				if(triggerIsOk) then --on incrémente le compteur si le trigger est ok
					
					
					
					count = count +1
					logme(number,count)
				end
				
				
			end
			
			
			
			
		end
		
		if(count == #requirementcondition) then --si le compteur de bon trigger est egale a la totalité du requirementcondition, c'est que tout les parametres sont requis pour ce requirement
			result = true
		end
		
		
		
		
		
	end	
	
	if(#requirement == 0 and #triggerlist == 0) then
		result = true
		
	end
	
	logme(number,"Test Result : "..tostring(result))
	
	return result
end




--run action Thread
function runActionList(actionlist, tag, source,isquest,executortag,bypassMenu)
	
	if(tag ~= nil) then
	if(workerTable[tag] == nil) then
		local copy = deepcopy(actionlist, copies)
		
		-- for k,v in pairs(copy) then
		-- copy[k]["active"] = true
		-- end
		
		if(source == nil) then
			source = "interact"
		end
		
		
		if(workerTable[tag] == nil) then
			workerTable[tag] = {}
		end
		
		workerTable[tag]["action"] = copy
		workerTable[tag]["index"] = 1
		workerTable[tag]["parent"] = ""
		workerTable[tag]["started"] = false
		workerTable[tag]["pending"] = false
		workerTable[tag]["disabled"] = false
		workerTable[tag]["source"] = source
		workerTable[tag]["executortag"] = executortag
		workerTable[tag]["bypassMenu"] = bypassMenu
		workerTable[tag]["started_at"] =tostring(os.date("%x %X", os.time()))
		workerTable[tag]["last_update"] =tostring(os.date("%x %X", os.time()))
		if(isquest ~= nil) then
			workerTable[tag]["quest"] = isquest
		end
	end
	end
end

function runSubActionList(actionlist, tag, parent, source, isquest,executortag,bypassMenu)
	
	if(tag ~= nil) then
		
		if(workerTable[tag] == nil) then
			local copy = deepcopy(actionlist, copies)
		print(tag)
			-- for k,v in pairs(copy) then
			-- copy[k]["active"] = true
			-- end
			
			if(source == nil) then
				source = "interact"
			end
			
			if(workerTable[tag] == nil) then
				workerTable[tag] = {}
			end
			
			
			workerTable[tag]["action"] = copy
			workerTable[tag]["index"] = 1
			workerTable[tag]["parent"] = parent
			workerTable[tag]["pending"] = false
			workerTable[tag]["started"] = false
			workerTable[tag]["source"] = source
			workerTable[parent]["pending"] = true
			workerTable[parent]["children"] = tag
			workerTable[tag]["disabled"] = false
			workerTable[tag]["executortag"] = executortag
			workerTable[tag]["bypassMenu"] = bypassMenu
			workerTable[tag]["started_at"] =tostring(os.date("%x %X", os.time()))
			workerTable[tag]["last_update"] =tostring(os.date("%x %X", os.time()))
			if(isquest ~= nil and isquest == true) then
				workerTable[tag]["quest"] = true
			end
		end
	end
end




--Do and Check object
function doEvent(tag)
	
	local boj = cyberscript.cache["event"][tag]
	
	if( boj ~= nil) then
		local event = boj.data
		--testTriggerRequirement(event.requirement,event.trigger)
		checkContext(event)
		if(checkTriggerRequirement(event.requirement,event.trigger))then
			
			--logme(10,"CyberScript : Doing event : "..data.name)
			
			--	doActionof(event.action,"interact")
			runActionList(event.action, tag, "interact",false,"nothing")
			else
			--logme(10,"CyberScript : can't do event : "..data.name)
			
		end
	end
end

function doFunction(tag)
	
	local boj = cyberscript.cache["functions"][tag]
	local event = boj.data
	checkContext(event)
	runActionList(event.action, tag, "interact",false,"nothing",boj.data.bypassmenu)
	
end

function doTriggeredEvent()
	
	
	
	worldprocessing = true
	
	possibleEvent = {}
	
	
	
	for key,value in pairs(cyberscript.cache["event"]) do --actualcode
		
		local event = cyberscript.cache["event"][key].data
		
		if(event.way == "world") then
			checkContext(event)
			------print("test"..dump(event))
			--logme(4,"check for "..data.name)
			--testTriggerRequirement(event.requirement,event.trigger)
			------print(key)
			if(checkTriggerRequirement(event.requirement,event.trigger))then
				if workerTable[key] == nil then
					runActionList(event.action,key,"interact",false,"nothing")
				end
			end
		end 
	end
	
	worldprocessing = false
	
	
end

function doInitEvent()
	
	
	
	worldprocessing = true
	
	possibleEvent = {}
	
	
	
	for key,value in pairs(cyberscript.cache["event"]) do --actualcode
		
		local event = value.data
		
		if(event.way == "init") then
			checkContext(event)
			if(checkTriggerRequirement(event.requirement,event.trigger))then
				----print(k)
				
				
				runActionList(event.action,key,"interact",false,"nothing")
			end
		end 
	end
	
	worldprocessing = false
	logme(1,"CyberScript : doing init event...")
	
end

function doIf(action,list,currentindex,listaction)
	if(list[1].name ~= "goto" or list[1].name ~= "if") then
		local moveindex = #list
		local newlist = listaction
		for i = 1, moveindex do
			newlist[currentindex+moveindex+i] =  newlist[currentindex+i]
		end
		
		for i = 1, moveindex do
			newlist[currentindex+i] =  list[i]
		end
		
		logme(4,"List Is :")
		for i=1, #newlist do
			logme(4,newlist[i].name)
		end
		logme(4,"End of ")
		action.newlist = newlist
		
		
		
		return false
	end	
	
end

function checkIf(action,parent,source,executortag)
	
	local trigger = action.trigger
	if(checkTrigger(trigger)) then
		
		local tag= parent
		local actiontodo = action.if_action
		runSubActionList(actiontodo, tag.."_if", parent,source,false,executortag)
		
		else
		
		local tag= parent
		local actiontodo = action.else_action
		runSubActionList(actiontodo, tag.."_else", parent,source,false,executortag)
		
		
		
		
	end
	
	
	
	
end

function checkEvents()
	
	getTriggeredActions()
	local message = ""
	
	if(#possibleInteract > 0) then
		message = message.."There is some interactions"
		else
		message = message.."There is no interactions"
	end
	
	if currentQuest == nil then
		
		if(#possibleQuest > 0) then
			message = message.." and some quest"
			else
			message = message.." and no quest"
		end
		
		
	end
	
	message = message.." available near from you"
	Game.GetPlayer():SetWarningMessage(message)
	
end

function checkAmbush()
	local ambushevent = {}
	
	if(AmbushEnabled == true and isAVinService == false) then
		--logme(4,"mark1")
		if(currentDistricts2.customdistrict ~= nil) then
			--logme(4,"mark1")		
			
			
			logme(3,"check ambsush")
			--	logme(4,"mark1")	
			for k,v in pairs(cyberscript.cache["event"]) do
				
				if(cyberscript.cache["event"][k].data.way == "ambush") then
					--logme(4,cyberscript.cache["event"][k].data.way)
					--table.insert(ambushevent,k)
					logme(10,k)
					doEvent(k)
					
					
				end
			end
			
			-- if(#ambushevent > 0) then
			-- local tag = math.random(1,#ambushevent)
			-- logme(4,"doing ambush "..tag)
			-- doEvent(ambushevent[tag])
			-- end
			
			
			
			
			
			
			
			
		end
	end
	
end

function checkSpeakDialog()
	
	if currentStar ~= nil then
		--if string.match(currentStar.Names,targName) then
		
		
		
		if tostring(TweakDBID.new(currentStar.TweakIDs)) == tostring(objLook:GetRecordID()) then
			
			if startSpeak == false then
				
				selectNPCForSpeak(currentStar)
				
				
				
				
			end
			else
			if(currentDialogHub ~= nil) then
				openSpeakDialogWindow = false	
				startSpeak =false
				isdialogactivehub = false
				removeDialog()
				currentDialogHub = nil
				logme(4,"totot")
			end
		end
		
		
	end
	
	if objLook == nil then
		
		openSpeakDialogWindow = false	
		startSpeak =false
		
	end
	
end

function checkFixer()
	
	
	
	
	if phonedFixer == false then
		if curPos ~= nil then
			--	logme(4,curPos)
			currentfixer =  deepcopy(checkWithFixer(curPos),nil)
		end
	end
	
	
	
	-- pcall(function() 
	if(currentfixer ~= nil) then --if fixer si founded
		
		
		
		
		if(checkTriggerRequirement(currentfixer.requirement,currentfixer.trigger)) then --check that fixer can be spawn
			
			
			oldfixer = deepcopy(currentfixer,nil)
			if(fixerIsSpawn == false and currentfixer.exist == false and currentfixer.npcexist == false and cyberscript.EntityManager[currentfixer.tag] == nil) then
				print(currentfixer.tag)
				
				
				local twkVehi = TweakDBID.new(currentfixer.tweakid)
				
				
				
				
				if cyberscript.EntityManager[currentfixer.tag] == nil then
					cyberscript.EntityManager[currentfixer.tag] = {}
					if currentfixer.appearance == nil then currentfixer.appearance = "" end
				spawnNPC(currentfixer.tweakid,currentfixer.appearance, currentfixer.tag, currentfixer.x, currentfixer.y, currentfixer.z, 42, false, false, nil, false, nil,0,true,true,true,true,true)
				logme(1,"Cyberscript : Spawn Fixer :"..currentfixer.tag)
				end
				
			
				   
				   
				   
			end	
			
			-- if(currentfixer.exist == false and currentfixer.npcexist == false and fixerIsSpawn == false) then
				-- ------print("spawn")
				-- -- if (cyberscript.EntityManager[currentfixer.tag] ~= nil ) then
					-- -- despawnEntity(currentfixer.tag)
				
				-- -- end
				
				
				-- -- local twkVehi = TweakDBID.new(currentfixer.tweakid)
				
				
				
				-- -- cyberscript.EntityManager[currentfixer.tag] = {}
			-- --	spawnNPC(currentfixer.tweakid,"", currentfixer.tag, currentfixer.x, currentfixer.y, currentfixer.z, 42, true, false, nil, false, nil)
				
				
				
			
				
				
				
			-- end	
			
			if(fixerIsSpawn == false and currentfixer.spawn_action ~= nil and #currentfixer.spawn_action >0 ) then
				
				
				
				runActionList(currentfixer.spawn_action, currentfixer.tag.."_Spawn",nil,nil,currentfixer.tag)
				fixerIsSpawn = true
				
			end
			
			
			
			
			
			
			
		end
		
	else -- if we move away from fixer so currentfixer is nil
		
		
		ChangeZoneIndicatorPublic()
		
		if(oldfixer ~= nil) then
			
			
				
				
				
				if(oldfixer ~= nil and oldfixer.despawn_action ~= nil and #oldfixer.despawn_action >0) then
					
					--doActionof(currentfixer.action,"interact")
					runActionList(oldfixer.despawn_action, oldfixer.tag.."_Despawn",nil, nil,oldfixer.tag)
					
					
					
				end
				
				oldfixer = nil
				
				
			
			
		end
		
		fixerIsSpawn = false
		
		
	end
	
	
	
	
end


function checkContext(item)
	
	if(item ~= nil and item.context ~= nil) then
		
		if(isArray(item.context))then
			for i,v in ipairs(item.context) do
				
				if(checkTriggerRequirement(v.requirement,v.trigger))then
					
					if(v.action ~= nil and #v.action > 0) then
						
						runActionList(v.action, item.tag, "see", false,"see",false)					
					end
					
					
					for k,u in pairs(v.prop) do
						
						
						local path =  splitDot(k, ".")
						setValueToTablePath(item, path, GeneratefromContext(item,u))
						
					end
				end
			end
			else
			if(checkTriggerRequirement(item.context.requirement,item.context.trigger))then
				for k,u in pairs(item.context.prop) do
					
					
					local path =  splitDot(k, ".")
					
					
					setValueToTablePath(item, path, GeneratefromContext(item,u))
				end
			end
		end
		
	end
end

function checkNPC()
	
	
	
	for k,v in pairs(cyberscript.cache["npc"]) do
		
		local npc = cyberscript.cache["npc"][k].data
		
		
		
		if(cyberscript.EntityManager[k] == nil) then
			checkContext(npc)
			
			
			local npcpostion = getPositionFromParameter(npc.location)
			
			if(npcpostion.x ~= nil and npcpostion.y ~= nil and npcpostion.z~= nil)then
				if( check3DPos(curPos, npcpostion.x,  npcpostion.y,  npcpostion.z, npc.location.player_range) ) then
					--if the npc is not spawned
					
					
					if(getEntityFromManager(k).id == nil and checkTriggerRequirement(npc.requirement,npc.triggers)) then
						
						
						
						
						
						local tweakDBnpc =  npc.tweakDB
						
						if(tweakDBnpc== "district") then
							
							local gangs = getGangfromDistrict(currentDistricts2.Tag,20)
							
							if(#gangs == 0) then
								
								break
								
							end
							
							local gang = getFactionByTag(gangs[1].tag)
							
							if(#gang.spawnable_npc > 0) then
								local index = math.random(1,#gang.spawnable_npc)
								
								tweakDBnpc = gang.spawnable_npc[index]
								else
								break
							end
							
							elseif (tweakDBnpc== "subdistrict") then
							
							local gangs = {}
							
							for i, test in ipairs(currentDistricts2.districtLabels) do
								if i > 1 then
									
									
									gangs = getGangfromDistrict(test,20)
									
									if(#gangs == 0) then
										
										break
										
									end
								end
							end
							
							local gang = getFactionByTag(gangs[1].tag)
							
							if(#gang.spawnable_npc > 0) then
								local index = math.random(1,#gang.spawnable_npc)
								
								tweakDBnpc = gang.spawnable_npc[index]
								else
								break
							end
							
							if(tweakDBnpc== "districttag") then
								
								gangs = getGangfromDistrict(npc.locationtag,20)
								
								if(#gangs == 0) then
									
									break
									
								end
								
								local gang = getFactionByTag(gangs[1].tag)
								
								if(#gang.spawnable_npc > 0) then
									local index = math.random(1,#gang.spawnable_npc)
									
									tweakDBnpc = gang.spawnable_npc[index]
									else
									break
								end
								
								elseif (tweakDBnpc== "subdistricttag") then
								
								local gangs = {}
								
								gangs = getGangfromDistrict(npc.locationtag,20)
								
								local gang = getFactionByTag(gangs[1].tag)
								
								if(#gang.spawnable_npc > 0) then
									local index = math.random(1,#gang.spawnable_npc)
									
									tweakDBnpc = gang.spawnable_npc[index]
									else
									break
								end
								
								
								
								
							end
						end
						
						
						
						cyberscript.EntityManager[npc.tag] = {}
						spawnNPC(tweakDBnpc,"", npc.tag, npcpostion.x, npcpostion.y, npcpostion.z, 42, true, false, nil, false, npc.rotation,0)
						
						npc.isspawn=true
						npc.init=false
						
					end
				end
				
				
				
				
				
			end
			
			else
			
			local obj = getEntityFromManager(k)
			
			if(obj ~= nil and obj.id ~= nil) then 
				local enti = Game.FindEntityByID(obj.id)	
				
				
				if(enti ~= nil) then--entity exist 
					checkContext(npc)
					local npcpostion = getPositionFromParameter(npc.location)
					if((check3DPos(Game.GetPlayer():GetWorldPosition(), npcpostion.x,  npcpostion.y,  npcpostion.z, npc.location.player_range) and npc.spawnforced == false) or npc.spawnforced == true) then --ifplayer is in the location
						
						if(cyberscript.cache["npc"][k].data.init==false) then --if not initiaded
							
							local npc = cyberscript.cache["npc"][k].data
							
							if(npc.appeareance ~= nil or npc.appeareance ~= "" and cyberscript.cache["npc"][k].data.appearancesetted == false) then
								
								local obj = getEntityFromManager(npc.tag)
								local enti = Game.FindEntityByID(obj.id)
								if(enti ~= nil) then
									
									
									setAppearance(enti,npc.appeareance)
									cyberscript.cache["npc"][k].data.appearancesetted = true
								end
								
								
							end
							
							if(workerTable[npc.tag.."_spawn"] == nil and #npc.spawnaction > 0 and npc.dospawnaction == true) then
								
								
								
								runActionList(npc.spawnaction, npc.tag.."_spawn", "interact",false,npc.tag)
								
							end
							
							if(workerTable[npc.tag.."_routine"] == nil and #npc.routineaction > 0 and npc.doroutineaction == true) then
								runActionList(npc.routineaction, npc.tag.."_routine", "interact",false,npc.tag)
								
							end
							
							
							cyberscript.cache["npc"][k].data.init = true
							
							else
							
							
							
							if(workerTable[npc.tag.."_routine"] == nil and npc.repeat_routine == true and #npc.routineaction > 0 and npc.doroutineaction == true) then
								runActionList(npc.routineaction, npc.tag.."_routine", "interact",false,npc.tag)
								--	logme(4,"doing routine of "..npc.name)
								
							end
							
							
							if (workerTable[npc.tag.."_death"] == nil and npc.deathaction ~= nil and #npc.deathaction > 0 and (enti:IsDead() == true or enti:IsActive() == false) and npc.dodeathaction == true)then
								runActionList(npc.deathaction, npc.tag.."_death", "interact",false,npc.tag)
								
								npc.dodeathaction= false
							end
						end
						
						
						else
						
						
						if(npc.auto_despawn == true) then
							
							cyberscript.cache["npc"][k].data.isspawn=false
							cyberscript.cache["npc"][k].data.init=false
							cyberscript.cache["npc"][k].data.appearancesetted = nil
							
							if(workerTable[npc.tag.."_spawn"] ~= nil) then
								
								workerTable[npc.tag.."_spawn"] = nil
								
							end
							
							if(workerTable[npc.tag.."_routine"] ~= nil) then
								
								workerTable[npc.tag.."_routine"] = nil
								
							end
							
							if(workerTable[npc.tag.."_death"] ~= nil) then
								
								workerTable[npc.tag.."_death"] = nil
								
							end
							
							despawnEntity(npc.tag)
							----print("despawn "..npc.tag)
							if(workerTable[npc.tag.."_despawn"] == nil and #npc.despawnaction > 0 and npc.dospawnaction == true) then
								runActionList(npc.despawnaction, npc.tag.."_despawn", "interact",false,npc.tag)
								
							end
							
						end
						
					end
					
				end
			end
			
			
		end
		
		
	end
	
	
end

function checkValue(operator,value1,value2, min, max)
	
	return (
		(value1 ~= nil and value2 ~= nil and 
			(
				(operator == "<" and value1 < value2) or 
				(operator == "<=" and value1 <= value2) or
				(operator == ">" and value1 > value2) or
				(operator == ">=" and value1 >= value2) or
				(operator == "!=" and value1 ~= value2) or 
				(operator == "=" and value1 == value2) or
				
				(operator == "><" and min ~= nil and max ~= nil and value1 > min and value1 < max ) or
				(operator == ">=<" and min ~= nil and max ~= nil and value1 >= min and value1 < max ) or
				(operator == "><=" and min ~= nil and max ~= nil and value1 > min and value1 <= max ) or
				(operator == ">=<=" and min ~= nil and max ~= nil and value1 >= min and value1 <= max ) or
				
				(operator == "<>" and min ~= nil and max ~= nil and (value1 < min or value1 > max )) or
				(operator == "<=>" and min ~= nil and max ~= nil and (value1 <= min or value1 > max )) or
				(operator == "<>=" and min ~= nil and max ~= nil and (value1 < min or value1 >= max )) or
				(operator == "<=>=" and min ~= nil and max ~= nil and (value1 <= min or value1 >= max )) 
			)
		) or
		(operator == "empty" and value1 == nil) or
		(operator == "notempty" and value1 ~= nil)
		
		or
		(operator == "nothing" and value1 == nil) or
		(operator == "notnothing" and value1 ~= nil)
		
		
	)
end

--Get List

function getInteractGroup()
	
	currentInteractGroup ={}
	
	local groupof = {}
	
	for key,value in pairs(cyberscript.cache["interact"]) do --actualcode
		
		
		local interact2 = cyberscript.cache["interact"][key].data
		local canadd = true
		
		for i=1,#currentInteractGroup do
			
			if(currentInteractGroup[i] == interact2.group)  then
				canadd = false
				
			end
			
		end
		
		if(canadd == true) then
			
			table.insert(currentInteractGroup, interact2.group)
			
		end
		
		
	end
	
	
	
	
end

function getTriggeredActions()
	
	
	
	worldprocessing = true
	local possibleinteractchunk = {}
	possibleInteract = {}
	local possibleinteractchunked = {}
	
	
	for key,value in pairs(cyberscript.cache["interact"]) do --actualcode
		
		local interact2 = cyberscript.cache["interact"][key].data
		
		--testTriggerRequirement(interact2.requirement,interact2.trigger)
		if(checkTriggerRequirement(interact2.requirement,interact2.trigger)) and (interact2.group == currentInteractGroup[currentInteractGroupIndex] or key == "default_open_datapack_group_ui") then
			
			--logme(4,"check for "..data2.name.." "..tostring(checkTriggerRequirement(interact2.requirement,interact2.trigger)))
			table.insert(possibleinteractchunk, interact2)
			else
			
			if(#currentInputHintList > 0) then
				
				for i = 1, #currentInputHintList do
					
					if(currentInputHintList[i]~= nil and currentInputHintList[i].tag == interact2.tag) then
						hideCustomHints(interact2.tag)
						
						currentInputHintList[i] = nil
					end
					
					
				end
				
				
			end
			
		end
	end
	local chunk = {}
	local count = 1
	
	
	for i=1,#possibleinteractchunk+1 do 
		
		--	
		if(#chunk < 4 and i<#possibleinteractchunk+1) then
			
			
			if(possibleinteractchunk[i] ~= nil) then
				
				table.insert(chunk,possibleinteractchunk[i])
				count = count + 1
				
			end
			
			else
			
			
			
			local chunkcopy = {}
			for z=1,#chunk do 
				
				table.insert(chunkcopy,chunk[z])
				
			end
			
			table.insert(possibleInteract,chunkcopy)
			
			
			if(possibleinteractchunk[i] ~= nil) then
				chunk = {}
				table.insert(chunk,possibleinteractchunk[i])
				
				count = 1
				
			end
		end
		
		
	end
	
	
	
	
	
	
	worldprocessing = false
	
	
end

function getTriggeredActionsDisplay()
	
	-- if(#currentInputHintList > 0) then
	
	-- for i = 1, #currentInputHintList do
	
	-- hideCustomHints(currentInputHintList[i].tag)
	
	-- end
	
	-- end
	
	
	possibleinteractchunk = {}
	
	local possibleinteractchunked = {}
	possibleInteractDisplay = {}
	for i=1,#possibleInteract do
		
		for z=1,#possibleInteract[i] do 
			
			
			if((possibleInteract[i][z].display == "event_interact" 
				or 
				(currentHouse ~= nil and (possibleInteract[i][z].display == "place"
					or possibleInteract[i][z].display == "place_main" or 
				possibleInteract[i][z].display == "event_interact")))) then
				table.insert(possibleinteractchunk,possibleInteract[i][z])
			end
			
			
		end
		
		
	end
	
	
	local chunk = {}
	
	for i=1,#possibleinteractchunk+1 do 
		
		--	
		if(#chunk < 4 and i<#possibleinteractchunk+1) then
			
			
			if(possibleinteractchunk[i] ~= nil) then
				
				table.insert(chunk,possibleinteractchunk[i])
				
				
			end
			
			else
			
			
			
			local chunkcopy = {}
			for z=1,#chunk do 
				chunk[z].input=z
				table.insert(chunkcopy,chunk[z])
				
			end
			
			table.insert(possibleInteractDisplay,chunkcopy)
			
			if(possibleinteractchunk[i] ~= nil) then
				chunk = {}
				table.insert(chunk,possibleinteractchunk[i])
				
				
			end
		end
		
		
	end
	
	
	
	
	
	
	
end

function getMissionByTrigger()
	
	
	--find new mission
	
	
	possibleQuest = {}
	
	for key,value in pairs(cyberscript.cache["mission"]) do --actualcode
		
		if(checkQuestStatutByTag(key, nil) == true or checkQuestStatutByTag(key, -1) == true) then
			local quest = cyberscript.cache["mission"][key].data
			
			if(HaveTriggerCondition(quest))then
				
				
				--if(possibleQuest[quest] ~= nil) then
				
				table.insert(possibleQuest, quest)
				
				if(QuestManager.GetQuestState(quest.tag).isActive == false) then
					
					if(quest.unlock_action ~= nil and #quest.unlock_action > 0) then
						runActionList(quest.unlock_action,quest.tag.."_unlockaction","quest",true,"see_engine",true)
					end
					
					
					QuestManager.MarkQuestAsActive(quest.tag)
					
					
				end
				--end
				
				else
				--logme(4,tostring(QuestManager.isVisited(key)))
				if not QuestManager.isVisited(key) then
					QuestManager.MarkQuestAsInactive(key)
					--logme(4,"remove"..key)
				end
			end
			
			else
			if(checkQuestStatutByTag(key, 3) == true) then
				--QuestManager.MarkQuestAsInactive(key)
				QuestManager.MarkQuestASucceeded(key)
			end
			
		end
		
	end
	
	
	
	
	
	
	takenQuest = {}
	
	for key,value in pairs(cyberscript.cache["mission"]) do --actualcode
		local statuQue = checkQuestStatutByTag(key, 0) or checkQuestStatutByTag(key, 1) or checkQuestStatutByTag(key, 2)
		
		if( statuQue== true) then
			
			local quest = cyberscript.cache["mission"][key].data
			
			
			
			
			--if(possibleQuest[quest] ~= nil) then
			--table.insert(takenQuest, quest)
			QuestManager.MarkQuestAsActive(quest.tag)
			--end
			
		end
		
	end
	
	
	
end





--GET objects

function CorrectAllPOI()
	
	if poicorrectready == true  and activeEditedPOI["locations"][currentpoicorrectindex] ~= nil then
		
		----print("TP to "..activeEditedPOI["locations"][currentpoicorrectindex].Tag)
		poicorrectready = false
		local correctpoi = activeEditedPOI["locations"][currentpoicorrectindex]
		local loca = {}
		loca.x = correctpoi.x 
		loca.y = correctpoi.y 
		loca.z = correctpoi.z 
		
		if activeEditedPOI["locations"][currentpoicorrectindex+1] ~= nil then
			teleportTo(Game.GetPlayer(), loca, 1,true)
			
			Cron.After(0.1, function()
				
				activeEditedPOI["locations"][currentpoicorrectindex].district = getVariableKey("current_district","enum")
				activeEditedPOI["locations"][currentpoicorrectindex].subdistrict = getVariableKey("current_district","subdistrict_enum")
				activeEditedPOI["locations"][currentpoicorrectindex].Tag = activeEditedPOI.tag.."_"..currentpoicorrectindex
				--		----print("Correct "..activeEditedPOI["locations"][currentpoicorrectindex].Tag.." on "..#activeEditedPOI["locations"])
				currentpoicorrectindex = currentpoicorrectindex+1
				poicorrectready = true
				-- if isprevention == true then
				-- local postp = Vector4.new( x, y, z,1)
				-- teleportTo(Game.FindEntityByID(NPC), postp, 1,false)
				-- end
				
				
				
				
			end)
			else
			----print("nope")
		end
		
		else
		if poicorrectready == true and activeEditedPOI["locations"][currentpoicorrectindex] == nil then
			wantcorrectpoi = false 
			----print("nope2")
		end
		
	end
	
	
end

function getEventByTag(tag)
	logme(4,"d,f,	")
	for i=1,#cyberscript.cache["event"] do
		logme(4,cyberscript.cache["event"][i].data.name)
		if(cyberscript.cache["event"][i].data.tag == tag)then
			
			return cyberscript.cache["event"][i].data
			
		end
		
	end
	
	return nil
end

function getSubtitleByTag(tag)
	
	for i=1,#arraySubtitle do
		
		if(arraySubtitle[i].tag == tag)then
			
			return arraySubtitle[i]
			
		end
		
	end
	
	return nil
end

function getShardByTag(tag)
	
	
	if(cyberscript.cache["shard"][tag] ~= nil)then
		
		return cyberscript.cache["shard"][tag].data
		
	end
	return nil
	
end

function getCustomNPCByTag(tag)
	
	
	if(cyberscript.cache["npc"][tag] ~= nil)then
		
		return cyberscript.cache["npc"][tag].data
		
	end
	return nil
	
end

function getInteractByTag(tag)
	
	return cyberscript.cache["interact"][tag].data
	
	
end

function getInteractsBySortTag(tag)
	local result = {}
	
	for i = 1, #possibleInteract do
		
		for z = 1, #possibleInteract[i] do
			--logme(4,possibleInteract[i].name)
			if(possibleInteract[i][z].sorttag == tag)then
				
				table.insert(result, possibleInteract[i][z])
				
			end
			
		end
		
	end
	
	return result
end

function getPhoneConversationByTag(tag)
	
	if(cyberscript.cache["phone_dialog"][tag] ~= tag)then
		
		return cyberscript.cache["phone_dialog"][tag].conv
		
	end
	
	return nil
	
end

function getPath(tag)
	
	
	if(cyberscript.cache["path"][tag] ~= nil) then
		return cyberscript.cache["path"][tag].data
	end
	return nil
	
end

function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
  end

function getPOI(tag)
	
	
	if(cyberscript.cache["poi"][tag] ~= nil) then
		return cyberscript.cache["poi"][tag].poi
	end
	return nil
	
	
end

function FindPOI(tag,district,subdistrict,iscar,poitype,locationtag,fromposition,range,frompositionx,frompositiony,frompositionz,listargument,distancename)
	
	
	
	local currentpoilist = {}
	local frompos = curPos
	
	if(frompositionx ~= nil and frompositiony ~= nil and frompositionz ~= nil) then
		
		frompos.x = frompositionx
		frompos.y = frompositiony
		frompos.z = frompositionz
		
	end
	
	if(listargument == "type" and poi_type[tostring(poitype)] ~= nil) then
		
		local list = poi_type[tostring(poitype)]["outVehicule"]
		
		if(iscar) then
			
			list = poi_type[tostring(poitype)]["inVehicule"]
			
		end
		
		
		
		for k,location in pairs(list) do
			--print(k)
			-- ----print(tostring((tag == nil or tag == "" or k == tag)))
			-- ----print(tostring((district == nil or district == "" or (district ~= nil and location.district == district))))
			-- ----print(tostring(subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict)))
			------print(tostring((fromposition == false or (fromposition == true and check3DPos(frompos, location.x, location.y, location.z, range)))))
			------print(tostring(check3DPos(frompos, location.x, location.y, location.z, range)))
			
			if
				(
					
					(tag == nil or tag == "" or k == tag) and
					
					(district == nil or district == "" or (district ~= nil and location.district == district)) and
					
					(subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict)) and
					
					--	(poitype == nil or poitype == 1 or (poitype == location.type) and
					
					(fromposition == false or (fromposition == true and check3DPos(frompos, location.x, location.y, location.z, range)))
					
					
				)
				then
				
				
				
				table.insert(currentpoilist,location)
				
				
				
				
				
				
				
			end
			
		end
		
		
		
	end
	
	if(listargument == "subdistrict" and poi_subdistrict[subdistrict] ~= nil) then
		
		local list = poi_subdistrict[subdistrict]["outVehicule"]
		
		if(iscar) then
			
			list = poi_subdistrict[subdistrict]["inVehicule"]
			
		end
		
		for k,location in pairs(list) do
			
			if
				(
					
					
					
					(district == nil or district == "" or (district ~= nil and location.district == district)) and
					
					(tag == nil or tag == "" or k == tag) and
					
					(district == nil or district == "" or (district ~= nil and location.district == district)) and
					
					--	(subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict)) and
					
					(poitype == nil or poitype == 1 or (poitype == location.type)) and
					
					(fromposition == false or (fromposition == true and check3DPos(frompos, location.x, location.y, location.z, range)))
					
					
				)
				then
				
				
				
				table.insert(currentpoilist,location)
				
				
				
				
				
				
				
			end
			
		end
		
	end
	
	if(listargument == "district" and poi_district[district] ~= nil) then
		
		local list = poi_district[district]["outVehicule"]
		
		if(iscar) then
			
			list = poi_district[district]["inVehicule"]
			
		end
		
		for k,location in pairs(list) do
			
			if
				(
					
					(tag == nil or tag == "" or k == tag) and
					
					--	(district == nil or district == "" or (district ~= nil and location.district == district)) and
					
					(subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict)) and
					
					(poitype == nil or poitype == 1 or (poitype == location.type)) and
					
					(fromposition == false or (fromposition == true and check3DPos(frompos, location.x, location.y, location.z, range)))
					
					
				)
				then
				
				
				
				table.insert(currentpoilist,location)
				
				
				
				
				
				
				
			end
			
		end
		
	end
	
	if(listargument == "tag") then
		
		local location = poi_tag[tag]
		if(location ~= nil) then
			
			table.insert(currentpoilist,location)
		end	
		
	end
	
	
	if true then
		-- for k,v in pairs(cyberscript.cache["poi"]) do
		
		
		
		
		-- if
		-- (#v.data.locations > 0) then	
		
		-- for y=1,#v.data.locations do
		
		-- local location = v.data.locations[y]
		
		-- -- logme(4,"TEST POI ---")
		-- -- logme(4,"tag : "..tostring((
		-- -- ((tag == nil or tag == "" or (v.data.tag ~= nil and v.data.tag == tag)) and locationtag == false) or
		-- -- ((tag == nil or tag == "" or (location.Tag ~= nil and location.Tag == tag)) and locationtag == true)
		-- -- )))
		
		-- -- logme(4,"district : "..tostring((district == nil or district == "" or (district ~= nil and location.district == district))))
		-- -- logme(4,"subdistrict : "..tostring((subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict))))
		
		-- -- logme(4,"iscar : "..tostring((iscar == nil or (iscar ~= nil and location.inVehicule == iscar))))
		-- -- logme(4,"poitype : "..tostring((poitype == nil or poitype == 1 or (poitype == v.data.isFor))))
		-- -- logme(4,"fromposition : "..tostring((fromposition == false or	(fromposition == true and check3DPos(curPos, location.x, location.y, location.z, range)))))
		-- -- logme(4,"TEST POI ---")
		
		-- if
		-- (
		-- (
		-- ((tag == nil or tag == "" or (v.data.tag ~= nil and v.data.tag == tag)) and locationtag == false) or
		-- ((tag == nil or tag == "" or (location.Tag ~= nil and location.Tag == tag)) and locationtag == true)
		-- )
		
		-- and
		
		-- (district == nil or district == "" or (district ~= nil and location.district == district)) and
		-- (subdistrict == nil or subdistrict == "" or (subdistrict ~= nil and location.subdistrict == subdistrict)) and
		-- (iscar == nil or (iscar ~= nil and location.inVehicule == iscar)) and
		
		
		-- (poitype == nil or 
		
		-- (
		-- (isArray(poitype) == false and isArray(v.data.isFor) == false and (poitype == 1 or (poitype == v.data.isFor))) or
		-- (isArray(poitype) == true and isArray(v.data.isFor) == false and table_contains(poitype,v.data.isFor)) or
		-- (isArray(poitype) == false and isArray(v.data.isFor) == true and table_contains(v.data.isFor,poitype)) or
		-- (isArray(poitype) == true and isArray(v.data.isFor) == true and table.compare(poitype, v.data.isFor))
		-- )
		
		-- ) and
		
		
		-- (fromposition == false or	(fromposition == true and check3DPos(frompos, location.x, location.y, location.z, range)))
		
		
		-- )
		-- then
		
		
		-- local location =  deepcopy(v.data.locations[y],nil)
		-- location.parent = deepcopy(v.data,nil)
		-- location.parent.locations = nil
		-- table.insert(currentpoilist,location)
		
		
		
		
		
		
		
		-- end
		
		
		
		
		
		-- end
		
		
		-- end
		
		-- end
	end
	
	if(#currentpoilist > 0) then
		
		
		
		if(distancename == "near") then
			-- local currentpoi = nil
			-- --currentpoi = currentpoilist[math.random(#currentpoilist)]
			
			
			-- local distance = function(start)
				-- return math.abs(start.x - frompos.x) + math.abs(start.y - frompos.y)
			-- end
			
			-- -- Define a comparator that compares locations based on
			-- -- distance to final position
			-- local comparator = function(a, b)
				-- return distance(a) < distance(b)
			-- end
			
			-- local adj_tiles
			-- -- Set adj_tiles to an array of grid positions
			
			-- table.sort(currentpoilist, comparator) -- Sort adjacent tiles based on distance
			
			
			currentpoilist = sortPositionsByDistance(currentpoilist, frompos,100000,range)
			--	----print(dump(currentpoilist[1]))
		--	print(dump(currentpoilist[1]))
			return currentpoilist[1]
			
		end
		
		if(distancename == "far") then
		
			currentpoilist = sortPositionsByDistance(currentpoilist, frompos,100000,range)
			-- local currentpoi = nil
			-- --currentpoi = currentpoilist[math.random(#currentpoilist)]
			
			
			-- local distance = function(start)
				-- return math.abs(start.x - frompos.x) + math.abs(start.y - frompos.y)
			-- end
			
			-- -- Define a comparator that compares locations based on
			-- -- distance to final position
			-- local comparator = function(a, b)
				-- return distance(a) < distance(b)
			-- end
			
			-- local adj_tiles
			-- -- Set adj_tiles to an array of grid positions
			
			-- table.sort(currentpoilist, comparator) -- Sort adjacent tiles based on distance
			
			
			
			-- ------print(dump(currentpoilist[#currentpoilist]))
			-- ------print(dump(currentpoilist))
		
			return currentpoilist[#currentpoilist]
			
		end
		
		if(distancename == "random") then
			local currentpoi = nil
			--currentpoi = currentpoilist[math.random(#currentpoilist)]
			
			
			
			
			
			----print(dump(currentpoilist[math.random(1,#currentpoilist)]))
			return currentpoilist[math.random(1,#currentpoilist)]
			
		end
		
		
		
		else
		return nil
	end
	
end
function calculateDistance(point1, point2)
     local dx = point1.x - point2.x
    local dy = point1.y - point2.y
    local dz = point1.z - point2.z
	
    return math.floor(math.sqrt(dx * dx + dy * dy + dz * dz))
end

-- Function to sort a list of position objects from far to near using bucket sort
function sortPositionsByDistance(positions, targetPosition, bucketCount,range)
    -- Create buckets for storing positions
    local buckets = {}
    

    -- Calculate and place positions into buckets based on distance
    for _, position in ipairs(positions) do
        local distance = calculateDistance(position, targetPosition)
		
		if(distance >= 0 and distance <= range) then
			local bucketIndex = distance+1
			
			if buckets[bucketIndex] == nil then buckets[bucketIndex] = {} end
		
			table.insert(buckets[bucketIndex], position)
		end
    end
	
	
    -- Concatenate the buckets to get the sorted positions
    local sortedPositions = {}
     for i, buk in pairs(buckets) do
		
        for _, position in ipairs(buckets[i]) do
            table.insert(sortedPositions, position)
			
        end
    end
	

    return sortedPositions
end

function getNodeIndexFromCircuit(tag,listnodes)
	for i=1,#listnodes do
		
		
		
		
		if(listnodes[i] == tag)then
			return i
		end
		
		
		
		
		
		
	end
end

function getPathBetweenTwoNode(CurrentNode, NextNode)
	logme(4,"CurrentNode"..CurrentNode)
	logme(4,"NextNode"..NextNode)
	for k,v in pairs(cyberscript.cache["path"])do
		
		
		local path = v.data
		logme(4,"startNode"..path.startNode)
		logme(4,"endNode"..path.endNode)
		
		if(path.startNode == CurrentNode and path.endNode == NextNode)then
			return path
		end
		
		
		
		
		
		
	end
end

function getNodefromPosition(x,y,z,range)
	local vec4 = {}
	vec4.x = x
	vec4.y = y
	vec4.z = z
	
	for k,v in pairs(cyberscript.cache["node"]) do
		
		
		local node = v.data
		
		
		
		if(check3DPos(vec4,node.x,node.y,node.z,range) or check3DPos(vec4,node.gameplay_x,node.gameplay_y,node.gameplay_z,range))then
			return node
		end
		
		
		
		
		
		
	end
	
	
end

function getTrack(tag)
	
	for i=1,#arrayTrack do
		
		
		local location = arrayTrack[i]
		
		if(location.tag == tag)then
			return location
		end
		
		
		
		
		
		
	end
	
	
end

function getCurrentTrack(tag)
	
	for i=1,#enabledTrack do
		
		
		local location = enabledTrack[i]
		
		if(location.tag == tag)then
			return location
		end
		
		
		
		
		
		
	end
	
	
end

function getCurrentTrackIndex(tag)
	
	for i=1,#enabledTrack do
		
		
		local location = enabledTrack[i]
		
		if(location.tag == tag)then
			return i
		end
		
		
		
		
		
		
	end
	
	
end

function checkQuestStatutByTag(tag, statut)
	local result = false
	
	
	
	
	
	
	
	
	if(currentSave.Variable[tag] ~= nil) then
		
		
		
		if( currentSave.Variable[tag]["Score"] == statut) then
			result = true
		end
		
		else
		
		if(currentSave.Variable[tag] == statut) then
			
			result = true
			
		end
		
	end
	
	return result
end

function getCircuit(tag)
	
	
	
	if(cyberscript.cache["circuit"][tag] ~= nil) then
		return cyberscript.cache["circuit"][tag].data
	end
	
	
end

function getNode(tag)
	
	
	if(cyberscript.cache["node"][tag] ~= nil) then
		return cyberscript.cache["node"][tag].data
	end
	
	
	
	
	
	
end

function getRadioByTag(tag)
	
	
	
	if(cyberscript.cache["radio"][tag] ~= nil)then
		return cyberscript.cache["radio"][tag].data
	end
	
	
	return nil
	
end	

function getMappinByTag(tag)
	
	
	return mappinManager[tag]
	
end

function getPNJ (tab, val)
	for index, value in ipairs(tab) do
		if value.ID == val then
			
			return value
		end
	end
	
	return false
end

function getGameTime()
	
	local temp = {}
	local gameTime = Game.GetTimeSystem():GetGameTime()
	
	temp.hour = GetSingleton('GameTime'):Hours(gameTime)
	temp.min = GetSingleton('GameTime'):Minutes(gameTime)
	temp.sec = GetSingleton('GameTime'):Seconds(gameTime)
	temp.day = GetSingleton('GameTime'):Days(gameTime)
	
	return temp
	
end

function getDistrictfromEnum(enum)
	
	for i = 1, #arrayDistricts do
		if arrayDistricts[i].EnumName:upper() == Game.GetLocalizedText(enum):upper() then
			return arrayDistricts[i]
			
			
		end
		
	end
	
end

function getDistrictBySubfromEnum(enum)
	
	for i = 1, #arrayDistricts do
		if(#arrayDistricts[i].SubDistrict > 0) then
			for j=1,#arrayDistricts[i].SubDistrict do
				if arrayDistricts[i].SubDistrict[j]:upper() == Game.GetLocalizedText(enum):upper() then
					return arrayDistricts[i]
					
					
				end
			end
		end	
	end
	
end

function getDistrictByTag(district)
	
	for i = 1, #arrayDistricts do
		if(arrayDistricts[i].Tag == district) then
			
			
			return arrayDistricts[i]
			
			
			
		end
	end	
end

function getMappinByGroup(group)
	local mapLot = {}
	
	for k,v in pairs(mappinManager) do
		if(v.group and v.group == group )then
			table.insert(mapLot,v)
		end
	end
	
	return mapLot
end

function GetPlayerGender()
	-- True = Female / False = Male
	if string.find(tostring(Game.GetPlayer():GetResolvedGenderName()), "Female") then
		return "female"
		else
		return "male"
	end
end

function GetEntityGender(entity)
	-- True = Female / False = Male
	logme(4,tostring(Game.NameToString(entity:GetBodyType())))
	logme(4,tostring(string.find(string.lower(tostring(Game.NameToString(entity:GetBodyType()))), "woman")))
	if string.match(string.lower(tostring(Game.NameToString(entity:GetBodyType()))), "woman") then
		return "female"
		else
		return "male"
	end
end

function getQuestByTag(tag)
	
	local parentquest = cyberscript.cache["mission"][tag]
	local quest = nil
	if(parentquest ~= nil) then
		quest =  parentquest.data
		--logme(4,parentquest.file)
	end
	return quest
	
	
end

function getQuestStatut(tag)
	
	
	
	local score = getScoreKey(tag,"Score")
	
	if(score ~= nil) then
		return score
		
	end
	
	return nil
	
	
end

function getMarketScoreByTag(tag)
	
	local result = nil
	
	for i=1,#arrayMarket do
		
		if(arrayMarket[i].tag == tag) then
			return arrayMarket[i]
		end
		
		
		
	end
	
	return result
	
end

function getScorebyTag(tag)
	
	local score = 0
	
	score = getScoreKey(tag,"Score")
	if(score == nil)then
		score = 0
	end
	
	
	
	return score
	
end

function getFactionByDistrictTag(tag)
	
	local factiontable = {}
	
	for k,v in pairs(cyberscript.cache["faction"]) do
		checkContext(v)
		if(cyberscript.cache["faction"][k].data.district_tag == tag) then
			
			table.insert(factiontable,cyberscript.cache["faction"][k].data)
			
		end
		
		
		
	end
	
	return factiontable
	
end

function getVIPfromfactionbyscore(factiontag)
	local tempvip = {}
	
	local faction = getFactionByTag(factiontag)
	
	local playerscore = getScorebyTag(factiontag)
	
	
	if(#faction.vip > 0) then
		for i=1,#faction.vip do 
			
			if(faction.vip[i].score <= playerscore) then
				
				local npc = getNPCByName(faction.vip[i].name)
				
				table.insert(tempvip,npc.TweakIDs)
				
			end
			
			
		end
	end
	
	if(#tempvip == 0) then
		logme(10,getLang("scripting_novip01")..factiontag..getLang("scripting_novip02")..playerscore)
	end
	
	return tempvip
end

function getGangfromDistrict(district,minimum)
	
	local factiontable = {}
	
	for k,v in pairs(cyberscript.cache["faction"]) do
		
		if(currentSave.Variable[k] ~= nil and currentSave.Variable[k][district] ~= nil and currentSave.Variable[k][district] >= minimum) then
			
			local factionscore= {}
			factionscore.tag = k
			factionscore.score = currentSave.Variable[k][district]
			table.insert(factiontable,factionscore)
			
			else
			
			
			getVariableKeyWithDefault(k, district,0)
			
			
		end
		
		
		
	end
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	
	return factiontable
	
end

function getGangRivalsFromGang(gang)
	
	local factiontable = {}
	if(currentSave.Variable[gang] ~= nil) then
		for k,v in pairs(currentSave.Variable[gang]) do
			if(k ~= "Score") then
				local factionscore= {}
				factionscore.tag = k
				factionscore.score =getFactionRelation(gang,k)
				table.insert(factiontable,factionscore)
			end
		end
	end
	table.sort(factiontable, function(a,b) return a.score < b.score end)
	
	return factiontable
	
end

function getGangRivalfromDistrict(gang,district,minimum)
	
	local districttable = {}
	local factiontable = {}
	
	for k,v in pairs(cyberscript.cache["faction"]) do
		
		if(currentSave.Variable[k] ~= nil and currentSave.Variable[k][district] ~= nil and currentSave.Variable[k][district] >= minimum) then
			
			local factionscore= {}
			factionscore.tag = k
			factionscore.score = currentSave.Variable[k][district]
			table.insert(districttable,factionscore)
			
			else
			
			getVariableKeyWithDefault(k,district,0)
			
			
		end
		
		
		
	end
	
	
	
	
	for i=1,#districttable do
		
		local factionscore= {}
		factionscore.tag = districttable[i].tag
		factionscore.score = getFactionRelation(gang,districttable[i].tag)
		table.insert(factiontable,factionscore)
		
	end
	
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	return factiontable
	
end

function getGangfromDistrictAndSubdistrict(district,minimum)
	
	local factiontable = {}
	
	
	local mydistrict = getDistrictByTag(district)
	
	for k,v in pairs(cyberscript.cache["faction"]) do
		
		
		if(currentSave.Variable[k] ~= nil and currentSave.Variable[k][mydistrict.Tag] ~= nil and currentSave.Variable[k][mydistrict.Tag] >= minimum) then
			-- logme(4,k)
			
			local obj = {}
			obj.tag = k
			obj.score = currentSave.Variable[k][mydistrict.Tag]
			table.insert(factiontable,obj)
			
			
			
			
			else
			getVariableKeyWithDefault(k,mydistrict.Tag,0)
			
			
		end
		
		
		
	end
	
	
	
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	
	return factiontable
	
end

function getGangAffinityfromDistrictAndSubdistrict(district,minimum)
	
	local factiontable = {}
	
	
	
	local mydistrict = getDistrictByTag(district)
	
	for k,v in pairs(cyberscript.cache["faction"]) do
		
		
		if(currentSave.Variable[k] ~= nil and currentSave.Variable[k][mydistrict.Tag] ~= nil and currentSave.Variable[k][mydistrict.Tag] >= minimum) then
			
			
			local obj = {}
			obj.tag = k
			obj.score = getScorebyTag(k)
			table.insert(factiontable,obj)
			
			
			
			
			else
			getVariableKeyWithDefault(k,mydistrict.Tag,0)
			
			
		end
		
		
		
	end
	
	for i=1,#mydistrict.SubDistrict do
		
		local subdist = mydistrict.SubDistrict[i]
		logme(4,subdist)
		for k,v in pairs(cyberscript.cache["faction"]) do
			
			
			if(currentSave.Variable[k] ~= nil and currentSave.Variable[k][subdist] ~= nil and currentSave.Variable[k][subdist] >= minimum) then
				for i=1,#factiontable do
					if(factiontable[i].tag == k) then
						
						factiontable[i].score =  factiontable[i].score + getScorebyTag(k)
						else
						
						local obj = {}
						obj.tag = k
						obj.score = getScorebyTag(k)
						table.insert(factiontable,obj)
						logme(4,k)
						
					end
					
					
					
				end
			end
			
			
		end
	end
	
	
	
	table.sort(factiontable, function(a,b) return a.score > b.score end)
	
	return factiontable
	
end

function getFactionByTag(tag)
	
	local factiontable = {}
	
	for k,v in pairs(cyberscript.cache["faction"]) do
		checkContext(v)
		if(cyberscript.cache["faction"][k].data.tag == tag) then
			
			return cyberscript.cache["faction"][k].data
			
		end
		
		
		
	end
	
	return factiontable
	
end

function getItemEntityFromManager(entid)
	
	local obj =  nil
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			
			
			
			if type(enti.entityId) ~= "number" then
				
				if(enti.entityId.hash == entid.hash) then
					
					obj = enti
					
				end
				
			end
			
			
			
			
			
		end
	end
	return obj
	
	
	
end

function getItemEntityIndexFromManager(entid)
	
	
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			
			
			
			if type(enti.entityId) ~= "number" then
				
				if(enti.entityId.hash == entid.hash) then
					
					return i
					
				end
				
			end
			
			
			
			
			
		end
	end
	
	return nil
	
	
	
end

function getItemByHouseTagandTagFromManager(tag,housetag)
	
	
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			
			
			
			if enti.HouseTag == housetag and enti.Tag == tag then
				
				
				
				return i
				
				
				
			end
			
			
			
			
			
		end
	end
	
	return nil
	
	
	
end

function getItemEntityFromManagerByPlayerLookinAt()
	
	local obj =  nil
	
	if(#currentItemSpawned > 0) then
		for i = 1, #currentItemSpawned do
			
			local enti = currentItemSpawned[i]
			local playerlook = getForwardPosition(Game.GetPlayer(),2)
			
			
			
			if type(enti.entityId) ~= "number" then
				local postion = Vector4.new(enti.X, enti.Y, enti.Z, 1)
				
				if(check3DPos(postion, playerlook.x, playerlook.y, playerlook.z,1, 3)) then
					
					obj = enti
					
				end
				
			end
			
			
			
			
			
		end
	end
	return obj
	
	
	
end

function getItemFromUserHousing(tag,X,Y,Z,HouseTag,ItemPath)
	
	for i=1,#currentSave.arrayHousing do
		
		if(currentSave.arrayHousing[i].Tag == tag and currentSave.arrayHousing[i].HouseTag == HouseTag and currentSave.arrayHousing[i].ItemPath == ItemPath) then
			return currentSave.arrayHousing[i]
		end
		
	end
	
	return nil
end

function getItemCountInCart(tag) 
	
	local count = 0
	
	for i=1,#ItemsCart do
		
		if(ItemsCart[i].tag == tag) then
			
			count = count + 1
			
		end
		
	end
	
	
	return count
	
end

function getEntityFromManager(tag)
	local obj = {}
	obj.id = nil
	
	
	local enti = cyberscript.EntityManager[tag]
	if(enti ~= nil) then
		obj = enti
	end
	
	
	
	
	if(tag == "lookatentity" or tag == "last_spawned") then
		
		
		
		
		
		local enti = cyberscript.EntityManager[cyberscript.EntityManager[tag].tag]
		
		if(enti ~= nil) then
			
			obj = enti
			
		end	
		
		
		
		
		
	end

	if(enti ~= nil and enti.primarytag ~= nil) then
		
		
		
		
		
		local enti = cyberscript.EntityManager[enti.primarytag]
		
		if(enti ~= nil) then
			
			obj = enti
			
		end	
		
		
		
		
		
	end
	
	if(tag == "mounted_vehicle" ) then
		
		if Game['GetMountedVehicle;GameObject'](Game.GetPlayer()) ~= nil then
			
			
			
			
			local enti = cyberscript.EntityManager["mounted_vehicle"]
			if (enti ~= nil) and type(enti.id) ~= "number" then
				
				if(enti.id ~= nil and enti.id.hash == Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetEntityID().hash) then
					obj = enti
				end
				
			end	
			
			
			if(obj.id == nil) then
				obj.id = Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetEntityID()
				obj.tag = "mounted_vehicle"
				obj.tweak = nil
				else
				--		obj.tag = "lookat"
			end
			
		end
	end
	
	
	
	return obj
end

function getTrueEntityFromManager(tag)
	
	
	
	local enti = cyberscript.EntityManager[tag]
	

	if(tag == "lookatentity" or tag == "last_spawned") then
		
		
		
		
		
		local enti = cyberscript.EntityManager[cyberscript.EntityManager[tag].tag]
		
		if(enti ~= nil) then
			
			obj = enti
			
		end	
		
		
		
		
		
	end

	if(enti ~= nil and enti.primarytag ~= nil) then
		
		
		
		
		
		local enti = cyberscript.EntityManager[enti.primarytag]
		
		if(enti ~= nil) then
			
			obj = enti
			
		end	
		
		
		
		
		
	end

	if(tag == "mounted_vehicle" ) then
		
		if Game['GetMountedVehicle;GameObject'](Game.GetPlayer()) ~= nil then
			
			
			
			
			local enti = cyberscript.EntityManager["mounted_vehicle"]
			if (enti ~= nil) and type(enti.id) ~= "number" then
				
				if(enti.id ~= nil and enti.id.hash == Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetEntityID().hash) then
					obj = enti
				end
				
			end	
			
			
			if(obj.id == nil) then
				obj.id = Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetEntityID()
				obj.tag = "mounted_vehicle"
				obj.tweak = nil
				else
				--		obj.tag = "lookat"
			end
			
		end
	end
	
	
	if((enti ~= nil) and enti.tag == tag) then
		return enti
	end
	
	
	
	
end

function setEntityFromManager(tag,obju)
	
	
	
	
	cyberscript.EntityManager[tag] = obju
	
	
	
	
	
	
end

function getExpression(name)
	
	for i = 1, #reactionlist do
		
		local enti = reactionlist[i]
		if(enti.name == name) then
			return enti
		end
		
		
	end
	
end

function getEntityFromManagerById(Id, avoid)
	local obj = {}
	obj.id = nil
	for k,v in pairs(cyberscript.EntityManager) do
		
		local enti = v
		
		if( avoid == false or ((avoid == nil or avoid == true) and k ~= "lookatentity" and k ~= "lookatnpc")) then
		
			if type(enti.id) ~= "number" then
				
				if(enti.id ~= nil and Id ~= nil and enti.id.hash == Id.hash) then
					obj = v
					
					
				end
				
			end

		end
		
		
		
		
		
	end
	if(obj.id ~= nil and obj.primarytag ~= nil) then
		obj = cyberscript.EntityManager[obj.primarytag]
	end

	return obj
	
end


function getScannerdataFromEntityOrGroupOfEntity(entity)
	
	if (ScannerInfoManager[entity.tag] ~= nil) then
		return ScannerInfoManager[entity.tag]
		
		else
		local group= getEntityGroupfromEntityTag(entity.tag)
		if group ~= nil then
			
			if (ScannerInfoManager[group.tag] ~= nil) then
				return ScannerInfoManager[group.tag]
			end
		end
		
	end
	
	return nil
	
	
end

function getGroupfromManager(tag)
	
	
	
	return cyberscript.GroupManager[tag]
	
	
end

function getEntityGroupfromEntityTag(tag)
	local goodgroup = nil
	
	for k,v in pairs(cyberscript.GroupManager)do
		
		local group = v
		if(#group.entities > 0) then
			
			for y=1,#group.entities do
				
				local entity = group.entities[y]
				
				if(entity == tag) then
					goodgroup = group
				end
				
				
				
			end
		end
	end
	
	return goodgroup
end

function getEntityIndexIntoGroup(grouptag, tag)
	local group = getGroupfromManager(grouptag)
	local index = nil
	for i, v in ipairs (group) do 
		if (v == tag) then
			index = i 
		end
	end
	return index
end



function getCustomNPCbyTag(tag)
	
	
	
	if (cyberscript.cache["npc"][tag] ~= nil) then
		
		return cyberscript.cache["npc"][tag].data
		
	end
	
	
	
	return nil
	
end

function getInkWidget(tag)
	
	
	for k, interface in pairs(currentInterfaceWidget) do
		
		for i,control in ipairs(interface.controls) do
			
			if(control.tag == tag) then
				
				return control
				
			end
			
		end
		
		
	end
	
end

function getInkWidgetControl(uitag,tag)
	
	
	if(currentInterfaceWidget[uitag] ~= nil) then
		
		for i,control in ipairs(currentInterfaceWidget[uitag].controls) do
			
			if(control.tag == tag) then
				
				return control
				
			end
			
		end
		
	end
	
	
end

function GetInterfaceChildren(interface,tag)
	
	
	
	
	for i,control in ipairs(interface.controls) do
		
		if(control.tag == tag) then
			
			return control
			
		end
		
	end
	
	
	
	
end


function RemoveInterfaceChildren(interface,tag)
	
	
	
	
	for i,control in ipairs(interface.controls) do
		
		if(control.tag == tag) then
			
			control = nil
			
		end
		
	end
	
	
	
	
end

function getCustomAction(house,roomTypeId)
	
	
	for i=1, #arrayPlaceInteract do 
		if(has_value(arrayPlaceInteract[i].place,house.type)) then
			
			if(arrayPlaceInteract[i].type == roomTypeId) then
				
				if(arrayPlaceInteract[i].placetag ~= "")then
					
					
					customActionUI(arrayPlaceInteract[i])
					
					
					else
					if(arrayPlaceInteract[i].placeTag == house.tag)then 
						
						customActionUI(arrayPlaceInteract[i])
						
					end
				end
				
				
			end
			
			
		end
		
	end
end

function getHouseByTag(tag)
	
	return cyberscript.cache["place"][tag].data
end

function getRoomByTag(tag, housetag)
	
	for i=1,#cyberscript.cache["place"][housetag].data.rooms do
		
		if(cyberscript.cache["place"][housetag].data.rooms[i].tag == tag) then
			return cyberscript.cache["place"][housetag].data.rooms[i]
		end
	end
	return nil
end

function getHouseStatut(houseTag)
	
	
	return getScoreKey(houseTag,"Statut")
	
	
end

function getHouseProperties(houseTag)
	
	
	return getScore(houseTag)
	
	
	
end

function getNPCById(npcId)
	
	for k,v in pairs(cyberscript.entitieshash) do
		
		if v.entity_id == npcId then
			
			
			
			return v
		end
		
	end
	
	
	
end

function getNPCByTweakId(tweak)
	
	for k,v in pairs(cyberscript.entitieshash) do
		
		if v.entity_tweak == tweak then
			
			
			
			return v
		end
		
	end
end

function getNPCByName(name)
	
	for k,v in pairs(cyberscript.entitieshash) do
		
		if v.entity_name == name then
			
			
			
			return v
		end
		
	end
end

function getPhonedNPCByName(name)
	
	for i=1, #arrayPhoneNPC do
		
		if arrayPhoneNPC[i].Names == name then
			
			
			
			return arrayPhoneNPC[i]
		end
		
	end
end

function findPhonedNPCByName(name)
	logme(4,#arrayPhoneNPC)
	for i=1, #arrayPhoneNPC do
		
		if string.find(string.lower(name),string.lower(arrayPhoneNPC[i].Names) ) then
			
			
			
			return arrayPhoneNPC[i]
		end
		
	end
end

function getPhonedNPCByTweakDBId(tweak)
	
	for i=1, #arrayPhoneNPC do
		
		if arrayPhoneNPC[i].TweakIDs == tweak then
			
			
			
			return arrayPhoneNPC[i]
		end
		
	end
end

function getFixerByTag(tag)
	
	
	
	if cyberscript.cache["fixer"][tag] ~= nil then
		
		local fixer = cyberscript.cache["fixer"][tag].data
		checkContext(fixer)
		
		
		
		return fixer
	end
	
	return nil
end

function getSoundByName(name)
	
	for k,v in pairs(cyberscript.cache["sound"]) do
		
		if v.data.name == name then
			
			
			
			return v.data
		end
		
	end
	
	return nil
end

function getLang(text)
	
	
	
	
	if(cyberscript.language ~= nil and cyberscript.cache["lang"] ~= nil )then
		
		for k,languagefile in pairs(cyberscript.cache["lang"]) do
			
			if(languagefile.data.languages[cyberscript.language] ~= nil and languagefile.data.languages[cyberscript.language][text] ~= nil) then
			
				return languagefile.data.languages[cyberscript.language][text]
			
			end
			
			
			
		end
		
		
		for k,languagefile in pairs(cyberscript.cache["lang"]) do
			
			if(languagefile.data.languages["default"] ~= nil and languagefile.data.languages["default"][text] ~= nil) then
			
				return languagefile.data.languages["default"][text]
			
			end
			
			
			
		end
		
		
		
		
	
		
		
		
	end	
	
	if(lang["default"] ~= nil and lang["default"][text] ~= nil and lang["default"][text] ~= "" )then
		
			return lang["default"][text]	
		
	end
	
	return text
	
end

function getCustomScorebyTag(tag)
	
	return getScore(tag)
	
end

function getPlayerItemsbyTag(tag)
	
	for i=1,#currentSave.arrayPlayerItems do
		if(currentSave.arrayPlayerItems[i].Tag == tag) then
			return currentSave.arrayPlayerItems[i]
		end
	end
	
end



function getSoundByNameNamespace(name,namespace)
	
	for k,v in pairs(cyberscript.cache["sound"]) do
		
		if k == name and v.sound.namespace == namespace then
			
			logme(4,"sound founded")
			
			return v.data
		end
		
	end
	
	return nil
end

function GetSoundSettingValue(volumTag)
	
	local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", volumTag)
	return SfxVolume:GetValue()
end

function getHelpByTag(tag)
	for i=1, #cyberscript.cache["help"] do
		
		if cyberscript.cache["help"][i].tag == tag then
			return cyberscript.cache["help"][i].data
		end
	end
	return
end


function getTextureByTag(tag)
	
	
	
	if cyberscript.cache["texture"][tag] ~= nil then
		
		
		
		return cyberscript.cache["texture"][tag].data
	end
	
	return nil
end		


function printbool(bool)

	print(tostring(bool))

end

function refreshUIWidgetController(active)
	if active == true then
		pcall(function()
			if(GameController["MinimapContainerController"] ~= nil and displayHUD["default_minimap_root"] == nil ) then
				
				--print("MinimapContainerController")
				displayHUD["default_minimap_root"] = GameController["MinimapContainerController"]:GetRootWidget()
				
				displayHUD["default_minimap_container"] = GameController["MinimapContainerController"]:GetRootWidget():GetWidgetByIndex(4)
				
			end
		end)
		pcall(function()
			if(GameController["healthbarWidgetGameController"] ~= nil and displayHUD["default_healthbar"] == nil ) then
				--print("healthbarWidgetGameController")
				displayHUD["default_healthbar"] = GameController["healthbarWidgetGameController"]:GetRootWidget()
				
			end
		end)
		pcall(function()
			if(GameController["StaminabarWidgetGameController"] ~= nil and displayHUD["default_staminabar"] == nil ) then
				--print("StaminabarWidgetGameController")
				displayHUD["default_staminabar"] = GameController["StaminabarWidgetGameController"]:GetRootWidget()
				
			end
		end)
		pcall(function()
			if(GameController["HotkeysWidgetController"] ~= nil and displayHUD["default_hotkey"] == nil ) then
				
				--print("HotkeysWidgetController")
				displayHUD["default_hotkey"] = GameController["HotkeysWidgetController"].root
				displayHUD["default_hotkey_phone"] = GameController["HotkeysWidgetController"].phone
				displayHUD["default_hotkey_car"] = GameController["HotkeysWidgetController"].car
				displayHUD["default_hotkey_consumables"] = GameController["HotkeysWidgetController"].consumables
				displayHUD["default_hotkey_gadgets"] = GameController["HotkeysWidgetController"].gadgets
			end
		end)
		local result,err = pcall(function()
			if(GameController["BraindanceGameControllerRoot"] ~= nil and displayHUD["main_root_default"] == nil) then
				--print("BraindanceGameControllerRoot")
				----print("setting HUD")
				
				local rootContainerHUD = GameController["BraindanceGameControllerRoot"]
				pcall(function() 
					rootContainerHUD:SetVisible(true)
				end)
				
				local cscontainer = rootContainerHUD:GetWidget(CName("default_cs")) 
				local makenew = false
				local hudprocessing = false
				
				
				if(cscontainer == nil) or (cscontainer:GetName() ~= CName("default_cs")) then
					----print("No container")
					CName.add("default_cs")
					local cscontainer = nil
					cscontainer = inkCanvas.new()
					cscontainer:SetName(CName("default_cs"))
					cscontainer:SetAnchor(0)
					cscontainer:SetFitToContent(false)
					cscontainer:SetSize(rootContainerHUD:GetWidth(),rootContainerHUD:GetHeight() )
					cscontainer:Reparent(rootContainerHUD, -1)
					makenew = true
					
					
				end
				
				
				
				displayHUD["main_root_default"] = cscontainer
				
				
				
				if(makenew == true) then
					----print("redo HUD")
					hudprocessing = true
					for k,v in pairs(cyberscript.cache["hud"]) do
						local hud = v.data
						if(hud.type == "container") then
							displayHUD[k] = inkCanvas.new()
							displayHUD[k]:SetName(CName.new(hud.tag))
							displayHUD[k]:SetAnchor(inkEAnchor.Fill)
							displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
							
							
						end
					end
					
					
					for k,v in pairs(cyberscript.cache["hud"]) do
						local hud = v.data
						if(hud.type == "container") then
							if(hud.container == nil or hud.container == "default" or  hud.container == "") then
								displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
								else
								displayHUD[k]:Reparent(displayHUD[hud.container], -1)
							end
							
							
						end
					end
					
					for k,v in pairs(cyberscript.cache["hud"]) do
						local hud = v.data
						if(hud.type == "widget") then
							displayHUD[k] = inkText.new()
							displayHUD[k]:SetName(CName.new(hud.tag))
							displayHUD[k]:SetMargin(inkMargin.new({ top = hud.margin.top, left = hud.margin.left}))
							displayHUD[k]:SetFontFamily(hud.fontfamily)
							displayHUD[k]:SetFontStyle(hud.fontstyle)
							displayHUD[k]:SetFontSize(hud.fontsize)
							displayHUD[k]:SetTintColor(gamecolor(hud.color.red,hud.color.green,hud.color.blue,1))
							displayHUD[k]:SetVisible(hud.visible)
							displayHUD[k]:SetHorizontalAlignment(textHorizontalAlignment.Center)
							displayHUD[k]:SetVerticalAlignment(textVerticalAlignment.Center)
							
							if(hud.container == nil or hud.container == "default" or hud.container == "") then
								displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
								else
								displayHUD[k]:Reparent(displayHUD[hud.container], -1)
							end
							
						end
						
					end
					
					----print("HUD created")
					else
					if hudprocessing == false then
						----print("recreate HUD")
						displayHUD["main_root_default"]:RemoveAllChildren()
						
						
						for k,v in pairs(cyberscript.cache["hud"]) do
							local hud = v.data
							if(hud.type == "container") then
								
								
								displayHUD[k] = inkCanvas.new()
								displayHUD[k]:SetName(CName.new(hud.tag))
								displayHUD[k]:SetAnchor(inkEAnchor.Fill)
								displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
								
								
								
							end
						end
						
						
						for k,v in pairs(cyberscript.cache["hud"]) do
							local hud = v.data
							if(hud.type == "container") then
								if(hud.container == nil or hud.container == "default" or  hud.container == "") then
									displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
									else
									displayHUD[k]:Reparent(displayHUD[hud.container], -1)
								end
								
								
							end
						end
						
						for k,v in pairs(cyberscript.cache["hud"]) do
							local hud = v.data
							if(hud.type == "widget") then
								
								
								displayHUD[k] = inkText.new()
								displayHUD[k]:SetName(CName.new(hud.tag))
								displayHUD[k]:SetMargin(inkMargin.new({ top = hud.margin.top, left = hud.margin.left}))
								displayHUD[k]:SetFontFamily(hud.fontfamily)
								displayHUD[k]:SetFontStyle(hud.fontstyle)
								displayHUD[k]:SetFontSize(hud.fontsize)
								displayHUD[k]:SetTintColor(gamecolor(hud.color.red,hud.color.green,hud.color.blue,1))
								displayHUD[k]:SetVisible(hud.visible)
								displayHUD[k]:SetHorizontalAlignment(textHorizontalAlignment.Center)
								displayHUD[k]:SetVerticalAlignment(textVerticalAlignment.Center)
								
								if(hud.container == nil or hud.container == "default" or hud.container == "") then
									displayHUD[k]:Reparent(displayHUD["main_root_default"], -1)
									else
									displayHUD[k]:Reparent(displayHUD[hud.container], -1)
								end
							end
							
							
							
							
						end
						
						----print("HUD initialised")
					end
				end
			end
		end)
		
		if(result == false) then 
			logme(1,err)
		end
		
		
		pcall(function()
			if(GameController["hudCorpoController"] ~= nil and displayHUD["hud_corpo"] == nil ) then
				
				displayHUD["hud_corpo"] = GameController["hudCorpoController"].root
				
				--print("hudCorpoController")
				
				displayHUD["hud_corpo_market"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0)
				displayHUD["hud_corpo_market_marketFluffIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(0)
				displayHUD["hud_corpo_market_marketFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(1)
				displayHUD["hud_corpo_market_marketConnection"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(2)
				displayHUD["hud_corpo_market_marketHolderIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(3)
				displayHUD["hud_corpo_market_marketHolderFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(4)
				
				displayHUD["hud_corpo_market_marketWindowWrapperA"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5)
				displayHUD["hud_corpo_market_marketWindowWrapperA_container"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0)
				displayHUD["hud_corpo_market_marketWindowWrapperA_marketText"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(0)
				displayHUD["hud_corpo_market_marketWindowWrapperA_marketWindow"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(1)
				displayHUD["hud_corpo_market_marketWindowWrapperA_marketMask"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(2)
				displayHUD["hud_corpo_market_marketWindowWrapperA_FluffTxt_bottom2"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(3)
				displayHUD["hud_corpo_market_marketWindowWrapperA_Flufftxt_Bottom"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(4)
				displayHUD["hud_corpo_market_marketWindowWrapperA_logoArasaka"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(5)
				displayHUD["hud_corpo_market_marketWindowWrapperA_FluffTxt_bottom3"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(6)
				displayHUD["hud_corpo_market_marketWindowWrapperA_03_mt_bottfluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(5):GetWidgetByIndex(0):GetWidgetByIndex(7)
				
				displayHUD["hud_corpo_market_marketWindowWrapperB"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6)
				displayHUD["hud_corpo_market_marketWindowWrapperB_markerGraph"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(0)
				displayHUD["hud_corpo_market_marketWindowWrapperB_marketWindow"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(1)
				displayHUD["hud_corpo_market_marketWindowWrapperB_marketMask"] = GameController["hudCorpoController"].root:GetWidgetByIndex(0):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(2)
				
				displayHUD["hud_corpo_assistant"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1)
				displayHUD["hud_corpo_assistant_header"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(0)
				displayHUD["hud_corpo_assistant_text"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(1)
				displayHUD["hud_corpo_assistant_connection"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(2)
				displayHUD["hud_corpo_assistant_holderfluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(3)
				displayHUD["hud_corpo_assistant_holdericon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(4)
				displayHUD["hud_corpo_assistant_holderplate"] = GameController["hudCorpoController"].root:GetWidgetByIndex(1):GetWidgetByIndex(5)
				
				
				
				displayHUD["hud_corpo_stock"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2)
				displayHUD["hud_corpo_stock_stockConnection"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(0)
				displayHUD["hud_corpo_stock_stockFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(1)
				displayHUD["hud_corpo_stock_stockLogo"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(2)
				displayHUD["hud_corpo_stock_stockHolderIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(3)
				displayHUD["hud_corpo_stock_stockHolderFluff"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(4)
				displayHUD["hud_corpo_stock_stockBorder"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(5)
				displayHUD["hud_corpo_stock_marqueeUnit"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6)
				
				displayHUD["hud_corpo_stock_marqueeUnit_name_pet"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(2)
				displayHUD["hud_corpo_stock_marqueeUnit_name_orb"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(5)
				displayHUD["hud_corpo_stock_marqueeUnit_name_mil"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(8)
				displayHUD["hud_corpo_stock_marqueeUnit_name_ara"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(11)
				
				displayHUD["hud_corpo_stock_marqueeUnit_value_pet"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(0)
				displayHUD["hud_corpo_stock_marqueeUnit_value_orb"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(3)
				displayHUD["hud_corpo_stock_marqueeUnit_value_mil"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(6)
				displayHUD["hud_corpo_stock_marqueeUnit_value_ara"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(9)
				
				displayHUD["hud_corpo_stock_marqueeUnit_arrow_pet"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(1)
				displayHUD["hud_corpo_stock_marqueeUnit_arrow_orb"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(4)
				displayHUD["hud_corpo_stock_marqueeUnit_arrow_mil"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(7)
				displayHUD["hud_corpo_stock_marqueeUnit_arrow_ara"] = GameController["hudCorpoController"].root:GetWidgetByIndex(2):GetWidgetByIndex(6):GetWidgetByIndex(0):GetWidgetByIndex(10)
				
				displayHUD["hud_corpo_logo"] = GameController["hudCorpoController"].root:GetWidgetByIndex(3)
				
				displayHUD["hud_corpo_news"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5)
				displayHUD["hud_corpo_news_stockHolderIcon"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(0)
				displayHUD["hud_corpo_news_hudFluffRight"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(1)
				displayHUD["hud_corpo_news_title"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(2)
				displayHUD["hud_corpo_news_inkFlexWidget9"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(3)
				displayHUD["hud_corpo_news_content"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(3):GetWidgetByIndex(0)
				displayHUD["hud_corpo_news_inkBorderWidget14"] = GameController["hudCorpoController"].root:GetWidgetByIndex(5):GetWidgetByIndex(4)
				
			end
		end)
		
		-- local panzer = VehiclePanzerBootupUIQuestEvent.new()
		-- panzer.mode  = 3
		
		-- Game.GetUISystem():QueueEvent(panzer)
		
	end
	
end	

function refreshModVariable(active)
	if active == true then
		 if(GameController["HUDManager"] ~= nil) then inScanner = GameController["HUDManager"].uiScannerVisible else inScanner = false end
		player = Game.GetPlayer()
		currentTime = getGameTime()
		curPos = player:GetWorldPosition()
		
		next_ambush = next_ambush + 1	
		loadCustomPlace()
		--itemMover()
		
		curRot = GetSingleton('Quaternion'):ToEulerAngles(Game.GetPlayer():GetWorldOrientation())
		
		districtState = lang.Friendly
		getCurrentDistrict2()
		
		
		
		if(currentDistricts2 ~= nil)then
			
			setVariable("current_district","tag", currentDistricts2.Tag)
			local district =  getDistrictByTag(currentDistricts2.Tag)
			if district~= nil then setVariable("current_district","enum", district.EnumName) end
			if(districtState == nil) then
				districtState = "loading"
				
			end	
			
			local disstate = isHostileDistrict()
			setVariable("current_district","state",disstate)
			
			if(disstate == 0) then 
				
				setVariable("current_district","stateName",getLang("Friendly"))
				districtState = getLang("Friendly")
				
			end
			
			if(disstate == 1) then 
				
				setVariable("current_district","stateName",getLang("Neutral"))
				districtState = getLang("Neutral")
				
			end
			
			if(disstate == 2) then 
				
				setVariable("current_district","stateName",getLang("Hostile"))
				districtState = getLang("Hostile")
				
			end
			
			
			
			
			local districttext = ""
			if(currentDistricts2.districtLabels ~=nil and #currentDistricts2.districtLabels > 0) then
				
				if(currentDistricts2.districtLabels ~=nil and #currentDistricts2.districtLabels > 1) then
					
					setVariable("current_district","subdistrict_enum", currentDistricts2.districtLabels[2])
					else
					setVariable("current_district","subdistrict_enum", "")
				end
				
				for i, test in ipairs(currentDistricts2.districtLabels) do
					if i == 1 then
						if(#currentDistricts2.districtLabels == 1) then
							
							
							districttext = districttext.."  |  "..test.." ("..districtState..")"
							else
							
							districttext = districttext..test
							
						end
						else
						districttext = districttext.."  |  "..test.." ("..districtState..")"
					end
				end
				
				setVariable("current_district","districttext",districttext)
				
				else
				setVariable("current_district","tag", "")
				setVariable("current_district","enum", "")
				setVariable("current_district","districttext","")
				setVariable("current_district","subdistrict_enum", "")
				setVariable("current_district","state","")
				setVariable("current_district","stateName","")
				
			end
			
			
			else
			setVariable("current_district","tag", "")
			setVariable("current_district","enum", "")
			setVariable("current_district","districttext","")
			setVariable("current_district","subdistrict_enum", "")
			setVariable("current_district","state","")
			setVariable("current_district","stateName","")
			
		end
		
		
		
		setVariable("player_position","x",ftos(curPos.x))
		setVariable("player_position","y",ftos(curPos.y))
		setVariable("player_position","z",ftos(curPos.z))
		
		setVariable("player_rotation","yaw",ftos(curRot.yaw))
		setVariable("player_rotation","pitch",ftos(curRot.pitch))
		setVariable("player_rotation","roll",ftos(curRot.roll))
		
		
		setVariable("game_time","day",GetSingleton('GameTime'):Days(gameTime))
		setVariable("game_time","hour",GetSingleton('GameTime'):Hours(gameTime))
		setVariable("game_time","min",GetSingleton('GameTime'):Minutes(gameTime))
		setVariable("game_time","sec",GetSingleton('GameTime'):Seconds(gameTime))
		
		
		
		setScore("player","money",getStackableItemAmount("Items.money"))
		
		if(currentHouse ~= nil) then
			interactautohide = false
			setVariable("current_place","tag",currentHouse.tag)
			setVariable("current_place","name",currentHouse.name)
			if(currentRoom ~= nil) then
				
				setVariable("current_place","room_tag",currentRoom.tag)
				setVariable("current_place","room_name",currentRoom.name)
				else
				setVariable("current_place","room_tag","")
				setVariable("current_place","room_name","")
				
			end
			else
			setVariable("current_place","tag","")
			setVariable("current_place","name","")
			setVariable("current_place","room_tag","")
			setVariable("current_place","room_name","")
		end
		
		
	end
end


function getAIContextOrDefault(tag)
	
	if(AIhandler[tag] ~= nil and AIhandler[tag].context ~= nil) then
		return {"System", AIhandler[tag].context} 
	end
	
	return nil
	
end

function getAIAnswerOrDefault(tag)
	
	if(AIhandler[tag] ~= nil and AIhandler[tag].answer ~= nil) then
	print(AIhandler[tag].answer)
		return AIhandler[tag].answer
	end
	
	return nil
	
end

function setupAIkey(tag)
	
	if(AIhandler[tag] == nil) then AIhandler[tag] = {} end
	AIhandler[tag].answer = nil

end



prevRandom = nil

-- Function to generate a new random number that is different from the previous one
function random2(mind,maxd)
    local newRandom
	
    repeat
		newRandom = 0
        newRandom = math.random(mind,maxd)  -- Adjust the range as needed
    until newRandom ~= prevRandom

    -- Update the previous random number
    prevRandom = newRandom
	
    return newRandom
end









