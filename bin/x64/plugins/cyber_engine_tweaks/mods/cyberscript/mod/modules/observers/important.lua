
function QuestTrackerGameController_OnInitialize()
	
	if(observerthread4 == true or moddisabled  == true)   then return end
	
	
	
	if not isGameLoaded then
		--logme(2,'Game Session Started')
		isGameLoaded = true
		draw = true
	end
end

function QuestTrackerGameController_OnUninitialize()
	if(observerthread4 == true or moddisabled  == true)   then return end
	if Game.GetPlayer() == nil then
		--logme(2,'Game Session Ended')
		workerTable = {}
		despawnAll()
		isGameLoaded = false
		draw = false
	end
end


function SettingsMainGameController_RequestClose (_, _, target) -- Check if activated button is the custom mods button
	if(observerthread4  == true or moddisabled == true)    then return end
	
	local sessionFile = io.open("user/settings/cyberscript.json", 'w')
	sessionFile:write(JSON:encode_pretty(arrayUserSetting))
	sessionFile:close()
	
	local sessionFile = io.open("user/settings/userinput.json", 'w')
	sessionFile:write(JSON:encode_pretty(arrayUserInput))
	sessionFile:close()
	
	cyberscript.language = Game.GetSettingsSystem():GetVar("/language", "OnScreen"):GetValue().value
	local activeData = CodexListSyncData.new()
	local gameshards = CodexUtils.GetShardsDataArray(GameInstance.GetJournalManager(), activeData)
	if gameshardscompiled == nil then gameshardscompiled = {} end
	for i,v in pairs(gameshards) do
		if gameshardscompiled[v.data.title] == nil then gameshardscompiled[v.data.title] = true end
		
		
	end		
	if(AutoRefreshDatapack == true) then
		LoadDataPackCache()
	end
end