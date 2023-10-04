logme(1,"CyberScript: AV module loaded")
cyberscript.module = cyberscript.module +1

AVspeed = 2
maxcollisionattemp = 5
attempt = 0
yawvelocity =  0.01
rollvelocity = 0.01
returnrollvelocity = 0.01

maxspeed = 15
--TAKEN AND ADAPTED FROM FREEFLY, This mod was created by keanuWheeze from CP2077 Modding Tools Discord. Check his page : https://www.nexusmods.com/cyberpunk2077/mods/780?tab=files

function refreshAV()
	--Exit
	if(AVinput.exit ~= nil and AVinput.exit == true) then
		if AVisIn == true and inVehicule == true then
			-- local fppComp = Game.GetPlayer():GetFPPCameraComponent()
			-- fppComp:SetLocalPosition(Vector4:new(0.0, 0.0, 0.0, 1.0))
			-- Stop("env")
			if(AVseat ~= nil) then
				UnsetSeat("player",false, AVseat)
				RemoveEffectPlayer("GameplayRestriction.NoScanning")
				AVseat = nil
				Cron.After(1, function()
					
					logme(10,#cyberscript.GroupManager["AV"].entities)
					for i=1, #cyberscript.GroupManager["AV"].entities do 
						local entityTag = cyberscript.GroupManager["AV"].entities[i]
						logme(10,entityTag)
						local obj = getEntityFromManager(entityTag)
						local enti = Game.FindEntityByID(obj.id)
						if(enti ~= nil) then
							despawnEntity(entityTag)
						end
					end
					cyberscript.GroupManager["AV"].entities = {}	
					CurrentAVEntity = nil
					AVisIn = false
					AVinput.exit = false							
				end)
				else
				CurrentAVEntity = nil
				AVisIn = false
				AVinput.exit = false		
			end
		end
	end
	----print(AVspeed)	

	
	
	if(AVinput.isMoving == false and AVisIn) then
		ApplyEffectOnPlayer("GameplayRestriction.NoScanning")
		AVspeed = 1
		AVinput.isMoving = false
		AVinput.currentDirections.backwards = false
		AVinput.currentDirections.forward = false
		-- AVinput.lastInput = ""
		-- local group =getGroupfromManager("AV")
		-- for i=1, #group.entities do 
		-- local entityTag = group.entities[i]
		-- local isplayer = false
		-- if entityTag == "player" then
		-- isplayer = true
		-- end
		-- local obj = getEntityFromManager(entityTag)
		-- local enti = Game.FindEntityByID(obj.id)
		-- if(enti ~= nil) then
		
		-- local newAngle = {}
		-- newAngle.yaw = AVyaw
		-- newAngle.roll = AVroll
		-- newAngle.pitch = AVPitch
		-- teleportTo(enti, enti:GetWorldPosition(), newAngle, false,obj)
		-- end
		-- end
		
		-- -- local speede = math.floor(AVspeed*10)
		-- -- setScore("av","speed",speede)
		
	end
	
	
	
end

function inputAV(action)
	
	if (AVisIn == true) then
	
		--back/forward
		
		if  
			actionName == "world_map_filter_navigation_up" or
			actionName == "world_map_menu_move_vertical" or
			actionName == "world_map_menu_move_horizontal" or
			actionName == "world_map_menu_cycle_filter_prev" or
			actionName == "ToggleVehCamera" or
			actionName == "left_stick_x" or
			actionName == "left_stick_y" or
			actionName == "right_trigger" or
			actionName == "left_trigger" or
			actionName == "UI_Skip" or
			actionName == "CameraMouseX" or
			actionName == "right_stick_x" or
			actionName == "VisionHold" or
			actionName == "option_switch_next"  or
			actionName == "Exit" 
		then
			
			if actionName == "right_stick_x" then -- Controller movement
				local x = action:GetValue(action)
				
				if x < 0 then
					--AVinput.analogRight = 0
					AVinput.analogLeft = -x
					AVinput.keyPressed = true
					AVinput.isMoving = true
					--print(x)
                elseif x>0 then
					AVinput.analogRight = x
					--AVinput.analogLeft = 0
					AVinput.keyPressed = true
					AVinput.isMoving = true
					--print(x)
				
				elseif x == 0 then
					AVinput.analogRight = 0
					AVinput.analogLeft = 0
					AVinput.keyPressed = false
					AVinput.isMoving = false
				end
				end
              if actionName == "left_stick_y" then
				local x = action:GetValue(action)
				if x < 0 then
					AVinput.analogForward = 0
					AVinput.analogBackwards = x
					AVinput.keyPressed = true
					AVinput.isMoving = true
					
                    else
					AVinput.analogForward = -x
					AVinput.analogBackwards = 0
					AVinput.keyPressed = true
					AVinput.isMoving = true
				end
				if x == 0 then
					AVinput.analogForward = 0
					AVinput.analogBackwards = 0
					AVinput.keyPressed = false
					AVinput.isMoving = false
				end
                elseif actionName == "right_trigger" and actionType == "AXIS_CHANGE" then
				local z = action:GetValue(action)
				if z == 0 then
					AVinput.analogUp = 0
					AVinput.keyPressed = false
					AVinput.isMoving = false
                    else
					AVinput.analogUp = z
					AVinput.keyPressed = true
					AVinput.isMoving = true
				end
                elseif actionName == "left_trigger" and actionType == "AXIS_CHANGE" then
				local z = action:GetValue(action)
				if z == 0 then
					AVinput.analogDown = 0
					AVinput.keyPressed = false
					AVinput.isMoving = false
                    else
					AVinput.analogDown = z
					AVinput.keyPressed = true
					AVinput.isMoving = true
				end
			end
			
			-- if actionName == 'world_map_filter_navigation_up' then
				-- if actionType == 'BUTTON_PRESSED' then
					-- AVinput.analogForward = 1
					-- AVinput.keyPressed = true
					-- AVinput.isMoving = true
                    -- elseif actionType == 'BUTTON_RELEASED' then
					-- AVinput.analogForward = 0
					-- AVinput.keyPressed = false
					-- AVinput.isMoving = false
				-- end
                -- elseif actionName == 'world_map_menu_move_vertical' then
				-- if actionType == 'BUTTON_PRESSED' then
					-- AVinput.analogBackwards = 1
					-- AVinput.keyPressed = true
					-- AVinput.isMoving = true
                    -- elseif actionType == 'BUTTON_RELEASED' then
					-- AVinput.analogBackwards = 0
					-- AVinput.keyPressed = false
					-- AVinput.isMoving = false
				-- end
                -- elseif actionName == 'world_map_menu_move_horizontal' then
				-- if actionType == 'BUTTON_PRESSED' then
					-- AVinput.analogRight = 1
					-- AVinput.keyPressed = true
					-- AVinput.isMoving = true
                    -- elseif actionType == 'BUTTON_RELEASED' then
					-- AVinput.analogRight = 0
					-- AVinput.keyPressed = false
					-- AVinput.isMoving = false
				-- end
                -- elseif actionName == 'world_map_menu_cycle_filter_prev' then
				-- if actionType == 'BUTTON_PRESSED' then
					-- AVinput.analogLeft = 1
					-- AVinput.keyPressed = true
					-- AVinput.isMoving = true
                    -- elseif actionType == 'BUTTON_RELEASED' then
					-- AVinput.analogLeft = 0
					-- AVinput.keyPressed = false
					-- AVinput.isMoving = false
				-- end
                -- elseif actionName == 'ToggleVehCamera' then
				-- if actionType == 'BUTTON_PRESSED' then
					-- AVinput.analogDown = 1
					-- AVinput.keyPressed = true
					-- AVinput.isMoving = true
                    -- elseif actionType == 'BUTTON_RELEASED' then
					-- AVinput.analogDown = 0
					-- AVinput.keyPressed = false
					-- AVinput.isMoving = false
				-- end
                -- elseif actionName == 'UI_Skip' then
				-- if actionType == 'BUTTON_PRESSED' or actionType == 'BUTTON_HOLD_COMPLETE' then
					-- AVinput.analogUp = 1
                    -- elseif actionType == 'BUTTON_RELEASED' then
					-- AVinput.analogUp = 0
					-- AVinput.keyPressed = false
					-- AVinput.isMoving = false
				-- end
			-- end
			
			if actionName == "CameraMouseX" then
                local x = action:GetValue(action)
				local sens = Game.GetSettingsSystem():GetVar("/controls/fppcameramouse", "FPP_MouseX"):GetValue() / 2.9
				AVinput.yaw = - (x / 35) * sens
			end
		
			-- if actionName == "right_stick_x" then
				-- local x = action:GetValue(action)
				-- local sens = Game.GetSettingsSystem():GetVar("/controls/fppcamerapad", "FPP_PadX"):GetValue() / 10
				-- AVinput.yaw = - x * 1.7 * sens
			-- end
		
			if actionName == "VisionHold" then
				
				
				if actionType == 'BUTTON_PRESSED' then
					AVinput.analogRollRight = 1
					AVinput.keyPressed = true
					AVinput.isMoving = true
					
					elseif actionType == 'BUTTON_RELEASED' then
					AVinput.analogRollRight = 0
					AVinput.keyPressed = false
					AVinput.isMoving = false
				end
				
			end
			
			if actionName == "option_switch_next" then
				
				if actionType == 'BUTTON_PRESSED' then
					AVinput.analogRollLeft = 1
					AVinput.keyPressed = true
					AVinput.isMoving = true
					elseif actionType == 'BUTTON_RELEASED' then
					AVinput.analogRollLeft = 0
					AVinput.keyPressed = false
					AVinput.isMoving = false
				end
				
				
			end	
			
			if actionName == 'Exit' then
				if actionType == 'BUTTON_PRESSED'then
					AVinput.exit = true
					
				end
			end
			
			
			
			if (AVinput.isMoving == true and AVisIn and AVinput.keyPressed == true ) then
		
				fly(AVinput, 0)
				
			end
			
		end
	end
end

function fly(directions, angle)
	
	local inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
	if(inVehicule) then
		local vehicules = GetMountedVehicle(Game.GetPlayer())
		
		local newPos = vehicules:GetWorldPosition()
		
		local record = vehicules:GetRecord()
		ApplyEffectOnPlayer("GameplayRestriction.NoScanning")
		
		
		local uiData = record:VehicleUIData()
		
		local vehimass = MeasurementUtils.ValueToImperial(uiData:Mass(), EMeasurementUnit.Kilogram)
		
		local mass = math.floor(vehimass)
		
		
		
		
		local newAngle = {}
		newAngle.yaw = AVyaw
		newAngle.roll = AVroll
		newAngle.pitch = AVPitch
		
		local group =getGroupfromManager("AV")
		
		
		for i=1, #group.entities do 
			local entityTag = group.entities[i]
			local isplayer = false
			
			
			if entityTag == "player" then
				-- isplayer = true
			end
			
			local obj = getEntityFromManager(entityTag)
			local enti = Game.FindEntityByID(obj.id)
			
			if(enti ~= nil) then
				
				
				local newpostouse = newPos
				
				--print("zyesy")
				--print(dump(directions))
				
				--local test = Game.GetPlayer():GetFPPCameraComponent():GetLocalOrientation()
				
				
				
				
				newPos = calculateNewPos2("forward", newPos, AVSpeed,directions,AVVelocity,mass)
				newPos = calculateNewPos2("backwards", newPos, AVSpeed,directions,AVVelocity,mass)
				newPos = calculateNewPos2("right", newPos,AVSpeed,directions,AVVelocity,mass)
				newPos = calculateNewPos2("left", newPos, AVSpeed,directions,AVVelocity,mass)
				newPos = calculateNewPos2("up", newPos, AVSpeed,directions,AVVelocity,mass)
				newPos = calculateNewPos2("down", newPos, AVSpeed,directions,AVVelocity,mass)
				
				
				
				
				-- for directionKey, state in pairs(directions) do
				-- if state == true and (directionKey ~= "left" or directionKey ~= "right") and (directionKey ~= "rollleft" or directionKey ~= "rollright") then
				
				-- if((directionKey=="forward" or directionKey=="backwards") or (directionKey=="up" or directionKey=="down") or entityTag == "fake_av") then
				
				-- newpostouse.z = newpostouse.z+0.2
				
				-- end
				
				
				-- if(entityTag == "fake_av") then
				
				-- mass = 3000
				
				-- end
				
				
				-- newPos =  calculateNewPos(directionKey, newpostouse, vehicules,mass,actionValue)
				
				
				
				
				
				-- end
				
				
				-- --	if state == true and (directionKey == "left" or directionKey == "right" or directionKey == "rollleft" or directionKey == "rollright") then
				
				-- if state == true then
				
				-- --if(directionKey~="forward" or directionKey~="backwards") then
				--calculateNewAngle(directionKey)
				-- --end
				
				
				
				
				
				
				-- end
				
				
				
				
				-- end
				 local playerRot = Game.GetCameraSystem():GetActiveCameraForward():ToRotation()
				
				-- --print(AVyaw)
				-- --print(playerRot.yaw)
				setVariable("AV","playerRot", playerRot.yaw)
				local diff = playerRot.yaw - AVyaw
				setVariable("AV","diff", diff)
				if(diff<2 and diff >-2) then
				 AVyaw = playerRot.yaw
				end
				setVariable("AV","yaw", AVyaw)
				
				newAngle.yaw = AVyaw
				newAngle.roll = AVroll
				newAngle.pitch = 0
				
				--print(dump(newAngle))
				
				teleportTo(enti, newPos, newAngle, false,obj)
				--AVyaw = 0
			end
			
		end
		
		--teleportTo(vehicule, newPos, newAngle, false)
	--Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(0, 0-AVrollCam, 0)))
		AVrollCam = 0
		
	end
	
end


function calculateNewPos2(direction, newPos, speed,directions,AVVelocity,mass)
	if direction == "forward" and directions.analogForward ~= 0 and directions.analogForward ~= nil then
		--AVspeed =  getvelocity(AVspeed,AVVelocity,mass)
		AVspeed = AVspeed + directions.analogForward
		
		
			
		
        elseif direction == "backwards" and directions.analogBackwards ~= 0 and directions.analogBackwards ~= nil then
		--AVspeed =  getvelocity(AVspeed,AVVelocity,mass)
		AVspeed = AVspeed + directions.analogBackwards
		local playerRot = Game.GetCameraSystem():GetActiveCameraForward():ToRotation()
				
			
		--speed = speed * directions.analogBackwards
        elseif direction == "right"  and directions.analogRight ~= 0 and directions.analogForward ~= nil then
		-- AVyaw = AVyaw - yawvelocity
		-- AVroll = AVroll+rollvelocity
		AVrollCam = -1
        elseif direction == "left" and directions.analogLeft ~= 0 and directions.analogLeft ~= nil then
		-- AVyaw = AVyaw - yawvelocity
		-- AVroll = AVroll-rollvelocity
		AVrollCam = -1
			
				
		--calculateNewAngle("left")
        elseif direction == "up" then
		--speed = speed * directions.analogUp
        elseif direction == "down" then
		--speed = speed * directions.analogDown
	end
	
	local vec
	if direction == "forward" or direction == "backwards" then
		vec = Game.GetCameraSystem():GetActiveCameraForward()
        elseif direction == "right" or direction == "left" then
		vec = Game.GetCameraSystem():GetActiveCameraRight()
	end
	if direction == "forward" or direction == "right" then
		newPos.x = newPos.x + (vec.x * AVspeed)
		newPos.y = newPos.y + (vec.y * AVspeed)
		newPos.z = newPos.z + (vec.z * AVspeed)
        elseif direction == "backwards" or direction == "left" then
		newPos.x = newPos.x - (vec.x * AVspeed)
		newPos.y = newPos.y - (vec.y * AVspeed)
		newPos.z = newPos.z - (vec.z * AVspeed)
        elseif direction == "up" then
		newPos.z = newPos.z + (0.7 * 1)
        elseif direction == "down" then
		newPos.z = newPos.z - (0.7 * 1)
	end
	
	return newPos
end

function calculateNewPos(direction, newPos, vehicule,mass,actionValue)
	
	
	local collision = false
	
	local from = Vector4.new(
		newPos.x + 1 ,
		newPos.y + 1,
		newPos.z,
		newPos.w
	)
	
	local forward = Game.GetCameraSystem():GetActiveCameraForward()
	local to = Vector4.new(
		from.x + (forward.x * AVspeed),
		from.y + (forward.y * AVspeed),
		from.z,
		from.w
	)
	
	-- local filters = {
	
	-- 'Static', -- Buildings, Concrete Roads, Crates, etc.
	
	-- 'Terrain'
	
	-- }
	local filters = {
		-- 'Dynamic', -- Movable Objects
		-- 'Vehicle',
		'Static', -- Buildings, Concrete Roads, Crates, etc.
		'Water',
		'Terrain',
		-- 'PlayerBlocker', -- Trees, Billboards, Barriers
	}
	
	local results = {}
	
	
	
	
	
	if direction == "backwards"  then
		
		forward =Game.GetCameraSystem():GetActiveCameraForward()
		
		from = Vector4.new(
			newPos.x ,
			newPos.y ,
			newPos.z,
			newPos.w
		)
		to = Vector4.new(
			from.x - (forward.x * AVspeed),
			from.y - (forward.y * AVspeed),
			from.z,
			from.w
		)
		
		
	end
	
	if direction == "down"  then
		
		
		
		from = Vector4.new(
			newPos.x ,
			newPos.y ,
			newPos.z,
			newPos.w
		)
		to = Vector4.new(
			from.x - (forward.x * AVspeed),
			from.x - (forward.x * AVspeed),
			from.z - (1 * AVspeed),
			from.w
		)
		
		--	filters = {'Terrain'}
		
	end
	
	for _, filter in ipairs(filters) do
		local success, result = Game.GetSpatialQueriesSystem():SyncRaycastByCollisionGroup(from, to, filter, false, false)
		
		if success then
			collision = true
			
			if(filter == "Static") then
				collision = false
				attempt = attempt+1
				
				else
				
				attempt = 0
				
			end
			
			if(attempt > maxcollisionattemp) then
				
				collision = true
				
				--print("direction "..direction.."normal"..tostring(result.normal))
				--print("direction "..direction.."material"..tostring(result.material))
				--print("direction "..direction.."filter"..tostring(filter))
				
			end
			
		end
	end
	
	
	direc = Game.GetCameraSystem():GetActiveCameraForward()
	
	if direction == "forward" and (collision == false)  then
		
		newPos.x = newPos.x + (direc.x * -AVspeed)
		newPos.y = newPos.y + (direc.y * -AVspeed)
		--newPos.z = newPos.z + (direc.z * AVspeed)
		
		
		--newPos.z = newPos.z + (direc.z * AVspeed)
		
		-- if(AVPitch ~= 0) then
		
		-- if(AVPitch > 0) then
		-- AVPitch = AVPitch -  0.1
		-- else
		
		-- AVPitch = AVPitch +  0.1
		-- end
		-- end
		--newPos.z = newPos.z + (direc.z * AVspeed)
		
		elseif direction == "backwards" and collision == false  then
		
		newPos.x = newPos.x - (direc.x * AVspeed)
		newPos.y = newPos.y - (direc.y * AVspeed)
		--newPos.z = newPos.z - (direc.z * AVspeed)
		
		
		
		--newPos.z = newPos.z + (direc.z * AVspeed)
		
		
		-- if(AVPitch ~= 0) then
		
		-- if(AVPitch > 0) then
		-- AVPitch=AVPitch  -  0.1
		-- else
		
		-- AVPitch= AVPitch +  0.1
		-- end
		-- end
		
		
		
		newPos.x = direc.x 
		newPos.y = direc.y
		
	end
	
	if direction == "up" then
		
		
		newPos.z = newPos.z + 0.01
		AVPitch= AVPitch - 0.1
		
	end
	
	
	if direction == "down" and collision == false then
		
		newPos.z = newPos.z - 0.01
		AVPitch= AVPitch +  0.1
		
		
	end
	
	-- if collision == true then
	-- AVspeed = 0.3
	
	-- else
	-- AVspeed =  getvelocity(AVspeed,AVVelocity,mass)
	
	-- end
	
	
	
	return newPos
end


function calculateNewAngle(direction)
	
	
	--logme(2,direction)
	if direction == "right" or direction == "rollright" or direction == "left" or direction == "rollleft" then
		
		
		
		
		if direction == "left" then
			
			AVyaw = AVyaw - yawvelocity
			AVroll = AVroll+rollvelocity
			AVrollCam = -1
		end
		
		if direction == "rollleft"  then
			
			
			AVroll = AVroll+rollvelocity
			AVrollCam = -1
		end
		
		if direction == "right"  then
			
			AVyaw = AVyaw + yawvelocity
			AVroll = AVroll-rollvelocity
			AVrollCam = -1
		end
		
		if direction == "rollright" then
			
			
			AVroll = AVroll-rollvelocity
			AVrollCam = -1
		end
		
		
		
		
		else
		
		if(AVroll > 1 or AVroll <-1 ) then
			--print("returning")
			if(AVroll > 0) then
				AVroll=AVroll  -  returnrollvelocity
				else
				
				AVroll= AVroll +  returnrollvelocity
			end
			else
			
			AVroll = 0
			
		end
	end
	
	
	
end


function getvelocity(speed,velocity,mass)
	--print("speed"..tostring(speed))
	-- local minmass = mass/1000
	-- --print("minmass"..tostring(mass))
	-- local massveloce = minmass * 0.01
	-- --print("massveloce"..tostring(massveloce))
	local result = speed * velocity
	--print("result"..tostring(result))
	-- if(result < 0) then
		
		-- result = 0-result
		
	-- end
	if(result > maxspeed) then
		result= maxpeed
		
	end
	
	--print("speed"..tostring(result))
	return result
	
end
