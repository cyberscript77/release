
function ScannervehicleGameController_OnVehicleInfoChanged(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].primaryname ~= nil) then
				local vehicleInfoData = ScannerVehicleInfo.new()
				vehicleInfoData = FromVariant(value)
				
				if vehicleInfoData ~= nil then
					local text = ""..ScannerInfoManager[entity.tag].text
					
					if string.match(text,"cyberscript_scanner_") then
						text = text:gsub("cyberscript_scanner_", " ") 
						inkTextRef.SetText(thos.vehicleInfoText, text)
						
						thos.isValidVehicleInfo = true
						
						
						
						else
						if(Game.GetLocalizedText(vehicleInfoData:GetVehicleInfo()) ~= nil) then 
							
							inkTextRef:SetLocalizedTextScript(thos.vehicleInfoText, vehicleInfoData:GetVehicleInfo())
							
						end
						thos.isValidVehicleInfo = true
						
						
					end
					thos:UpdateGlobalVisibility()
					
					else
					
					wrappedMethod(value)
				end
				else
				
				wrappedMethod(value)
			end
			
			else
			
			wrappedMethod(value)
			
		end
	end
end


function ScannerNPCHeaderGameController_OnNameChanged(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].primaryname ~= nil) then
				
				local testshow = ScannerInfoManager[entity.tag].primaryname
				
				if(ScannerInfoManager[entity.tag].secondaryname ~= nil and ScannerInfoManager[entity.tag].secondaryname ~= "") then
					
					testshow = testshow.." "..ScannerInfoManager[entity.tag].secondaryname
					
				end
				
				inkTextRef.SetText(thos.nameText, testshow)
				thos.isValidName = true
				thos:UpdateGlobalVisibility()
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
	
end

function ScannerNPCHeaderGameController_OnLevelChanged(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].level ~= nil) then
				
				inkWidgetRef.SetVisible(thos.skullIndicator, (Game.GetStatsSystem():GetStatValue(Game.GetPlayer():GetEntityID(), 605) < ScannerInfoManager[entity.tag].level))
				
				
				thos:UpdateGlobalVisibility()
				
				else
				wrappedMethod()
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end

function ScannerNPCHeaderGameController_OnAttitudeChange(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].attitude ~= nil) then
				
				if(ScannerInfoManager[entity.tag].attitude == 0) then
					inkWidgetRef.SetState(thos.nameText, "Friendly")
				end
				
				if(ScannerInfoManager[entity.tag].attitude == 1) then
					inkWidgetRef.SetState(thos.nameText, "Neutral")
				end
				
				if(ScannerInfoManager[entity.tag].attitude == 2) then
					inkWidgetRef.SetState(thos.nameText, "Hostile")
				end
				
				
				
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
	
end

function ScannerNPCBodyGameController_OnFactionChanged(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].data ~= nil) then
				local gang = getFactionByTag(ScannerInfoManager[entity.tag].data)
				inkTextRef.SetText(thos.dataText, "CS faction "..gang.Name)
				thos.isValidFaction = true;
				
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end


function ScannerNPCBodyGameController_OnRarityChanged(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			--thos.asyncSpawnRequest:Cancel()
			if(ScannerInfoManager[entity.tag].rarity ~= nil) then
				if(ScannerInfoManager[entity.tag].iscivilian == nil) then
					ScannerInfoManager[entity.tag].iscivilian = true
				end
				if (ScannerInfoManager[entity.tag].iscivilian == true and thos.asyncSpawnRequest ~= nil) then
					thos.asyncSpawnRequest = thos:AsyncSpawnFromLocal(inkWidgetRef.Get(thos.dataBaseWidgetHolder), "ScannerCitizenDB", thos, "OnCitizenDBSpawned")
				end
				
				else
				wrappedMethod(value)
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end

function ScannerBountySystemGameController_OnBountySystemChanged(thos, value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].bounty ~= nil) then
				
				thos.isValidBounty = true
				
				
				
				if #ScannerInfoManager[entity.tag].bounty.transgressions >0 or #ScannerInfoManager[entity.tag].bounty.customtransgressions > 0 then
					local transgressionsText = ""
					inkWidgetRef.SetVisible(thos.rewardPanel, true)
					
					inkWidgetRef.SetVisible(thos.streetCredRewardRow, true);
					inkTextRef.SetText(thos.streetCredReward, IntToString(ScannerInfoManager[entity.tag].bounty.streetreward))
					
					inkWidgetRef.SetVisible(thos.moneyRewardRow, true);
					
					inkTextRef.SetText(thos.moneyReward, IntToString(ScannerInfoManager[entity.tag].bounty.reward))
					
					if(ScannerInfoManager[entity.tag].bounty.danger > 5) then
						
						ScannerInfoManager[entity.tag].bounty.danger = 5
						
					end
					
					if(ScannerInfoManager[entity.tag].bounty.danger < 0) then
						
						ScannerInfoManager[entity.tag].bounty.danger = 0
						
					end
					
					if(ScannerInfoManager[entity.tag].bounty.danger > 0) then
						for i = 1, ScannerInfoManager[entity.tag].bounty.danger do
							if i <= ScannerInfoManager[entity.tag].bounty.danger then
								inkWidgetRef.SetVisible(thos.starsWidget[i], true)
								else
								inkWidgetRef.SetVisible(thos.starsWidget[i], false)
							end
						end
						else
						inkWidgetRef.SetVisible(thos.starsWidget[1], false)
						inkWidgetRef.SetVisible(thos.starsWidget[2], false)
						inkWidgetRef.SetVisible(thos.starsWidget[3], false)
						inkWidgetRef.SetVisible(thos.starsWidget[4], false)
						inkWidgetRef.SetVisible(thos.starsWidget[5], false)
						
					end
					
					if(#ScannerInfoManager[entity.tag].bounty.transgressions > 0) then
						local transgressionslist = {}
						
						for i,trans in ipairs(ScannerInfoManager[entity.tag].bounty.transgressions) do
							
							local tweak = TweakDBID.new("Transgression."..trans)
							table.insert(transgressionslist,tweak)
							
							
						end
						
						if(#transgressionslist > 0) then	
							
							
							for i = 1, #transgressionslist do
								local record = TweakDBInterface.GetTransgressionRecord(transgressionslist[i])
								local trantext = ""
								if(record ~= nil) then
									
									trantext = record:LocalizedDescription()
									logme(10,trantext)
								end
								
								transgressionsText = transgressionsText..GetLocalizedText(trantext)
								if i < #transgressionslist then
									transgressionsText = transgressionsText.." ; "
								end
							end
							inkTextRef.SetText(thos.transgressions, transgressionsText)
							
							inkWidgetRef.SetVisible(thos.transgressionsWidget, true)
						end
						
					end
					
					if(#ScannerInfoManager[entity.tag].bounty.customtransgressions > 0) then
						transgressionsText = transgressionsText.." ; "
						
						
						for i = 1, #ScannerInfoManager[entity.tag].bounty.customtransgressions do
							transgressionsText = transgressionsText..ScannerInfoManager[entity.tag].bounty.customtransgressions[i]
							
							if i < #ScannerInfoManager[entity.tag].bounty.customtransgressions then
								transgressionsText = transgressionsText.." ; "
							end
							
						end
						
						inkTextRef.SetText(thos.transgressions, transgressionsText)
						
						inkWidgetRef.SetVisible(thos.transgressionsWidget, true)
					end
					
					inkWidgetRef.SetVisible(thos.wanted, true)
					inkTextRef.SetText(thos.wanted, "By : "..ScannerInfoManager[entity.tag].bounty.issuedby)
					
					else
					
					inkWidgetRef.SetVisible(thos.transgressionsWidget, false)
					inkWidgetRef.SetVisible(thos.rewardPanel, false)
					inkWidgetRef.SetVisible(thos.notFound, true)
					inkTextRef.SetLocalizedTextScript(thos.notFound, "LocKey#40655")
					inkWidgetRef.SetVisible(thos.mugShot, false)
					inkWidgetRef.SetVisible(thos.wanted, false)
				end
				
				
				thos:UpdateGlobalVisibility()
				
				
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end

function scannerDetailsGameController_RefreshLayout(thos,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod()  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		
		if (entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			thos:StopAnimations()
			
			if HUDManager.GetActiveMode() ~= ActiveMode.FOCUS then
				thos:PlayOutroAnimation();
			end
			
			if thos.scanningState == gameScanningState.Complete or thos.scanningState == gameScanningState.ShallowComplete or thos.scanningState ==  gameScanningState.Started then
				
				for i,value in ipairs(thos.asyncSpawnRequests) do
					
					value:Cancel()
					
					
				end
				
				thos.asyncSpawnRequests = {}
				
				inkCompoundRef.RemoveAllChildren(thos.scannerCountainer)
				inkCompoundRef.RemoveAllChildren(thos.quickhackContainer)
				inkWidgetRef.SetVisible(thos.bg, true)
				thos:GetRootWidget():SetVisible(false)
				table.insert(thos.asyncSpawnRequests,thos:AsyncSpawnFromLocal(inkWidgetRef.Get(thos.quickhackContainer), "QuickHackDescription"))
				
				--	--------print(tostring(thos.scannedObjectType))
				if(thos.scannedObjectType == ScannerObjectType.PUPPET) then
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerNPCHeaderWidget")
					thos:AsyncSpawnScannerModule("ScannerNPCBodyWidget")
					thos:AsyncSpawnScannerModule("ScannerBountySystemWidget")
					thos:AsyncSpawnScannerModule("ScannerRequirementsWidget")
					thos:AsyncSpawnScannerModule("ScannerAbilitiesWidget")
					thos:AsyncSpawnScannerModule("ScannerResistancesWidget")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					thos:AsyncSpawnScannerModule("ScannerVehicleBody")
					
					
					elseif(thos.scannedObjectType == ScannerObjectType.DEVICE) then
					
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerDeviceHeaderWidget")
					thos:AsyncSpawnScannerModule("ScannerVulnerabilitiesWidget")
					thos:AsyncSpawnScannerModule("ScannerRequirementsWidget")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					
					
					elseif(thos.scannedObjectType == ScannerObjectType.VEHICLE) then
					
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerVehicleBody")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					
					elseif(thos.scannedObjectType == ScannerObjectType.GENERIC) then
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerDeviceHeaderWidget")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					
					inkWidgetRef:SetVisible(thos.toggleDescirptionHackPart, false)
					
				end
				
				
				thos.showScanAnimProxy = thos:PlayLibraryAnimation("intro")
				thos.showScanAnimProxy:RegisterToCallback(inkanimEventType.OnFinish, thos, "OnScannerDetailsShown")
			end
			
			
			if thos.scanningState == gameScanningState.Stopped or thos.scanningState ==  gameScanningState.Default then 
				thos:PlayOutroAnimation()
			end
			
			else
			
			wrappedMethod()
			------print("tossss")
			
		end
		
		else
		
		wrappedMethod()
		------print("tossss")
	end
	
end





function QuickhacksListGameController_PopulateData(this,data,wrappedMethod)
	print("step 00")
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(data)  end
	
	local index = this.listController:GetSelectedIndex()
	index = index ~= -1 and index or 0
	logme(1,dump(data))
	wrappedMethod(data)
	
	
	for k,v in pairs(cyberscript.cache["quickhack"]) do
		
		if(checkTriggerRequirement(v.data.requirement,v.data.trigger))then
			
			
			CName.add("cyberscript_hack:"..v.data.tag)
			
			CName.add("cyberscript_hack_category")
			
			local mydata = QuickhackData.new()
			
			mydata.actionOwner = Game.GetPlayer()
			mydata.actionOwnerName = CName("cyberscript_hack:"..v.data.tag)
			mydata.icon = TweakDBID.new(v.data.icon)
			mydata.iconCategory = CName("cyberscript_hack_category")
			mydata.title = v.data.title
			mydata.titleAlternative = v.data.titlealternative
			mydata.description = v.data.description
			mydata.inactiveReason = v.data.inactivereason
			mydata.isLocked = checkTriggerRequirement(v.data.unlockrequirement,v.data.unlocktrigger) == false
			mydata.type = v.data.actiontype
			mydata.cost = v.data.cost
			mydata.costRaw = v.data.cost
			mydata.uploadTime = v.data.uploadtime
			mydata.duration =  v.data.duration
			mydata.ICELevelVisible = v.data.icelevelvisible
			mydata.ICELevel =  v.data.iceLevel
			mydata.vulnerabilities = nil
			mydata.quality =  v.data.quality
			mydata.isInstant =  v.data.isinstant
			mydata.cooldown  = v.data.cooldown
			mydata.cooldownTweak  = nil
			mydata.actionMatchesTarget  = false
			mydata.maxListSize  =  13
			mydata.category  =  nil
			mydata.actionCompletionEffects  = nil
			mydata.networkBreached  =  v.data.networkbreached
			
			this.listController:PushData(mydata, false)
			
		end
		
		
		
		
	end
	
	this.listController:Refresh()
	this.listController:SetSelectedIndex(index);
end


function QuickhacksListGameController_ApplyQuickHack(this,shouldUseUI)
	
	if(observerthread5 == true or moddisabled  == true)  then return  end
	this.lastMaxCells = 999
	
	if string.match(NameToString(this.selectedData.actionOwnerName),"cyberscript_hack:") then
		
		local splittext = split(NameToString(this.selectedData.actionOwnerName),':')
		
		if(checkTriggerRequirement(cyberscript.cache["quickhack"][splittext[2]].data.requirement,cyberscript.cache["quickhack"][splittext[2]].data.trigger))then
			
			usedCells = this.selectedData.cost
			maxCells =  this.lastMaxCells
			
			
			local availablecell = maxCells-usedCells
			
			local percent = math.floor((availablecell*100)/maxCells)
			
			local fillCells =  math.floor(maxCells * percent *0.01)
			if(fillCells > -1) then
				runActionList(cyberscript.cache["quickhack"][splittext[2]].data.action,cyberscript.cache["quickhack"][splittext[2]].data.tag,"interact",false,"player")
			end
			if this:GetRootWidget():IsVisible() == false or (this.lastFillCells == fillCells and this.lastUsedCells == usedCells and this.lastMaxCells == maxCells) then
				
				else
				this.lastUsedCells = usedCells
				this.lastMaxCells = maxCells
				this.lastFillCells = fillCells
				this:UpdateMemoryBar()
			end
			
			
			
			
		end
		
		
		
		
	end
	
	
end

function QuickhacksListGameController_OnQuickhackStarted(this,value,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(value) end
	wrappedMethod(value)
	
	-- if value.shouldReveal then
	-- 	logme(1,dump(value.commands))
	-- 	if (not value.shouldReveal or this:GetPlayerControlledObject():GetHudManager():GetActiveMode() ~= ActiveMode.FOCUS) then
	-- 	  logme(1,"bad condition 01")
	-- 	end
	-- 	if IsDefined(value.lookAtObject) then
	-- 		logme(1,"goood condition 01")
	-- 	else
	-- 		logme(1,"bad condition 02")
	-- 	end
		
	--   else 
	-- 	logme(1,"bad condition 03")
	--   end


	if this.selectedData ~= nil and string.match(NameToString(this.selectedData.actionOwnerName),"cyberscript_hack:") then
		
		local splittext = split(NameToString(this.selectedData.actionOwnerName),':')
		
		if(checkTriggerRequirement(cyberscript.cache["quickhack"][splittext[2]].data.requirement,cyberscript.cache["quickhack"][splittext[2]].data.trigger))then
			
			local availablecell = maxCells-usedCells
			
			local percent = math.floor((availablecell*100)/maxCells)
			
			local fillCells =  math.floor(maxCells * percent *0.01)
			
			
			
		end
		
		
		
	end
	
end
