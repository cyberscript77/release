

print("CyberScript Core Initialisation...")

local modLoaded = false


function loadExternal()

	QuestManager = dofile('external/QuestManager.lua')
	QuestJournalUI = dofile('external/QuestJournalUI.lua')
	QuestTrackerUI = dofile('external/QuestTrackerUI.lua')
	GameUI = dofile('external/GameUI.lua')
	TargetingHelper = dofile('external/TargetingHelper.lua')
	AIControl = dofile('external/AIControl.lua')
	GameHUD = dofile('external/GameHUD.lua')
	GameSettings = dofile('external/GameSettings.lua')
	IGE = dofile('external/ImGuiExtension.lua')
	Cron = dofile('external/Cron.lua')
	Ref = dofile('external/Ref.lua')
	EventProxy = dofile('external/EventProxy.lua')
	UIPopupsManager = dofile('external/UIPopupsManager.lua')
	UIScroller = dofile('external/UIScroller.lua')
	UIButton = dofile('external/UIButton.lua')
	GameSession = dofile('external/GameSession.lua')
	CPStyling =  dofile('external/cpstyling.lua')
	CPS =  CPStyling:New()
	RES_slot =  dofile('external/attachment-slots.lua')
	RES_attributes =  dofile('external/attributes.lua')
	RES_crafting =  dofile('external/crafting-components.lua')
	RES_area =  dofile('external/equipment-areas.lua')
	RES_perks =  dofile('external/perks.lua')
	RES_perksalias =  dofile('external/perks-by-alias.lua')
	RES_skills =  dofile('external/skills.lua')
	RES_TweakDB =  dofile('external/tweakdb-ids.lua')
	RES_TweakDBmeta =  dofile('external/tweakdb-meta.lua')
	
end

-- logme(2,"Start Mod")



function debugPrint(level,value)
	logme(level,value) 
	
end



function ModInitialisation()
	
	
	
	
	--version of compiled cache
	cacheVersion = 2
	
	
	print("test")
	
	currentSave = {}
	currentSave.Score = {}
	currentSave.Variable = {}
	currentSave.Variable["Affinity"] = {}
	
	currentSave.arrayPlayerData = {}
	currentSave.arrayAffinity = {}
	currentSave.arrayQuestStatut = {}
	currentSave.arrayFactionScore = {}
	currentSave.arrayUserSetting = {}
	currentSave.arrayHouseStatut = {}
	currentSave.arrayHousing = {}
	currentSave.arrayPlayerItems = {}
	currentSave.savedStates = {}
	currentSave.arrayFactionDistrict = nil
	currentSave.arrayFactionRelation = nil
	currentSave.garage = {}
	currentSave.arrayHUD = {}
	
	
	 --not require a verification because it's not mine ^^
	loadModule()
	
	CompiledDatapack = {}
	
	local reader = dir("cache")
	if(reader ~= nil) then
	for i,v in ipairs(reader) do 
		if(tostring(reader[i].type) ~= "directory" and reader[i].name ~= "placeholder") then
			
			
			local file =io.open('cache/'..reader[i].name)
			local size = file:seek("end")    -- get file size
			file:close()
			
			if size > 100 and size < 10000000 then
				
				CompiledDatapack[reader[i].name] =  dofile('cache/'..reader[i].name)
				
				else
				
				local msg = " is too big. The cache file will not be loaded.."
				
				if(size < 100) then
					
					local msg = "is too small. The cache file will not be loaded.."
					
				end
				
				debugPrint(2,"Size of the cache "..reader[i].name..msg)
				
			end
			
			
			
			
		end
	end
	end
	-- File Checking for Init
	if file_exists("desc.json") then
		local f = io.open("desc.json")
		lines = f:read("*a")
		if lines ~= "" then
			local json = json.decode(lines)
			cyberscript.version = json.version
			cyberscript.channel = json.channel
			cyberscript.changelog = json.changelog
		end
		f:close()
	end
	
	
	
	
	--lang import
	havelang = ImportLanguage()

	
end
function SaveLoading()
	
	arrayVehicles = initVehicles()
	unlockVehicles(initVehicles())
	arrayDistricts = initDistrict()
	arrayFastTravel = initFastTravel()
	arrayGameSounds = initGameSounds()
	arrayAttitudeGroup = initAttitudeGroup()
	
	
	if #currentSave.arrayAffinity == 0 then
		reloadCET = false
		if file_exists("sessions/latest.txt") then
			nodata = false
			GameSession.readLatest()
			debugPrint(2,"CyberScript Session : data found, recover latest data")
			else
			nodata = true
			
		end
	end
	
	for i,v in ipairs(arrayPnjDb) do
		if currentSave.myAvatar ~= nil and currentSave.myAvatar == v.TweakIDs then
			Avatarindex = i
		end
		table.insert(tweakdbtable,v.TweakIDs)
	end
	
	
	if GameIsLoaded == true and #currentSave.arrayAffinity > 0 then
		loadUIsetting()
	end
	
	if #currentSave.garage > 0 then
		for i=1, #currentSave.garage do
			Game.GetVehicleSystem():EnablePlayerVehicle(currentSave.garage[i].path, true, false)
		end
	end
	
	if(currentSave.arrayUserSetting[1] ~= nil) then -- convert old setting to new
		
		local arrayUserSetting2 = {}
		
		for i,v in ipairs(currentSave.arrayUserSetting) do
			
			arrayUserSetting2[currentSave.arrayUserSetting[i].Tag] = currentSave.arrayUserSetting[i].Value
			
			
		end
		
		currentSave.arrayUserSetting = arrayUserSetting2
		
		
		
		debugPrint(2,getLang("init_renew_setting"))
		
	end
	
	
	ScrollSpeed = getUserSettingWithDefault("ScrollSpeed",ScrollSpeed)
	ScriptedEntityAffinity = getUserSettingWithDefault("ScriptedEntityAffinity",ScriptedEntityAffinity)
	AmbushMin = getUserSettingWithDefault("AmbushMin",AmbushMin)
	AlwaysShowDefaultWindows = getUserSettingWithDefault("AlwaysShowDefaultWindows",AlwaysShowDefaultWindows)
	AmbushEnabled = getUserSettingWithDefault("AmbushEnabled",AmbushEnabled)
	AutoAmbush = getUserSettingWithDefault("AutoAmbush",AutoAmbush)
	displayXYZset = getUserSettingWithDefault("displayXYZ",displayXYZset)
	currentController = getUserSettingWithDefault("currentController",currentController)
	enableLocation = getUserSettingWithDefault("enableLocation",enableLocation)
	showFactionAffinityHud = getUserSettingWithDefault("showFactionAffinityHud",showFactionAffinityHud)
	AmbushMax = getUserSettingWithDefault("AmbushMax",AmbushMax)
	GangWarsEnabled = getUserSettingWithDefault("GangWarsEnabled",GangWarsEnabled)
	AutoRefreshDatapack = getUserSettingWithDefault("AutoRefreshDatapack",AutoRefreshDatapack)
	logrecordlevel = getUserSettingWithDefault("logrecordlevel",logrecordlevel)
	enableCustomQuest =  getUserSettingWithDefault("enableCustomQuest",enableCustomQuest)
	InfiniteDoubleJump =  getUserSettingWithDefault("InfiniteDoubleJump",InfiniteDoubleJump)
	DisableFallDamage =  getUserSettingWithDefault("DisableFallDamage",DisableFallDamage)
	Player_Sprint_Multiplier = getUserSettingWithDefault("Player_Sprint_Multiplier",Player_Sprint_Multiplier)
	Player_Run_Multiplier = getUserSettingWithDefault("Player_Run_Multiplier",Player_Run_Multiplier)
	Jump_Height = getUserSettingWithDefault("Jump_Height",Jump_Height)
	Double_Jump_Height = getUserSettingWithDefault("Double_Jump_Height",Double_Jump_Height)
	moddisabled = getUserSettingWithDefault("moddisabled",moddisabled)
	CurrentPOIDetectionRange = getUserSettingWithDefault("CurrentPOIDetectionRange",CurrentPOIDetectionRange)
	AutoCheckPOI = getUserSettingWithDefault("AutoCheckPOI",AutoCheckPOI)
	
	SetFlatFromSetting()
	
	GetScriptableSystemsContainer = Game.GetScriptableSystemsContainer()
	FastTravelSystem = GetScriptableSystemsContainer:Get('FastTravelSystem')
	FastTravelPoints = FastTravelSystem:GetFastTravelPoints()
	local mappinData = Game.GetMappinSystem():GetMappins(gamemappinsMappinTargetType.Map)
	
	mappedFastTravelPoint = {}
	for i=1, #FastTravelPoints do
		local point = FastTravelPoints[i]
		local position = ""
		local obj = {}
		for i=1, #mappinData do
			local pointmp = mappinData[i]
			if(pointmp.id.value  == point.mappinID.value) then
				--position = .."X : "..tostring(pointmp.worldPosition.x) .." Y : ".. tostring(pointmp.worldPosition.x) .." Z : ".. tostring(pointmp.worldPosition.x) 
				obj.position = pointmp.worldPosition
			end
		end
		obj.name = Game.GetLocalizedText(point:GetPointDisplayName())
		obj.markerref = GameDump(point:GetMarkerRef())
		obj.markerrefdata = point:GetMarkerRef()
		table.insert(mappedFastTravelPoint,obj)
	end
	
	
	
	
	
	
	if (currentSave.Variable["player"] == nil) then
		
		currentSave.Variable["player"]= {}
		
	end
	
	if (currentSave.Variable["player"]["current_gang"] == nil) then
		
		currentSave.Variable["player"]["current_gang"] = "faction_mox"
		
	end
	
	
	makeNativeSettings()
	
end
-- ----------------------------------------------------------------------
-------------------------------Var Loading-------------------------------
-- ---------------------------------------------------------------------------¸



-- ---------------------------------------------------------------------------
-- -------------------------------MAIN Function-------------------------------
-- ---------------------------------------------------------------------------

function setupCore() --Setup environnement (DatapackLoading, observer, overrider)
	
	
	GameUI.Listen(function(state)
		
		if(state.submenu == "Stats") then
		end
		if(state.isMenu) then
			inMenu = true
			ActiveMenu = state.menu
			ActiveSubMenu = state.submenu 
			if(ActiveSubMenu ~= "Shards") then
			firstexecutionshard = nil
			end
			else
			inMenu = false
			ActiveMenu = nil
			ActiveSubMenu = nil
			firstexecutionshard = nil
			AffinityPopupisShow = false
		end
	end)
	MasterVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MasterVolume")
	UIPopupsManager.Inititalize()
	playerDeltaPos = Vector4.new(0, 0, 0, 1)
	screenWidth, screenHight = GetDisplayResolution()
	windowPos = ((screenWidth / 4) *3) - 43
	targetS = Game.GetTargetingSystem()
	tp = Game.GetTeleportationFacility()
	SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
	playerDeltaPos = Vector4.new(0, 0, 0, 1)
	screenWidth, screenHight = GetDisplayResolution()
	windowPos = ((screenWidth / 4) *3) - 43
	targetS = Game.GetTargetingSystem()
	tp = Game.GetTeleportationFacility()
	SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
	DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
	MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
	CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
	SetOverrider()
	SetObserver()
	eventCatcher = sampleStyleManagerGameController.new()
	local datapackresult,datapackerror  = pcall(function()
	DatapackLoading()
	end)
	
	if datapackresult == false then
		
		
	logme(1,"!!!!! CYBERSCRIPT : ERROR IN DATAPACK LOADING" .. datapackerror)
		
end
		
	
	if(ModIsLoaded) then
		reloadDB()
		GameSession.StoreInDir('sessions')
		GameSession.Persist(currentSave, true)
		GameSession.OnLoad(function() 
			reloadDB()
			for k,v in pairs(mappinManager) do
				deleteMappinByTag(k)
			end
			isdead = false
			if(#currentSave.arrayAffinity > 0) then
				GameIsLoaded = true
				reloadCET = false
			end
			initCore()
			
		end) 
		initCore()
		
		CName.add("Available Quests")
	end
end
function DatapackLoading() --handle the loading and creation of cache for datapack in datapack
	
	local reader = dir("cache")
	
	--if there is existing cache
	if(reader ~= nil and #reader > 0 ) then
		debugPrint(2,getLang("compilefound"))
		
		
		
		
		local haveerror = false
		
		arrayDatapack = {}
		loadAssetsObject()
		
		local directories = {}
		
		
		--we load the directories from datapack
		local reader = dir("datapack")
		for i=1, #reader do 
			if(tostring(reader[i].type) == "directory") then
				
				table.insert(directories,reader[i].name)
			end
		end
		
		
		--for each directories
		for i,u in ipairs(directories) do
			
			-- we check if there is an existing cache
			local v = CompiledDatapack[u..".lua"]
			
			
			try {
				function()
					
					--if datapack cache is not good or doesn't exist, we create an new cache and added it to arrayDatapack
					if(v == nil or v.cachedata == nil or v.cachedata.CacheVersion== nil or v.cachedata.modVersion== nil  or v.cachedata.CacheVersion ~= cacheVersion or v.cachedata.modVersion ~= cyberscript.version) then
						if(file_exists("datapack/"..u.."/desc.json") == true) then
							ImportDataPackFolder(u)
							exportCompiledDatapackFolder(u,"Created Cache")
							debugPrint(2,u.." "..getLang("compileoutdated"))
							
						end
						
						else
						--if datapack cache is good, we added it to arrayDatapack from the compiled lua cache
						debugPrint(2,u.." "..getLang("compileuptodate"))
						arrayDatapack[u] = v
					end
					
					
					--if the desc.json doesnt exist
					if(file_exists("datapack/"..u.."/desc.json") == false) then
						
						
						--if there is no desc json but an cache,
						if(file_exists('cache/'..u..'.lua') == true) then
							--we delete the cache (means no datapack in the datapack folder)
							os.remove('cache/'..u..'.lua')
							debugPrint(2,u.." datapack no longer exist, deleting cache...")
							
						end
						
					end
					
					
					
					
					
					
				end,
				catch {
					function(error)
						debugPrint(1,getLang("datatpackimporterror").."("..u..")"..error)
						
						
						haveerror = true
					end
				}
			}
			
			
			
			
			
		end
		
		--if an error occur, we only load the default datapack
		if(haveerror == true) then
			
			--RecoverDatapack()
			
		end
		
		debugPrint(1,getLang("compileloaded"))
		
		else
		--if there is no cache, we create an new cache for each directories in datapack
		ImportDataPack()
	end
	
	
	
end
function initCore() --Setup session, external observer and trigger mod core loading
	isGameLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():IsPreGame()
	if GetMod('AppearanceMenuMod') then 
		AMM =  GetMod("AppearanceMenuMod")
		if(AMM.API ~= nil) then
			AMMversion = AMM.API.version
			print("Cyberscript : AMM Version founded : "..AMMversion)
			else
			AMM = nil
			print(getLang("ammoutdated"))
		end
		else 
		print(getLang("ammnotfound"))
		
	end
	
	
	resetVar()
	
	
	
	if GetMod('nativeSettings') then nativeSettings =  GetMod("nativeSettings") else debugPrint(1,getLang("nonattivesetting")) error(getLang("nonattivesetting")) end
	
	
	
	
	
	
	
	
	if(nativeSettings ~= nil and nativeSettings.data["CMDT"] ~= nil  ) then
		nativeSettings.data["CMDT"].options = {}
		else
		nativeSettings.addTab("/CMDT", "CyberScript Datapack Manager") -- Add our mods tab (path, label)
		nativeSettings.data["CMDT"].options = {}
	end
	
	
	
	
	

	tweakdbtable = {}
	
	
	
	
	debugPrint(2,"CyberScript version "..cyberscript.version..cyberscript.channel)
	debugPrint(1,"CyberScript Initialisation...")
	
	
	
	
	
	
	
	
	
	
	
	cyberscript.EnemyManager = {}
	cyberscript.FriendManager = {}
	cyberscript.NPCManager = {}
	cyberscript.EntityManager = {}
	cyberscript.GroupManager = {}
	
	testVehicule = {}
	currentdialogQuestList = {}
	currentdialogOptionList = {}
	arrayInteractEnable = {}
	-- --INIT VAR
	bgcolor = "5df6ff"
	draw = false
	next_ambush = 0
	nexttimer_ambush = 300
	setkillAggro = false
	setPassive = false
	enemy_count = 0
	currentMissionId = 0
	haveMission = false
	canTakeContract = false
	npcSpawned = false
	npcStarSpawn = false
	enemySpawned = false
	setStarFriend = false
	currentHostileFaction = ""
	getArrow = false
	isInHouse = false
	candrwMapPinFixer= true
	fixerCanSpawn = true
	nash_have_speak = false
	
	
	
	
	
	CheckandUpdateDatapack()
	LoadDataPackCache()
	SaveLoading()
	
	
	
	if file_exists("modules/editor.lua") then
		initEditor()
	end
	
	
	debugPrint(1,getLang("CyberScriptinit"))
	tick = 0
end
function inGameInit() -- init some function after save loaded
	--loadHUD()
	LoadDataPackCache()
	candrwMapPinFixer= false
	cancheckmission = true
	choiceHubData =  gameinteractionsvisInteractionChoiceHubData.new()
	choiceHubData.active =true 
	choiceHubData.flags = EVisualizerDefinitionFlags.Undefined
	choiceHubData.title = "possibleInteractList" --'Test Interaction Hub'
	
	loadUIsetting()
	
	theme = CPS.theme
	color = CPS.color
	cyberscript.GroupManager = {}
	cyberscript.EntityManager = {}
	Game.SetTimeDilation(0)
	
	doInitEvent()

	
	local entity = {}
	entity.id = Game.GetPlayer():GetEntityID()
	entity.tag = "player"
	entity.tweak = "player"
	cyberscript.EntityManager[entity.tag] = entity
	local entity1 = {}
	entity1.id = 0
	entity1.tag = "selection1"
	entity1.tweak = "selection1"
	cyberscript.EntityManager[entity1.tag] = entity1
	local entity2 = {}
	entity2.id = 0
	entity2.tag = "selection2"
	entity2.tweak = "selection2" 
	cyberscript.EntityManager[entity2.tag] = entity2
	local entity3 = {}
	entity3.id = 0
	entity3.tag = "selection3"
	entity3.tweak = "selection3"
	cyberscript.EntityManager[entity3.tag] = entity3
	local entity4 = {}
	entity4.id = 0
	entity4.tag = "selection4"
	entity4.tweak = "selection4"
	cyberscript.EntityManager[entity4.tag] = entity4
	local entity5 = {}
	entity5.id = 0
	entity5.tag = "selection5"
	entity5.tweak = "selection5"
	cyberscript.EntityManager[entity5.tag] = entity5
	
	
	
	draw = true
	
	despawnAll()
	--createInteraction(true)
	local blackboardDefs = Game.GetAllBlackboardDefs()
	local blackboardPSM = Game.GetBlackboardSystem():GetLocalInstanced(Game.GetPlayer():GetEntityID(), blackboardDefs.PlayerStateMachine)
	blackboardPSM:SetInt(blackboardDefs.PlayerStateMachine.SceneTier, 1, true) -- GameplayTier.Tier1_FullGameplay 
	Game.SetTimeDilation(0)

pcall(function()
	Game.GetSettingsSystem():GetVar("/gameplay/performance", "CrowdDensity"):SetValue("High")
end)
	debugPrint(1,getLang("seestarted"))
end
function shutdownManager() -- setup some function at shutdown
	
	CheckandUpdateDatapack()
	UIPopupsManager.ClosePopup()
	for k,v in pairs(mappinManager) do
		deleteMappinByTag(k)
	end
	debugPrint(10,"mappin deleted")
	
	despawnAll()
	resetVar()
	
	
	
	
	
	logme(2,"End Mod")
	
	collectgarbage()
end
function TweakManager() -- Load vehicles and change some TweakDB
	
		TweakDB:CloneRecord("Cyberscript.Player_Male", "Character.TPP_Player_Cutscene_Male")
		TweakDB:CloneRecord("Cyberscript.Player_Female", "Character.TPP_Player_Cutscene_Female")
		
		
		TweakDB:SetFlat("Cyberscript.Player_Male.entityTemplatePath", "base\\cyberscript\\ent\\player_ma_tpp.ent")
		TweakDB:SetFlat("Cyberscript.Player_Female.entityTemplatePath", "base\\cyberscript\\ent\\player_wa_tpp.ent")
		
		
	
  
	local f = assert(io.open("data/vehicles.json"))
	local lines = f:read("*a")
	local encdo = lines
	local tableDis = {}
	tableDis =json.decode(lines)
	vehiclelist = tableDis
	f:close()
	
	local unlockableVehicles = TweakDB:GetFlat(TweakDBID.new('Vehicle.vehicle_list.list'))
	
	for _, vehiclePath in ipairs(tableDis) do
		
		local targetVehicleTweakDbId = TweakDBID.new(vehiclePath)
		local isVehicleUnlockable = false
		
		for _, unlockableVehicleTweakDbId in ipairs(unlockableVehicles) do
			if tostring(unlockableVehicleTweakDbId) == tostring(targetVehicleTweakDbId) then
				isVehicleUnlockable = true
				break
			end
		end
		
		if not isVehicleUnlockable then
			table.insert(unlockableVehicles, targetVehicleTweakDbId)
		end
	end
	
	TweakDB:SetFlat('Vehicle.vehicle_list.list', unlockableVehicles)

	
	
	SetFlatFromSetting()
	
end


function SetFlatFromSetting()
	
	if(Player_Sprint_Multiplier ~= nil) then
	TweakDB:SetFlat("PlayerLocomotion.player_locomotion_data_Sprint_inline1.value", 6.5 * Player_Sprint_Multiplier)
	TweakDB:SetFlat("PlayerLocomotion.player_locomotion_data_Stand_inline1.value", 3.5 * Player_Run_Multiplier)
	TweakDB:SetFlat("PlayerLocomotion.JumpJumpHeightModifier.value", 1 * Jump_Height)
	TweakDB:SetFlat("PlayerLocomotion.DoubleJumpJumpHeightModifier.value", 2.6 * Double_Jump_Height)
	end
	
	
		TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
	
end
-- ------------------------------------------------------------------
-- -------------------------------Event-------------------------------
-- ------------------------------------------------------------------

registerForEvent("onInit", function()
	
	--TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
	JSON = dofile("external/json.lua")
	
	Observe('PlayerPuppet', 'OnAction',function(_,action)
			
			listenPlayerInput(action)
			
	end)
	
	loadExternal()
	cyberscript.var = dofile('modules/var.lua')
	cyberscript.observercontroller = dofile('modules/observer_call.lua')

	resetVar()
	ModInitialisation()
	setupCore()
	
end)
registerForEvent('onDraw', function()
	
	
	if(moddisabled == false) then
	windowsManager()
	end
	
end)
registerForEvent("onUpdate", function(delta)
		
		if(moddisabled == false) then
		
		
		if(hotreload == true and inMenu == false) then
			hotreload = false
			Game.GetPlayer():SetWarningMessage(getLang("CyberScript : Hot Reload in progress..."))
			loadModule()
			Game.GetPlayer():SetWarningMessage(getLang("CyberScript : Hot Reload finished !"))
			TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
		else
	
		if saveLocationEnabled then
			savePath(recordRotation,recordRelative,recordRotationOnly)
		end
		if playLocationEnabled then
			playPath()
			playtick = playtick+1
		end
		refresh(delta)
			
	
		end
		
		
		
		
		
		
		end
	
	

	
	
end)
registerForEvent("onShutdown", function()
	
	shutdownManager()
	
end)
registerForEvent("onOverlayOpen", function()
	overlayOpen = true
end)
registerForEvent("onOverlayClose", function()
	overlayOpen = false
end)
registerForEvent("onTweak", function()
	
	
	
	
	TweakManager()
	
	
	
	
	
end)


-- -------------------------------HotKey------------------------------
registerHotkey("cycleCustomInteract", "Cycle Custom Interact", function()
	cycleInteract()
end
)
registerHotkey("push", "push", function()
	objectDist = objectDist + 0.5
	debugPrint(10,objectDist)
end
)
registerHotkey("pull", "pull", function()
	objectDist = objectDist - 0.5
	debugPrint(10,objectDist)
end
)
registerHotkey("selectcurrentInteractGroup1", "Select 1 Interact Group", function()
	currentInteractGroupIndex = 1
	cycleInteractgroup()
end
)
registerHotkey("selectcurrentInteractGroup2", "Select 2 Interact Group", function()
	currentInteractGroupIndex = 2
	cycleInteractgroup()
end
)
registerHotkey("selectcurrentInteractGroup3", "Select 3 Interact Group", function()
	currentInteractGroupIndex = 3
	cycleInteractgroup()
end
)
registerHotkey("selectcurrentInteractGroup4", "Select 4 Interact Group", function()
	currentInteractGroupIndex = 4
	cycleInteractgroup()
end
)
registerHotkey("selectcurrentInteractGroup5", "Select 5 Interact Group", function()
	currentInteractGroupIndex = 5
	cycleInteractgroup()
end
)

registerHotkey("housingXp", "Housing : X+", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true				
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				objpos.x = objpos.x + 0.05
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingXm", "Housing : X-", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true							
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				objpos.x = objpos.x - 0.05
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingYp", "Housing : Y+", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				objpos.y = objpos.y + 0.05
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingYm", "Housing : Y-", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				objpos.y = objpos.y - 0.05
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingZp", "Housing : Z+", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				objpos.z = objpos.z + 0.05
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingZm", "Housing : Z-", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				objpos.z = objpos.z - 0.05
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingRollp", "Housing : Roll+", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				angle.roll = angle.roll + 5
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingRollm", "Housing : Roll-", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				angle.roll = angle.roll - 5
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingPitchp", "Housing : Pitch+", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				angle.pitch = angle.pitch +5
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingPitchm", "Housing : Pitch-", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				angle.pitch = angle.pitch -5
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingYawp", "Housing : Yaw+", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = entity:GetWorldPosition()
				local worldpos = Game.GetPlayer():GetWorldTransform()
				local qat = entity:GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				angle.yaw = angle.yaw + 5
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingYawm", "Housing : Yaw-", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				if(entity ~= nil) then
					local objpos = entity:GetWorldPosition()
					local worldpos = Game.GetPlayer():GetWorldTransform()
					local qat = entity:GetWorldOrientation()
					local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
					angle.yaw = angle.yaw - 5 
					updateItemPosition(selectedItem, objpos, angle, true)
					cetkeyused = false
				end
			end
		end
	end
end)
registerHotkey("housingMovetoPlayer", "Housing : Move To Player", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				local objpos = Game.GetPlayer():GetWorldPosition()
				local qat = Game.GetPlayer():GetWorldOrientation()
				local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
				updateItemPosition(selectedItem, objpos, angle, true)
				cetkeyused = false
			end
		end
	end
end)
registerHotkey("housingRemove", "Housing : Remove", function()
	if(cetkeyused == false)then
		if(selectedItem ~= nil) then
			local entity = Game.FindEntityByID(selectedItem.entityId)
			if(entity ~= nil) then		
				cetkeyused = true			
				for i =1, #currentSave.arrayPlayerItems do
					local mitem = currentSave.arrayPlayerItems[i]
					if(mitem.Tag == selectedItem.Tag) then
						Game.FindEntityByID(selectedItem.entityId):GetEntity():Destroy()
						debugPrint(10,"toto")
						updatePlayerItemsQuantity(mitem,1)
						deleteHousing(selectedItem.Id)
						local index = getItemEntityIndexFromManager(selectedItem.entityId)
						--despawnItem(selectedItem.Id)
						table.remove(currentItemSpawned,index)
						Cron.After(1, function()
							selectedItem = nil
						end)
					end
				end
				cetkeyused = false
				else
				debugPrint(10,"nope")
			end
		end				
	end
end)
registerHotkey("housingcycleplaced", "Housing : Cycle Through placed items", function()
	selectedItem = nil
	if(selectedItem == nil) then
		selectedItem = currentItemSpawned[currentselectedItemIndex]
		Game.GetPlayer():SetWarningMessage("Current Selected Item : "..currentItemSpawned[currentselectedItemIndex].Title)
		currentselectedItemIndex = currentselectedItemIndex+1
		if(currentselectedItemIndex > #currentItemSpawned) then
			currentselectedItemIndex = 1
		end
	end
end)
registerHotkey("hideCustomInteract", "Hide Custom Interact", function()
	hideInteract()
end
)
registerHotkey("saveLocationInput", "Save location to file in json/report", function()
	savelocation = {}
	savelocation.locations = {}
	savelocation.desc = "location_"..math.random(0,59656518543133)
	savelocation.isFor = ""
	savelocation.tag = desc
	local location = {}
	local inVehicule = false
	inVehicule = Game.GetWorkspotSystem():IsActorInWorkspot(Game.GetPlayer())
	location.x = curPos.x
	location.y = curPos.y
	location.z = curPos.z
	local qat = Game.GetPlayer():GetWorldOrientation()
	local angle = GetSingleton('Quaternion'):ToEulerAngles(qat)
	location.pitch = angle.pitch
	location.roll = angle.roll
	location.yaw = angle.yaw
	location.inVehicule = inVehicule
	location.Tag = currentDistricts2.Tag
	if currentDistricts2 ~= nil and #currentDistricts2.districtLabels >0 then
		for i, currentDistricts2 in ipairs(currentDistricts2.districtLabels) do
			if i == 1 then
				location.district = currentDistricts2
				else
				location.subdistrict = currentDistricts2
			end
		end
	end
	table.insert(savelocation.locations,location)
	local file = io.open("json/report/"..savelocation.desc..".json", "w")
	local stringg = JSON:encode_pretty(savelocation)
	debugPrint(10,stringg)
	file:write(stringg)
	file:close()
end
)


registerHotkey("toogleview", 'Toggle View', function()
	if lastView == nil or lastView == 1 then--Normal View
		local fppComp = Game.GetPlayer():GetFPPCameraComponent()
		fppComp:SetLocalPosition(Vector4:new(0.0, 0.0, 0.0, 1.0))
		local isFemale = GetPlayerGender()
		if isFemale == "_Female" then gender = 'Wa' else gender = 'Ma' end
		local headItem = string.format("Items.CharacterCustomization%sHead", gender)
		local ts = Game.GetTransactionSystem()
		local gameItemID = GetSingleton('gameItemID')
		local tdbid = TweakDBID.new(headItem)
		local itemID = gameItemID:FromTDBID(tdbid)
		if(AVisIn == false) then
			Game.EquipItemOnPlayer(headItem, "TppHead")
		end
		lastView = 2
		elseif lastView == 2 then -- 3rd Person View near
		local fppComp = Game.GetPlayer():GetFPPCameraComponent()
		fppComp:SetLocalPosition(Vector4:new(0.0, -3.0, 0, 1.0))
		local isFemale = GetPlayerGender()
		if isFemale == "_Female" then gender = 'Wa' else gender = 'Ma' end
		local headItem = string.format("Items.CharacterCustomization%sHead", gender)
		local ts = Game.GetTransactionSystem()
		local gameItemID = GetSingleton('gameItemID')
		local tdbid = TweakDBID.new(headItem)
		local itemID = gameItemID:FromTDBID(tdbid)
		if(AVisIn == false) then
			Game.AddToInventory(headItem, 1)
			Game.EquipItemOnPlayer(headItem, "TppHead")
		end
		lastView = 3
		elseif lastView == 3 then -- 3rd Person View far
		local fppComp = Game.GetPlayer():GetFPPCameraComponent()
		fppComp:SetLocalPosition(Vector4:new(0.0, -12.0, 1.5, 1.0))
		local isFemale = GetPlayerGender()
		if isFemale == "_Female" then gender = 'Wa' else gender = 'Ma' end
		local headItem = string.format("Items.CharacterCustomization%sHead", gender)
		local ts = Game.GetTransactionSystem()
		local gameItemID = GetSingleton('gameItemID')
		local tdbid = TweakDBID.new(headItem)
		local itemID = gameItemID:FromTDBID(tdbid)
		if(AVisIn == false) then
			Game.EquipItemOnPlayer(headItem, "TppHead")
		end
		lastView = 4
		elseif lastView == 4 then -- 3rd Person View very far
		local fppComp = Game.GetPlayer():GetFPPCameraComponent()
		fppComp:SetLocalPosition(Vector4:new(0.0, -22.0, 5.5, 1.0))
		local isFemale = GetPlayerGender()
		if isFemale == "_Female" then gender = 'Wa' else gender = 'Ma' end
		local headItem = string.format("Items.CharacterCustomization%sHead", gender)
		local ts = Game.GetTransactionSystem()
		local gameItemID = GetSingleton('gameItemID')
		local tdbid = TweakDBID.new(headItem)
		local itemID = gameItemID:FromTDBID(tdbid)
		if(AVisIn == false) then
			Game.EquipItemOnPlayer(headItem, "TppHead")
		end
		lastView = 1
	end
end)
