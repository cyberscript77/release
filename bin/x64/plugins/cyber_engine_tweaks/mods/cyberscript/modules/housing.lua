debugPrint(3,"CyberScript: housing module loaded")
cyberscript.module = cyberscript.module +1

function spawnItem(spawnIteme, pos, angle)
	
	if (string.match(tostring(spawnIteme.Tag), "AMM_Props.") == nil or (string.match(tostring(spawnIteme.Tag), "AMM_Props.") ~= nil and AMM ~= nil)  ) then
	local spawnTransform = Game.GetPlayer():GetWorldTransform()
	spawnTransform:SetPosition(pos)
	spawnTransform:SetOrientationEuler(angle)
	local ID = WorldFunctionalTests.SpawnEntity(spawnIteme.ItemPath, spawnTransform, '')
	return ID
	else
	error()
	end
end
function spawnItemFromHouseTag(houseTag)
	local itemsof = {}
	for i = 1, #currentSave.arrayHousing do
		local item = currentSave.arrayHousing[i]
		if item.HouseTag == houseTag then
			table.insert(itemsof,item)
		end
	end
	if(#itemsof > 0) then
		for i = 1, #itemsof do
			local item = itemsof[i]
			local postion = Vector4.new(item.X, item.Y, item.Z, 1)
			local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
			item.entityId = spawnItem(item, postion, angle)
			table.insert(currentItemSpawned,item)
			Cron.After(0.5, function()
				debugPrint(10,"Spawning item ok")
			end)
		end
	end
end
function spawnItemFromHouseMultiTag()
	local itemsof = {}
	for i = 1, #ActualPlayerMultiData.currentPropsItems do
		local item = ActualPlayerMultiData.currentPropsItems[i]
			table.insert(itemsof,item)
	end
	if(#itemsof > 0) then
		for i = 1, #itemsof do
			local isnew = true
			local itemmulti = itemsof[i]
			if(#currentItemMultiSpawned > 0)then
			for y = 1, #currentItemMultiSpawned do
				local item = currentItemMultiSpawned[y]
				if(item.Tag == itemmulti.Tag) then
				isnew = false
					if(item.LastUpdateDate ~= itemmulti.LastUpdateDate) then
						debugPrint(2,"Updating item")
						local entityid = item.entityId
						local test = Game.FindEntityByID(item.entityId)
						if(test ~= nil) then 
							Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(item.entityId), Vector4.new(itemmulti.X, itemmulti.Y, itemmulti.Z, 1), EulerAngles.new(itemmulti.Roll,itemmulti.Pitch,itemmulti.Yaw))
						 else
							 local postion = Vector4.new(itemmulti.X, itemmulti.Y, itemmulti.Z, 1)
							local angle = EulerAngles.new(itemmulti.Roll,itemmulti.Pitch,itemmulti.Yaw)
						 	entityid = spawnItem(itemmulti, postion, angle)
						end
						currentItemMultiSpawned[y] = itemsof[i]
						currentItemMultiSpawned[y].entityId = entityid
						if(selectedItemMulti ~= nil) then
							if(selectedItemMulti.Tag == currentItemMultiSpawned[y].Tag) then
								selectedItemMulti.entityId = currentItemMultiSpawned[y]
							end
						end
						Cron.After(0.5, function()
							debugPrint(2,"Updating item ok")
						end)
					end
				end
			end
			else
			isnew = true
			debugPrint(2,"nex2")
			end
		if(isnew == true) then
				local postion = Vector4.new(itemsof[i].X, itemsof[i].Y, itemsof[i].Z, 1)
				local angle = EulerAngles.new(itemsof[i].Roll,itemsof[i].Pitch,itemsof[i].Yaw)
						debugPrint(2,"Spawning item")
				itemsof[i].entityId = spawnItem(itemmulti, postion, angle)
				table.insert(currentItemMultiSpawned,itemsof[i])
				Cron.After(0.5, function()
					debugPrint(2,"Spawning item ok")
				end)
			end
		end
		local toremove ={}
		for i = 1, #currentItemMultiSpawned do
			local exist = false
			local item = currentItemMultiSpawned[i]
			for y = 1, #itemsof do
				local itemmulti = itemsof[y]
				if(item.Tag == itemmulti.Tag) then
					exist = true
				end
			end
			if(exist == false) then
				local entityid = item.entityId
				local test = Game.FindEntityByID(item.entityId)
						if(test ~= nil) then 
						test:GetEntity():Destroy()
						end
						debugPrint(2,"Delete item")
				table.insert(toremove,i)
			end
		end
		if(#toremove > 0) then
			for i = 1, #toremove do
				table.remove(currentItemMultiSpawned,toremove[i])
				debugPrint(2,"delete item ok")
			end
		end
	end
	ItemOfHouseMultiSpawned = true
end

function setItemScale(entity, obj, values, proportional)
 local components = checkForValidComponents(entity)
  if components then
  
  local n = values
  local newScale = Vector3.new(n.x / 100, n.y / 100, n.z / 100)
  if proportional then newScale = Vector3.new(n.x / 100, n.x / 100, n.x / 100) end
  obj.scale = values
  for _, comp in ipairs(components) do
    comp.visualScale = newScale
	
    comp:Toggle(false)
    comp:Toggle(true)
  end
  end
end

function checkDefaultScale(components)
  local defaultScale = components[1].visualScale
  for _, comp in ipairs(components) do
    if comp.visualScale.x ~= 1 then
      defaultScale = comp.visualScale
    end
  end

  return defaultScale
end

function checkForValidComponents(entity)
  if entity then
    local components = {}

    for i,comp in ipairs(componentCname) do
      local c = entity:FindComponentByName(CName.new(comp))
      if c and NameToString(c:GetClassName()) ~= 'entPhysicalSkinnedMeshComponent'
      and NameToString(c:GetClassName()) ~= 'entSkinnedMeshComponent' then
        table.insert(components, c)
      end
    end

    if #components > 0 then return components end
  end

  return false
end

function itemMover()
	---From Tytheus Object Mover Mod https://www.nexusmods.com/cyberpunk2077/mods/2503
	if (enabled == true) then
		target = grabbedTarget
		playerPos, playerAngle = targetS:GetCrosshairData(Game.GetPlayer())
		playerFootPos = Game.GetPlayer():GetWorldPosition()
		playerDeltaWorldPos = Delta(playerPos, playerFootPos)
		playerDeltaWorldPos.w = 1
		if (id == true) then
			if (target ~= nil) then
				debugPrint(2,target, targetPos)
			end
			id = false
		end
		if (grabbed == true) then
			if (grabbedTarget ~= nil) then
				if (playerOldPos == nil) then
					playerOldPos = playerPos
				end
				playerDeltaPos = Delta(playerOldPos, playerPos)
				phi = math.atan2(playerAngle.y, playerAngle.x)
				if (objPush == true) then
					objectDist = objectDist + 0.5
					objPush = false
				end
				if (objPull == true) then
					objectDist = objectDist - 0.5
					objPull = false
				end
				targetPos = Vector4.new(((objectDist * math.cos(phi)) + playerPos.x), ((objectDist * math.sin(phi)) + playerPos.y), (objectDist * math.sin(playerAngle.z) + playerPos.z), targetPos.w)
				targetPos = Vector4Add(targetDeltaPos, targetPos)
				targetPos.x = targetPos.x + playerDeltaPos.x
				targetPos.y = targetPos.y + playerDeltaPos.y
				targetPos.z = targetPos.z + playerDeltaPos.z
				if(grabbedTarget:IsA('gameObject') == true)then
				tp:Teleport(grabbedTarget, targetPos, targetAngle)
				playerOldPos = playerPos
				else
					--updateItemPosition(selectedItem, targetPos, targetAngle,true)
				playerOldPos = playerPos
				end
			else
				grabbed = false
			end
		else
			playerOldPos = nil
			playerDeltaPos = nil
		end
	else
		id = false
		grabbed = false
	end
end

function updateItemPosition(obj, pos, angle,test)
	--accept an vector4, an eulerangle
    if obj.entityId then
		-- debugPrint(2,obj.X)
		-- debugPrint(2,obj.Y)
		-- debugPrint(2,obj.Z)
		-- debugPrint(2,obj.Yaw)
		-- debugPrint(2,pos.x)
		-- debugPrint(2,pos.y)
		-- debugPrint(2,pos.z)
        if test then
		local entityid = obj.entityId
		local testitem = Game.FindEntityByID(entityid)
		if(testitem ~= nil) then 
		testitem:GetEntity():Destroy()
		end
            local transform = Game.GetPlayer():GetWorldTransform()
            transform:SetOrientation(GetSingleton('EulerAngles'):ToQuat(angle))
            transform:SetPosition(pos)
			local housingitem = getHousing(obj.Tag,obj.X,obj.Y,obj.Z)
			if(housingitem ~= nil) then
				housingitem.X = pos.x
				housingitem.Y = pos.y
				housingitem.Z = pos.z
				housingitem.Roll = angle.roll
				housingitem.Pitch = angle.pitch
				housingitem.Yaw = angle.yaw
				obj.X = pos.x
				obj.Y = pos.y
				obj.Z = pos.z
				obj.Roll = angle.roll
				obj.Pitch = angle.pitch
				obj.Yaw = angle.yaw
				local res = updateHousing(housingitem)
				if(res == true) then
					local transform = Game.GetPlayer():GetWorldTransform()
					transform:SetPosition(pos)
					transform:SetOrientationEuler(angle)
					obj.entityId = exEntitySpawner.Spawn(obj.ItemPath, transform)
					else
					debugPrint(2,"error")
				end
			end
       else
		pcall(function ()
            Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(obj.entityId), pos,  angle)
        end)
        end
		else 
		debugPrint(2,"noID")	
	end
end
function updateItemPositionMulti(obj, pos, angle,test)
	--accept an vector4, an eulerangle
    if obj.entityId then
		-- debugPrint(2,obj.X)
		-- debugPrint(2,obj.Y)
		-- debugPrint(2,obj.Z)
		-- debugPrint(2,obj.Yaw)
		-- debugPrint(2,pos.x)
		-- debugPrint(2,pos.y)
		-- debugPrint(2,pos.z)
        if test then
			local entityid = obj.entityId
			local testitem = Game.FindEntityByID(entityid)
			if(testitem ~= nil) then 
			
			
            local transform = Game.GetPlayer():GetWorldTransform()
            transform:SetOrientation(GetSingleton('EulerAngles'):ToQuat(angle))
            transform:SetPosition(pos)
				obj.X = pos.x
				obj.Y = pos.y
				obj.Z = pos.z
				obj.Roll = angle.roll
				obj.Pitch = angle.pitch
				obj.Yaw = angle.yaw
				
				local transform = Game.GetPlayer():GetWorldTransform()
				transform:SetPosition(pos)
				transform:SetOrientationEuler(angle)
				obj.entityId = exEntitySpawner.Spawn(obj.ItemPath, transform)
				
				if(obj.entityId == nil) then --failsafe
				
					obj.entityId = exEntitySpawner.Spawn(obj.ItemPath, transform)
					
						if(obj.entityId == nil) then --failsafe
				
							obj.entityId = exEntitySpawner.Spawn(obj.ItemPath, transform)
							else
							testitem:GetEntity():Destroy()
							
						end
					
					
					else
					testitem:GetEntity():Destroy()
					
				end
				
				
				else
				logme(1,"No items !!!")
			end
       else
		pcall(function ()
            -- Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(obj.entityId), pos,  angle)
				-- obj.X = pos.x
				-- obj.Y = pos.y
				-- obj.Z = pos.z
				-- obj.Roll = angle.roll
				-- obj.Pitch = angle.pitch
				-- obj.Yaw = angle.yaw
        end)
        end
		else 
		debugPrint(2,"noID")	
	end
end

function despawnItem(entityId)
	 if(Game.FindEntityByID(entityId) ~= nil) then
		Game.FindEntityByID(entityId):GetEntity():Destroy()
	 end
end
function despawnItemFromHouse()
	if(#currentItemSpawned > 0) then 
		for i=1,#currentItemSpawned do
			local entity = Game.FindEntityByID(currentItemSpawned[i].entityId)
			if entity ~= nil then
				despawnItem(currentItemSpawned[i].entityId)
				Cron.After(0.5, function()
					currentItemSpawned = {}
					debugPrint(2,"despawning item ok")
				end)
			end
		end
	end
end
function despawnItemFromId(itemId)
	if(#currentItemSpawned > 0) then 
	local index = 0
		for i=1,#currentItemSpawned do
			
			if(currentItemSpawned[i].Id == itemId) then
				index = i
				local entity = Game.FindEntityByID(currentItemSpawned[i].entityId)
				if entity ~= nil then
					despawnItem(currentItemSpawned[i].entityId)
					
				end
			end
		end
		if(index > 0) then
		
		table.remove(currentItemSpawned,index)
		end
	end
end
function despawnItemFromMultiHouse()
	if(#currentItemMultiSpawned > 0) then 
		for i=1,#currentItemMultiSpawned do
			local entity = Game.FindEntityByID(currentItemMultiSpawned[i].entityId)
			if entity ~= nil then
				despawnItem(currentItemMultiSpawned[i].entityId)
				
			end
		end
		Cron.After(0.5, function()
					currentItemMultiSpawned = {}
					debugPrint(1,"despawning item ok")
		end)
		else
		debugPrint(2,"despawning not ok")
	end
end