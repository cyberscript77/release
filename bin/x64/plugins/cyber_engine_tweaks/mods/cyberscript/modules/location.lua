debugPrint(2,"CyberScript: location module loaded")
cyberscript.module = cyberscript.module +1

function openLocation()
	
if( file_exists("json/report/savelocation.json") ) then


local flo = io.open("json/report/savelocation.json")
  lines = flo:read("*a")
  if(lines ~= "") then
	savelocation = trydecodeJSOn(lines, flo,"json/report/savelocation.json")
		
  end

flo:close()
end 
end


function savePath(recordRotation,recordRelative)

pathtick = tick

saveLocation(recordRotation,recordRelative)
-- if (pathtick % 30 == 0) then

-- saveLocation()
-- pathtick = 0

-- end


end

function saveLocation(recordRotation,recordRelative)

local location = {}
local inVehicule = false

inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())


if(recordRelative == true) then
	
location.x = curPos.x - recordInitialPosition.x
location.y = curPos.y - recordInitialPosition.y 
location.z = curPos.z - recordInitialPosition.z
recordInitialPosition = curPos

else
location.x = curPos.x
location.y = curPos.y
location.z = curPos.z  
end



local euler = {}

if recorderEntity == "player" then
        local v = Vector4.new(-Game.GetCameraSystem():GetActiveCameraForward().x, -Game.GetCameraSystem():GetActiveCameraForward().y, -Game.GetCameraSystem():GetActiveCameraForward().z, -Game.GetCameraSystem():GetActiveCameraForward().w)
		euler = GetSingleton('Vector4'):ToRotation(v)
		euler.yaw = euler.yaw + 180
		debugPrint(10,recorderEntity)
end
	if recorderEntity == "mounted_vehicle" then
		if Game['GetMountedVehicle;GameObject'](Game.GetPlayer()) ~= nil then
			local qat = Game['GetMountedVehicle;GameObject'](Game.GetPlayer()):GetWorldOrientation()
			euler = GetSingleton('Quaternion'):ToEulerAngles(qat)
			debugPrint(10,"GetMountedVehicle")
			debugPrint(10,recorderEntity)
			else
			local qat = Game.GetPlayer():GetWorldOrientation()
			euler = GetSingleton('Quaternion'):ToEulerAngles(qat)
			debugPrint(10,"Quaternion")
			debugPrint(10,recorderEntity)
		end  
	end   
		
	if recorderEntity == "player_entity" then
		local qat = Game.GetPlayer():GetWorldOrientation()
		euler = GetSingleton('Quaternion'):ToEulerAngles(qat)
		debugPrint(10,"player_entity")
		debugPrint(10,recorderEntity)
	end  
	
	if recorderEntity == "player_camera" then
		local fppComp = Game.GetPlayer():GetFPPCameraComponent()
		local cmapos = fppComp:GetLocalPosition() 
		location.x = cmapos.x 
		location.y = cmapos.y 
		location.z = cmapos.z 
	end   


location.x = location.x + pathOffsetX
location.y = location.y + pathOffsetY
location.z = location.z + pathOffsetZ  


if(recordRotation == true)then
location.pitch = euler.pitch
location.roll = euler.roll
location.yaw = euler.yaw
else
location.pitch = 0
location.roll = 0
location.yaw = 0
end


location.inVehicule = inVehicule
location.Tag = currentDistricts2.Tag

for i, currentDistricts2 in ipairs(currentDistricts2.districtLabels) do
			if i == 1 then
				location.district = currentDistricts2
				
				else
				location.subdistrict = currentDistricts2
				
			end
			
			
end


table.insert(tempLocation,location)

debugPrint(2,"Location "..location.district.." "..location.subdistrict.." "..location.x.." "..location.y.." "..location.z.." is saved in /json/report/savelocation.json")


end

function closeSaveLocation()

savelocation.locations = tempLocation


local file = assert(io.open("json/report/"..savelocation.desc..".json", "w"))
		local stringg = JSON:encode_pretty(savelocation)
		debugPrint(2,stringg)
		file:write(stringg)
		file:close()
tempLocation = {}		
		

end





function playPath()
	
	if(playtick<= #tempLocation.locations) then
	
		
		local rot = EulerAngles.new(tempLocation.locations[playtick].roll, tempLocation.locations[playtick].pitch,  tempLocation.locations[playtick].yaw)
		
		if(tempLocation.recordRotation == false) then
			rot =  GetSingleton('Quaternion'):ToEulerAngles(editorPathTarget:GetWorldOrientation())
		end
	
		local pos = Vector4.new(tempLocation.locations[playtick].x, tempLocation.locations[playtick].y, tempLocation.locations[playtick].z,1)			
		
		Game.GetTeleportationFacility():Teleport(editorPathTarget, pos , rot)
		
		
		if(editorPathTarget == Game.GetPlayer())then
			Game.GetPlayer():GetFPPCameraComponent().pitchMin = rot.pitch - 0.01
			Game.GetPlayer():GetFPPCameraComponent().pitchMax = rot.pitch
			Game.GetPlayer():GetFPPCameraComponent():SetLocalOrientation(GetSingleton('EulerAngles'):ToQuat(EulerAngles.new(rot.roll, 0, 0)))
		end
		
		
	else
		playLocationEnabled = false
		playtick = 1
	
	end
	
end


