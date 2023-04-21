logme(1,"CyberScript: Custom Place module loaded")
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
	
	for k,v  in pairs(cyberscript.cache["place"]) do
		
		checkContext(v.data)
		
		if(curPos ~= nil and currentHouse == nil and check3DPos(curPos,v.data.x,v.data.y, v.data.z,v.data.range, v.data.range_z))then
			
			if(checkTriggerRequirement(v.data.requirement,v.data.trigger)) then
				currentHouse = v.data
				
				
				
					
				
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
		
		if(checkTriggerRequirement(currentHouse.requirement,currentHouse.trigger) and check3DPos(curPos,currentHouse.x,currentHouse.y, currentHouse.z,currentHouse.range, currentHouse.range_z) ) then
			
			if ItemOfHouseSpawned == false  then
			
				
				spawnItemFromHouseTag(currentHouse.tag)
				
				
				ItemOfHouseSpawned = true
			end
			
			
			if(currentHouse.action ~= nil and #currentHouse.action >0) then
				
				
				runActionList(currentHouse.action,currentHouse.tag,"interact",false,currentHouse.tag,false)
			end
			
			isInHouse = true
			
			
			
			
			
			currentRoom = nil
				for y = 1, #currentHouse.rooms do 
				
					checkContext(currentHouse.rooms[y])
				
					if(check3DPos(curPos,currentHouse.rooms[y].x,currentHouse.rooms[y].y,currentHouse.rooms[y].z,currentHouse.rooms[y].range,currentHouse.rooms[y].range_z) )then
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
	
	if(cyberscript.cache["place"] ~= nil) then
	for _,h in pairs(cyberscript.cache["place"]) do
		
		
		
	
		variantType = "FixerVariant"
		
		if h.data.type == 0 then --house
			variantType = "ApartmentVariant"
			elseif h.data.type == 1 then--bar
			variantType = "ServicePointBarVariant"
			elseif h.data.type == 2 then--nightclub
			variantType = "ServicePointBarVariant"
			elseif h.data.type == 3 then--restaurant
			variantType = "ServicePointFoodVariant"
			elseif h.data.type == 4 then--shopping
			variantType = "ServicePointJunkVariant"
		end
		
		local score = getScoreKey(h.data.tag,"Score")
		
		
		
			if(h.data.type == 0 and (score == 0 or score == nil)) then
				variantType = "Zzz05_ApartmentToPurchaseVariant "
			
			end
			
			if(mappinManager[h.data.tag] == nil and h.showMappin == true) then
			local color = {}
			color.red = 255
			color.green = 255
			color.blue = 255
			registerMappin( h.data.x, h.data.y, h.data.z, h.data.tag ,variantType,true,false,nil,nil,nil,nil,color,"ApartmentIcon",0)
			end
		
		
	end
	end
	
	
	if(cyberscript.cache["node"] ~= nil) then
	for k,v in pairs(cyberscript.cache["node"])  do
	
	local node = v.data
		if(node.sort == "metro") then
		
			if(mappinManager[node.tag] == nil) then
		
				registerMappin(node.gameplay_x, node.gameplay_y, node.gameplay_z, node.tag ,"Zzz01_CarForPurchaseVariant",true,false,nil,nil,nil,nil)
			end
			
			
		end
							
	end
	end
	
end


