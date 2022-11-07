debugPrint(3,"CyberScript: Custom Place module loaded")
cyberscript.module = cyberscript.module +1

-- 0 : house
-- 1 : bar
-- 2 : nightclub
-- 3 : restaurant
-- 4 : shopping
-- 5 : special



--enum type room action
-- 0 : drink
-- 1 : eat
-- 2 : do

--enum type interact 
-- 0 : Nothing
-- 1 : Change Time
-- 2 : Change Stat
-- 3 : Mod Stat
-- 100 : Launch Quest
-- 200 : Launch Dialog


-- house statut
-- 0 or nil : not buyed
-- 1 : buy
-- 2 : rent

function loadCustomPlace()
	
	for k,v  in pairs(arrayHouse) do
		
		checkContext(v.house)
		
		if(curPos ~= nil and currentHouse == nil and check3DPos(curPos,v.house.posX,v.house.posY, v.house.posZ,v.house.range, v.house.Zrange))then
			
			if(checkTriggerRequirement(v.house.requirement,v.house.trigger)) then
				currentHouse = v.house
				
				
				
				
				
				else
				
				if ItemOfHouseSpawned == true then
					despawnItemFromHouse()
					ItemOfHouseSpawned = false
				end
				
				isInHouse = false
				currentHouse = nil
				selectedItem = nil
			end
			
		end
	end
	
	
	
	if(currentHouse ~= nil) then
		
		if(checkTriggerRequirement(currentHouse.requirement,currentHouse.trigger) and check3DPos(curPos,currentHouse.posX,currentHouse.posY, currentHouse.posZ,currentHouse.range, currentHouse.Zrange) ) then
			
			if ItemOfHouseSpawned == false  then
			
				
				spawnItemFromHouseTag(currentHouse.tag)
				
				
				ItemOfHouseSpawned = true
			end
			
			
			if(currentHouse.action ~= nil and #currentHouse.action >0) then
				
				
				runActionList(currentHouse.action,currentHouse.tag,"interact",false,currentHouse.tag,false)
			end
			
			isInHouse = true
			
			
			
			
			if(currentHouse.type == 0) then
				Game.ChangeZoneIndicatorSafe()
			end
			
			currentRoom = nil
				for y = 1, #currentHouse.rooms do 
				
					checkContext(currentHouse.rooms[y])
				
					if(check3DPos(curPos,currentHouse.rooms[y].posX,currentHouse.rooms[y].posY,currentHouse.rooms[y].posZ,currentHouse.rooms[y].range,currentHouse.rooms[y].Zrange) )then
						if(checkTriggerRequirement(currentHouse.rooms[y].requirement,currentHouse.rooms[y].trigger)) then
							currentRoom = currentHouse.rooms[y]
							if(currentRoom.action ~= nil and #currentRoom.action >0) then
								
							
								runActionList(currentRoom.action,currentRoom.tag,"interact",false,currentHouse.tag)
							end
							
							--getTriggeredActions()
						end
						
						
						
						
					end
					
					
					
					
					
					
				end
				
				
				
				
				
			
			
		else
			
			if ItemOfHouseSpawned == true then
				despawnItemFromHouse()
				ItemOfHouseSpawned = false
			end
			
			isInHouse = false
			currentHouse = nil
			selectedItem = nil
		end
		
		
	end
end

function setCustomLocationPoint() 
	
	if(arrayHouse ~= nil) then
	for _,h in pairs(arrayHouse) do
		
		
		
	
		variantType = "FixerVariant"
		
		if h.house.type == 0 then --house
			variantType = "ApartmentVariant"
			elseif h.house.type == 1 then--bar
			variantType = "ServicePointBarVariant"
			elseif h.house.type == 2 then--nightclub
			variantType = "ServicePointBarVariant"
			elseif h.house.type == 3 then--restaurant
			variantType = "ServicePointFoodVariant"
			elseif h.house.type == 4 then--shopping
			variantType = "ServicePointJunkVariant"
		end
		
		local score = getScoreKey(h.house.tag,"Score")
		
		
		
			if(h.house.type == 0 and (score == 0 or score == nil)) then
				variantType = "Zzz05_ApartmentToPurchaseVariant "
			
			end
			
			if(mappinManager[h.house.tag] == nil) then
		
			registerMappin( h.house.posX, h.house.posY, h.house.posZ, h.house.tag ,variantType,true,false,nil,nil)
			end
		
		
	end
	end
	
	
	if(arrayNode ~= nil) then
	for k,v in pairs(arrayNode)  do
	
	local node = v.node
		if(node.sort == "metro") then
		
			if(mappinManager[node.tag] == nil) then
		
				registerMappin(node.GameplayX, node.GameplayY, node.GameplayZ, node.tag ,"Zzz01_CarForPurchaseVariant",true,false,nil,nil)
			end
			
			
		end
							
	end
	end
	
end


