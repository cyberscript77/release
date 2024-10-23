

logme(1,"CyberScript Core Initialisation...")

local modLoaded = false



function loadexternal()
	

	inputManager = dofile('mod/modules/inputManager.lua')
	GameUI = dofile('mod/external/GameUI.lua')
	TargetingHelper = dofile('mod/external/TargetingHelper.lua')
	AIControl = dofile('mod/external/AIControl.lua')
	GameHUD = dofile('mod/external/GameHUD.lua')
	GameSettings = dofile('mod/external/GameSettings.lua')
	IGE = dofile('mod/external/ImGuiExtension.lua')
	Cron = dofile('mod/external/Cron.lua')
	Ref = dofile('mod/external/Ref.lua')
	EventProxy = dofile('mod/external/EventProxy.lua')
	UIPopupsManager = dofile('mod/external/UIPopupsManager.lua')
	UIScroller = dofile('mod/external/UIScroller.lua')
	UIButton = dofile('mod/external/UIButton.lua')
	GameSession = dofile('mod/external/GameSession.lua')
	CPStyling =  dofile('mod/external/cpstyling.lua')
	CPS =  CPStyling:New()
	RES_slot =  dofile('mod/external/attachment-slots.lua')
	RES_attributes =  dofile('mod/external/attributes.lua')
	RES_crafting =  dofile('mod/external/crafting-components.lua')
	RES_area =  dofile('mod/external/equipment-areas.lua')
	RES_perks =  dofile('mod/external/perks.lua')
	RES_perksalias =  dofile('mod/external/perks-by-alias.lua')
	RES_skills =  dofile('mod/external/skills.lua')
	RES_TweakDB =  dofile('mod/external/tweakdb-ids.lua')
	RES_TweakDBmeta =  dofile('mod/external/tweakdb-meta.lua')
	
	LVector = dofile("mod/external/Vector2")
	if GetMod('corruptNCPD') then 
	
	CorruptNCPDLang =  dofile('mod/external/CorruptNCPDLang.lua')
	end
end

-- logme(2,"Start Mod")







function ModInitialisation()

	
	
	--version of compiled cache
	cacheVersion = 3
	
	
	--print("test")
	
	currentSave = {}
	currentSave.Score = {}
	currentSave.Variable = {}
	currentSave.Variable["Affinity"] = {}
	
	currentSave.arrayPlayerData = {}
	currentSave.arrayAffinity = {}
	currentSave.arrayQuestStatut = {}
	currentSave.arrayFactionScore = {}
	arrayUserSetting = {}
	arrayUserInput = {}
	arrayUserInput = {
		["cyberscriptOpenGroup"] =
			{
				["keyboard"]=
					{
						["key_1"] = "IK_Pad_DigitLeft", -- Key 1' keycode of the "mkbBinding"
						["key_2"] = "IK_Pad_DigitLeft",
						["key_3"] = "IK_Pad_DigitLeft",
						["hold_1"] = true, -- Is Key 1 of the "mkbBinding" a hold down key?
						["hold_2"] = false,
						["hold_3"] = false,
						["keys"] = 1 -- How many of the keys are currently being used for the binding "mkbBinding"?
					},
				["gamepad"]=
					{
						["key_1"] = "IK_Pad_DigitLeft", -- Key 1' keycode of the "mkbBinding"
						["key_2"] = "IK_Pad_DigitLeft",
						["key_3"] = "IK_Pad_DigitLeft",
						["hold_1"] = true, -- Is Key 1 of the "mkbBinding" a hold down key?
						["hold_2"] = false,
						["hold_3"] = false,
						["keys"] = 1 -- How many of the keys are currently being used for the binding "mkbBinding"?
					}
			}
	}
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
	SetObserver()
	
	interactionUI_init()
	
	if file_exists("editor/editor.lua") then
	
		
		cyberscript.editor2_variable = dofile('editor/editor_variable.lua')
	end
	
	CompiledDatapack = {}
	
	
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
	arrayVehicles2 = {}
	arrayVehicles = initVehicles()
	
	unlockVehicles(initVehicles())
	arrayDistricts = initDistrict()
	arrayFastTravel = initFastTravel()
	arrayGameSounds = initGameSounds()
	arrayAttitudeGroup = initAttitudeGroup()
	
	
	if #currentSave.arrayAffinity == 0 then
		reloadCET = false
		if file_exists("user/sessions/latest.txt") then
			nodata = false
			GameSession.readLatest()
			logme(1,"CyberScript Session : data found, recover latest data")
			else
			nodata = true
			
		end
	end
	
	
	
	
	if GameIsLoaded == true and #currentSave.arrayAffinity > 0 then
		loadUIsetting()
	end

	
	
	if #currentSave.garage > 0 then
		for i=1, #currentSave.garage do
			Game.GetVehicleSystem():EnablePlayerVehicle(currentSave.garage[i].path, true, false)
		end
	end
	
	arrayUserSetting = {}
	
	if file_exists("user/settings/cyberscript.json") then
		local f = io.open("user/settings/cyberscript.json")
		lines = f:read("*a")
		if lines ~= "" then
			local json = json.decode(lines)
			arrayUserSetting = json
		end
		f:close()
		
	end
	
	
	arrayUserInput = {
		["cyberscriptOpenGroup"] =
			{
				["keyboard"]=
					{
						["key_1"] = "IK_Pad_DigitLeft", -- Key 1' keycode of the "mkbBinding"
						["key_2"] = "IK_Pad_DigitLeft",
						["key_3"] = "IK_Pad_DigitLeft",
						["hold_1"] = true, -- Is Key 1 of the "mkbBinding" a hold down key?
						["hold_2"] = false,
						["hold_3"] = false,
						["keys"] = 1 -- How many of the keys are currently being used for the binding "mkbBinding"?
					},
				["gamepad"]=
					{
						["key_1"] = "IK_Pad_DigitLeft", -- Key 1' keycode of the "mkbBinding"
						["key_2"] = "IK_Pad_DigitLeft",
						["key_3"] = "IK_Pad_DigitLeft",
						["hold_1"] = true, -- Is Key 1 of the "mkbBinding" a hold down key?
						["hold_2"] = false,
						["hold_3"] = false,
						["keys"] = 1 -- How many of the keys are currently being used for the binding "mkbBinding"?
					}
			}
	}




	if file_exists("user/settings/userinput.json") then
		local f = io.open("user/settings/userinput.json")
		lines = f:read("*a")
		if lines ~= "" then
			local json = json.decode(lines)
			arrayUserInput = json
		end
		f:close()
		
	end

	
	moddisabled = getUserSettingWithDefault("moddisabled",moddisabled)
	
	currentController = getUserSettingWithDefault("currentController",currentController)
	currentControllerName = "Keyboard"
	currentControllerid = "keyboard"

	if(currentController == true)then
		currentControllerName = "Gamepad"
		currentControllerid = "gamepad"
	end

	

	AmbushMin = getUserSettingWithDefault("AmbushMin",AmbushMin)
	CurrentPOIDetectionRange = getUserSettingWithDefault("CurrentPOIDetectionRange",CurrentPOIDetectionRange)
	

	enableCustomQuest =  getUserSettingWithDefault("enableCustomQuest",enableCustomQuest)
	AutoRefreshDatapack = getUserSettingWithDefault("AutoRefreshDatapack",AutoRefreshDatapack)
	
	Player_Sprint_Multiplier = getUserSettingWithDefault("Player_Sprint_Multiplier",Player_Sprint_Multiplier)
	Player_Run_Multiplier = getUserSettingWithDefault("Player_Run_Multiplier",Player_Run_Multiplier)
	Jump_Height = getUserSettingWithDefault("Jump_Height",Jump_Height)
	Double_Jump_Height = getUserSettingWithDefault("Double_Jump_Height",Double_Jump_Height)
	Immortal = getUserSettingWithDefault("Immortal",Immortal)
	InfiniteStaminas = getUserSettingWithDefault("InfiniteStaminas",InfiniteStaminas)

	RamUpgrade = getUserSettingWithDefault("RamUpgrade",RamUpgrade)

	OpticalCamo = getUserSettingWithDefault("OpticalCamo",false)
	
	
	debugLog = getUserSettingWithDefault("debugLog",debugLog)
	showcyberscriptfixeronmap = getUserSettingWithDefault("showcyberscriptfixeronmap",showcyberscriptfixeronmap)
	
	logrecordlevel = getUserSettingWithDefault("logrecordlevel",logrecordlevel)

	holdTime = getUserSettingWithDefault("holdTime",holdTime)
	
	
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

	if (currentSave.Variable["game"] == nil) then
		currentSave.Variable["game"] ={}
		

	end
	if (currentSave.Variable["game"]["loaded_gang_affinity"] == nil) then
		
		currentSave.Variable["game"]["loaded_gang_affinity"] = true
		GangAffinityCalculator()
		initGangRelation()
		initGangDistrictScore()

	end

	
	loadModule()
	
	makeNativeSettings()
	print("save me")
end
-- ----------------------------------------------------------------------
-------------------------------Var Loading-------------------------------
-- ---------------------------------------------------------------------------¸



-- ---------------------------------------------------------------------------
-- -------------------------------MAIN Function-------------------------------
-- ---------------------------------------------------------------------------

function setupCore() --Setup environnement (DatapackLoading, observer, overrider)
	
	inputManager.onInit()
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
			if(GameController["NewHudPhoneGameController"] ~= nil and GameController["NewHudPhoneGameController"]:IsA('NewHudPhoneGameController') and GameController["NewHudPhoneGameController"]:IsPhoneActive() == true) then
				inMenu = true
				ActiveMenu = "Phone"
				ActiveSubMenu = "Phone"
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
		end
		
	end)
	MasterVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MasterVolume")
	UIPopupsManager.Inititalize()
	playerDeltaPos = Vector4.new(0, 0, 0, 1)
	cyberscript.language = Game.GetSettingsSystem():GetVar("/language", "OnScreen"):GetValue().value
	targetS = Game.GetTargetingSystem()
	tp = Game.GetTeleportationFacility()
	SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
	playerDeltaPos = Vector4.new(0, 0, 0, 1)
	screenWidth, screenHight = GetDisplayResolution()
	windowPos = ((screenWidth / 4) *3) - 43
	
	tp = Game.GetTeleportationFacility()
	SfxVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "SfxVolume")
	DialogueVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "DialogueVolume")
	MusicVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "MusicVolume")
	CarRadioVolume = Game.GetSettingsSystem():GetVar("/audio/volume", "CarRadioVolume")
	SetOverrider()
	SetObserver()
	
	interactionUI_init()
	
	eventCatcher = sampleStyleManagerGameController.new()
	
		
	
	if(ModIsLoaded) then
		reloadDB()
		GameSession.StoreInDir('user/sessions')
		GameSession.Persist(currentSave, true)
		GameSession.OnLoad(function() 
			reloadDB()
			inputManager.onShutdown()
			for k,v in pairs(mappinManager) do
				deleteMappinByTag(k)
			end
			isdead = false
			if(#currentSave.arrayAffinity > 0) then
				GameIsLoaded = true
				reloadCET = false
			end
			inputManager.onInit()
			initCore()
			
		end) 
		initCore()
		
		CName.add("Available Quests")
	end
end

function DatapackLoading() --handle the loading and creation of cache for datapack in datapack
	
	
		
		
		
		local haveerror = false
		
		
		loadAssetsObject()
		ImportDataPack()
	
	
	
	
end
function initCore() --Setup session, mod/external observer and trigger mod core loading
	isGameLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():IsPreGame()
	if GetMod('AppearanceMenuMod') then 
		AMM =  GetMod("AppearanceMenuMod")
		if(AMM.API ~= nil) then
			AMMversion = AMM.API.version
			print("Cyberscript : AMM Version founded : "..AMMversion)
			else
			AMM = nil
			print("Cyberscript : AMM outdated !")
		end
		else 
		print("Cyberscript : AMM not found !")
		
	end
	
	
	resetVar()
	
	
	
	if GetMod('nativeSettings') then nativeSettings =  GetMod("nativeSettings") else logme(1,getLang("nonattivesetting")) error(getLang("nonattivesetting")) end
	
	
	
	
	
	
	
	
	
	
	
	
	

	tweakdbtable = {}
	
	
	
	
	logme(2,"CyberScript version "..cyberscript.version..cyberscript.channel)
	logme(1,"CyberScript Initialisation...")
	
	
	
	
	
	
	
	
	
	
	
	cyberscript.EnemyManager = {}
	cyberscript.FriendManager = {}
	cyberscript.NPCManager = {}
	cyberscript.EntityManager = {}
	cyberscript.GroupManager = {}
	cyberscript.PositionManager = {}
	
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
	
	
	
	
	
	LoadDataPackCache()
	SaveLoading()
	
	
	
	if file_exists("modules/editor.lua") then
		initEditor()
	end
	
	
	logme(1,getLang("CyberScriptinit"))
	tick = 0
end


function shutdownManager() -- setup some function at shutdown
	
	UIPopupsManager.ClosePopup()
	for k,v in pairs(mappinManager) do
		deleteMappinByTag(k)
	end
	logme(10,"mappin deleted")
	inputManager.onShutdown()
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
		
		
	
  
	local f = assert(io.open("mod/data/vehicles.json"))
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
	
	
		
		if(RamUpgrade ~= nil and RamUpgrade == true) then
				
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline1.value", 1000)
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline4.value", 50)

			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline2.floatValues", {1000})
			TweakDB:SetFlat("Items.AdvancedRamUpgradeLegendaryPlusPlus_inline5.floatValues", {50})
		end


		if(OpticalCamo ~= nil and OpticalCamo == true) then
				
			TweakDB:SetFlat("BaseStatusEffect.OpticalCamoPlayerBuffLegendary_inline1.value", 30)
			TweakDB:SetFlat("BaseStatusEffect.OpticalCamoPlayerBuffEpic_inline1.value", 30)
			TweakDB:SetFlat("BaseStatusEffect.OpticalCamoPlayerBuffRare_inline1.value", 30)
		  
			TweakDB:SetFlat("BaseStatusEffect.OpticalCamoLegendaryCooldown_inline1.value", 1)
			TweakDB:SetFlat("BaseStatusEffect.OpticalCamoCooldown_inline1.value",1)
		  
			TweakDB:SetFlat("Items.OpticalCamoLegendary_inline2.intValues", 1)
			TweakDB:SetFlat("Items.OpticalCamoEpic_inline2.intValues", 30)
			TweakDB:SetFlat("Items.OpticalCamoRare_inline2.intValues", 30)
		end
	


end
-- ------------------------------------------------------------------
-- -------------------------------Event-------------------------------
-- ------------------------------------------------------------------

registerForEvent("onInit", function()
	arrayDatapack = {}
	currentControllerid = "keyboard"
	currentControllerName = "Keyboard"
	--TweakDB:SetFlat("PreventionSystem.setup.totalEntitiesLimit", 999999)
	JSON = dofile("mod/external/json.lua")
	
	Observe('PlayerPuppet', 'OnAction',function(_,action)
			
			listenPlayerInput(action)
			
	end)
	holdTime = 1
	loadexternal()
	
	cyberscript.var = dofile('mod/modules/var.lua')
	interactionUI = dofile("mod/modules/interactionUI")
	cyberscript.observercontroller = dofile('mod/modules/observer_call.lua')
	
	if GetMod('AppearanceMenuMod') then 
		AMM =  GetMod("AppearanceMenuMod")
		if(AMM.API ~= nil) then
			AMMversion = AMM.API.version
			print("Cyberscript : AMM Version founded : "..AMMversion)
			else
			AMM = nil
			print("Cyberscript : AMM outdated !")
		end
		else 
		print("Cyberscript : AMM Not found !")
		
	end
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
			
			
			inputManager.onUpdate(delta)
			refresh(delta)
			interactionUI.update()
		
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



registerHotkey('OpenInteractMenu', 'Open Interact Menu (CET mode)', function()
	cycleInteract2()
end)

