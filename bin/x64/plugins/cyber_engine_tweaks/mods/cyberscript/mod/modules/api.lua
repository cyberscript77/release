logme(10,"CyberMod: api module loaded")
cyberscript.module = cyberscript.module +1
local api = {}

function api.spawn(chara,appearance, tag, x, y ,z, spawnlevel, isprevention, isMPplayer, scriptlevel, isitem, rotation) 
	
	spawnNPC(chara,appearance, tag, x, y ,z, spawnlevel, isprevention, isMPplayer, scriptlevel, isitem, rotation)
	
end

function api.spawnVehicle(chara, appearance, tag, x, y ,z, spawnlevel, spawn_system ,isAV,from_behind,isMP,wait_for_vehicule, scriptlevel, wait_for_vehicle_second)
	
	
	
	spawnVehicleV2(chara, appearance, tag, x, y ,z, spawnlevel, spawn_system ,isAV,from_behind,isMP,wait_for_vehicule, scriptlevel, wait_for_vehicle_second)
end

function api.despawn(tag) 
	
	despawnEntity(tag)
	
end

function api.move(targetPuppet, targetPosition, targetDistance, movementType, v2)
	
	MoveTo(targetPuppet, targetPosition, targetDistance, movementType, v2)
	
end

function api.teleport(objlook, position, rotation, isplayer)
	
	teleportTo(objlook, position, rotation, isplayer)
	
end

function api.getEntitybyTag(tag)
	
	getEntityFromManager(tag)
	
end

function api.runActionList(actionlist, tag, source,isquest,executortag,bypassMenu)
	
	runActionList(actionlist, tag, source,isquest,executortag,bypassMenu)
	
end

function api.checkTriggerRequirement(requirement,triggerlist)
	
	checkTriggerRequirement(requirement,triggerlist)
	
end

return api