logme(10,"CyberMod: sound module loaded")
cyberscript.module = cyberscript.module +1


function PlaySound(sound,isradio,needrepeat)
	
	local playsound = sound.tag
	
	if sound.language ~= nil then
		
		if sound.language[cyberscript.language] ~= nil then
		
			playsound = sound.language[cyberscript.language]
		
		else
			
			if sound.language["default"] ~= nil then
				playsound = sound.language["default"]
			end
		end
	
	end
	
	local audioEvent = SoundPlayEvent.new()
	audioEvent.soundName = playsound
	Game.GetPlayer():QueueEvent(audioEvent)
	local times = os.date()
	
	cyberscript.soundmanager[sound.tag] = {}
	cyberscript.soundmanager[sound.tag] = sound
	cyberscript.soundmanager[sound.tag].isplaying = true
	cyberscript.soundmanager[sound.tag].isradio = isradio
	cyberscript.soundmanager[sound.tag].needrepeat = needrepeat
	cyberscript.soundmanager[sound.tag].startplaying = os.time(os.date("!*t"))+0
	cyberscript.soundmanager[sound.tag].endplaying = os.time(os.date("!*t"))+sound.duration
	
	
end

function PlaySoundAtEntity(sound,isradio,needrepeat,tag)
	
	local playsound = sound.tag
	
	if sound.language ~= nil then
		
		if sound.language[cyberscript.language] ~= nil then
		
			playsound = sound.language[cyberscript.language]
		
		else
			
			if sound.language["default"] ~= nil then
				playsound = sound.language["default"]
			end
		end
	
	end
	local obj = getEntityFromManager(tag)
	if(obj ~= nil) then
		local enti = Game.FindEntityByID(obj.id)
		if(enti ~= nil) then
			local audioEvent = SoundPlayEvent.new()
			audioEvent.soundName = playsound
			enti:QueueEvent(audioEvent)
			local times = os.date()
			
			cyberscript.soundmanager[sound.tag] = {}
			cyberscript.soundmanager[sound.tag] = sound
			cyberscript.soundmanager[sound.tag].isplaying = true
			cyberscript.soundmanager[sound.tag].isradio = isradio
			cyberscript.soundmanager[sound.tag].needrepeat = needrepeat
			cyberscript.soundmanager[sound.tag].startplaying = os.time(os.date("!*t"))+0
			cyberscript.soundmanager[sound.tag].endplaying = os.time(os.date("!*t"))+sound.duration
		end
	end
	
end

function Stop(sound)
	
	local playsound = sound
	
	-- if sound.language ~= nil then
		
		-- if sound.language[cyberscript.language] ~= nil then
		
			-- playsound = sound.language[cyberscript.language]
		
		-- else
			
			-- if sound.language["default"] ~= nil then
				-- playsound = sound.language["default"]
			-- end
		-- end
	
	-- end
	
	
	local audioEvent = SoundStopEvent.new()
	audioEvent.soundName = playsound
	Game.GetPlayer():QueueEvent(audioEvent)
	cyberscript.soundmanager[sound] = nil
	
	
end



function IsPlaying(sound)
	
local bool = (cyberscript.soundmanager[sound.tag] ~= nil and cyberscript.soundmanager[sound.tag].isplaying == true)
	
		
	
return bool
	
	
end

function SetSoundSettingValue(volumTag,value)
	
	local SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", volumTag)
	SoundManager.SfxVolume = SfxVolume:GetValue()
	SfxVolume:SetValue(value)
	
end



