


function NPCPuppet_CompileScannerChunks(thos)
	if(observerthread3  == true or moddisabled == true)    then return end
	local vehicleSummonDef = Game.GetAllBlackboardDefs().UI_ScannerModules
	local scannerBlackboard = Game.GetBlackboardSystem():Get(vehicleSummonDef)
	
	
	local characterRecord  = TweakDBInterface.GetCharacterRecord(thos:GetRecordID())
	
	
	
	
	
	if (characterRecord ~= nil and scannerBlackboard ~= nil )then
		
		local scannerPreset = characterRecord:ScannerModulePreset()
		
		---get information
		local thosEntity = thos:GetRecordID()
		
		local ps = thos:GetPS()
		currentScannerItem = {}
		
		
		
		
		
		
		
		if ps:GetForcedScannerPreset() ~= nil then
			scannerPreset = TweakDBInterface.GetScannerModuleVisibilityPresetRecord(ps:GetForcedScannerPreset())
			else
			scannerPreset = characterRecord.ScannerModulePreset()
		end
		
		
		currentScannerItem.networkstate = tonumber(ScannerNetworkState.NOT_CONNECTED)
		
		local aps = ps:GetAccessPoint()
		
		if(aps ~= nil)then
			if aps:IsBreached() then
				
				currentScannerItem.networkstate = tonumber(ScannerNetworkState.BREACHED)
				else
				
				currentScannerItem.networkstate = tonumber(ScannerNetworkState.NOT_BREACHED)
			end
			
		end
		
		
		local archetype = characterRecord:ArchetypeData()
		local archetypename = nil
		if(archetype ~= nil) then
			
			archetypename = archetype:Type():LocalizedName()
			
		end
		
		
		
		
		
		
		
		if(archetypeName ~= nil and archetypeName ~= "") then
			
			--currentScannerItem.archetypename = archetypeName
			
		end
		
		
		
		-- local items = AIActionTransactionSystem.CalculateEquipmentItems(thos, thos:GetRecord():PrimaryEquipment(), -1)
		
		-- local primaryweapons = nil
		
		-- if(#items>0) then
		-- primaryweapons = items[1]:Item():DisplayName()
		-- end
		
		
		
		
		currentScannerItem.bounty = nil
		
		if thos.bounty ~= nil then
			
			local bountyChunk =ScannerBountySystem.new()
			local bountyUI = BountyUI.new() 
			local bounty =Bounty.new()
			local transgressions = {}
			
			
			if #thos.bounty.transgressions >0 then
				
				for i,trans in ipairs(thos.bounty.transgressions) do
					local transText = getTransgressionFromTweakId(trans)
					
					if(transText ~= nil) then
						table.insert(transgressions,transText)
						
					end
					
					
				end
				
				
				bounty = BountyManager.GenerateBounty(thos)
				else 
				bounty = thos.bounty
			end
			
			
			
			
			
			currentScannerItem.entityname = thos:ToString()
			currentScannerItem.entityname = thos:ToString()
			currentScannerItem.secondaryname = Game.NameToString(thos:GetCurrentAppearanceName())
			currentScannerItem.primaryname = LocKeyToString(thos:GetDisplayName())
			currentScannerItem.attitude = tonumber(thos:GetAttitudeTowards(Game.GetPlayer()))
			currentScannerItem.data = tostring(NameToString(characterRecord:Affiliation():EnumName()))
			currentScannerItem.rarity = tonumber(thos:GetNPCRarity())
			currentScannerItem.text = ""
			currentScannerItem.bounty = {}
			currentScannerItem.bounty.danger = bountyUI.level
			currentScannerItem.bounty.reward = bountyUI.moneyReward
			currentScannerItem.bounty.streetreward = bountyUI.streetCredReward
			currentScannerItem.bounty.transgressions = transgressions
			currentScannerItem.bounty.customtransgressions = {}
			currentScannerItem.bounty.issuedby = getAffiliationsFromTweakId(bounty.bountySetter)
			
			
			
		end
		
		
		
		
		
		
		
		
		
		-- --custom scanner
		local entid = thos:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) then
			
			
			if (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
				currentScannerItem = getScannerdataFromEntityOrGroupOfEntity(entity)
				currentScannerItem.entityname = thos:ToString()
				
			end
			
			
			
			
			
		end
		
		else
		
		
		currentScannerItem = nil
		
	end
	

end

function NPCPuppet_CompileScannerChunksBefore(thos)
	if(observerthread3  == true or moddisabled == true)    then return end
	local vehicleSummonDef = Game.GetAllBlackboardDefs().UI_ScannerModules
	local scannerBlackboard = Game.GetBlackboardSystem():Get(vehicleSummonDef)
	
	--print(Game.NameToString(thos:GetCurrentAppearanceName()))
	
	scannedEntity = thos
		local obj = getEntityFromManagerById(thos:GetEntityID())
						
		
			if(cyberscript.EntityManager["last_scanned"] == nil) then
			local entity = {}
			entity.id = nil
			entity.tag = "last_scanned"
			entity.tweak = "None"
			entity.lock = true
			cyberscript.EntityManager[entity.tag] = entity
			
			end
			cyberscript.EntityManager["last_scanned"].id = nil
			cyberscript.EntityManager["last_scanned"].tweak = "None"
			
			
		
			pcall(function ()
				if(thos:GetRecordID() ~= nil and thos:GetRecordID().hash ~= nil and cyberscript.entitieshash[tostring(thos:GetRecordID().hash)] ~= nil) then
					
					
					cyberscript.EntityManager["last_scanned"].tweak =  cyberscript.entitieshash[tostring(thos:GetRecordID().hash)].entity_tweak
					
				end
			end)
			
			--	cyberscript.EntityManager["lookatnpc"].id = nil
			cyberscript.EntityManager["last_scanned"].id = thos:GetEntityID()
			
		
		
		
	
	

end



function NPCPuppet_SendAfterDeathOrDefeatEvent(target)
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	
	local obj = getEntityFromManagerById(target:GetEntityID())
	if(obj.id ~= nil) then
		
	end
	
	
	if target ~= nil and ((target.myKiller ~= nil and target.myKiller:GetEntityID().hash == Game.GetPlayer():GetEntityID().hash) or target.wasJustKilledOrDefeated) then
		
		if(obj.id ~= nil) then
			
			cyberscript.EntityManager["last_killed"].tweak =  obj.tweak
			else
			cyberscript.EntityManager["last_killed"].tweak = "none"
		end
		
		if cyberscript.EntityManager["last_killed"].isquest == nil then cyberscript.EntityManager["last_killed"].isquest = false end
		
		cyberscript.EntityManager["last_killed"].id = nil
		
		cyberscript.EntityManager["last_killed"].id = target:GetEntityID()
		
		target:MarkAsQuest(cyberscript.EntityManager["last_killed"].isquest)
		
		
		lastTargetKilled = target
		
	end
end

function VehicleSummonWidgetGameController_OnVehicleSummonStateChanged(state,value ) 
	

	if(observerthread4 == true or moddisabled  == true)   then return end
	local vehicleSummonDef = Game.GetAllBlackboardDefs().VehicleSummonData
	local vehicleSummonBB = Game.GetBlackboardSystem():Get(vehicleSummonDef)
	vehicleEntId = vehicleSummonBB:GetEntityID(vehicleSummonDef.SummonedVehicleEntityID)
	----printGameDump(vehicleSummonBB))
	----printdump(vehicleSummonBB))
	local vehi = Game.FindEntityByID(vehicleEntId)
	--local vehicleRecordID = vehicleSummonBB:GetRecordID()
	
	
		local entity = {}
		entity.id = vehicleEntId
		entity.tag = "called_garage"
		entity.tweak = "None"
		entity.lock = true
		cyberscript.EntityManager[entity.tag] = entity
		
	
	for k,v in pairs(cyberscript.PositionManager) do
		
		if(v.pending == true) then
			local pos = vehi:GetWorldPosition()
			v.x = pos.x
			v.y = pos.y
			v.z = pos.z
			v.pending = false
			
			local qat = vehi:GetWorldOrientation()
			local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
			v.yaw = angle.yaw
			v.pitch = angle.pitch
			v.roll = angle.roll
			v.fromgarage = true
		end
	
	end
	
end