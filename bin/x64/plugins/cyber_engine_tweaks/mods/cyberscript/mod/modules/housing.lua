logme(1,"CyberScript: housing module loaded")
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
	
	-- for each housing in cyberscript.cache["housing"], we check that items is already registred in user cyberscript.cache["housing"] (means the user move it or edit it)
	-- if exist, we replace the item by user value and save it in itemsof
	-- if not we spawn it as cyberscript.cache["housing"] do
	-- then for each item in user save, if it not in items of (means not already spawn) we hceck the housetag then try to spawn it
	
	
	-- when the user will move an housing item, it will add the new version in save
	
	
	
	
	for k,v in pairs(cyberscript.cache["housing"]) do
		
		checkContext(v)
		
		if(v.data.target == houseTag) then
		
			
			
			if(checkTriggerRequirement(v.data.requirement,v.data.trigger))then
				cyberscript.cache["housing"][k].togglehousing = true
				for i,items in ipairs(v.data.items) do
					checkContext(items)
					
					local fromuser = getItemFromUserHousing(items.Tag,items.X,items.Y,items.Z,items.HouseTag,items.ItemPath)
					
					if fromuser ~= nil then items = fromuser table.insert(itemsof,fromuser) end
					
					if(items.trigger ~= nil and items.requirement ~= nil) then
						if(checkTriggerRequirement(items.requirement,items.trigger))then
							
							local item = items
							local postion = Vector4.new(item.X, item.Y, item.Z, 1)
							local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
							item.entityId = spawnItem(item, postion, angle)
							item.from = k
							item.fromTemplate = false
							table.insert(currentItemSpawned,item)
							
							Cron.After(0.7, function()
							local entityid = item.entityId
							local entity = Game.FindEntityByID(entityid)
							local components = checkForValidComponents(entity)
								if(components and item.scale ~= nil) then
									setItemScale(entity, item, item.scale,proportionalMode)
									
								end
							
							setItemColor(entity, item)
							
							end)
							
						end
					
					else
						
						local item = items
						local postion = Vector4.new(item.X, item.Y, item.Z, 1)
						local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
						item.entityId = spawnItem(item, postion, angle)
						item.from = k
						item.fromTemplate = false
						table.insert(currentItemSpawned,item)
						Cron.After(0.7, function()
							local entityid = item.entityId
							local entity = Game.FindEntityByID(entityid)
							local components = checkForValidComponents(entity)
								if(components and item.scale ~= nil) then
									setItemScale(entity, item, item.scale,proportionalMode)
									
								end
							setItemColor(entity, item)
							
							end)
							
					end
				
				end
			
			end
		
		
		end
		
		
		
	end
	
	for i,items in ipairs(currentSave.arrayHousing) do
					checkContext(items)
					local already_span = table_contains(itemsof,items,false)
					
					if already_span == false and items.HouseTag == houseTag then
					
					if(items.trigger ~= nil and items.requirement ~= nil) then
						if(checkTriggerRequirement(items.requirement,items.trigger))then
							
							local item = items
							local postion = Vector4.new(item.X, item.Y, item.Z, 1)
							local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
							item.entityId = spawnItem(item, postion, angle)
							item.from = "save"
							item.fromTemplate = false
							table.insert(currentItemSpawned,item)
							Cron.After(0.7, function()
							local entityid = item.entityId
							local entity = Game.FindEntityByID(entityid)
							local components = checkForValidComponents(entity)
								if(components and item.scale ~= nil) then
									setItemScale(entity, item, item.scale,proportionalMode)
									
								end
								
								setItemColor(entity, item)
							end)
							
							
						end
					
					else
						
						local item = items
						local postion = Vector4.new(item.X, item.Y, item.Z, 1)
						local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
						item.entityId = spawnItem(item, postion, angle)
						item.from = "save"
						item.fromTemplate = false
						table.insert(currentItemSpawned,item)
						Cron.After(0.7, function()
							local entityid = item.entityId
							local entity = Game.FindEntityByID(entityid)
							local components = checkForValidComponents(entity)
								if(components and item.scale ~= nil) then
									setItemScale(entity, item, item.scale,proportionalMode)
									
								end
								
								setItemColor(entity, item)
							end)
							
					end
				
				end
	end
	
end


function spawnItemFromHousingTag(houseTag, housingTag)
	local itemsof = {}
	
	
	local objhousing = cyberscript.cache["housing"][housingTag]
	if(objhousing ~= nil) then 
	local housing = objhousing.data
	checkContext(housing)
		
		if(housing.target == houseTag) then
		
			
			
			if(checkTriggerRequirement(housing.requirement,housing.trigger))then
			
				for i,items in ipairs(housing.items) do
					checkContext(items)
					
					
					
					if(items.trigger ~= nil and items.requirement ~= nil) then
						if(checkTriggerRequirement(items.requirement,items.trigger))then
							
							local item = items
							local postion = Vector4.new(item.X, item.Y, item.Z, 1)
							local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
							item.entityId = spawnItem(item, postion, angle)
							item.from = k
							item.fromTemplate = false
							table.insert(currentItemSpawned,item)
							Cron.After(0.7, function()
							local entityid = item.entityId
							local entity = Game.FindEntityByID(entityid)
							local components = checkForValidComponents(entity)
								if(components and item.scale ~= nil) then
									setItemScale(entity, item, item.scale,proportionalMode)
									
								end
								
								setItemColor(entity, item)
							end)
							
						end
					
					else
						
						local item = items
						local postion = Vector4.new(item.X, item.Y, item.Z, 1)
						local angle = EulerAngles.new(item.Roll,item.Pitch,item.Yaw)
						item.entityId = spawnItem(item, postion, angle)
						item.from = housingTag
						item.fromTemplate = false
						table.insert(currentItemSpawned,item)
						Cron.After(0.7, function()
						local entityid = item.entityId
						local entity = Game.FindEntityByID(entityid)
						local components = checkForValidComponents(entity)
							if(components and item.scale ~= nil) then
								setItemScale(entity, item, item.scale,proportionalMode)
								
							end
							
							setItemColor(entity, item)
						end)
					end
				
				end
			
			end
		
		
		end
	end
	
	
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
  
  if(#currentItemSpawned > 0) then 
	  
				for i=1,#currentItemSpawned do
					
					if(currentItemSpawned[i].Id == obj.Id) then
						
						currentItemSpawned[i] = obj
					end
				end
				
			end
  
  end
end



function setItemColor(entity, obj)
 local components = checkForValidComponents(entity)
 local lightcomponents = checkForValidLightComponents(entity)
				if(lightcomponents) then
				
						local comp = lightcomponents[1]
						if obj.color == nil then
						
						
						
						obj.color = {
							red = comp.color.Red,
							blue = comp.color.Blue,
							green = comp.color.Green,
							alpha = comp.color.Alpha
						}
						
						obj.intensity = comp.intensity
						obj.radius = comp.radius
						obj.innerAngle = comp.innerAngle
						obj.outerAngle = comp.outerAngle
						obj.lightType = comp.type
					end
						comp:SetIntensity(obj.intensity)
						
						if obj.lightType == ELightType.LT_Area or obj.lightType == ELightType.LT_Area then
							
							comp:SetRadius(Light.activeLight.radius)
						  
						end

						if obj.lightType == ELightType.LT_Spot then
						 
							comp:SetAngles(obj.innerAngle, obj.outerAngle)
						 
						end
						
						
						if obj.lightType == ELightType.LT_Area or obj.lightType == ELightType.LT_Area then
						 
							comp:SetRadius(Light.activeLight.radius)
						 
						end

						if obj.lightType == ELightType.LT_Spot then
						
							comp:SetAngles(obj.innerAngle, obj.outerAngle)
						
						end
						
						
						 local newColor = NewObject('Color')
							
							  newColor.Red = obj.color.red 
							  newColor.Green = obj.color.green
							  newColor.Blue =  obj.color.blue
							  newColor.Alpha = comp.color.Alpha
							  comp:SetColor(newColor)
		
		
		

				
				
  
  if(#currentItemSpawned > 0) then 
	  
				for i=1,#currentItemSpawned do
					
					if(currentItemSpawned[i].Id == obj.Id) then
						
						currentItemSpawned[i] = obj
					end
				end
				
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


function checkForValidLightComponents(entity)
  if entity then
    local components = {}

  for i,comp in ipairs(lightComponents) do
      local c = entity:FindComponentByName(CName.new(comp))
      if c then
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
				logme(2,target, targetPos)
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
		-- logme(2,obj.X)
		-- logme(2,obj.Y)
		-- logme(2,obj.Z)
		-- logme(2,obj.Yaw)
		-- logme(2,pos.x)
		-- logme(2,pos.y)
		-- logme(2,pos.z)
        if test then
		local entityid = obj.entityId
		local testitem = Game.FindEntityByID(entityid)
		if(testitem ~= nil) then 
			testitem:GetEntity():Destroy()
			--print("Destroy")
		
			local transform = Game.GetPlayer():GetWorldTransform()
           
			transform:SetPosition(pos)
			transform:SetOrientationEuler(angle)
			obj.entityId = exEntitySpawner.Spawn(obj.ItemPath, transform)
			
			
			
			obj.X = pos.x
			obj.Y = pos.y
			obj.Z = pos.z
			obj.Roll = angle.roll
			obj.Pitch = angle.pitch
			obj.Yaw = angle.yaw
			
			if(#currentItemSpawned > 0) then 
			
				for i=1,#currentItemSpawned do
					
					if(currentItemSpawned[i].Id == obj.Id) then
						
						currentItemSpawned[i] = obj
					end
				end
				
			end
			
			updateHousing(obj)
			
		end
       else
		local success, message = pcall(function ()
            Game.GetTeleportationFacility():Teleport(Game.FindEntityByID(obj.entityId), pos,  angle)
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
function updateItemPositionMulti(obj, pos, angle,test)
	--accept an vector4, an eulerangle
    if obj.entityId then
		-- logme(2,obj.X)
		-- logme(2,obj.Y)
		-- logme(2,obj.Z)
		-- logme(2,obj.Yaw)
		-- logme(2,pos.x)
		-- logme(2,pos.y)
		-- logme(2,pos.z)
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
		logme(2,"noID")	
	end
end

function despawnItem(entityId)
	 if(Game.FindEntityByID(entityId) ~= nil) then
		Game.FindEntityByID(entityId):GetEntity():Destroy()
	 end
end
function despawnItemFromHouse()
	
	for k,v in pairs(cyberscript.cache["housing"]) do
		
		checkContext(v)
		
		if(v.togglehousing == true) then
		
			
			
			if(checkTriggerRequirement(v.data.requirement,v.data.trigger) == false)then
				cyberscript.cache["housing"][k].togglehousing = false
				
			end
		
		
		end
		
		
		
	end
	
	if(#currentItemSpawned > 0) then 
		for i=1,#currentItemSpawned do
			local entity = Game.FindEntityByID(currentItemSpawned[i].entityId)
			if entity ~= nil then
				despawnItem(currentItemSpawned[i].entityId)
				Cron.After(0.5, function()
					currentItemSpawned = {}
					logme(10,"despawning item ok")
				end)
			end
		end
	end
end
function despawnItemFromId(itemId)
	if(#currentItemSpawned > 0) then 
	local index = 0
		for i=1,#currentItemSpawned do
			--print(currentItemSpawned[i].Id)
			if(currentItemSpawned[i].Id == itemId) then
				index = i
				local entity = Game.FindEntityByID(currentItemSpawned[i].entityId)
				if entity ~= nil then
					despawnItem(currentItemSpawned[i].entityId)
					else
					--print("no entity")
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
					logme(10,"despawning item ok")
		end)
		else
		logme(2,"despawning not ok")
	end
end


function currentHouseApplyTemplate(tag,x,y,z)

if(currentHouse ~=nil and cyberscript.cache["housing_template"][tag] ~= nil) then
				local template = cyberscript.cache["housing_template"][tag].data
				
				if(#template.items > 0) then
					
					
					
					
					for i,v in ipairs(template.items) do
						
						local obj = {}
						obj.Id = v.Id
						obj.Tag = v.Tag
						obj.HouseTag = currentHouse.tag
						obj.ItemPath = v.ItemPath
						obj.X = template.center.x + x +v.X
						obj.Y = template.center.y + y + v.Y
						obj.Z = template.center.z + z + v.Z
						obj.Yaw = v.Yaw
						obj.Pitch = v.Pitch
						obj.Roll = v.Roll
						obj.Title = v.Title
						obj.fromTemplate = true
						obj.template = template.tag
						
						
						saveHousing(obj)
						
						local housing = getHousing(obj.Tag,obj.X,obj.Y,obj.Z)
						obj.Id = housing.Id
						
						local poss = Vector4.new( obj.X, obj.Y,  obj.Z,1)
						
						
						local angless = EulerAngles.new(obj.Roll, obj.Pitch,  obj.Yaw)
						
						
						obj.entityId = spawnItem(obj, poss, angless)
						local entity = Game.FindEntityByID(spawnedItem.entityId)
						local components = checkForValidComponents(entity)
						if components then
							local visualScale = checkDefaultScale(components)
							obj.defaultScale = {
								x = visualScale.x * 100,
								y = visualScale.x * 100,
								z = visualScale.x * 100,
							}
							obj.scale = {
								x = visualScale.x * 100,
								y = visualScale.y * 100,
								z = visualScale.z * 100,
							}
						end
						
						table.insert(currentItemSpawned,obj)
						
					end
					
					
				end
				
			end
	
	
end


function currentHouseClearTemplate(tag)

if(currentHouse ~=nil) then
				
				if(#currentItemSpawned > 0) then
					
					for i=1,#currentItemSpawned do
						
						if(currentItemSpawned[i] ~= nil and currentItemSpawned[i].fromTemplate ~= nil and currentItemSpawned[i].fromTemplate == true and currentItemSpawned[i].template == tag) then
							deleteHousing(currentItemSpawned[i].Id)
							despawnItemFromId(currentItemSpawned[i].Id)
							
						end
						
						
					end
					
					
				end
				
			end
	
	
end


function currentHouseClearAllTemplate()

if(currentHouse ~=nil) then
				
				if(#currentItemSpawned > 0) then
					
					for i=1,#currentItemSpawned do
						
						if(currentItemSpawned[i] ~= nil and currentItemSpawned[i].fromTemplate ~= nil and currentItemSpawned[i].fromTemplate == true) then
							deleteHousing(currentItemSpawned[i].Id)
							despawnItemFromId(currentItemSpawned[i].Id)
							
						end
						
						
					end
					
					
				end
				
			end
	
	
end







function currentHouseClearHousing(tag)

if(currentHouse ~=nil) then
				
				if(#currentItemSpawned > 0) then
					
					for i,item in ipairs(currentItemSpawned) do
						logme(1,tostring(i))
						logme(1,dump(item))
						----print(tostring(currentItemSpawned))
						if(item ~= nil and (item.fromTemplate == nil or item.fromTemplate == false ) and item.from == tag) then
							deleteHousing(item.Id)
							despawnItemFromId(item.Id)
							
						end
						
						
					end
					
					
				end
				
			end
	
	
end


function currentHouseClearAllHousing()

if(currentHouse ~=nil) then
				
				if(#currentItemSpawned > 0) then
					
					for i=1,#currentItemSpawned do
						
						if(currentItemSpawned[i] ~= nil and currentItemSpawned[i].fromTemplate == false) then
							deleteHousing(currentItemSpawned[i].Id)
							despawnItemFromId(currentItemSpawned[i].Id)
							
						end
						
						
					end
					
					
				end
				
			end
	
	
end