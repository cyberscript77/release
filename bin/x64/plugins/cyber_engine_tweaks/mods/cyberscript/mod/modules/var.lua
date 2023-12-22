--print("CyberScript: global variable loaded")
cyberscript.module = 1
cyberscript.module = cyberscript.module +1


--functions
function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			s = s .. '['..k..'] = ' .. dump(v) .. ','
		end
		return s .. '} '
		else
		return tostring(o)
	end
end

function catch(what)
	return what[1]
end

function try(what)
	status, result = pcall(what[1])
	if not status then
		what[2](result)
	end
	return result
end

function trydecodeJSOn(text, file,path)
	local jsontext = nil
	if(path == nil) then
		path = "Unknown"
	end
	try {
		function()
			jsontext = json.decode(text)
			
		end,
		catch {
			function(error)
				
				logme(1,'Error decoding JSON : '..error.." ( path : "..path,true)
				file:close()
			end
		}
	}
	return jsontext
end


function Enume(t)
	local e = { enums = t }
	return setmetatable(e, enummt)
end

function isSameInstance(a, b)
	return Game['OperatorEqual;IScriptableIScriptable;Bool'](a, b)
end


function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
	
    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
		else
        --table.sort(keys)
	end
	
    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
		end
	end
end

function getMainStash()
	
	local stashId = NewObject('entEntityID')
	stashId.hash = ""
	
	return Game.FindEntityByID(stashId)
	
	
end

function Delta(from, to)
    return Vector4.new(to.x - from.x, to.y - from.y, to.z - from.z, to.w - from.w)
end

function Vector4Add(a, b)
	return Vector4.new(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
end







function resetVar()
	
	
	cyberscript.soundmanager={} 
	
	
	
	editorAnimName = "add__stand__2h_front__01__dynamic"
	editorAnimRepo = "man_base"
	editorAnimTag = "lookatnpc"
	editorEntName = "base\\amm_workspots\\entity\\workspot_anim.ent"
	editorWKName = "amm_workspot_custom_base"
	editorAnimx = 0
	editorAnimy = 0
	editorAnimz = 0
	
	animsearch = ""
	forcecrashSEE = false
	recordRotationOnlypos = {}
	
	recordRotationOnlypos.x = 0
	recordRotationOnlypos.y = 0
	recordRotationOnlypos.z = 0
	
	hotreload = false
	ScrollSpeed = 0.020
	ScriptedEntityAffinity = false
	AmbushMin = 5 
	AmbushMax = 10
	AmbushEnabled = true
	AutoAmbush = true
	GangWarsEnabled = true
	AutoRefreshDatapack = true
	displayXYZset = false
	playerNoticed = false
	playerTargeted = false
	entityTargetPlayer = {}
	displayHUD = {}
	CurrentPOIDetectionRange = 10
	AutoCheckPOI = true
	editorCurrentVariableSearch = ""
	editorCurrentVariableKeySearch = ""
	PlayerisHitten = false
	spawntablecount = {}
	moddisabled = false
	cachedespawn = {}
	
	poi_district = {}
	poi_subdistrict = {}
	poi_type = {}
	poi_tag = {}
	
	
	anim_rigs_list = {}
	
	
	 currentObjectiveId = 0
	 
	
	
	
	local reader = dir("mod/data/anims/workspot")
	if(reader ~= nil) then
		for i=1, #reader do 
			if(tostring(reader[i].type) == "file" and string.match(tostring(reader[i].name), ".json")) then
				local f = assert(io.open("mod/data/anims/workspot/"..reader[i].name))
				
				lines = f:read("*a")
				
				encdo = lines
				f:close()
				
				
				local mytable = trydecodeJSOn(encdo, f ,"mod/data/anims/workspot/"..reader[i].name)
				anim_rigs_list[reader[i].name:gsub(".json", "")] = mytable
				
				
			end
		end
	end
	
	
	
	
	datapackObjectType = { 
		"character",
		"circuit",
		"codex",
		"corpo",
		"choice",
		"event",
		"faction",
		"fixer",
		"functions",
		"help",
		"housing",
		"housing_template",
		"hud",
		"interact",
		"interfaces",
		"lang",
		"mission",
		"node",
		"npc",
		"path",
		"phone_dialog",
		"place",
		"poi",
		"radio",
		"scene",
		"setting",
		"shard",
		"sound",
		"texture",
		"webpage",
		"email",
		"quickhack",
		"garage",
		"ai",
		"aitemplate"
		
	}
	cacheupdate = false
	passwordView =ImGuiInputTextFlags.Password
	menuName = "CyberScript"
	debugPrintLevel = 5
	showLog = false
	onlineInstanceCreation = false
	onlineGuildCreation = false
	onlineInstanceUpdate = false
	onlineGuildUpdate = false
	togglehousing = true
	onlineInstancePlaceCreation = false
	onlineShootMessage = false
	CreateInstance={}
	CreateGuild={}
	CreateInstancePlace={}
	UpdateInstance={}
	UpdateGuild={}
	instancePrivacy ={ "Public", "Private", "Secret (Private with password)"}
	CurrentFriendTag =""
	selectedUser = {}
	selectedGuild = {}
	selectedGuildUser = {}
	selectedUser.data = {}
	currentPlaceTag = {}
	selectedFriend = {}
	selectedFriend.data = {}
	settingsTables = {}
	pox = 0
	poy = 0
	JackFlightJackFlight = false
	poz = 0
	sliderPathTarget = 1 
	recorderEntity = "player"
	recorderPlayerCamera = false
	recorderEntityList ={ "player", "mounted_vehicle","player_entity","player_camera" }
	pathPlayerEntityList ={ "player", "mounted_vehicle","editor_cam","lookat" }
	scenepov ={ "free", "entity" }
	scenepovtype = "free"
	editorcam = false
	loadInteract = {}
	moveX=0
	moveY=0
	moveZ=0
	debugOptions= false
	currentInterfaceWidget= {}
	
	arrayItems = {}
	arrayPnjDb = {}
	arrayPhoneNPC = {}
	
	
	arrayBoundedEntity = {}
	logrecordlevel =3
	currentScannerItem = nil
	currentScannerEntity = nil
	
	
	
	contractTypeLevel = 3 -- gameJournalQuestType.Contract
	maxNestedLevel = 7
	
	fetcheddata = nil
	npcpreventionlimit = 99999
	
	editHousingTemplateX = 0
	editHousingTemplateY = 0
	editHousingTemplateZ = 0
	
	editHousingTemplateYaw = 0
	editHousingTemplatePitch = 0
	editHousingTemplateRoll = 0
	
	editPOIlocation = ""
	
	editorCurrentScore = ""
	editorCurrentScoreKey = ""
	editorCurrentScoreValue = 0
	
	
	editorCurrentVariable = ""
	editorCurrentVariableKey = ""
	editorCurrentVariableValue = ""
	
	pathOffsetX = 0
	pathOffsetY = 0
	pathOffsetZ = 0
	enableCustomQuest = true
	InfiniteDoubleJump = false
	numberOfMultiJumps = 100
	DisableFallDamage = false
	Immortal = false
	InfiniteStaminas = false
	InfiniteAmmo = false
	RamUpgrade = false
	
	Player_Sprint_Multiplier = 1	--Default is 1 IMPORTANT as of 1.3, movement speed is capped somewhere.
	Player_Run_Multiplier = 1 --Default 1
	Jump_Height = 1 --Default 1
	Double_Jump_Height = 1 --Default 1
	UltraSpeedDodge = false
	UnlimitedCarryLimit = false
	CurrentStock = nil
	moveRoll=0
	movePitch=0
	moveYaw=0
	
	currentScene = nil
	tempdatapack = nil
	playerisstopped = false
	id = false
	enabled = false
	grabbed = false
	objPush = false
	objPull = false
	target = nil
	grabbedTarget = nil
	testObject = nil
	playerOldPos = nil
	objectDist = 0
	interactautohide = true
	reloadCET = false
	ambush_limit_min = 15000 -- 5min15
	ambush_limit_max = 30000 -- 10min30
	AutoRefreshDatapack = false
	updateinprogress = false
	updatefinished = false
	currentInputHintList = {}
	needupdate = false

	arrayroom = {}
	arrayNPCInteract ={}
	cyberscript.customHouse = true
	initFinished = false
	saveLocationEnabled = false
	locationWindowsIsVisible = true
	fixerIsSpawn = false
	isFadeIn = false
	canwaitend = false
	ExecPauseMenu = false
	testTag = ""
	isReady = false
	currentTime = {}
	phonedFixer = false
	currentreason = 4
	isdead = false
	inMenu = false
	ActiveMenu = nil
	ActiveSubMenu = nil
	inScanner = false
	targetObject = nil
	currentPhoneCall = nil
	activeMetroDisplay = false
	freezeCamera = false
	TakeAIVehicule = false
	objLook = nil
	objLookIsVehicule = false
	interactKey = false
	cetkeyused = false
	nextkey = false
	multiName = ""
	editorView = {}
	editorView.x = 0
	editorView.y = 0
	editorView.z = 0
	editorView.roll = 0
	editorView.pitch = 0
	editorView.yaw = 0
	editorFreeze = false
	pitch = 0
	yaw = 0
	AlwaysShowDefaultWindows = 1
	SoundManager = nil
	fademessage = "Never Fade Away..."
	opacity = 1
	next_ambush = 0
	isGameLoaded = false
	nopes = {}
	nope = {}
	ModIsLoaded = true
	SaveisLoaded = false
	cyberscript.soundpath = "json\\datapack\\"
	cyberscript.autoload = false
	tick = 0
	ticktimer = 0
	cetVer = 1.12
	pcWasOpen = false
	LastChoiceActionName  = nil
	inputInAction = false
	ActivecustomMappin = nil
	ActiveFastTravelMappin = nil
	SelectedMappinHouse = nil
	SelectedMappinMetro = nil
	SelectedScriptMappin = nil
	isdialogactivehub = false
	candisplayInteract = true
	forcedialog = false
	myobs = {}
	myDialogHubLogicController = {}
	lastHubId = 0
	nativeSettings = nil
	nativesettingEnabled = false
	Keystone_currentSelectedDatapack = nil
	recordingMode = false
	BrowserCustomPlace = nil
	mpvehicletick = 0
	BraindanceGameController = nil
	locationWindowsX = 35
	locationWindowsY = 355
	
	currentHouseCenter = nil
	newHousingTemplateTag = ""
	newHousingTemplateName = ""
	newHousingTemplatePrice = 0
	newHousingTemplateDescription = ""
	newHousingTemplateTarget = ""
	
	menuWindowsX = 400
	menuWindowsY = 200
	currentHousingTemplate = nil
	currentHousingTemplatetag = ""
	currentHousing = nil
	currentHousingtag=""
	menuFrameX = 400
	menuFrameY = 200
	
	menuBTNX = 180
	menuBTNY = 150
	
	menuRowX = menuFrameX
	menuRowY = 150
	
	menufont= 1.5
	currentselectedItemIndex = 1
	currentInterface = nil
	
	choiceHubData = nil
	
	currentpoi = nil
	
	onlineReceiver =  nil
	onlineMessageContent =  ""
	onlineMessagePopup = false
	onlineWhisperPopup = false
	onlineMessagePopupFirstUse = true
	
	
	gameStatModifierType = {"Additive","AdditiveMultiplier","Multiplier"}
	newgroupinteractUI =true
	
	currentLoadedTexture = {}
	
	currentHelp = nil
	currentHelpIndex = 1
	local phonewaitmessage = "Connecting to 10.5.6.189.."
	local animcounter = 0
	local tranpsarency = 0
	openHelpMenu = false
	openHelp = false
	openJournalMenu = false
	inputquest = "joytoy_quest_radiant"
	inputscore = "myscore"
	inputvariable = "myvariable"
	inputkey = "mykey"
	openInterface = false
	defaultIsOpen = true
	currentDialogHub = nil
	currentInteractionHub = nil
	currentPossibleInteractChunkIndex = 1
	possibleInteractdisplay = {}
	isGodMod = false
	lastTargetKilled = nil
	irpmenu = {}
	possibleinteractchunk = {}
	irpmenu.main = true
	
	irpmenu.contact = false
	irpmenu.fixer = false
	irpmenu.service = false
	
	irpmenu.social = false
	irpmenu.address = false
	irpmenu.radio = false
	
	irpmenu.tools = false
	irpmenu.multi = false
	irpmenu.editor = false
	
	canLoadDtpckMenu = true
	
	waiting = false
	mainwait = false
	firstload = true
	
	firstloadMission = true
	firstloadMarket = true
	initfinish = false
	ItemsCart = {}
	CartPrice = 0
	
	query = ""
	querycat = ""
	
	netontracthub = {}
	netontracthub.login = true
	netontracthub.register = false
	netontracthub.main = false
	RememberMe = false
	
	
	AvatarList = {}
	currentRole = ""
	currentbranch = ""
	currentFaction = ""
	currentFactionRank = ""
	possiblebranch = {}
	VBodyComponents = {"l0_003_pwa_pants__leggins7303", "l1_004_pma_pants__sweatpants8832", "l1_004_pwa_pants__sweatpants1663", "l1_006_pma_pants__stoop_king8208", "l1_006_pwa_pants__stoop_king6174", "l1_008_pma_shorts__long8821", "l1_008_pwa_shorts__long6811", "l1_011_pma_skirt__tight1732", "l1_044_pma_pants__panties", "l1_011_pwa_skirt__tight0028", "l1_096_pwa_shorts__micro_thong", "l1_012_pma_pants__jeans_tight4118", "l1_012_pwa_pants__jeans_above_ankle8405", "l1_012_pwa_pants__jeans_tight7860", "l1_013_pma_shorts__small4307", "l1_013_pwa_shorts__small0548", "l1_021_pma_pants__cargo_computer", "l1_021_pwa_pants__cargo_computer7114", "l1_021_pwa_pants__cargo_computer", "l1_022_pma_pants__suit_belt5255", "l1_025_pma_pants__leather3476", "l1_034_pma_pants__scavenger6036", "l1_034_pwa_pants__scavenger4728", "l1_045_pma_pants__suit0076", "l1_045_pwa_pants__suit2855", "l1_047_pwa_shorts__panties7731", "l1_049_pma_shorts__boxers6361", "l1_052_pma_pants__suit_paulnight8641", "l1_054_pma_shorts__latino8283", "l1_054_pwa_shorts__latino4138", "l1_061_pma_pants__chaps_farmer5718", "l1_061_pwa_pants__chaps_farmer6443", "l1_062_pma_pants__jeans6487", "l1_063_pwa_pants__leather3162", "l1_065_pma_pants__pockets6523", "l1_065_pwa_pants__pockets7734", "l1_066_pwa_pants__rogue7706", "l1_068_pma_pants__racing_right7166", "l1_068_pma_pants__racing_right_harness_074", "l1_068_pma_pants__racing_right_012_01", "l1_068_pwa_pants__racing_right_012_01", "l1_068_pwa_pants__racing_right_harness_074", "l1_068_pwa_pants__racing", "l1_069_pma_shorts__torn_shorts3371", "l1_069_pwa_shorts__torn_shorts5467", "l1_070_pma_pants__loose 1305", "l1_070_pwa_pants__loose 5137", "l1_077_pma_pants__trauma_small0585", "l1_077_pwa_pants__trauma_small5157", "l1_078_pma_pants__militech5364", "l1_078_pwa_pants__militech6668", "l1_081_pwa_pants__suit8188", "l1_084_pma_skirt__misty8388", "l1_084_pwa_skirt__misty6640", "l1_087_pma_pants__ninja6302", "l1_087_pwa_pants__ninja2367", "l1_088_pma_pants__sergeant1676", "l1_088_pwa_pants__sergeant3237", "l1_091_pma_pants__silverhand5016", "l1_091_pwa_pants__silverhand3762", "a0_005_ma__strongarms_int_r", "a0_005_ma__strongarms_r", "a0_005_ma__strongarms_cyberware_r", "a0_005_ma__strongarms_cyberware_l", "a0_005_ma__strongarms_int_l", "a0_005_ma__strongarms_l", "a0_005_wa__strongarms_cyberware_l", "a0_005_wa__strongarms_l", "a0_005_wa__strongarms_int_l", "a0_005_wa__strongarms_cyberware_r", "a0_005_wa__strongarms_r", "a0_005_wa__strongarms_int_r", "a0_005_wa__strongarms_holstered_personal_link_dec_l3001", "a0_005_wa__strongarms_personal_link_dec_l4456", "a0_001_wa__personal_link_port", "a0_001_ma__personal_link", "a0_001_ma__personal_link_default6377", "a0_001_pma_cyber__silverhand_overlay", "a0_001_wa__personal_link_prototype", "a0_001_wa__personal_link_port_decal1800", "a0_002_ma__monowire_whip_l", "a0_002_ma__monowire_whip_r", "a0_002_wa__monowire_whip_l_cableless", "a0_002_wa__monowire_whip_r_cableless", "a0_002_wa__monowire_left_arm_prototype", "a0_002_wa__monowire_left_whip_prototype", "a0_002_wa__monowire_right_arm_prototype", "a0_002_wa__monowire_right_whip_prototype", "a0_003_ma__mantisblade_left", "a0_003_ma__mantisblade_right", "a0_003_ma__mantisblades_right", "a0_003_ma__mantisblades_left", "SkinnedMesh8480", "SkinnedMesh3815", "a0_004__weapon_grip_device0226", "a0_004__weapon_grip_decal_01", "a0_005_ma__strongarms_holstered_cyberware_r", "a0_005_ma__strongarms_holstered_r", "a0_005_ma__strongarms_holstered_cyberware_l", "a0_005_ma__strongarms_holstered_l", "a0_005_wa__strongarms_holstered_r", "a0_005_wa__strongarms_holstered_cyberware_r", "a0_005_wa__strongarms_holstered_l", "a0_005_wa__strongarms_holstered_cyberware_l", "a0_005_wa__strongarms_photo_mode_r", "a0_005_wa__strongarms_photo_mode_cyberware_r", "a0_005_wa__strongarms_photo_mode_cyberware_l", "a0_005_wa__strongarms_photo_mode_l", "a0_006_launcher_arm_cables", "a0_006_launcher_arm_forearm_bottom_plate_a", "a0_006_launcher_arm_forearm_plate_a", "a0_006_launcher_arm_forearm_plate_b", "a0_006_launcher_arm_forearm_upper_plate_a", "a0_006_launcher_arm_guts_b", "a0_006_launcher_arm_guts_c", "a0_006_launcher_arm_guts_d", "a0_006_launcher_arm_muscle_a", "a0_006_launcher_arm_muscle_b", "a0_006_launcher_arm_muscle_c", "a0_006_launcher_arm_plate_a", "a0_006_launcher_arm_plate_b", "a0_006_launcher_arm_plate_c", "a0_006_launcher_arm_side_plate_a", "a0_006_launcher_arm_side_plate_b", "a0_006_launcher_arm_skin", "a0_006_launcher_arm_wrist_plate_a", "a0_006_launcher_arm_wrist_plate_b", "a0_006_launcher_arm_wrist_plate_c", "a0_006_launcher_arm_wrist_plate_d", "a0_006_launcher_arm_guts_a", "a0_006_launcher_projectile_a", "a0_010_ma__soft_token5036", "a0_010_wa__soft_token2203", "a0_010_ma__soft_token7310", "a0_002_ma__monowire_whip_l_cableless", "a0_002_ma__monowire_whip_r_cableless", "a0_002_ma__monowire_whip_personal_link_dec_l", "a0_000_ma_base__nails_l", "a0_000_ma_base__nails_r", "a0_002_wa__monowire_whip_whip1_l", "a0_002_wa__monowire_whip_whip1_r", "a0_003_ma__mantisblade_upperarm_left", "a0_003_ma__mantisblade_upperarm_right", "a0_003_ma__mantisblade_left", "a0_003_ma__mantisblade_left_blade", "a0_003_ma__mantisblade_left_mechanisms", "a0_003_ma__mantisblade_right_mechanisms", "a0_003_ma__mantisblade_right_blade", "a0_003_wa__mantisblade_right_blade", "a0_003_wa__mantisblade_left_blade", "a0_003_ma__mantisblade_holstered_left6562", "a0_003_ma__mantisblade_holstered_right", "a0_003_ma__mantisblade_holstered_upperarm_left", "a0_003_ma__mantisblade_holstered_upperarm_right", "a0_003_wa__mantisblade_holstered_right", "a0_003_wa__mantisblade_holstered_upperarm_right", "a0_003_wa__mantisblade_holstered_upperarm_left", "a0_003_wa__mantisblade_holstered_left", "a0_003_wa__mantisblade_photomode_left2804", "a0_003_wa__mantisblade_photomode_right", "a0_003_wa__mantisblade_photomode_upperarm_left", "a0_003_wa__mantisblade_photomode_upperarm_right", "a0_003_wa__mantisblade_upperarm_left", "a0_003_wa__mantisblade_upperarm_right", "a0_003_wa__mantisblade_right", "a0_003_wa__mantisblade_left", "a0_006_ma__launcher_upperarm", "a0_006_ma__launcher_upperarm_right", "a0_006_ma__launcher_ammo_fire2714", "a0_006_ma__launcher_shells1525", "a0_006_ma__launcher_fragment_fire4806", "a0_006_ma__launcher_holstered1283", "a0_006_ma__launcher_holstered_upperarm", "a0_006_ma__launcher_holstered_upperarm_right", "a0_006_ma__launcher_mechanisms", "a0_006_ma__launcher_muscles", "a0_006_wa__launcher_upperarm", "a0_006_wa__launcher_holstered_right", "a0_006_wa__launcher_ammo_fire2326", "a0_006_wa__launcher_shells8722", "a0_006_wa__launcher_fragment_fire6227", "a0_006_wa__launcher_holstered4156", "a0_006_wa__launcher_holstered_upperarm", "a0_006_wa__launcher_holstered_photo_mode8630", "a0_006_wa__launcher_upperarm_photo_mode", "a0_006_wa__launcher_holstered_photo_mode_right", "a0_006_wa__launcher_muscles", "a0_006_wa__launcher_mechanisms", "a0_006_wa__launcher_nails_l", "a0_006_wa__launcher_nails_r", "monowire_arm", "monowire_hooks", "monowire_wire", "a0_001_wa__personal_link_prototype1385", "a0_006_launcher_arm_projectile", "t0_005_pma_body__t_bug5280", "t0_005_pma_body__t_bug_cuff", "t0_005_pwa_body__t_bug7718", "t0_005_pwa_body__t_bug_cuff", "t0_006_pma_full__queen2164", "t0_006_pma_full__queen_cuff", "t0_006_pwa_full__queen6424", "t0_006_pwa_full__queen_cuff", "t1_001_pma_shirt__militech_agent", "t1_001_pma_shirt__militech_agent_cuffs", "t1_001_pwa_shirt__militech_agent", "t1_001_pwa_shirt__militech_agent_cuffs", "t1_004_pma_tshirt__longsleeve5383", "t1_004_pma_tshirt__longsleeve_cuff", "t1_007_pma_shirt__lumberjack4112", "t2_pma_shirt__lumberjack", "t1_007_pwa_shirt__lumberjack3803", "t1_011_pwa_tank__plain3516", "t1_011_pwa_tank__plain_dec_sticker", "t1_012_pwa_tank__open_sides7518", "t1_018_pma_full__body0281", "t1_018_pma_full__body_cuffs", "t1_018_pwa_full__body1277", "t1_018_pwa_full__body_cuffs", "t2_pma_jacket__sleeves_shadow", "t1_024_pma_tshirt__sweater_cuffs", "t1_024_pma_tshirt__sweater0253", "t1_024_pwa_tshirt__sweater_cuffs", "t1_024_pwa_tshirt__sweater1258", "t1_035_pwa_shirt__suit6540", "t1_035_pwa_shirt__suit_cuff", "t1_041_pma_tshirt__sleeveless6413", "t1_045_pma_shirt__cowboy3770", "t1_045_pma_shirt__cowboy_suff", "t1_047_pma_tank__pushup8854", "t1_047_pwa_tank__pushup8543", "t1_048_pma_tank__plastic_bag4601", "t1_057_pwa_tank__bra0730", "t1_060_pma_tank__corset3513", "t1_061_pma_shirt__holster_belts5680", "t1_068_pwa_tank__long_rogue3063", "t1_070_pma_full__hanako2543", "t1_070_pma_full__hanako_cuff", "t1_070_pwa_full__hanako4412", "t1_070_pwa_full__hanako_cuff", "t1_071_pma_tank__basic4518", "t1_071_wa_tank__basic7841", "t1_073_pma_shirt__torn_shirt0687", "t1_073_pwa_shirt__torn_shirt8278", "t1_074_pma_shirt__torn_shirt4011", "t1_074_pwa_shirt__torn_shirt7362", "t1_079_pma_tshirt__casual2303", "t1_079_pma_tshirt__casual_dec_witcher", "t1_079_ma_tshirt__casual_dec_samurai", "t1_079_pma_tshirt__casual_dec_galaxy", "sq_white_vote_peralez", "t1_079_pma_tshirt__casual_dec_vote_peralez", "t1_079_pwa_tshirt__casual6346", "t1_079_pwa_tshirt__casual_dec_samurai", "t1_079_pwa_tshirt__casual_dec_witcher", "t1_079_pwa_tshirt__casual_dec_galaxy", "t1_079_pwa_tshirt__casual_dec_vote_peralez", "t1_080_pwa_tank__judy6160", "t1_082_pwa_tank__casual0270", "t1_087_pma_shirt__high_collar2852", "t1_087_pwa_shirt__high_collar3543", "t1_088_pma_shirt__kimono0082", "t1_088_pwa_shirt__kimono3315", "t1_089_pwa_tank__short_torn4743", "t1_090_pma_tank__johnny4617", "t1_090_pwa_tank__johnny1030", "t1_091_pma_full__jumpsuit7248", "t1_091_pma_full__jumpsuit_cuff", "t1_041_pma_tshirt__sleeveless", "t1_091_pwa_full__jumpsuit3810", "t1_091_pwa_full__jumpsuit_cuff", "t1_071_pwa_tank__basic", "t1_093_pwa_shirt__denny_corset8405", "t1_094_pma_shirt__scientist7816", "t1_094_pma_shirt__scientist_cuff", "t1_094_pwa_shirt__scientist3763", "t1_094_pwa_shirt__scientist_cuff", "t1_097_pma_tank__corset_doll_prostitute", "t1_097_pwa_tank__corset_doll_prostitute3055", "t1_102_pma_shirt__vest4307", "t1_102_pwa_shirt__vest5844", "t1_105_pma_tank__bandage1160", "t2_002_pma_vest__puffy1434", "t2_002_pwa_vest__puffy2302", "t2_014_pma_dress__chic3813", "t2_014_pma_dress__chic_cuff", "t2_014_pwa_dress__chic4878", "t2_014_pwa_dress__chic_cuff", "t2_021_pma_vest__denim5608", "black_leather", "t2_021_pma_vest__denim_patch", "t2_021_pma_vest__denim_patch_torn", "t2_021_pwa_vest__denim6405", "t2_021_pwa_vest__denim_patch", "t2_021_pwa_vest__denim_patch_torn", "t2_023_pma_full__uniform8588", "t2_023_pma_full__uniform_badge", "t2_023_pma_full__uniform_screen", "t2_023_pwa_full__uniform0884", "t2_023_pwa_full__uniform_badge", "t2_023_pwa_full__uniform_screen", "t2_031_pma_full__hazmat_no_hood7674", "t2_031_pma_full__hazmat_no_hood_cuff", "t2_031_pma_full__hazmat_no_hood_dec_stickers", "t2_031_pwa_full__hazmat_no_hood2811", "t2_031_pwa_full__hazmat_no_hood_cuff", "t2_031_pwa_full__hazmat_no_hood_dec_stickers", "t2_033_pwa_jacket__suspenders3145", "t2_033_pwa_jacket__suspenders_cuffs", "t2_036_pma_jacket__suit_open_elegant4133", "t2_036_pma_jacket__suit_open_elegant_cuff", "t2_039_pwa_jacket__suit_closed5581", "t2_039_pwa_jacket__suit_closed_shirt", "t2_039_pwa_jacket__suit_closed_cuff", "t2_041_pma_jacket__spiked2584", "t2_041_pwa_jacket__spiked3028", "t2_047_pma_jacket__bolero0308", "t2_047_pwa_jacket__bolero5123", "t2_050_pma_jacket__scavenger6531", "t2_050_pma_jacket__scavenger_cuffs", "t2_061_pma_vest__tactical1201", "t2_061_pma_vest__tactical_dec_corpo", "t2_061_pwa_vest__tactical6683", "t2_061_pwa_vest__tactical_dec_corpo", "t2_063_pwa_jacket__silver3022", "t2_063_pwa_jacket__silver_cuffs", "l0_003_pwa_pants__leggins", "t2_064_pma_jacket__t2_player_heavy2048", "t2_064_pma_jacket__t2_player_heavy_cuff", "t2_064_pma_jacket__t2_player_heavy_collar2277", "t2_064_pma_jacket__t2_player_heavy_collar_folded", "t2_064_pma_jacket__t2_player_heavy_folded", "t2_064_pwa_jacket__t2_player_heavy3241", "t2_064_pwa_jacket__t2_player_heavy_cuff", "t2_064_pwa_jacket__t2_player_heavy_collar3310", "t2_068_pma_jacket__formal_suit7461", "t2_068_pma_jacket__formal_suit_cuff", "t2_068_pma_jacket__formal_suit_elegant4353", "t2_070_pma_jacket__suit_paulnight5857", "t2_070_pma_jacket__suit_paulnight_cuff", "t2_072_pma_vest__tactic_collar6428", "t2_072_pma_vest__tactic_collar_dec_corpo", "t2_072_pwa_vest__tactic_collar0062", "t2_072_pwa_vest__tactic_collar_dec_corpo", "t2_073_pma_vest__tactic_collar27052", "t2_073_pma_vest__tactic_collar2_dec_corpo", "t2_073_pwa_vest__tactic_collar20561", "t2_073_pwa_vest__tactic_collar2_dec_corpo", "t2_075_pwa_jacket__tied6223", "t2_076_pma_vest__armor_short1544", "t2_076_pma_vest__armor_short_dec_corpo", "t2_076_pwa_vest__armor_short4166", "t2_076_pwa_vest__armor_short_dec_corpo", "t2_077_pma_vest__armor_short6286", "t2_077_pma_vest__armor_short_dec_corpo", "t2_077_pwa_vest__armor_short7777", "t2_077_pwa_vest__armor_short_dec_corpo", "t2_080_pma_jacket__prince1302", "t2_080_pma_jacket__prince_cuffs", "t2_080_pwa_jacket__prince4284", "t2_080_pwa_jacket__prince_cuffs", "t2_082_pma_vest__hoodie6131", "t2_082_pwa_vest__hoodie2631", "t2_083_pwa_vest__denim4704", "t2_084_pma__short_sleeves5437", "t2_084_pma_jacket__short_sleeves_hanging2284", "t2_084_pma_jacket__short_sleeves_decal_hanging", "t2_084_pwa__short_sleeves3780", "t2_087_pma_jacket__river_short5470", "t2_087_pma_jacket__river_short_cuff", "t2_087_pwa_jacket__river_short_cuff", "t2_087_pwa_jacket__river_short", "t2_088_pwa_jacket__rogue6184", "t2_088_pwa_jacket__rogue_dec_gang", "t2_088_pwa_jacket__rogue_dec_corpo", "t2_090_pma_vest__harness1084", "t2_090_pwa_vest__harness1081", "t2_091_pma_jacket__racing0841", "t2_091_pma_jacket__racing_cuffs", "t2_091_pma_jacket__racing_dec_sticker", "t2_091_pwa_jacket__racing4672", "t2_091_pwa_jacket__racing_cuffs", "t2_091_pwa_jacket__racing_dec_sticker", "t2_093_pwa_jacket__collar0600", "t2_093_pwa_jacket__collar_collar", "t2_094_pma_full__racing_suit2847", "t2_094_pma_full__racing_suit_cuff", "t2_094_pma_full__racing_suit_stephenson_dec_sticker", "t2_094_pwa_full__racing_suit6578", "t2_094_pwa_full__racing_suit_cuff", "prisoner_orange", "t2_094_pwa_full__racing_suit_stephenson_dec_sticker", "t2_097_pma_jacket__holmes_coat8230", "t2_097_pwa_jacket__holmes_coat1745", "t2_098_pwa_jacket__bomber_jacket1140", "t1_pma_formal__shirt_shadow", "t2_099_pma_jacket__military", "t2_100_pma_vest__military1561", "t2_100_pma_vest__military_dec_corpo", "t2_100_pwa_vest__military3323", "t2_100_pwa_vest__military_dec_corpo", "t2_102_pma_vest__tight3467", "t2_103_pwa_jacket__agent2013", "t2_103_pwa_jacket__agent_cuff", "t2_106_pma_jacket__trauma_small2653", "t2_106_pma_jacket__trauma_small_cuffs_cuffs", "t2_106_ma_jacket__trauma_small_dec_logo", "t2_106_pma_jacket__trauma_small_dec_cable", "t2_106_pwa_jacket__trauma_small4411", "t2_106_pwa_jacket__trauma_small_cuffs", "t2_106_pwa_jacket__trauma_small_dec_cable", "t2_106_wa_jacket__trauma_small_dec_logo", "t2_109_pma_jacket__puffy_vest0887", "t2_109_pwa_jacket__puffy_vest6740", "t2_110_pma_vest__high_collar4286", "t2_110_pwa_vest__high_collar4710", "t2_111_pma_jacket__bodyguard_dex4063", "t2_111_pma_jacket__bodyguard_dex_cuffs", "t2_111_pwa_jacket__bodyguard_dex1833", "t2_111_pwa_jacket__bodyguard_dex_cuffs", "t2_114_pma_vest__hi_vis5306", "t2_114_pma_vest__hi_vis_dec_corpo", "t2_114_pwa_vest__hi_vis1141", "t2_114_pwa_vest__hi_vis_dec_corpo", "t2_115_pma_jacket__military3431", "t2_115_pma_jacket__military_dec_sticker", "t2_115_pma_jacket__military", "t2_115_pwa_jacket__military1114", "t2_115_pwa_jacket__military_dec_sticker", "t2_119_pma_jacket__suit_cuff", "t2_119_pma_jacket__suit8131", "t2_120_pwa_jacket__suit_01", "t2_120_pwa_jacket__suit_sleeves_01", "t2_120_pwa_jacket__suit_sleeves_04", "t2_120_pwa_jacket__suit_sleeves_02_cuff", "t2_120_pwa_jacket__suit_022017", "t2_120_pwa_jacket__suit_03", "t2_122_pma_jacket__biker0023", "t2_122_pma_jacket__biker_cuffs", "t2_122_pwa_jacket__bike", "t2_122_pwa_jacket__biker_cuffs", "t2_123_pma_full__space_suit4181", "t2_123_pma_full__space_suit_dec_sticker", "t2_123_pma_full__space_suit_trauma_pack", "t2_123_pma_full__space_suit_helmet3538", "t2_123_pwa_full__space_suit0210", "t2_123_pwa_full__space_suit_trauma_pack", "t2_123_pwa_full__space_suit_dec_sticker", "t2_123_pwa_full__space_suit_helmet7518", "t2_126_pma_jacket__hood5142", "t2_126_pma_jacket__hood_cuffs", "t2_127_pwa_jacket__evelyn3568", "t2_128_pma_jacket__takemura8622", "t2_128_pma_jacket__takemura_cuff", "t2_131_pma_vest__kerry4682", "t2_131_pma_vest__kerry_dec_gang", "t2_131_pwa_vest__kerry2131", "t2_131_pwa_vest__kerry_dec_gang", "t2_132_pma_jacket__wilson7816", "t2_132_pma_jacket__wilson_dec_corpo", "t2_132_pma_jacket__wilson_dec_gang", "t2_132_pma_jacket__wilson_cuff", "t2_140_pma_jacket__leather7543", "t2_140_pma_jacket__leather_cuff", "t2_140_pwa_jacket__leather3281", "t2_140_pwa_jacket__leather_cuff", "t2_142_pma_jacket__witcher0688", "t2_142_pma_jacket__witcher_cuffs", "leather_black", "t2_142_pwa_jacket__witcher0655", "t2_142_pwa_jacket__witcher_cuffs", "s1_001_pma_shoe__swim_fins4245", "s1_001_pwa_shoe__swim_fins7734", "s1_004_pma_shoe__sneakers_high5153", "s1_005_pma_shoe__sport_high5041", "s1_010_pma_shoe__elegant3230", "s1_011_pwa_boot__heel_sneakers5643", "s1_013_pma_boot__snow_shoes2172", "s1_013_pwa_boot__snow_shoes1576", "s1_026_pma_boot__heavy4104", "s1_026_pwa_boot__heavy7835", "s1_027_pwa_shoe__heel_pointy1510", "s1_039_pma_boot__knee_high1352", "s1_051_pwa_shoe__latino1302", "s1_052_pma_boot__cowboy3283", "s1_052_pwa_boot__cowboy", "s1_053_pma_boot__military3700", "s1_053_pwa_boot__military2302", "s1_055_pma_shoe__converse5711", "s1_055_pwa_shoe__converse6558", "s1_056_pma_boot__biker5465", "s1_056_pwa_boot__biker0668", "s1_057_pma_shoe__racing6821", "s1_057_pwa_shoe__racing4635", "s1_059_pwa_shoe__judy7548", "s1_061_pma_shoe__clair6674", "s1_061_pwa_shoe__clair7540", "s1_063_pma_shoe__mexican7186", "s1_063_pma_shoe__mexican_harness", "s1_063_pwa_shoe__mexican2571", "s1_063_pwa_shoe__mexican_harness", "s1_065_pma_shoe__ankle6553", "s1_065_pwa_shoe__ankle0855", "s1_066_pma_boot__bovver3318", "s1_066_pma_boot__bovver_laces_01", "s1_066_pma_boot__bovver_metal_tip_01", "s1_066_pwa_boot__bovver4748", "s1_066_pwa_boot__bovver_laces_01", "s1_066_pwa_boot__bovver_metal_tip_01", "s1_067_pma_shoe__river3450", "s1_068_pma_shoe__sneakers1043", "s1_068_pwa_shoe__sneakers7640", "s1_073_pwa_shoe__high_heels", "s1_075_pma_shoe__yorinobu2284", "s1_076_pwa_boot__misty5375", "s1_077_pma_boot__blackwater8588", "s1_077_pwa_boot__blackwater7310", "s1_078_pma_boot__wilson6368", "s1_078_pwa_boot__wilson", "s1_079_pwa_shoe__hanako3883", "s1_084_pma_boot__thrusters", "s1_084_pma_boot__thrusters_dec_corpo", "s1_084_pwa_boot__thrusters", "s1_084_pwa_boot__thrusters_dec_corpo", "left_arm", "right_arm", "a0_000_pwa_fpp__nails_l", "a0_000_pwa_fpp__nails_r", "a0_001__personal_link_default_holstered", "MorphTargetSkinnedMesh0531", "l0_000_pwa_base__cs_flat", "t0_000_pwa_fpp__torso", "n0_000_pwa_fpp__neck0160", "t0_000_pma_base__full", "n0_000_pma_fpp__neck2814", "i0_000_pma_base__nipple", "a0_000_pma_base__nails_r", "a0_000_pma_base__nails_l", "a0_000_ma_base__full_ag_hq1491", "a0_000_ma_base__full_ag_hq6168", "g1_012_pma_gloves__trauma_no_protection4340", "i1_002_pwa_slot__diving_bottle7786", "i1_003_pma_neck__bullet_pendant1068", "i1_114_pwa_neck__dogtag_johnny1520", "i1_020_pma_neck__goggles7616", "i1_020_pwa_neck__goggles1368", "i1_050_pma_neck__bolo_tie5567", "i1_074_pma_full__harness_racing", "i1_074_pwa_full__harness_racing", "i1_106_wa_neck__doll7414", "i1_114_pma_neck__dogtag_johnny6127", "i1_122_ma_full__devices", "i1_122_ma_full__devices_dec_sticker", "i1_122_pwa_full__devices4716", "i1_122_pwa_full__devices_dec_sticker", "h1_001_pma_mask__swim_mask2764", "h1_001_pwa_mask__swim_mask0307", "h1_002_pma_hat__headcap4652", "h1_002_pwa_hat__headcap2675", "h1_003_pma_hat__beanie7181", "h1_003_pwa_hat__beanie8268", "h1_007_pma_specs__aviators1285", "h1_007_pwa_specs__aviators2376", "h1_011_pma_hat__baseball7254", "h1_011_pma_hat__baseball_back8080", "h1_011_pwa_hat__baseball7030", "h1_011_pwa_hat__baseball_back4262", "h1_012_pma_hat__googles3226", "h1_012_pwa_hat__googles3001", "h1_015_pma_specs__visor_holo0421", "h1_015_pwa_specs__visor_holo7440", "h1_021_pma_hat__cowboy_sheriff6747", "h1_021_pwa_hat__cowboy_sheriff2327", "h1_024_pma_hat__scavenger5026", "h1_024_pwa_hat__scavenger8308", "h1_032_pma_hat__asian6840", "h1_032_pwa_hat__asian0587", "h1_033_pma_specs__braindance0241", "h1_033_pwa_specs__braindance4636", "h1_036_pma_hat__elegant2825", "h1_036_pwa_hat__elegant7660", "h1_037_pma_hat__hijab0370", "h1_037_pwa_hat__hijab1547", "h1_038_pma_specs__classic6586", "h1_038_pwa_specs__classic3436", "h1_045_pma_hat__farmer0115", "h1_045_pwa_hat__farmer2402", "h1_051_pma_mask__headkerchief_lower0382", "h1_051_pwa_mask__headkerchief_lower7323", "h1_052_pma_specs__tactical_017720", "h1_052_pma_specs__tactical_026748", "h1_052_pma_specs__tactical_035180", "h1_052_pma_specs__tactical_047786", "h1_052_pwa_specs__tactical_018516", "h1_052_pwa_specs__tactical_023262", "h1_052_pwa_specs__tactical_031711", "h1_052_pwa_specs__tactical_048724", "h1_055_pma_specs__googles6020", "h1_055_pwa_specs__googles4313", "h1_056_pma_mask__samurai4161", "h1_056_pwa_mask__samurai0763", "h1_058_pma_mask__skull1350", "h1_058_pma_mask__skull_mask_cover", "h1_058_pma_mask__skull_mask_cover02", "h1_058_pma_mask__skull_small_cover03", "h1_058_pwa_mask__skull5430", "h1_058_pwa_mask__skull_mask_cover", "h1_058_pwa_mask__skull_mask_cover02", "h1_058_pwa_mask__skull_small_cover03", "h1_060_pma_hat__bandana_kerry8710", "h1_060_pwa_hat__bandana_kerry0240", "h1_063_pma_hat__military5372", "h1_063_pwa_hat__military1528", "h1_064_pma_specs__sunglasses_011714", "h1_064_pma_specs__sunglasses_025032", "h1_064_pwa_specs__sunglasses_011343", "h1_064_pwa_specs__sunglasses_026676", "h1_065_pma_hat__guard1224", "h1_065_pwa_hat__guard8765", "h1_070_pma_mask__glasses_l1313", "h1_070_pwa_mask__glasses", "h1_082_pma_hat__bandage1421", "h2_005_pma_helmet__construction0817", "h2_005_pwa_helmet__construction6140", "h2_009_pma_helmet__samurai8040", "h2_009_pwa_helmet__samurai5837", "h2_011_pma_helmet__riot3158", "h2_011_pwa_helmet__riot0243", "h2_015_pma_helmet__motorcycle0431", "h2_015_pwa_helmet__motorcycle1627", "h2_016_pma_helmet__max_tac7723", "h2_016_pwa_helmet__max_tac0037", "i1_020_pma_neck__goggles6842", "i1_020_pwa_neck__goggles0113", "a0_008_ma__fpp_right_q001_injection_mark", "a0_008_wa__fpp_right_q001_injection_mark", "a0_004__weapon_grip_decal_02", "a0_004__weapon_grip_device", "a0_000_nomad_base_fists", "t0_000_pwa_base__full", "hh_000_ma__prototype3047", "hh_000_mb__prototype", "hh_000_wa__prototype", "hh_006_ma__demo3633", "hh_006_mb__demo", "hh_006_wa__demo", "hh_007_ma__demo1210", "hh_007_mb__demo", "hh_007_wa__demo", "hh_008_ma__demo0028", "hh_008_mb__demo", "hh_008_wa__demo", "hh_009_ma__demo3404", "hh_009_mb__demo", "hh_009_wa__demo4473", "hh_011_ma__demo3010", "hh_011_wa__demo7364", "hh_011_waf__demo1381", "hh_020_ma__mullet7683", "hh_020_wa__mullet", "hh_021_ma__player", "hh_021_mb__player013337", "hh_021_wa__player012513", "hh_022_ma__chrome_celeb", "hh_022_mb__chrome_celeb", "hh_022_wa__chrome_celeb", "hh_023_ma__short_messy5102", "hh_023_mb__short_messy", "hh_023_wa__short_messy", "hh_024_wa__underwater_dancer1446", "hh_025_ma__pompadour", "hh_025_mb__pompadour0053", "hh_025_mba__pompadour3258", "hh_025_wa__pompadour2838", "hh_025_wba__pompadour6412", "hh_026_ma__rat_tail", "hh_026_mb__rat_tail7140", "hh_026_mba__rat_tail4380", "hh_026_mc__rat_tail8050", "hh_026_wa__rat_tail6062", "hh_026_wba__rat_tail6150", "hh_027_ma__scavenger", "hh_027_mb__scavenger", "hh_027_mc__scavenger8838", "hh_027_wa__scavenger0663", "hh_028_ma__corpo_bun3807", "hh_028_wa__corpo_bun", "hh_029_wa__misty", "hh_029_wa__misty6688", "hh_030_ma__punk_idol", "hh_030_mb__punk_idol", "hh_030_mc__punk_idol_short5114", "hh_030_wa__punk_idol", "hh_031_ma__morgan_blackhand", "hh_032_ma__ripper_doc_common", "hh_032_mb__ripper_doc_common2200", "hh_032_mf__ripper_doc_common7107", "hh_033_ma__player", "hh_033_wa__player", "hh_034_wa__militech_agent", "hh_034_wa__militech_agent7131", "hh_035_ma__mohawk_tall", "hh_035_mb__mohawk_tall", "hh_035_wa__mohawk_tall", "hh_036_ma__high_tight4653", "hh_036_mb__high_tight3688", "hh_036_mba__high_tight8062", "hh_036_mc__high_tight2408", "hh_036_mf__high_tight7000", "hh_036_wa__high_tight3672", "hh_036_waf__high_tight6778", "hh_036_wba__high_tight1646", "hh_037_ma__gungho3158", "hh_037_mb__gungho7340", "hh_037_mba__gungho8170", "hh_037_mc__gungho5665", "hh_037_mf__gungho4245", "hh_037_wa__gungho5574", "hh_037_waf__gungho8031", "hh_037_wba__gungho7046", "hh_039_ma__punk_shaved7577", "hh_039_mb__punk_shaved7460", "hh_039_mba__punk_shaved6716", "hh_039_mc__punk_shaved8275", "hh_039_mf__punk_shaved0306", "hh_039_wa__punk_shaved", "hh_039_waf__punk_shaved0178", "hh_039_wba__punk_shaved1308", "hh_040_ma__pixie_bob0822", "hh_040_mb__pixie_bob7356", "hh_040_mc__pixie_bob3384", "hh_040_wa__pixie_bob", "hh_040_waf__pixie_bob6887", "hh_040_wba__pixie_bob4233", "hh_041_ma__valentino8404", "hh_041_wa__valentino", "hh_042_ma__topknots6552", "hh_042_mb__topknots1558", "hh_042_mba__topknots2542", "hh_042_mc__topknots3560", "hh_042_mf__topknots0633", "hh_042_wa__topknots", "hh_042_wa__topknots_band", "hh_042_mf__topknots_band", "hh_042_mc__topknots_band", "hh_042_mba__topknots_band", "hh_042_mb__topknots_band", "hh_042_ma__topknots_band", "hh_042_wba__topknots_band", "hh_042_wba__topknots1411", "hh_043_wa__modern_bob6743", "hh_044_ma__classic4517", "hh_044_wa__classic7063", "hh_045_ma__short_spiked8708", "hh_045_mb__short_spiked6105", "hh_045_mba__short_spiked7177", "hh_045_mc__short_spiked1850", "hh_045_mf__short_spiked4442", "hh_045_wa__short_spiked2173", "hh_045_wba__short_spiked7343", "hh_046_ma__saburo_arasaka3348", "hh_047_ma__swirl_pomp5410", "hh_047_wa__swirl_pomp1544", "hh_048_ma__dual_braids8777", "hh_048_mb__dual_braids8661", "hh_048_wa__dual_braids6587", "hh_049_ma__thiago6065", "hh_049_ma__thiago_common6367", "hh_049_mb__thiago_common4480", "hh_049_mba__thiago_common1414", "hh_049_mc__thiago_common8054", "hh_049_mf__thiago_common5240", "hh_049_wa__thiago_common6388", "hh_049_waf__thiago_common7105", "hh_049_wba__thiago_common2817", "hh_050_ma__johnny_silverhand", "hh_051_ma__judy_common7437", "hh_051_wa__judy", "hh_051_wa__judy_common1632", "hh_052_mc__clair6255", "hh_052_wa__clair2245", "hh_053_ma__kerry_eurodyne5786", "hh_053_ma__kerry_eurodyne_common4302", "hh_053_ma__yorinobu3860", "hh_053_wa__kerry_eurodyne_common3268", "hh_054_wa__michiko6576", "hh_054_wa__rogue_young5787", "hh_054_wa__rogue_young_common8076", "hh_055_mb_placide", "hh_055_mba_placide_common3028", "hh_056_wa__rogue_old4448", "hh_057_ma__kerry_eurodyne_young1370", "hh_058_ma__voodoo_013726", "hh_058_mb__voodoo_017001", "hh_058_mba__voodoo_012844", "hh_058_mc__voodoo_016270", "hh_058_wa__voodoo_011875", "hh_058_wba__voodoo_018748", "hh_059_ma__voodoo_027611", "hh_059_mb__voodoo_028265", "hh_059_mba__voodoo_020116", "hh_059_mc__voodoo_028010", "hh_059_mf__voodoo_020552", "hh_059_wa__voodoo_024201", "hh_059_waf__voodoo_020436", "hh_059_wba__voodoo_027872", "hh_060_ma__voodoo_034083", "hh_060_mb__voodoo_037007", "hh_060_mba__voodoo_034235", "hh_060_mc__voodoo_037705", "hh_060_wa__voodoo_036583", "hh_060_wba__voodoo_034725", "hh_061_ma__midlength_wavy2365", "hh_061_mb__midlength_wavy", "hh_061_mba__midlength_wavy", "hh_061_mc__midlength_girly0457", "hh_061_mc__midlength_wavy2788", "hh_061_wa__midlength_wavy8134", "hh_062_ma__slick_back1308", "hh_062_mb__slick_back4121", "hh_062_mba__slick_back4575", "hh_062_wa__slick_back2407", "hh_063_ma__messy_bob0304", "hh_063_mc__messy_bob6182", "hh_063_wa__messy_bob3723", "hh_063_wa__messy_bob_us_cracks8748", "hh_063_wba__messy_bob0017", "hh_064_mc__bob_fringe4183", "hh_064_wa__bob_fringe8438", "hh_064_waf__bob_fringe6800", "hh_064_wba__bob_fringe7150", "hh_065_ma__afro_knots8114", "hh_065_mb__afro_knots4580", "hh_065_mba__afro_knots0164", "hh_065_mc__afro_knots2484", "hh_065_wa__afro_knots5387", "hh_065_waf__afro_knots3741", "hh_065_wba__afro_knots4883", "hh_066_mba__animals_011153", "hh_067_mba__animals_027836", "hh_068_ma__animals_032316", "hh_068_ma__animals_03_band", "hh_068_mb__animals_032001", "hh_068_mb__animals_03_band", "hh_068_mba__animals_03_band", "hh_068_mba__animals_030814", "hh_068_mc__animals_030804", "hh_068_mc__animals_band", "hh_068_wa__animals_band", "hh_068_wa__animals_038526", "hh_068_waf__animals_band", "hh_068_waf__animals_033647", "hh_068_wba__animals_band", "hh_068_wba__animals_038362", "hh_999_wba__buzz_cap5647", "hh_999_waf__buzz_cap3810", "hh_999_wa__buzz_dorset_cap4185", "hh_999_wa__buzz_cap", "hh_999_mf__buzz_cap6774", "hh_999_mc__buzz_cap7112", "hh_999_mba__buzz_cap0763", "hh_999_mb__buzz_cap", "hh_999_ma__buzz_cap", "hh_151_waf__judy_variation02_common3001", "hh_151_wa__judy_v02_shadow_npc", "hh_151_wa__judy_variation02_common4843", "hh_151_wa__judy_variation022886", "hh_151_ma__judy_variation02_common5775", "hh_145_ma__v_short5237", "hh_140_wba__short_afro1353", "hh_140_wa__short_afro8843", "hh_140_mf__short_afro1273", "hh_140_mc__short_afro0562", "hh_140_mba__short_afro1001", "hh_140_mb__short_afro3783", "hh_140_ma__short_afro8223", "hh_133_wa_cyberware_spikes_03", "hh_133_mb_cyberware_spikes_03", "hh_133_ma_cyberware_spikes_03", "hh_132_wa_cyberware_spikes_02", "hh_131_wa_cyberware_spikes_01_cap", "hh_132_ma_cyberware_spikes_02", "hh_131_ma_cyberware_spikes_01_cap", "hh_131_wa_cyberware_spikes_01", "hh_131_wa_cyberware_spikes_01_cap", "hh_131_ma_cyberware_spikes_01", "hh_122_ma__roy5656", "hh_121_wba__t_bug_common2037", "hh_121_waf__t_bug_common0674", "hh_121_wa__t_bug_common5334", "hh_121_wa__t_bug5630", "hh_121_mc__t_bug_common4202", "hh_121_ma__t_bug_common2560", "hh_120_ma__arasaka_bun_knot_04", "hh_120_ma__arasaka_bun_knot_04_band", "hh_120_ma__arasaka_bun_common_04", "hh_082_ma__afro_bun_shadow_npc", "hh_120_ma__arasaka_bun_knot_05", "hh_120_ma__arasaka_bun_knot_03", "hh_120_ma__arasaka_bun_knot_03_band", "hh_120_ma__arasaka_bun_knot_06", "hh_120_ma__arasaka_bun_knot_06_sticks", "hh_120_ma__arasaka_bun_common_03", "hh_120_ma__arasaka_bun_knot_02", "hh_120_ma__arasaka_bun_knot_05_band", "hh_120_ma__arasaka_bun_knot_01", "hh_120_ma__arasaka_bun_common_02", "hh_120_ma__arasaka_bun_knot_02_band", "hh_120_ma__arasaka_bun_common_01", "hh_120_ma__arasaka_bun_046120", "hh_120_ma__arasaka_bun_031001", "hh_120_ma__arasaka_bun_027010", "hh_120_ma__arasaka_bun_016145", "hh_119_ma__kojima0247", "hh_118_wa__gillean8283", "hh_118_ma__gillean4256", "hh_117_wa__nina8038", "hh_116_mb__jesse1353", "hh_115_wa__alanah_common3135", "hh_115_wa__alanah2374", "hh_115_mc__alanah_common1307", "hh_114_ma__cohh4631", "hh_113_ma__iwinski_common2284", "hh_113_ma__iwinski2288", "hh_112_ma__kicinski_player3800", "hh_112_ma__kicinski_common2475", "hh_112_ma__kicinski8536", "hh_110_wa__wizzy2244", "hh_105_wa__us_cracks_020823", "hh_105_wa__us_cracks_02_bands", "hh_104_wa__braids5870", "hh_104_mb__braids8634", "hh_104_ma__braids1237", "hh_103_wa__common_spikes6864", "hh_103_ma__maelstrom_spikes5116", "hh_103_ma__common_spikes4318", "hh_102_ma__maelstrom_mohawk4657", "hh_101_ma__maelstrom_ugly5430", "hh_100_wa__wakako2015", "hh_100_wa__wakako_bun", "hh_100_wa__wakako_bun_chopsticks_bun_sticks", "hh_099_ma__holt_common7842", "hh_099_ma__holt2555", "hh_098_wa__top_bun4103", "hh_097_ma__perez8713", "hh_096_mba__saburo_arasaka_old_common7544", "hh_096_ma__saburo_arasaka_old_common5672", "hh_096_ma__saburo_arasaka_old4265", "hh_095_wa__panam5886", "hh_094_ma__saul_common5252", "hh_050_ma__johnny_silverhand_npc", "hh_094_ma__saul1807", "hh_093_wa__sumo_knot", "hh_093_wa__sumo_knot_band", "hh_085_ma__takemura_shadow_npc", "hh_093_mba__sumo_bodyguard6354", "hh_093_mba__sumo_knot", "hh_093_mba__sumo1528", "hh_093_ma__sumo4200", "hh_093_ma__sumo_knot", "hh_093_ma__sumo_band", "hh_092_wa__hanako7083", "hh_092_wa__hanako_bun", "hh_092_wa__hanako_clip", "hh_091_wa__dakota6784", "hh_091_wa__dakota_braid", "hh_091_wa__dakota_braid_band", "hh_090_wa__alt_sex_scene_023561", "hh_090_wa__alt_sex_scene", "hh_090_wa__alt_player2038", "hh_090_wa__alt5644", "hh_089_wba__thompson_common2040", "hh_089_waf__thompson_common4031", "hh_089_wa__thompson_common3557", "hh_089_mf__thompson3472", "hh_089_mba__thompson_common1478", "hh_089_mb__thompson_common4242", "hh_089_ma__thompson_common3557", "hh_089_ma__thompson_common7847", "hh_089_ma__thompson7678", "hh_088_waf__corpo_bob6527", "hh_088_wa__corpo_bob7280", "hh_087_ma__balding_ponytail7888", "hh_086_ma__balding_short_mitch6837", "hh_086_ma__balding_short0330", "hh_085_wba__takemura_common3666", "hh_085_waf__takemura_common2728", "hh_085_wa__takemura_common3377", "hh_085_mf__takemura_common4838", "hh_085_mc__takemura_common5134", "hh_085_mba__takemura_common4845", "hh_085_mb__takemura_common0623", "hh_085_ma__takemura_common1240", "hh_085_ma__takemura2044", "hh_084_wa__bun_chopsticks6071", "hh_084_wa__bun_chopsticks_bun", "hh_084_wa__bun_chopsticks_bun_sticks", "hh_084_ma__bun_chopsticks7617", "hh_084_ma__bun_chopsticks_bun", "hh_084_ma__bun_chopsticks_bun_sticks", "hh_083_wa__ponytail_straight_016481", "hh_083_wa__ponytail_base_01", "hh_083_wa__ponytail_straight_01_band", "hh_083_wa__ponytail_bulb_013744", "hh_083_wa__ponytail_bulb_01_band", "hh_083_wa__ponytail_braid_011002", "hh_083_wa__ponytail_braid_01_band", "hh_083_ma__ponytail_straight_013188", "hh_083_ma__ponytail_base_01", "hh_083_ma__ponytail_straight_01_band", "hh_083_ma__ponytail_bulb_012124", "hh_083_ma__ponytail_bulb_01_band", "hh_083_ma__ponytail_braid_012023", "hh_083_ma__ponytail_braid_01_band", "hh_082_wba__afro_bun7800", "hh_082_wba__afro_bun_bun", "hh_082_waf__afro_bun8315", "hh_082_waf__afro_bun_bun", "hh_082_wa__afro_bun3836", "hh_082_wa__afro_bun_bun", "hh_082_mf__afro_bun3424", "hh_082_mf__afro_bun_bun", "hh_082_mc__afro_bun5755", "hh_082_mc__afro_bun_bun", "hh_082_mba__afro_bun6161", "hh_082_mba__afro_bun_bun", "hh_082_mb__afro_bun6138", "hh_082_mb__afro_bun_bun", "hh_082_ma__afro_bun3687", "hh_082_ma__afro_bun_bun", "hh_081_wa__buns_02_us_cracks5582", "hh_080_wa__buns_01_shadow_npc", "hh_081_wa__buns_022704", "hh_080_waf__buns_017644", "hh_080_wa__buns_01_us_cracks0305", "hh_080_wa__buns_016838", "hh_079_wa__denny0258", "hh_078_wa__evelyn_common3385", "hh_078_wa__evelyn7467", "hh_077_wa__nomad_024358", "hh_077_ma__nomad_028327", "hh_076_mb__ozob4641", "hh_075_wa__peralez_common7071", "hh_075_mf__peralez_common7050", "hh_075_mba__peralez_common7148", "hh_075_mb__peralez_common3232", "hh_075_ma__peralez_common1541", "hh_075_ma__peralez4688", "hh_074_ma__henry8434", "hh_073_wa__nomad_012568", "hh_073_mba__nomad_011212", "hh_073_mb__nomad_017781", "hh_073_ma__nomad_018123", "hh_072_wa__maman_brigitte5557", "hh_071_ma__netwatch_agent1637", "hh_070_mm__animals_boss1635", "hh_070_mm__animals_boss_bangs", "hh_069_wba__animals_044800", "a0_000_pwa_base_nails_l", "a0_000_pwa_base_nails_r", "a0_000_pma_base__injection_r", "a0_000_pwa_base__injection_r", "a0_000_pwa_fpp__injection_r", "a0_000_pma_fpp__injection_r", "t0_000_pwa_base__full_seamfix", "t0_000_pma_base__full_seamfix", "ht_000_pwa_c__basehead", "hx_000_pwa_c__basehead_cyberware_01", "heb_000_pwa_c__basehead", "he_000_pwa_c__basehead", "h0_000_pwa_c__basehead", "hh_033_pwa__player_cyberware_01", "hx_000_pwa_c__basehead_personal_slot_dec", "h0_000_pma_c__basehead", "ht_000_pma_c__basehead", "he_000_pma_c__basehead", "i1_000_pma_c__basehead_earring_01", "hb_000_pma_c__basehead_shadowbase_01", "hb_000_pma_c__basehead", "heb_000_pma_c__basehead", "hh_045_pma__short_spiked_cyberware_01", "hh_045_ma__short_spiked_shadow", "hx_000_pma_c__basehead_cyberware_01", "hx_000_pma_c__basehead_personal_slot_dec", "a0_001__personal_link_tpp4537", "personal_link_female", "MorphTargetSkinnedMesh3637", "MorphTargetSkinnedMesh7243", "i1_000_pwa__morphs_earring_01", "i1_000_pwa__morphs_earring_02", "i1_000_pwa__morphs_earring_03", "i1_000_pwa__morphs_earring_04", "i1_000_pma__morphs_earring_01", "i1_000_pma__morphs_earring_02", "i1_000_pma__morphs_earring_03", "i1_000_pma__morphs_earring_04", "MorphTargetSkinnedMesh1265", "hx_000_pwa__basehead_makeup_lips_01", "hx_000_pwa__basehead_makeup_eyes_01", "hx_000_pma__basehead_makeup_eyes_01", "ht_000_pwa__basehead", "ht_000_pma__basehead", "heb_000_pwa__basehead", "heb_000_pma__basehead", "he_000_pma__basehead", "he_000_pwa__basehead", "t2_122_pwa_jacket__biker6317"}
	
	possibleFaction = { "Arasaka", "Militech", "KangTao", "Nomad"}
	
	npcsource = { "npc", "current_star", "faction", "current_district_leader", "current_subdistrict_leader", "district_leader", "subdistrict_leader", "random","from_list","district_rival","subdistrict_rival","current_district_rival","current_subdistrict_rival"}
	npcposition = { 
		"at", 
		"relative_to_entity", 
		"node",
		"player_look_at", 
		"poi", 
		"mappin", 
		"fasttravel", 
		"custom_place",
		"custom_room",
		"manager"
		}
		
	mappinsource = { 
		"at", 
		"relative_to_entity", 
		"node",
		"player_look_at", 
		"poi", 
		"mappin", 
		"fasttravel", 
		"custom_place",
		"custom_room",
		"on_entity",
		"on_group",
		"manager"
	}
	npcpositionway = { "normal", "behind", "forward","forward_relative"}
	npcpositionhouseway = { "default", "enter", "exit"}
	
	poitype={ "All", "Hostile", "Friendly","Special"}
	editorCurrentPOIType = "All"
	
	vehiclesource = { "vehicle", "faction", "current_district_leader", "current_subdistrict_leader", "district_leader", "subdistrict_leader", "random","from_list","district_rival","subdistrict_rival","current_district_rival","current_subdistrict_rival"}
	vehiclespawnsystem = {"From Garage", "Beta", "Prevention","Codeware"}
	vehiclespawnsystemeditordefault = "From Garage"
	
	local f = assert(io.open("mod/data/effects.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	f:close()
	effectslistJson = trydecodeJSOn(encdo, f ,"mod/data/effects.json")
	
	
	listFX = {"blackout", "fast_travel_glitch_long", "fast_travel_glitch", "terrain_scan", "trail", "transition_glitch_loop_braindance", "transition_glitch_loop", "fx_candles_lightup", "weakspot_explode", "weakspot_overload", "weakspot_compensating", "weakspot_destroyed", "weakspot_indicator", "weakspot_broken", "weakspot_hit", "light_on_destr", "mine_laser_green", "mine_laser_red", "light_cone_dust", "fx_empty", "deflection", "swimming_surface_stroke", "swimming_diving", "swimming_diving_stroke", "swimming_diving_stroke_fast", "fx_checked", "fx_damage_high", "fx_damage_medium", "fx_damage_low", "human_shield", "fx_health_low", "muzzle_flash_photo_mode", "fx_oxygen_critical", "stealth_mode", "detonation_warning", "ignition", "focus_mode", "screen_scanning_loop", "screen_scanning_red_loop", "transition_glitch_loop", "scan", "fx_distraction", "broken", "active", "friendly", "status_tired", "blood_onscreen", "fish_eye", "camera_transition_effect_start", "camera_transition_effect_stop", "camera_mask", "imp_concrete", "disabling_connectivity_glitch", "zoom", "fire", "thrusters", "underwater_bubbles", "explosion", "crystal_dome_instant_on", "crystal_dome_start", "crystal_dome_stop", "damage_engine_stage1", "damage_engine_stage2", "damage_engine_stage3", "cooler_destro_fx", "crystal_dome_fl_b", "crystal_dome_fl_f", "crystal_dome_fr_b", "crystal_dome_fr_f", "crystal_dome_ml", "crystal_dome_mr", "crystal_dome_ol", "crystal_dome_or", "overheating", "police_sign_combat", "charge", "police_sign_default",
		"blink_fast",
		"blink_slow",
		"eyes_closing_fast",
		"eyes_closing_slow_3s",
		"eyes_closing_slow",
		"eyes_closing",
		"fish_eye",
		"focus_mode",
		"reboot_glitch",
		"sunglasses",
		"status_drugged_low",
		"status_drugged_medium",
	"status_drugged_heavy"}
	
	npcFX = {"human_shield"}
	
	carFX={"fire", "thrusters", "underwater_bubbles", "explosion", "damage_engine_stage1", "damage_engine_stage2", "damage_engine_stage3"}
	transistionFX ={"blackout",
		"fast_travel_glitch_long",
		"fast_travel_glitch",
		"transition_glitch_loop_braindance",
		"transition_glitch_loop",
		"fx_health_low",
		"focus_mode",
		"screen_scanning_loop",
		"screen_scanning_red_loop",
		"transition_glitch_loop",
		"scan",
		"blood_onscreen",
		"fish_eye",
		"camera_transition_effect_start",
		"camera_transition_effect_stop",
		"camera_mask",
		"disabling_connectivity_glitch",
		"zoom",
		"blink_fast",
		"blink_slow",
		"eyes_closing_fast",
		"eyes_closing_slow_3s",
		"eyes_closing_slow",
		"eyes_closing",
		"fish_eye",
		"focus_mode",
		"reboot_glitch",
		"sunglasses",
		"status_drugged_low",
		"status_drugged_medium",
		"status_drugged_heavy"
		
	}
	
	
	
	
	affiliationTweakList = {
		
		"AfterlifeMercs",
		"Aldecaldos",
		"Animals",
		"Arasaka",
		"Biotechnica",
		"CityCouncil",
		"Civilian",
		"KangTao",
		"Maelstrom",
		"Militech",
		"NCPD",
		"NetWatch",
		"News54",
		"RecordingAgency",
		"Scavengers",
		"SixthStreet",
		"SouthCalifornia",
		"SSI",
		"TheMox",
		"TraumaTeam",
		"TygerClaws",
		"Unaffiliated",
		"UnaffiliatedCorpo",
		"Unknown",
		"Valentinos",
		"VoodooBoys",
		"Wraiths"
		
	}
	
	transgressionsTweakList = {"AidingAI",
		"Assault",
		"AssaultByMob",
		"AssaultCop",
		"AssaultCorpo",
		"AssaultPublicOfficial",
		"AttemptedMurder",
		"Battery",
		"BatteryCop",
		"BatteryCorpo",
		"BatteryPublicOfficial",
		"Blackmail",
		"BlackmailCorpo",
		"BlackwallViolation",
		"BodilyHarm",
		"BodySnatching",
		"Classified",
		"Confinement",
		"CopyrightInfringement",
		"CorporateSlander",
		"CorpoSlander",
		"DataDestruction",
		"DataVandal",
		"DefilingHumanRemains",
		"DrugDealing",
		"DrugPossession",
		"ElectronicallyStolenGoods",
		"EmancipationAI",
		"EspionageCorpo",
		"FatalHitAndRun",
		"ForcedImplantProcedures",
		"GeneticAlteration",
		"GeneticAlterationPerform",
		"GrandLarceny",
		"HostageTaking",
		"HumanTrafficking",
		"IllegalCorrespondance",
		"IllegalOrganicFood",
		"ImpersonationCorpo",
		"KidnappingCorpo",
		"KidnappingForRansom",
		"LarcenyCorpo",
		"ManufactureSubstances",
		"MilitaryHardware",
		"MultipleHomocide",
		"Murder",
		"Murder02",
		"MurderCop",
		"MurderCorpo",
		"NetFraud",
		"NetMayhem",
		"Occupation",
		"Pimping",
		"ProhibitedNet",
		"q110_pizza_easter_egg",
		"Racketeering",
		"ReverseEngineering",
		"SabotagingLifeSavingImplants",
		"SellingStolenImplants",
		"SexualAssault",
		"SIDForgery",
		"SIDTheft",
		"StealingLifeSavingImplants",
		"TradingXBD",
		"Trespassing",
		"UnlawfulDataAcquisition",
		"UnpaidDebt",
	"VandalCorp"}
	
	
	defaultFXlist="player"
	defaukltFX = "blackout"
	Fxobjectlist = {"player","npc","car","all"}
	
	
	
	
	
	arraySubDistrict =
	{
		"ArasakaWaterfront",
		"ArasakaWaterfront_AbandonedWarehouse",
		"ArasakaWaterfront_KonpekiPlaza",
		"Arroyo",
		"Arroyo_Arasaka_Warehouse",
		"Arroyo_ClairesGarage",
		"Arroyo_CytechFactory",
		"Arroyo_Kendachi",
		"Arroyo_KenmoreCafe",
		"Arroyo_LasPalapas",
		"Arroyo_Red_Dirt",
		"Arroyo_TireEmpire",
		
		"Badlands_BiotechnicaFlats",
		"Badlands_DryCreek",
		"Badlands_JacksonPlains",
		"Badlands_LagunaBend",
		"Badlands_LasPalapas",
		"Badlands_NorthSunriseOilField",
		"Badlands_RattlesnakeCreek",
		"Badlands_RedPeaks",
		"Badlands_RockyRidge",
		"Badlands_SantaClara",
		"Badlands_SierraSonora",
		"Badlands_SoCalBorderCrossing",
		"Badlands_VasquezPass",
		"Badlands_Yucca",
		"Badlands_YuccaGarage",
		"Badlands_YuccaRadioTower",
		
		"CharterHill_PowerPlant",
		
		"Coastview",
		"Coastview_BattysHotel",
		"Coastview_ButcherShop",
		"Coastview_GrandImperialMall",
		"Coastview_RundownApartment",
		"Coastview_VDBChapel",
		"Coastview_VDBMaglev",
		"Coastview_q110Cyberspace",
		"CorpoPlaza",
		"CorpoPlaza_ArasakaTowerAtrium",
		"CorpoPlaza_ArasakaTowerCEOFloor",
		"CorpoPlaza_ArasakaTowerJenkins",
		"CorpoPlaza_ArasakaTowerJungle",
		"CorpoPlaza_ArasakaTowerLobby",
		"CorpoPlaza_ArasakaTowerNest",
		"CorpoPlaza_ArasakaTowerSaburoOffice",
		"CorpoPlaza_ArasakaTowerUnlistedFloors",
		"CorpoPlaza_ArasakaTowerUpperAtrium",
		"CorpoPlaza_q201Cyberspace",
		"Downtown",
		"Downtown_Jinguji",
		"Downtown_TheHammer",
		"Glen",
		"Glen_Embers",
		"Glen_MusicStore",
		"Glen_NCPDLab",
		"Glen_WichedTires",
		
		"JapanTown",
		"JapanTown_Clouds",
		"JapanTown_DarkMatter",
		"JapanTown_Fingers",
		"JapanTown_FourthWallBdStudio",
		"JapanTown_HiromisApartment",
		"JapanTown_MegabuildingH8",
		"JapanTown_VR_Tutorial",
		"JapanTown_Wakakos_Pachinko_Parlor",
		"Kabuki",
		"Kabuki_JudysApartment",
		"Kabuki_LizziesBar",
		"Kabuki_NoTellMotel",
		"LagunaBend_LakeHut",
		"LittleChina",
		"LittleChina_Afterlife",
		"LittleChina_MistysShop",
		"LittleChina_Q101Cyberspace",
		"LittleChina_RiotClub",
		"LittleChina_TomsDiner",
		"LittleChina_VApartment",
		"LittleChina_VictorsClinic",
		"NorthBadlands",
		"NorthOaks",
		"NorthOaks_Arasaka_Estate",
		"NorthOaks_Columbarium",
		"NorthOaks_Denny_Estate",
		"NorthOaks_Kerry_Estate",
		"Northside",
		"Northside_All_Foods",
		"Northside_CleanCut",
		"Northside_Totentaz",
		"Northside_WNS",
		
		"RanchoCoronado",
		"RanchoCoronado_Caliente",
		"RanchoCoronado_GunORama",
		"RanchoCoronado_Piez",
		"RanchoCoronado_Softsys",
		"RanchoCoronado_Stylishly",
		
		"SouthBadlands",
		"SouthBadlands_EdgewoodFarm",
		"SouthBadlands_PoppyFarm",
		"SouthBadlands_TrailerPark",
		"SouthBadlands_q201SpaceStation",
		"VistaDelRey",
		"Vista_del_Rey_Delamain",
		"Vista_del_Rey_LaCatrina",
		"Vista_del_rey_Abandoned_Apartment_Building",
		"Vista_del_rey_ElCoyoteCojo",
		
		"Wellsprings",
		"WestWindEstate"
		
		
	}
	
	mappinTypeEnum  = {
		
		
		"ActionDealDamageVariant",
		"ActionFastSoloVariant",
		"ActionGenericInteractionVariant",
		"ActionNetrunnerAccessPointVariant",
		"ActionNetrunnerVariant",
		"ActionScanVariant",
		"ActionSoloVariant",
		"ActionTechieVariant",
		"AimVariant",
		"AllowVariant",
		"ApartmentVariant",
		"ArrowVariant",
		"BackOutVariant",
		"BountyHuntVariant",
		"CallVariant",
		"ChangeToFriendlyVariant",
		"ClientInDistressVariant",
		"ConversationVariant",
		"ConvoyVariant",
		"CoolVariant",
		"CourierVariant",
		"CustomPositionVariant",
		"CyberspaceNPC",
		"CyberspaceObject",
		"DefaultInteractionVariant",
		"DefaultQuestVariant",
		"DefaultVariant",
		"DistractVariant",
		"DropboxVariant",
		"DynamicEventVariant",
		"EffectAlarmVariant",
		"EffectControlNetworkVariant",
		"EffectControlOtherDeviceVariant",
		"EffectControlSelfVariant",
		"EffectCutPowerVariant",
		"EffectDistractVariant",
		"EffectDropPointVariant",
		"EffectExplodeLethalVariant",
		"EffectExplodeNonLethalVariant",
		"EffectFallVariant",
		"EffectGrantInformationVariant",
		"EffectHideBodyVariant",
		"EffectLootVariant",
		"EffectOpenPathVariant",
		"EffectPushVariant",
		"EffectServicePointVariant",
		"EffectShootVariant",
		"EffectSpreadGasVariant",
		"EffectStoreItemsVariant",
		"ExclamationMarkVariant",
		"FailedCrossingVariant",
		"FastTravelVariant",
		"FixerVariant",
		"FocusClueVariant",
		"GPSForcedPathVariant",
		"GPSPortalVariant",
		"GangWatchVariant",
		"GenericRoleVariant",
		"GetInVariant",
		"GetUpVariant",
		"GrenadeVariant",
		"GunSuicideVariant",
		"HandVariant",
		"HazardWarningVariant",
		"HiddenStashVariant",
		"HitVariant",
		"HuntForPsychoVariant",
		"ImportantInteractionVariant",
		"InvalidVariant",
		"JackInVariant",
		"JamWeaponVariant",
		"LifepathCorpoVariant",
		"LifepathNomadVariant",
		"LifepathStreetKidVariant",
		"LootVariant",
		"MinorActivityVariant",
		"NPCVariant",
		"NetrunnerAccessPointVariant",
		"NetrunnerSoloTechieVariant",
		"NetrunnerSoloVariant",
		"NetrunnerTechieVariant",
		"NetrunnerVariant",
		"NonLethalTakedownVariant",
		"OffVariant",
		"OpenVendorVariant",
		"OutpostVariant",
		"PhoneCallVariant",
		"QuestGiverVariant",
		"QuestionMarkVariant",
		"QuickHackVariant",
		"ReflexesVariant",
		"ResourceVariant",
		"RetrievingVariant",
		"SOSsignalVariant",
		"SabotageVariant",
		"ServicePointBarVariant",
		"ServicePointClothesVariant",
		"ServicePointCyberwareVariant",
		"ServicePointDropPointVariant",
		"ServicePointFoodVariant",
		"ServicePointGunsVariant",
		"ServicePointJunkVariant",
		"ServicePointMedsVariant",
		"ServicePointMeleeTrainerVariant",
		"ServicePointNetTrainerVariant",
		"ServicePointProstituteVariant",
		"ServicePointRipperdocVariant",
		"ServicePointTechVariant",
		"SitVariant",
		"SmugglersDenVariant",
		"SoloTechieVariant",
		"SoloVariant",
		"SpeechVariant",
		"TakeControlVariant",
		"TakeDownVariant",
		"TarotVariant",
		"TechieVariant",
		"ThieveryVariant",
		"UseVariant",
		"VehicleVariant",
		"WanderingMerchantVariant",
		"Zzz01_CarForPurchaseVariant",
		"Zzz02_MotorcycleForPurchaseVariant",
		"Zzz03_MotorcycleVariant",
		"CPO_PingDoorVariant",
		"CPO_PingGoHereVariant",
		"CPO_PingLootVariant",
		"CPO_RemotePlayerVariant",
		"Count",
		"Invalid"
	}
	
	
	statutEffect = {
	 "AdamSmasher.AdamSmasherOverload",
  "AdamSmasher.AdamSmasherStatus",
  "AdamSmasher.AdamSmasherStealthDot",
  "AdamSmasher.AdamSmasherStealthDotDamage",
  "AdamSmasher.AdamSmasherTakedownOverload",
  "AdamSmasher.AdamSmasherTakedownOverloadToBroken",
  "AdamSmasher.ArmorPhase1",
  "AdamSmasher.ArmorPhase2",
  "AdamSmasher.ArmorPhase3",
  "AdamSmasher.CounterState",
  "AdamSmasher.Destroyed_Plate",
  "AdamSmasher.Destroyed_Plate_Appearance_Effector",
  "AdamSmasher.Destroyed_Stage1",
  "AdamSmasher.Destroyed_Stage1_Appearance_Effector",
  "AdamSmasher.Destroyed_Stage2",
  "AdamSmasher.Destroyed_Stage2_Appearance_Effector",
  "AdamSmasher.Emergency",
  "AdamSmasher.EMP_Shield_Rocket_Barrage",
  "AdamSmasher.Follower_Smasher_Dps_Modifier",
  "AdamSmasher.Heal1",
  "AdamSmasher.Heal2",
  "AdamSmasher.Heal3",
  "AdamSmasher.InAir",
  "AdamSmasher.Invulnerable",
  "AdamSmasher.InvulnerableDefeated",
  "AdamSmasher.InvulnerableLimited",
  "AdamSmasher.InvulnerableWithHeal1",
  "AdamSmasher.InvulnerableWithHeal2",
  "AdamSmasher.InvulnerableWithHeal3",
  "AdamSmasher.IsInCEOFloor",
  "AdamSmasher.NoTakeDown",
  "AdamSmasher.OverloadWeakspotEffector",
  "AdamSmasher.Phase1",
  "AdamSmasher.Phase2",
  "AdamSmasher.Phase3",
  "AdamSmasher.ReduceDamageTransition",
  "AdamSmasher.Shooting",
  "AdamSmasher.Smashed",
  "AdamSmasher.Smasher_Parry_Bump_Back_Dps_Modifier",
  "AdamSmasher.Smasher_Single_Shot_Dps_Modifier",
  "AdamSmasher.SmasherAnimationActivator",
  "AdamSmasher.SmasherArmor",
  "AdamSmasher.Wounded",
  "AIQuickHackStatusEffect.BaseBuffQuickhack",
  "AIQuickHackStatusEffect.BeingHacked",
  "AIQuickHackStatusEffect.BeingHackedWithUntraceableHack",
  "AIQuickHackStatusEffect.BuffCamo",
  "AIQuickHackStatusEffect.BuffCapabilities",
  "AIQuickHackStatusEffect.BuffDamageReduction",
  "AIQuickHackStatusEffect.BuffICE",
  "AIQuickHackStatusEffect.BuffLocomotion",
  "AIQuickHackStatusEffect.BuffSturdiness",
  "AIQuickHackStatusEffect.HackBlind",
  "AIQuickHackStatusEffect.HackBurning",
  "AIQuickHackStatusEffect.HackCyberware",
  "AIQuickHackStatusEffect.HackDeathStaticNoise",
  "AIQuickHackStatusEffect.Hacking",
  "AIQuickHackStatusEffect.HackingInterrupted",
  "AIQuickHackStatusEffect.HackJamWeapon",
  "AIQuickHackStatusEffect.HackLocomotion",
  "AIQuickHackStatusEffect.HackLocomotionBase",
  "AIQuickHackStatusEffect.HackLocomotionTier2",
  "AIQuickHackStatusEffect.HackLocomotionTier3",
  "AIQuickHackStatusEffect.HackOverheat",
  "AIQuickHackStatusEffect.HackOverheatBase",
  "AIQuickHackStatusEffect.HackOverheatRibakov",
  "AIQuickHackStatusEffect.HackOverheatTier2",
  "AIQuickHackStatusEffect.HackOverheatTier3",
  "AIQuickHackStatusEffect.HackOverload",
  "AIQuickHackStatusEffect.HackReveal",
  "AIQuickHackStatusEffect.HackRevealInterrupted",
  "AIQuickHackStatusEffect.HackWeaponHud",
  "AIQuickHackStatusEffect.HackWeaponMalfunction",
  "AIQuickHackStatusEffect.HackWeaponMalfunctionBase",
  "AIQuickHackStatusEffect.NetrunnerStaticNoise",
  "AIQuickHackStatusEffect.QuickHack_GLP",
  "AIQuickHackStatusEffect.QuickHackEffect",
  "AIQuickHackStatusEffect.RevealPosition",
  "AIQuickHackStatusEffect.TrackedVirus",
  "BaseStatusEffect.AdvancedBerserk",
  "BaseStatusEffect.AdvancedBerserkDamageBonusStack",
  "BaseStatusEffect.AdvancedBerserkPlayerBuff",
  "BaseStatusEffect.AdvancedBerserkPlayerSFXEffector",
  "BaseStatusEffect.AirDrop_Burning",
  "BaseStatusEffect.AirDrop_Red_Effect",
  "BaseStatusEffect.AlcoholDebuff",
  "BaseStatusEffect.AllIconicCWFromTreasureChestPurchased",
  "BaseStatusEffect.AndroidHeadRemovedBlind",
  "BaseStatusEffect.AndroidTurnOff",
  "BaseStatusEffect.AndroidTurnOn",
  "BaseStatusEffect.Angelica_Buff",
  "BaseStatusEffect.AntiVirusCooldown",
  "BaseStatusEffect.ApplyExitCamoEffector",
  "BaseStatusEffect.ApplyExitCamoSoMiSQEffector",
  "BaseStatusEffect.Assault_Area_04_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Assault_Area_04_Perk_1_Buff_Level_2",
  "BaseStatusEffect.Assault_Area_07_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Assault_Trait_01_Buff",
  "BaseStatusEffect.Athletics_Trait_01_Buff",
  "BaseStatusEffect.AutoBlind",
  "BaseStatusEffect.AutoJam",
  "BaseStatusEffect.AutoLocomotion",
  "BaseStatusEffect.AutomaticReplenishmentCooldown",
  "BaseStatusEffect.AxeWeaponStealthBuff",
  "BaseStatusEffect.BarbedWireKnockdown",
  "BaseStatusEffect.BaseBlackWallHackEffect",
  "BaseStatusEffect.BaseBlindUI",
  "BaseStatusEffect.BaseBrainMelt",
  "BaseStatusEffect.BaseBurningUI",
  "BaseStatusEffect.BaseCommsNoise",
  "BaseStatusEffect.BaseContagionPoison",
  "BaseStatusEffect.BaseContagionPoisonDuration",
  "BaseStatusEffect.BaseControlQuickHackDuration",
  "BaseStatusEffect.BaseCovertQuickHackDuration",
  "BaseStatusEffect.BaseDurationMod",
  "BaseStatusEffect.BaseEMP",
  "BaseStatusEffect.BaseEmpGrenade",
  "BaseStatusEffect.BaseEMPUI",
  "BaseStatusEffect.BaseHoverJumpUI",
  "BaseStatusEffect.BaseOverheat",
  "BaseStatusEffect.BaseOverheatDuration",
  "BaseStatusEffect.BaseOverload",
  "BaseStatusEffect.BasePermaStatusEffect",
  "BaseStatusEffect.BaseQuickHackBlind",
  "BaseStatusEffect.BaseQuickHackDuration",
  "BaseStatusEffect.BaseQuickHackDurationBlind",
  "BaseStatusEffect.BaseQuickHackStatusEffect",
  "BaseStatusEffect.Bat_Malina_Frenzy_Buff",
  "BaseStatusEffect.Baton_Murphy_Brutality_Buff",
  "BaseStatusEffect.BeingCarried",
  "BaseStatusEffect.Berserk",
  "BaseStatusEffect.BerserkCooldown",
  "BaseStatusEffect.Berserker",
  "BaseStatusEffect.BerserkNPCBuff",
  "BaseStatusEffect.BerserkNPCDownState",
  "BaseStatusEffect.BerserkPlayerBuff",
  "BaseStatusEffect.BerserkPlayerSFXEffector",
  "BaseStatusEffect.BerserkTimeDilationEffector",
  "BaseStatusEffect.BikeKnockdown",
  "BaseStatusEffect.BioGrenade",
  "BaseStatusEffect.BlackLaceV0",
  "BaseStatusEffect.BlackLaceV1",
  "BaseStatusEffect.Blackmarket_CarryCapacityBooster",
  "BaseStatusEffect.Blackmarket_HealthBooster",
  "BaseStatusEffect.Blackmarket_MemoryBooster",
  "BaseStatusEffect.Blackmarket_StaminaBooster",
  "BaseStatusEffect.BlackwallCooldown",
  "BaseStatusEffect.BlackwallHack_FactHelper",
  "BaseStatusEffect.BlackwallHackBrainVFX",
  "BaseStatusEffect.BlackWallLight",
  "BaseStatusEffect.BlackWallMechanicalOverload",
  "BaseStatusEffect.BlackwallSQCooldown",
  "BaseStatusEffect.BlackWallUploadActive",
  "BaseStatusEffect.BladeMod2_FinisherBuff",
  "BaseStatusEffect.Bleeding",
  "BaseStatusEffect.BleedingInfinite",
  "BaseStatusEffect.Blind",
  "BaseStatusEffect.BlockBodyDisposal",
  "BaseStatusEffect.BlockBroken",
  "BaseStatusEffect.BlockCoverVisibilityReduction",
  "BaseStatusEffect.BlockFinisherStatusEffect",
  "BaseStatusEffect.BlockGrapple",
  "BaseStatusEffect.BlockNPCGrenadeBark",
  "BaseStatusEffect.BlockSkillProgressionTutorial",
  "BaseStatusEffect.BlockTargetingPlayer",
  "BaseStatusEffect.BlockTargetingPlayerAutoRemove",
  "BaseStatusEffect.BlockWorkspotFinisherStatusEffect",
  "BaseStatusEffect.BloodPumpBuff",
  "BaseStatusEffect.BloodswellPerkCooldown",
  "BaseStatusEffect.BoatRocking",
  "BaseStatusEffect.Body_Central_Perk_1_1_HealthRegenBuff",
  "BaseStatusEffect.Body_Central_Perk_1_2_Buff",
  "BaseStatusEffect.Body_Central_Perk_1_3_HealthRegenBuff",
  "BaseStatusEffect.Body_Central_Perk_1_4_MitigationBuff",
  "BaseStatusEffect.Body_DismemberExecuteChance_Stack",
  "BaseStatusEffect.Body_Left_Perk_3_3_Vulnerable",
  "BaseStatusEffect.Body_Right_Perk_2_3_Cooldown",
  "BaseStatusEffect.Body_Right_Perk_2_4_Vulnerable",
  "BaseStatusEffect.BonesMcCoy70V0",
  "BaseStatusEffect.BonesMcCoy70V1",
  "BaseStatusEffect.BonesMcCoy70V2",
  "BaseStatusEffect.BonesMcCoy70VEpic",
  "BaseStatusEffect.BonesMcCoy70VUncommon",
  "BaseStatusEffect.BoostAccuracyStatusEffect",
  "BaseStatusEffect.BorgStun",
  "BaseStatusEffect.BorisWardenUpgrade",
  "BaseStatusEffect.BossBaseBlackWallHackEffect",
  "BaseStatusEffect.BossBaseQuickHackBlind",
  "BaseStatusEffect.BossBlackWallHack",
  "BaseStatusEffect.BossControlhackReactionImmunity",
  "BaseStatusEffect.BossCyberwareMalfunction",
  "BaseStatusEffect.BossCyberwareMalfunctionLvl1",
  "BaseStatusEffect.BossCyberwareMalfunctionLvl2",
  "BaseStatusEffect.BossCyberwareMalfunctionLvl3",
  "BaseStatusEffect.BossCyberwareMalfunctionLvl4",
  "BaseStatusEffect.BossCyberwareMalfunctionLvl4PlusPlus",
  "BaseStatusEffect.BossGrenadeHackEffect",
  "BaseStatusEffect.BossHauntedBlackwallHackForceKill",
  "BaseStatusEffect.BossLocomotionMalfunction",
  "BaseStatusEffect.BossLocomotionMalfunctionLevel2",
  "BaseStatusEffect.BossLocomotionMalfunctionLevel3",
  "BaseStatusEffect.BossLocomotionMalfunctionLevel4",
  "BaseStatusEffect.BossMadness",
  "BaseStatusEffect.BossMemoryWipe",
  "BaseStatusEffect.BossMemoryWipeLevel2",
  "BaseStatusEffect.BossMemoryWipeLevel3",
  "BaseStatusEffect.BossMemoryWipeLevel4",
  "BaseStatusEffect.BossModerateBlind",
  "BaseStatusEffect.BossNoInterrupt",
  "BaseStatusEffect.BossNoTakeDown",
  "BaseStatusEffect.BossNoTakeDownInfinite",
  "BaseStatusEffect.BossOverheatLevel1",
  "BaseStatusEffect.BossOverheatLevel2",
  "BaseStatusEffect.BossOverheatLevel3",
  "BaseStatusEffect.BossOverheatLevel4",
  "BaseStatusEffect.BossOverheatLevel4PlusPlus",
  "BaseStatusEffect.BossQuickHackBlind",
  "BaseStatusEffect.BossQuickHackBlindLevel2",
  "BaseStatusEffect.BossQuickHackBlindLevel3",
  "BaseStatusEffect.BossQuickHackBlindLevel4",
  "BaseStatusEffect.BossShortBlind",
  "BaseStatusEffect.BossSuicide",
  "BaseStatusEffect.BossSystemCollapse",
  "BaseStatusEffect.BossSystemCollapseHackReactionImmunity",
  "BaseStatusEffect.BossTakedownCooldown",
  "BaseStatusEffect.BossWeaponMalfunction",
  "BaseStatusEffect.BossWeaponMalfunctionLvl2",
  "BaseStatusEffect.BossWeaponMalfunctionLvl3",
  "BaseStatusEffect.BossWeaponMalfunctionLvl4",
  "BaseStatusEffect.BossWeaponMalfunctionLvl4PlusPlus",
  "BaseStatusEffect.BoxingGym",
  "BaseStatusEffect.BrainMeltCooldown",
  "BaseStatusEffect.BrainMeltCostReductionSE",
  "BaseStatusEffect.BrainMeltLevel2",
  "BaseStatusEffect.BrainMeltLevel3",
  "BaseStatusEffect.BrainMeltLevel4",
  "BaseStatusEffect.BrainMeltLevel4PlusPlus",
  "BaseStatusEffect.BrainMeltQuestForceKill",
  "BaseStatusEffect.Brawling_Area_02_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_02_Perk_1_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_02_Perk_1_Buff_Level_3",
  "BaseStatusEffect.Brawling_Area_03_Perk_2_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_03_Perk_2_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_03_Perk_2_Buff_Level_3",
  "BaseStatusEffect.Brawling_Area_03_Perk_4_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_03_Perk_4_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_03_Perk_4_Buff_Level_3",
  "BaseStatusEffect.Brawling_Area_04_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_04_Perk_1_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_04_Perk_1_Buff_Level_3",
  "BaseStatusEffect.Brawling_Area_04_Perk_2_Vulnerable_Level_1",
  "BaseStatusEffect.Brawling_Area_04_Perk_2_Vulnerable_Level_2",
  "BaseStatusEffect.Brawling_Area_04_Perk_2_Vulnerable_Level_3",
  "BaseStatusEffect.Brawling_Area_04_Perk_3_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_04_Perk_3_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_04_Perk_3_Buff_Level_3",
  "BaseStatusEffect.Brawling_Area_04_Perk_4_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_04_Perk_4_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_04_Perk_4_Buff_Level_3",
  "BaseStatusEffect.Brawling_Area_07_Perk_2_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_07_Perk_2_Buff_Level_2",
  "BaseStatusEffect.Brawling_Area_08_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Brawling_Area_08_Perk_2_Buff_Level_1_Player",
  "BaseStatusEffect.Brawling_Area_08_Perk_2_Buff_Level_1_Weapon",
  "BaseStatusEffect.Brawling_Trait_01_Buff",
  "BaseStatusEffect.BreathingAbstract",
  "BaseStatusEffect.BreathingAnimationEffector",
  "BaseStatusEffect.BreathingHeavy",
  "BaseStatusEffect.BreathingLow",
  "BaseStatusEffect.BreathingMedium",
  "BaseStatusEffect.BreathingSick",
  "BaseStatusEffect.BrickStun",
  "BaseStatusEffect.BuffStatusEffect",
  "BaseStatusEffect.BurnGrenade",
  "BaseStatusEffect.Burning",
  "BaseStatusEffect.Burning_Tech_55",
  "BaseStatusEffect.BurningBuffEffector",
  "BaseStatusEffect.BurningParticleStatus",
  "BaseStatusEffect.BurningParticleStatusSFX",
  "BaseStatusEffect.BurningSFX",
  "BaseStatusEffect.Butchers_Cleaver_Bloodlust_Buff",
  "BaseStatusEffect.CallInCooldown",
  "BaseStatusEffect.CallReinforcement",
  "BaseStatusEffect.CameraAnimationAbstract",
  "BaseStatusEffect.CameraShakeAbstract",
  "BaseStatusEffect.CamoEffector",
  "BaseStatusEffect.CamoEffectorOda",
  "BaseStatusEffect.CamoSFXEffector",
  "BaseStatusEffect.CanDeflectTutorial",
  "BaseStatusEffect.CarFood",
  "BaseStatusEffect.Carnage_Edgerunners_Buff",
  "BaseStatusEffect.CarryCapacityBooster",
  "BaseStatusEffect.CarryCapacityPermaBonus",
  "BaseStatusEffect.Cassidy_Swap_Buff",
  "BaseStatusEffect.CatchMeIfYouCanBuff",
  "BaseStatusEffect.CatchMeIfYouCanCooldown",
  "BaseStatusEffect.CementPowder",
  "BaseStatusEffect.CerberusGrabAttackEffect01",
  "BaseStatusEffect.CerberusGrabAttackEffectBack",
  "BaseStatusEffect.CerberusGrabCheckPlayerOrientationEffect",
  "BaseStatusEffect.CerberusInPreAlerted",
  "BaseStatusEffect.CerberusRemovedDetection",
  "BaseStatusEffect.CerberusScanningVFXOff",
  "BaseStatusEffect.CerberusScanningVFXOn",
  "BaseStatusEffect.CerberusSkipPreAlerted",
  "BaseStatusEffect.Chao_Slaughter_Buff",
  "BaseStatusEffect.ChargeSystemCooldown",
  "BaseStatusEffect.CheckStatusEffect",
  "BaseStatusEffect.ChemicalResistanceFromChemicalDamage",
  "BaseStatusEffect.ChimeraBaseQuickHackBlind",
  "BaseStatusEffect.ChimeraBlackWallHack",
  "BaseStatusEffect.ChimeraMadness",
  "BaseStatusEffect.ChimeraMadnessCooldown",
  "BaseStatusEffect.ChimeraMeleeMod_BladeDismembers",
  "BaseStatusEffect.ChimeraMeleeMod_BluntDismembers",
  "BaseStatusEffect.ChimeraMeleeMod_HeadBlade",
  "BaseStatusEffect.ChimeraMeleeMod_HeadBlunt",
  "BaseStatusEffect.ChimeraMeleeMod_LeftArmBlade",
  "BaseStatusEffect.ChimeraMeleeMod_LeftArmBlunt",
  "BaseStatusEffect.ChimeraMeleeMod_LeftLegBlade",
  "BaseStatusEffect.ChimeraMeleeMod_LeftLegBlunt",
  "BaseStatusEffect.ChimeraMeleeMod_RightArmBlade",
  "BaseStatusEffect.ChimeraMeleeMod_RightArmBlunt",
  "BaseStatusEffect.ChimeraMeleeMod_RightLegBlade",
  "BaseStatusEffect.ChimeraMeleeMod_RightLegBlunt",
  "BaseStatusEffect.ChimeraQuickHackBlind",
  "BaseStatusEffect.ChimeraQuickHackBlindLevel2",
  "BaseStatusEffect.ChimeraQuickHackBlindLevel3",
  "BaseStatusEffect.ChimeraQuickHackBlindLevel4",
  "BaseStatusEffect.ChimeraSmartMod_Arms_Hack",
  "BaseStatusEffect.ChimeraSmartMod_Head_Hack",
  "BaseStatusEffect.ChimeraSmartMod_Legs_Hack",
  "BaseStatusEffect.ChimeraSmartMod_Torso_Hack",
  "BaseStatusEffect.ChimeraStompShake",
  "BaseStatusEffect.ChimeraSuicideCooldown",
  "BaseStatusEffect.ChimeraSystemCollapseCooldown",
  "BaseStatusEffect.ChimeraWeaponMalfunctionLvl2",
  "BaseStatusEffect.ChimeraWeaponMalfunctionLvl3",
  "BaseStatusEffect.ChimeraWeaponMalfunctionLvl4",
  "BaseStatusEffect.ChimeraWeaponMalfunctionLvl4PlusPlus",
  "BaseStatusEffect.Chingada_Madre_Buff",
  "BaseStatusEffect.Chingada_Madre_Fire_Buff",
  "BaseStatusEffect.Chingada_Madre_Helper_Buff",
  "BaseStatusEffect.ChokingHighDamage",
  "BaseStatusEffect.ChokingLowDamage",
  "BaseStatusEffect.ClimbingKnockdown",
  "BaseStatusEffect.Cloaked",
  "BaseStatusEffect.Cloaked_Exit",
  "BaseStatusEffect.Cloaked_Exit_SoMiSQ",
  "BaseStatusEffect.CloakedOda",
  "BaseStatusEffect.CloakedSoMiSQ",
  "BaseStatusEffect.CloudComputingUploadTimeReduction",
  "BaseStatusEffect.CocktailBleeding",
  "BaseStatusEffect.ColdBlood",
  "BaseStatusEffect.ColdBloodEnteringCritUpgrade",
  "BaseStatusEffect.ColdBloodEnteringResistancesUpgrade",
  "BaseStatusEffect.CombatFood3",
  "BaseStatusEffect.CombatHacking_Area_02_Perk_1_Buff_Level_1",
  "BaseStatusEffect.CombatHacking_Area_04_Perk_2_Buff",
  "BaseStatusEffect.CombatQuickHackStatusEffect",
  "BaseStatusEffect.CombatStim",
  "BaseStatusEffect.CombatStim_Hard",
  "BaseStatusEffect.CombatStim_VeryHard",
  "BaseStatusEffect.CommonEmpGrenade",
  "BaseStatusEffect.CommonFlashGrenade",
  "BaseStatusEffect.CommonFragGrenadeExplosion",
  "BaseStatusEffect.CommonLastingEffectBlind",
  "BaseStatusEffect.CommonPlusFlashGrenade",
  "BaseStatusEffect.CommsCallCombatTargetHelper",
  "BaseStatusEffect.CommsCallInLvl1",
  "BaseStatusEffect.CommsCallInLvl2",
  "BaseStatusEffect.CommsCallInLvl3",
  "BaseStatusEffect.CommsCallInLvl4",
  "BaseStatusEffect.CommsCallInLvl4PlusPlus",
  "BaseStatusEffect.CommsNoise",
  "BaseStatusEffect.CommsNoiseCooldown",
  "BaseStatusEffect.CommsNoiseLevel2",
  "BaseStatusEffect.CommsNoiseLevel3",
  "BaseStatusEffect.CommsNoiseLevel4",
  "BaseStatusEffect.ComradeStun",
  "BaseStatusEffect.ConsumableBuff",
  "BaseStatusEffect.ConsumablePoison",
  "BaseStatusEffect.ContagionCooldown",
  "BaseStatusEffect.ContagionPoison",
  "BaseStatusEffect.ContagionPoisonBounce2",
  "BaseStatusEffect.ContagionPoisonBounce3",
  "BaseStatusEffect.ContagionPoisonBounce4",
  "BaseStatusEffect.ContagionPoisonLvl2",
  "BaseStatusEffect.ContagionPoisonLvl3",
  "BaseStatusEffect.ContagionPoisonLvl4",
  "BaseStatusEffect.ContagionPoisonLvl4PlusPlus",
  "BaseStatusEffect.ControlQuickHackStatusEffect",
  "BaseStatusEffect.Cool_55_ExtendedStealth_Buff",
  "BaseStatusEffect.CooldownedSandevistanPlayerBuff",
  "BaseStatusEffect.CovertQuickHackStatusEffect",
  "BaseStatusEffect.CPO_FirstAidWhiff",
  "BaseStatusEffect.CPO_Shocked",
  "BaseStatusEffect.Crippled",
  "BaseStatusEffect.CrippledArm",
  "BaseStatusEffect.CrippledArmLeft",
  "BaseStatusEffect.CrippledArmRight",
  "BaseStatusEffect.CrippledHandLeft",
  "BaseStatusEffect.CrippledHandRight",
  "BaseStatusEffect.CrippledLeg",
  "BaseStatusEffect.CrippledLegLeft",
  "BaseStatusEffect.CrippledLegRight",
  "BaseStatusEffect.CritChanceFood",
  "BaseStatusEffect.CuttingGrenadeAttack",
  "BaseStatusEffect.CuttingGrenadeAttackPlus",
  "BaseStatusEffect.CWCapacity_DEBUGbuild_lvl20_PermaBonus",
  "BaseStatusEffect.CWCapacity_DEBUGbuild_lvl30_PermaBonus",
  "BaseStatusEffect.CWCapacity_Tier2_PermaBonus",
  "BaseStatusEffect.CWCapacity_Tier3_PermaBonus",
  "BaseStatusEffect.CWCapacity_Tier4_PermaBonus",
  "BaseStatusEffect.CWCapacity_Tier5_PermaBonus",
  "BaseStatusEffect.CyberspacePresence",
  "BaseStatusEffect.CyberwareBreachStreak",
  "BaseStatusEffect.CyberwareCooldownDuration",
  "BaseStatusEffect.CyberwareCooldownNotification",
  "BaseStatusEffect.CyberwareInstallationAnimation",
  "BaseStatusEffect.CyberwareInstallationAnimationBlackout",
  "BaseStatusEffect.CyberwareInstallationAnimationEnd",
  "BaseStatusEffect.CyberwareInstallationAnimationEndFast",
  "BaseStatusEffect.CyberwareInstallationAnimationFastForwardPossible",
  "BaseStatusEffect.CyberwareInstallationAnimationSFX",
  "BaseStatusEffect.CyberwareMalfunction",
  "BaseStatusEffect.CyberwareMalfunctionBlackwall",
  "BaseStatusEffect.CyberwareMalfunctionDamageOverTime",
  "BaseStatusEffect.CyberwareMalfunctionLvl1",
  "BaseStatusEffect.CyberwareMalfunctionLvl2",
  "BaseStatusEffect.CyberwareMalfunctionLvl3",
  "BaseStatusEffect.CyberwareMalfunctionLvl4",
  "BaseStatusEffect.CyberwareMalfunctionLvl4PlusPlus",
  "BaseStatusEffect.CyberwareMalfunctionWeakspotDestructionAbsentPereq",
  "BaseStatusEffect.CyberwareMalfunctionWeakspotDestructionAppliedPereq",
  "BaseStatusEffect.CyberwareShutdown",
  "BaseStatusEffect.CyberwareTutorialAdjustments",
  "BaseStatusEffect.DamageBoostFromDamageReceived",
  "BaseStatusEffect.DamageHackNoReaction",
  "BaseStatusEffect.Dante_Long_Range_Buff",
  "BaseStatusEffect.DeactivateBerserkStatusEffects",
  "BaseStatusEffect.DeactivateCloakedOdatatusEffects",
  "BaseStatusEffect.DeactivateCloakedtatusEffects",
  "BaseStatusEffect.DeactivateMaskedStatusEffects",
  "BaseStatusEffect.DeadeyeJustEndedSE",
  "BaseStatusEffect.DeadeyeQuickReloadSE",
  "BaseStatusEffect.DeadeyeSE",
  "BaseStatusEffect.Deaf",
  "BaseStatusEffect.DebuffStatusEffect",
  "BaseStatusEffect.Debug_EnableFinisher",
  "BaseStatusEffect.DecreaseSmartWeaponHitProbability",
  "BaseStatusEffect.Defeated",
  "BaseStatusEffect.DefeatedAIData",
  "BaseStatusEffect.DefeatedFinisherWorkspot",
  "BaseStatusEffect.DefeatedWithRecover",
  "BaseStatusEffect.Definition_Of_Madness_Rook_Buff",
  "BaseStatusEffect.Demolition_Area_02_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Demolition_Area_05_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Demolition_Area_05_Perk_1_Buff_Level_2",
  "BaseStatusEffect.Demolition_Area_05_Perk_1_Buff_Level_3",
  "BaseStatusEffect.Demolition_Area_07_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Demolition_Area_07_Perk_2_Buff_Level_1",
  "BaseStatusEffect.Demolition_Trait_01_Buff",
  "BaseStatusEffect.DetectorRushAvailableStatusEffect",
  "BaseStatusEffect.DetectorRushCooldown",
  "BaseStatusEffect.DetectorRushPlayerBuffCommon",
  "BaseStatusEffect.DetectorRushPlayerBuffCommonPlus",
  "BaseStatusEffect.DetectorRushPlayerBuffEpic",
  "BaseStatusEffect.DetectorRushPlayerBuffEpicPlus",
  "BaseStatusEffect.DetectorRushPlayerBuffLegendary",
  "BaseStatusEffect.DetectorRushPlayerBuffLegendaryPlus",
  "BaseStatusEffect.DetectorRushPlayerBuffLegendaryPlusPlus",
  "BaseStatusEffect.DetectorRushPlayerBuffRare",
  "BaseStatusEffect.DetectorRushPlayerBuffRarePlus",
  "BaseStatusEffect.DetectorRushPlayerBuffUncommon",
  "BaseStatusEffect.DetectorRushPlayerBuffUncommonPlus",
  "BaseStatusEffect.DeviceExplosionInvulnerability",
  "BaseStatusEffect.DeviceTrapHit",
  "BaseStatusEffect.DieInOneHit",
  "BaseStatusEffect.Dino_Slaughter_Buff",
  "BaseStatusEffect.DisableCyberware",
  "BaseStatusEffect.DisableCyberwareAndCyberwareStatusEffects",
  "BaseStatusEffect.DisableTargetingEffector",
  "BaseStatusEffect.Dismembered",
  "BaseStatusEffect.DismemberedArm",
  "BaseStatusEffect.DismemberedArmLeft",
  "BaseStatusEffect.DismemberedArmRight",
  "BaseStatusEffect.DismemberedHandLeft",
  "BaseStatusEffect.DismemberedHandRight",
  "BaseStatusEffect.DismemberedLeg",
  "BaseStatusEffect.DismemberedLegLeft",
  "BaseStatusEffect.DismemberedLegRight",
  "BaseStatusEffect.DistractionDuration",
  "BaseStatusEffect.DodgeAirBuff",
  "BaseStatusEffect.DodgeAirCooldown",
  "BaseStatusEffect.DodgeBuff",
  "BaseStatusEffect.DodgeBuffCooldown",
  "BaseStatusEffect.DodgeCooldown",
  "BaseStatusEffect.DodgeInvulnerability",
  "BaseStatusEffect.DodgeOutOfSightCooldown",
  "BaseStatusEffect.DoNotBlockShootingOnFriendlyFire",
  "BaseStatusEffect.DoNotUseVehicle",
  "BaseStatusEffect.DontShootAtMe",
  "BaseStatusEffect.DoTStatusEffect",
  "BaseStatusEffect.DrillingShakeHeavy",
  "BaseStatusEffect.DrillingShakeMedium",
  "BaseStatusEffect.DrillingShakeNormal",
  "BaseStatusEffect.DriverCombat",
  "BaseStatusEffect.DriverCombatHandgunFPPVFXScale",
  "BaseStatusEffect.DriverCombatHandgunVFXScale",
  "BaseStatusEffect.DriverCombatMountedWeaponVFXScale",
  "BaseStatusEffect.DriverCombatPistol",
  "BaseStatusEffect.DriverCombatRevolverFPPVFXScale",
  "BaseStatusEffect.DriverCombatRevolverVFXScale",
  "BaseStatusEffect.DriverCombatSMGFPPVFXScale",
  "BaseStatusEffect.DriverCombatSMGVFXScale",
  "BaseStatusEffect.DriverCombatSwayPause",
  "BaseStatusEffect.DriverCombatSwayRemoval",
  "BaseStatusEffect.DriverCombatVehicleManeuvers",
  "BaseStatusEffect.Drugged",
  "BaseStatusEffect.DruggedSevere",
  "BaseStatusEffect.DruggedSevereSFX",
  "BaseStatusEffect.DruggedSFX",
  "BaseStatusEffect.Drunk",
  "BaseStatusEffect.DrunkSFX",
  "BaseStatusEffect.EdgerunnersStun",
  "BaseStatusEffect.ElectricResistanceFromElectricDamage",
  "BaseStatusEffect.ElectrifiedWaterElectrocute",
  "BaseStatusEffect.Electrocuted",
  "BaseStatusEffect.ElectrocutedNoDamage",
  "BaseStatusEffect.ElectrocutedParticleStatus",
  "BaseStatusEffect.ElectrocutedParticleStatusSFX",
  "BaseStatusEffect.ElectrocutedSFX",
  "BaseStatusEffect.ElectroshockMechanismCooldown",
  "BaseStatusEffect.EMP",
  "BaseStatusEffect.EmpCyberwareTurnedOff",
  "BaseStatusEffect.EmpHighDamage",
  "BaseStatusEffect.EmpJamWeaponAccuracyDebuff",
  "BaseStatusEffect.EmpJamWeaponChance",
  "BaseStatusEffect.EmpLowDamage",
  "BaseStatusEffect.EMPReed",
  "BaseStatusEffect.EmpSFX",
  "BaseStatusEffect.EmpVeryHighDamage",
  "BaseStatusEffect.EmpVeryLowDamage",
  "BaseStatusEffect.EmpVeryLowDamageQuickhack",
  "BaseStatusEffect.Encumbered",
  "BaseStatusEffect.EnemyNetrunnerEmpHighDamage",
  "BaseStatusEffect.EpicBioGrenade",
  "BaseStatusEffect.EpicBurnGrenade",
  "BaseStatusEffect.EpicEmpGrenade",
  "BaseStatusEffect.EpicFlashGrenade",
  "BaseStatusEffect.EpicFragGrenadeExplosion",
  "BaseStatusEffect.EpicLastingEffectBlind",
  "BaseStatusEffect.EpicPlusBioGrenade",
  "BaseStatusEffect.EpicPlusBurnGrenade",
  "BaseStatusEffect.EpicPlusFlashGrenade",
  "BaseStatusEffect.Espionage_Central_Milestone_1_Buff_MantisBlades",
  "BaseStatusEffect.Exhausted",
  "BaseStatusEffect.ExhaustionStun",
  "BaseStatusEffect.ExplosionStun",
  "BaseStatusEffect.FastFinisherSE",
  "BaseStatusEffect.FatalElectrocutedParticleStatus",
  "BaseStatusEffect.FatigueStun",
  "BaseStatusEffect.Finisher_Healing_Buff",
  "BaseStatusEffect.FinisherActiveStatusEffect",
  "BaseStatusEffect.FirstAidWhiff",
  "BaseStatusEffect.FirstAidWhiffV0",
  "BaseStatusEffect.FirstAidWhiffV1",
  "BaseStatusEffect.FirstAidWhiffV2",
  "BaseStatusEffect.FirstAidWhiffVEpic",
  "BaseStatusEffect.FirstAidWhiffVUncommon",
  "BaseStatusEffect.FlatheadControl",
  "BaseStatusEffect.FocusedCoolPerkSE",
  "BaseStatusEffect.FocusedDelayedStaminaConsumptionSE",
  "BaseStatusEffect.FollowerDefeatedEasy",
  "BaseStatusEffect.FollowerDefeatedHard",
  "BaseStatusEffect.FollowerDefeatedStory",
  "BaseStatusEffect.FollowerDefeatedVeryHard",
  "BaseStatusEffect.FollowerDontLeaveStealth",
  "BaseStatusEffect.FollowerVisibilityTargeting",
  "BaseStatusEffect.ForceAllowAnyDirectionDodge",
  "BaseStatusEffect.ForceAllowTechWeaponDodge",
  "BaseStatusEffect.ForceCritOnNextThrowSE",
  "BaseStatusEffect.ForceDive",
  "BaseStatusEffect.ForcedQHUploadAwarenessBumps",
  "BaseStatusEffect.ForceKill",
  "BaseStatusEffect.ForceKillFromRagdoll",
  "BaseStatusEffect.ForceShoot",
  "BaseStatusEffect.ForceStagger",
  "BaseStatusEffect.ForceSwim",
  "BaseStatusEffect.ForceVisibility",
  "BaseStatusEffect.Gag",
  "BaseStatusEffect.GagOpportunity",
  "BaseStatusEffect.GenericTalkDisabled",
  "BaseStatusEffect.GlowingTattoos",
  "BaseStatusEffect.GorillaArmsOnePunchNPCMark",
  "BaseStatusEffect.GorillaArmsSpyBuff",
  "BaseStatusEffect.Grad_Buck_Demolition_Buff",
  "BaseStatusEffect.Grappled",
  "BaseStatusEffect.GreaterReducedVisibility",
  "BaseStatusEffect.GreaterSpreadFear",
  "BaseStatusEffect.GreaterSuppressNoise",
  "BaseStatusEffect.GrenadeCooldown",
  "BaseStatusEffect.GroundSlamCooldown",
  "BaseStatusEffect.GunRange",
  "BaseStatusEffect.Gunslinger_Area_04_Perk_3_Buff_Level_1",
  "BaseStatusEffect.Gunslinger_Area_08_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Gunslinger_Area_10_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Gunslinger_Trait_01_Buff",
  "BaseStatusEffect.GunslingerArea04Perk3Cooldown",
  "BaseStatusEffect.GunslingerProficiencyTutorial",
  "BaseStatusEffect.HackingTutorialStage01PingUsed",
  "BaseStatusEffect.Haunted_Deck_Equipped",
  "BaseStatusEffect.Haunted_Weapon_Kill_Human",
  "BaseStatusEffect.Haunted_Weapon_Kill_Mechanical",
  "BaseStatusEffect.HauntedBlackwallAfterKill",
  "BaseStatusEffect.HauntedBlackwallForceKill",
  "BaseStatusEffect.HauntedGunBlackWallForceKill",
  "BaseStatusEffect.HauntedGunBlackwallUpload",
  "BaseStatusEffect.HauntedQuickHackBlackwallUpload",
  "BaseStatusEffect.Headsman_Buff",
  "BaseStatusEffect.HealFood3",
  "BaseStatusEffect.HealingItemMinusFood",
  "BaseStatusEffect.HealingItemPlusFood",
  "BaseStatusEffect.Health_Regen",
  "BaseStatusEffect.HealthBooster",
  "BaseStatusEffect.HealthMonitor",
  "BaseStatusEffect.HealthMonitorCooldown",
  "BaseStatusEffect.HealthRegeneration",
  "BaseStatusEffect.HearingImpaired",
  "BaseStatusEffect.HeartAttack",
  "BaseStatusEffect.HeatUsingBoosterDummyEffect",
  "BaseStatusEffect.HeavyPoision",
  "BaseStatusEffect.HeavyStun",
  "BaseStatusEffect.Hercules_Poison",
  "BaseStatusEffect.HGMod1_Buff",
  "BaseStatusEffect.HGMod2_EquipBuff",
  "BaseStatusEffect.HighPitchNoiseCooldown",
  "BaseStatusEffect.Hitman_Combat_Buff",
  "BaseStatusEffect.HitReactionKnockdown",
  "BaseStatusEffect.HitReactionStagger",
  "BaseStatusEffect.HitReactionTBHCooldown",
  "BaseStatusEffect.HoverJumpCooldown",
  "BaseStatusEffect.HoverJumpPlayerBuff",
  "BaseStatusEffect.HumanShield",
  "BaseStatusEffect.ICECounterHackCooldown",
  "BaseStatusEffect.IconicCyberwareCooldown",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffEpic",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffEpicPlus",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffLegendary",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffLegendaryPlus",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffLegendaryPlusPlus",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffRare",
  "BaseStatusEffect.IconicDetectorRushPlayerBuffRarePlus",
  "BaseStatusEffect.IconicPunkKnifeRemoveCooldownsSE",
  "BaseStatusEffect.IconicPunkKnifeTag",
  "BaseStatusEffect.IgnoreWeaponSafe",
  "BaseStatusEffect.ImpactedThrownNPC",
  "BaseStatusEffect.IncreaseDamageOfNextMeleeAttackWithThrownWeaponSE",
  "BaseStatusEffect.IncreaseSmartTargetingDisruptionProbability",
  "BaseStatusEffect.InhalerBuff",
  "BaseStatusEffect.InjectorBuff",
  "BaseStatusEffect.Intelligence_60_Ping",
  "BaseStatusEffect.Intelligence_60_Ping_Aura",
  "BaseStatusEffect.Intelligence_Central_Milestone_3_Overclock_Buff",
  "BaseStatusEffect.Intelligence_Central_Perk_3_3_Buff",
  "BaseStatusEffect.Intelligence_Inbetween_Left_2_Buff",
  "BaseStatusEffect.Intelligence_Inbetween_Left_2_lvl2_Buff",
  "BaseStatusEffect.Intelligence_Master_Perk_2_Queue_Lock",
  "BaseStatusEffect.Intelligence_Master_Perk_4_Overclock_Buff",
  "BaseStatusEffect.Intelligence_Master_Perk_4_Overclock_Target_Weakspot",
  "BaseStatusEffect.Intelligence_Right_Perk_3_2_Buff",
  "BaseStatusEffect.InvisibleKillMovementSpeedBonusSE",
  "BaseStatusEffect.Invulnerable",
  "BaseStatusEffect.InvulnerableAfterDefeated",
  "BaseStatusEffect.InvulnerableShort",
  "BaseStatusEffect.JamCommuniations",
  "BaseStatusEffect.JamWeaponUI",
  "BaseStatusEffect.JenkinsCooldown",
  "BaseStatusEffect.JenkinsPlayerBuff",
  "BaseStatusEffect.JohnnySicknessAbstract",
  "BaseStatusEffect.JohnnySicknessHeavy",
  "BaseStatusEffect.JohnnySicknessLow",
  "BaseStatusEffect.JohnnySicknessMedium",
  "BaseStatusEffect.JohnnySicknessMediumQuest",
  "BaseStatusEffect.JohnnySicknessUI",
  "BaseStatusEffect.JuggernautBuff",
  "BaseStatusEffect.JugglerCriticalDamageBonusSE",
  "BaseStatusEffect.JugglerPerkRemoveKnifeCooldownsSE",
  "BaseStatusEffect.JustDestroyedWeakspot",
  "BaseStatusEffect.JustDodgedBuffer",
  "BaseStatusEffect.JustLootedAmazonIconicFromAirdrop",
  "BaseStatusEffect.JustLootedIconicCWFromAirdrop",
  "BaseStatusEffect.JustLootedIconicCWFromTreasureChest",
  "BaseStatusEffect.JustPurchasedBodySkillBookAtShankVendor",
  "BaseStatusEffect.JustPurchasedCoolSkillBookAtShankVendor",
  "BaseStatusEffect.JustPurchasedIntSkillBookAtShankVendor",
  "BaseStatusEffect.JustPurchasedNueJackieAtBM",
  "BaseStatusEffect.JustPurchasedRefSkillBookAtShankVendor",
  "BaseStatusEffect.JustPurchasedSkillBookAtShankVendorBase",
  "BaseStatusEffect.JustPurchasedTechSkillBookAtShankVendor",
  "BaseStatusEffect.Kappa_George_Motionless_Buff",
  "BaseStatusEffect.Kappa_George_Swap_Buff",
  "BaseStatusEffect.Katana_Saburo_Bleeding",
  "BaseStatusEffect.Kenjutsu_Area_02_Perk_4_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_02_Perk_4_Buff_Level_2",
  "BaseStatusEffect.Kenjutsu_Area_02_Perk_4_Buff_Level_3",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_2_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_2_Buff_Level_2",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_2_Buff_Level_3",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_3_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_3_Buff_Level_2",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_3_Buff_Level_3",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_4_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_4_Buff_Level_2",
  "BaseStatusEffect.Kenjutsu_Area_03_Perk_4_Buff_Level_3",
  "BaseStatusEffect.Kenjutsu_Area_04_Perk_3_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_04_Perk_4_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_04_Perk_4_Buff_Level_2",
  "BaseStatusEffect.Kenjutsu_Area_04_Perk_4_Buff_Level_3",
  "BaseStatusEffect.Kenjutsu_Area_05_Perk_1_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_05_Perk_1_Buff_Level_2",
  "BaseStatusEffect.Kenjutsu_Area_06_Perk_2_Buff_Level_1",
  "BaseStatusEffect.Kenjutsu_Area_06_Perk_3_Buff_Level_1",
  "BaseStatusEffect.KenjutsuBleeding",
  "BaseStatusEffect.KenshinWeaponChargedBurst_Effect",
  "BaseStatusEffect.KenshinWeaponChargedBurst_Trigger",
  "BaseStatusEffect.KerenzikovBuff",
  "BaseStatusEffect.KerenzikovCooldown",
  "BaseStatusEffect.KerenzikovPlayerBuff",
  "BaseStatusEffect.KerenzikovsBoostSystemBuff",
  "BaseStatusEffect.Kerry_Buff",
  "BaseStatusEffect.KiroshiCooldown",
  "BaseStatusEffect.KiroshiHighlightsBase",
  "BaseStatusEffect.KnifeNeurotoxin",
  "BaseStatusEffect.KnifePoison",
  "BaseStatusEffect.KnifeSharpenerBuff",
  "BaseStatusEffect.KnifeWeaponStealthBuff",
  "BaseStatusEffect.Knockdown",
  "BaseStatusEffect.KnockdownInfinite",
  "BaseStatusEffect.KurtKnifeRemoveCooldownsSE",
  "BaseStatusEffect.KurtKnifeStatusEffect",
  "BaseStatusEffect.KurtMeleeTakedownCooldownSE",
  "BaseStatusEffect.KurtSuicideWithGrenade",
  "BaseStatusEffect.KurtTakedown_01_Effect",
  "BaseStatusEffect.KurtTakedown_01AttackDamage",
  "BaseStatusEffect.KurtTakedown_01AttackDamage_Stab",
  "BaseStatusEffect.KurtTakedown_02_Effect",
  "BaseStatusEffect.KurtTakedown_02AttackDamage_1",
  "BaseStatusEffect.KurtTakedown_02AttackDamage_2",
  "BaseStatusEffect.KurtTakedown_02AttackDamage_3",
  "BaseStatusEffect.KurtTakedown_BaseAttack",
  "BaseStatusEffect.KurtTakedown01AttackDamage",
  "BaseStatusEffect.KurtTakedownKnifeStatusEffect",
  "BaseStatusEffect.KurtTakedownKnockdown",
  "BaseStatusEffect.Kurtz_Knife_CrippledLegLeft",
  "BaseStatusEffect.Kurtz_Knife_CrippledLegRight",
  "BaseStatusEffect.Kurtz_Metel_DismemberedLegLeft",
  "BaseStatusEffect.Kurtz_Metel_DismemberedLegRight",
  "BaseStatusEffect.KyubiMyersTag",
  "BaseStatusEffect.LeapWithMantisBladesCheck",
  "BaseStatusEffect.LegendaryBioGrenade",
  "BaseStatusEffect.LegendaryBurnGrenade",
  "BaseStatusEffect.LegendaryEffectBlind",
  "BaseStatusEffect.LegendaryEmpGrenade",
  "BaseStatusEffect.LegendaryFlashGrenade",
  "BaseStatusEffect.LegendaryFragGrenadeExplosion",
  "BaseStatusEffect.LegendaryPlusBioGrenade",
  "BaseStatusEffect.LegendaryPlusBurnGrenade",
  "BaseStatusEffect.LegendaryPlusFlashGrenade",
  "BaseStatusEffect.Liberty_Padre_Burning",
  "BaseStatusEffect.Liberty_Padre_BurningChanceBuff",
  "BaseStatusEffect.LightBurning_Tech_55",
  "BaseStatusEffect.LightPoision",
  "BaseStatusEffect.LimfaticNanoChargeSystemBuff",
  "BaseStatusEffect.LocomotionExpHarvested",
  "BaseStatusEffect.LocomotionMalfunction",
  "BaseStatusEffect.LocomotionMalfunctionKappa",
  "BaseStatusEffect.LocomotionMalfunctionLevel2",
  "BaseStatusEffect.LocomotionMalfunctionLevel3",
  "BaseStatusEffect.LocomotionMalfunctionLevel4",
  "BaseStatusEffect.LongEmpCyberwareTurnedOff",
  "BaseStatusEffect.LongerLastingPoisonDebuff",
  "BaseStatusEffect.LongLastingPoisonDebuff",
  "BaseStatusEffect.LoreAnim",
  "BaseStatusEffect.LoreVictimSaved",
  "BaseStatusEffect.LoseControlPerkCooldown",
  "BaseStatusEffect.LowAccuracy",
  "BaseStatusEffect.Madness",
  "BaseStatusEffect.MadnessCooldown",
  "BaseStatusEffect.MagnetDevice_NPC",
  "BaseStatusEffect.MagnetDeviceHit",
  "BaseStatusEffect.MainBossSE",
  "BaseStatusEffect.MajorBlind",
  "BaseStatusEffect.MajorQuickHackBlind",
  "BaseStatusEffect.MajorVulnerable",
  "BaseStatusEffect.MandessLevel4",
  "BaseStatusEffect.MandessLevel4PlusPlus",
  "BaseStatusEffect.MantisBladesGrandFinaleBleeding",
  "BaseStatusEffect.MantisBladesGrandFinaleNPCMark",
  "BaseStatusEffect.MantisBladesInstantDismembermentSpyBuff",
  "BaseStatusEffect.MantisBladesInvulnerableLeapRelicBuff",
  "BaseStatusEffect.MantisBladesRelicDismemberment",
  "BaseStatusEffect.MantisBladesSpecialAttackSpyBuff",
  "BaseStatusEffect.MaxTacAlone",
  "BaseStatusEffect.MaxtacCloaked",
  "BaseStatusEffect.MaxtacFightStartHelperStatus",
  "BaseStatusEffect.MediumBurning",
  "BaseStatusEffect.MeleeAttackWithThrowableHitPrereq",
  "BaseStatusEffect.MeleeDamageFood",
  "BaseStatusEffect.MeleeMod1_InAirBuff",
  "BaseStatusEffect.MeleeMod1_SpamStopper",
  "BaseStatusEffect.MeleeMod1_SpamZone",
  "BaseStatusEffect.MeleeMod2_AttackSpeedBuff",
  "BaseStatusEffect.MeleeMod2_InfiniteCombo",
  "BaseStatusEffect.MeleeMod2_JustFinishedSprint",
  "BaseStatusEffect.MeleeMod2_Listener",
  "BaseStatusEffect.MeleeMod3_CritBuff",
  "BaseStatusEffect.MeleeMod3_Listener",
  "BaseStatusEffect.MeleePerkStun",
  "BaseStatusEffect.MeleeWeaponBuffUI",
  "BaseStatusEffect.MemoryBooster",
  "BaseStatusEffect.MemoryWipe",
  "BaseStatusEffect.MemoryWipeCooldown",
  "BaseStatusEffect.MemoryWipeExitCombat",
  "BaseStatusEffect.MemoryWipeImmunity",
  "BaseStatusEffect.MemoryWipeLevel2",
  "BaseStatusEffect.MemoryWipeLevel2Police",
  "BaseStatusEffect.MemoryWipeLevel3",
  "BaseStatusEffect.MemoryWipeLevel4",
  "BaseStatusEffect.MemoryWipeOnDodge",
  "BaseStatusEffect.MemoryWipeOnOpticalCamoActivated",
  "BaseStatusEffect.MemoryWipeSquad",
  "BaseStatusEffect.MetelKurtMod_Dismembers",
  "BaseStatusEffect.MetelKurtMod_Head",
  "BaseStatusEffect.MetelKurtMod_LeftArm",
  "BaseStatusEffect.MetelKurtMod_LeftLeg",
  "BaseStatusEffect.MetelKurtMod_RightArm",
  "BaseStatusEffect.MetelKurtMod_RightLeg",
  "BaseStatusEffect.MinorBleeding",
  "BaseStatusEffect.MinorBlind",
  "BaseStatusEffect.ModerateBlind",
  "BaseStatusEffect.MonowireGrapple",
  "BaseStatusEffect.MonoWireQuickhackApliedBySpread",
  "BaseStatusEffect.MonoWireQuickhackContagiousHittableTarget",
  "BaseStatusEffect.Moron_Slaughter_Buff",
  "BaseStatusEffect.Moron_Slow_Down",
  "BaseStatusEffect.Moron_Slow_Down2",
  "BaseStatusEffect.Moron_Speed_Up",
  "BaseStatusEffect.Mox_Buff",
  "BaseStatusEffect.MuteAudioStims",
  "BaseStatusEffect.mws_se5_03_damage_vfx",
  "BaseStatusEffect.mws_se5_03_katana_vfx",
  "BaseStatusEffect.MyersNoCarCombat",
  "BaseStatusEffect.MyersNoTeleport",
  "BaseStatusEffect.NanoTechPlatesBlockIndication",
  "BaseStatusEffect.NanoTechPlatesMainEffect",
  "BaseStatusEffect.NanoTechPlatesUnavailableStatusEffect",
  "BaseStatusEffect.NetrunnerRAMFood",
  "BaseStatusEffect.NetrunnerRAMRegenFood",
  "BaseStatusEffect.NetwatcherGeneral",
  "BaseStatusEffect.NeurotoxinDelayedStun",
  "BaseStatusEffect.NeurotoxinHeadshotDelayedStun",
  "BaseStatusEffect.NewMicrogeneratorBuff",
  "BaseStatusEffect.NewMicrogeneratorBuffLinger",
  "BaseStatusEffect.NewPerkFinisherStun",
  "BaseStatusEffect.NicolasStun",
  "BaseStatusEffect.NoCombatWithQuickhacks",
  "BaseStatusEffect.NoCooldownedSandevistanGlitch",
  "BaseStatusEffect.NoCover",
  "BaseStatusEffect.NoCyberware",
  "BaseStatusEffect.NonInteractable",
  "BaseStatusEffect.NoPainNoGainBuff",
  "BaseStatusEffect.NoSandevistanGlitch",
  "BaseStatusEffect.NoShoot",
  "BaseStatusEffect.NotJustDestroyedWeakspotPrereq",
  "BaseStatusEffect.NPCBaseMeleeDebuff",
  "BaseStatusEffect.NPCForceEquipPrimaryWeapon",
  "BaseStatusEffect.NPCForceEquipSecondaryWeapon",
  "BaseStatusEffect.NPCForceStagger",
  "BaseStatusEffect.NpcMeleeAttackBleeding",
  "BaseStatusEffect.NpcMeleeAttackStun",
  "BaseStatusEffect.NpcSMasherMeleeAttackStun",
  "BaseStatusEffect.OdaSuicideWithGrenade",
  "BaseStatusEffect.OnAdvancedBerserkEndedStatusEffect",
  "BaseStatusEffect.OpticalCamo_Cool_40",
  "BaseStatusEffect.OpticalCamo_Cool_40_Cooldown",
  "BaseStatusEffect.OpticalCamoCooldownNotification",
  "BaseStatusEffect.OpticalCamoCoolPerkShort",
  "BaseStatusEffect.OpticalCamoPerkRestriction",
  "BaseStatusEffect.OpticalCamoPlayerBuffBase",
  "BaseStatusEffect.OpticalCamoPlayerBuffBase_HighTier",
  "BaseStatusEffect.OpticalCamoPlayerBuffBase_LowTier",
  "BaseStatusEffect.OpticalCamoPlayerBuffBaseEpic",
  "BaseStatusEffect.OpticalCamoPlayerBuffBaseLegendary",
  "BaseStatusEffect.OpticalCamoPlayerBuffBaseRare",
  "BaseStatusEffect.OpticalCamoPlayerBuffBaseUncommon",
  "BaseStatusEffect.OpticalCamoPlayerBuffCommon",
  "BaseStatusEffect.OpticalCamoPlayerBuffEpic",
  "BaseStatusEffect.OpticalCamoPlayerBuffLegendary",
  "BaseStatusEffect.OpticalCamoPlayerBuffRare",
  "BaseStatusEffect.OpticalCamoPlayerBuffUncommon",
  "BaseStatusEffect.OpticalCamoPlayerSFXEffector",
  "BaseStatusEffect.Osprey_Headshot_Buff",
  "BaseStatusEffect.Osprey_Multikill_Buff",
  "BaseStatusEffect.OutOfOxygen",
  "BaseStatusEffect.OutOfOxygenSFX",
  "BaseStatusEffect.Overheat",
  "BaseStatusEffect.OverheatAppliedPereq",
  "BaseStatusEffect.OverheatCooldown",
  "BaseStatusEffect.OverheatGrisGris",
  "BaseStatusEffect.OverheatLevel1",
  "BaseStatusEffect.OverheatLevel2",
  "BaseStatusEffect.OverheatLevel3",
  "BaseStatusEffect.OverheatLevel4",
  "BaseStatusEffect.OverheatLevel4PlusPlus",
  "BaseStatusEffect.Overload",
  "BaseStatusEffect.OverloadAndMalfunctionAbsentPereq",
  "BaseStatusEffect.OverloadAppliedPereq",
  "BaseStatusEffect.OverloadCooldown",
  "BaseStatusEffect.OverloadEMP",
  "BaseStatusEffect.OverloadGrisGris",
  "BaseStatusEffect.OverloadLevel1",
  "BaseStatusEffect.OverloadLevel2",
  "BaseStatusEffect.OverloadLevel3",
  "BaseStatusEffect.OverloadLevel4",
  "BaseStatusEffect.OverloadLevel4PlusPlus",
  "BaseStatusEffect.OverloadOrMalfunctionAppliedPereq",
  "BaseStatusEffect.OverloadShort",
  "BaseStatusEffect.OverloadWeakspotDisabled",
  "BaseStatusEffect.OverloadWeakspotEnabled",
  "BaseStatusEffect.OverloadWeakspotEnabledBoss",
  "BaseStatusEffect.OxyBooster",
  "BaseStatusEffect.Pain",
  "BaseStatusEffect.PainDistributorBuff",
  "BaseStatusEffect.PainInhibitors",
  "BaseStatusEffect.PanamRestoreDefaultHealth",
  "BaseStatusEffect.Parry",
  "BaseStatusEffect.ParryExpHarvested",
  "BaseStatusEffect.PersonalSoundSilencerPlayerBuff",
  "BaseStatusEffect.PhoneInterrupted",
  "BaseStatusEffect.PhotoModeForceFPPCamera",
  "BaseStatusEffect.PhysicalResistanceFromPhysicalDamage",
  "BaseStatusEffect.Ping",
  "BaseStatusEffect.PingLevel2",
  "BaseStatusEffect.PingLevel3",
  "BaseStatusEffect.PingLevel4",
  "BaseStatusEffect.PingLevel4PlusPlus",
  "BaseStatusEffect.PingLvl2MarkStatusEffect",
  "BaseStatusEffect.PingLvl4MarkStatusEffect",
  "BaseStatusEffect.PingLvl4PlusPlusMarkStatusEffect",
  "BaseStatusEffect.PingMarkStatusEffect",
  "BaseStatusEffect.PlatingGlitchBuffCommon",
  "BaseStatusEffect.PlatingGlitchBuffEpic",
  "BaseStatusEffect.PlatingGlitchBuffLegendary",
  "BaseStatusEffect.PlatingGlitchBuffRare",
  "BaseStatusEffect.PlatingGlitchBuffUncommon",
  "BaseStatusEffect.PlayerAiming",
  "BaseStatusEffect.PlayerBleeding",
  "BaseStatusEffect.PlayerBurning",
  "BaseStatusEffect.PlayerCooldown",
  "BaseStatusEffect.PlayerCyberwareCooldown",
  "BaseStatusEffect.PlayerElectrocuted",
  "BaseStatusEffect.PlayerExhausted",
  "BaseStatusEffect.PlayerInFinisherWorkspot",
  "BaseStatusEffect.PlayerInvulnerable",
  "BaseStatusEffect.PlayerJustAirDashed",
  "BaseStatusEffect.PlayerJustDashed",
  "BaseStatusEffect.PlayerJustDodged",
  "BaseStatusEffect.PlayerJustDodgedLocomotionBuffer",
  "BaseStatusEffect.PlayerJustEnteredCombat",
  "BaseStatusEffect.PlayerJustVaultedLocomotionBuffer",
  "BaseStatusEffect.PlayerMemoryReplenishmentCooldown",
  "BaseStatusEffect.PlayerMemoryReplenishmentIconicEpicCooldown",
  "BaseStatusEffect.PlayerMemoryReplenishmentIconicEpicPlusCooldown",
  "BaseStatusEffect.PlayerMemoryReplenishmentIconicLegendaryCooldown",
  "BaseStatusEffect.PlayerMemoryReplenishmentIconicLegendaryPlusCooldown",
  "BaseStatusEffect.PlayerMemoryReplenishmentIconicLegendaryPlusPlusCooldown",
  "BaseStatusEffect.PlayerMovementLocked",
  "BaseStatusEffect.PlayerPoisoned",
  "BaseStatusEffect.PlayerPoisonSlow",
  "BaseStatusEffect.PlayerRippingOffTurretWorkspotInv",
  "BaseStatusEffect.PocketRadioRestrictionUnlockDelay",
  "BaseStatusEffect.PoiseRegenStatusEffect",
  "BaseStatusEffect.Poisoned",
  "BaseStatusEffect.PoisonedSFX",
  "BaseStatusEffect.PostManiacStatusEffect",
  "BaseStatusEffect.PowerOfThePackSE",
  "BaseStatusEffect.Prejudice_Free_Ammo_Buff",
  "BaseStatusEffect.Prejudice_Pass",
  "BaseStatusEffect.PreventQHStaggerAnimation",
  "BaseStatusEffect.Pride_Free_Ammo_Buff",
  "BaseStatusEffect.Pride_Pass",
  "BaseStatusEffect.ProjectileLauncherCooldown",
  "BaseStatusEffect.ProjectileLauncherCooldownNotification",
  "BaseStatusEffect.PRSRMod2_Buff",
  "BaseStatusEffect.PRSRMod2_DoubleKill",
  "BaseStatusEffect.PRSRMod2_FactToggler",
  "BaseStatusEffect.PRSRMod2_Kill",
  "BaseStatusEffect.PRSRMod2_PentaKill",
  "BaseStatusEffect.PRSRMod2_QuadraKill",
  "BaseStatusEffect.PRSRMod2_TrippleKill",
  "BaseStatusEffect.q304_helicopter_rotor_effect",
  "BaseStatusEffect.q304_songbird_relic_shock",
  "BaseStatusEffect.QuickHackBlind",
  "BaseStatusEffect.QuickHackBlindLevel2",
  "BaseStatusEffect.QuickHackBlindLevel3",
  "BaseStatusEffect.QuickHackBlindLevel4",
  "BaseStatusEffect.QuickHackBlindLvl1",
  "BaseStatusEffect.QuickHackCooldown",
  "BaseStatusEffect.QuickHackCooldownDuration",
  "BaseStatusEffect.QuickhackExpHarvested",
  "BaseStatusEffect.QuickHackTutorialReset",
  "BaseStatusEffect.QuickHackUploaded",
  "BaseStatusEffect.QuickMeleeBodyPerkStunCooldown",
  "BaseStatusEffect.QuickMeleeStun",
  "BaseStatusEffect.RangedWeaponBuffUI",
  "BaseStatusEffect.RapidMuscleNurishBuffCommon",
  "BaseStatusEffect.RapidMuscleNurishBuffEpic",
  "BaseStatusEffect.RapidMuscleNurishBuffLegendary",
  "BaseStatusEffect.RapidMuscleNurishBuffRare",
  "BaseStatusEffect.RapidMuscleNurishBuffUncommon",
  "BaseStatusEffect.RareBioGrenade",
  "BaseStatusEffect.RareBurnGrenade",
  "BaseStatusEffect.RareEmpGrenade",
  "BaseStatusEffect.RareFlashGrenade",
  "BaseStatusEffect.RareFragGrenadeExplosion",
  "BaseStatusEffect.RareLastingEffectBlind",
  "BaseStatusEffect.RarePlusBioGrenade",
  "BaseStatusEffect.RarePlusBurnGrenade",
  "BaseStatusEffect.RarePlusFlashGrenade",
  "BaseStatusEffect.Rasetsu_Chain_1",
  "BaseStatusEffect.Rasetsu_Chain_2",
  "BaseStatusEffect.RebootOpticsBossCooldown",
  "BaseStatusEffect.RebootOpticsCooldown",
  "BaseStatusEffect.ReconGrenadeAttack",
  "BaseStatusEffect.ReconGrenadeAttackEpic",
  "BaseStatusEffect.ReconGrenadeAttackEpicPlus",
  "BaseStatusEffect.ReconGrenadeAttackLegendary",
  "BaseStatusEffect.ReconGrenadeAttackLegendaryPlus",
  "BaseStatusEffect.ReconGrenadeAttackRare",
  "BaseStatusEffect.ReconGrenadeAttackRarePlus",
  "BaseStatusEffect.ReconGrenadeAttackUncommon",
  "BaseStatusEffect.ReconGrenadeAttackUncommonPlus",
  "BaseStatusEffect.ReduceDamageTransition",
  "BaseStatusEffect.ReducedDetection",
  "BaseStatusEffect.ReducedVisibility",
  "BaseStatusEffect.ReduceStaminaCostOfFocused",
  "BaseStatusEffect.ReduceUltimateHackCost",
  "BaseStatusEffect.ReduceUltimateSuicideWithGrenadeCost",
  "BaseStatusEffect.ReduceUltimateSuicideWithGrenadeCostPlusPlus",
  "BaseStatusEffect.Reflexes_20_Accuracy_Buff",
  "BaseStatusEffect.Reflexes_Left_Perk_2_2_Swap_Buff",
  "BaseStatusEffect.Reflexes_Master_Perk_5_Bleeding",
  "BaseStatusEffect.Reflexes_Master_Perk_5_Buff_Level_1",
  "BaseStatusEffect.Reflexes_Right_Perk_3_1_Buff_Level_1",
  "BaseStatusEffect.Reflexes_Sharpshooter_AP_Stack",
  "BaseStatusEffect.Reflexes_Sharpshooter_Crit_Stack",
  "BaseStatusEffect.Reflexes_Sharpshooter_Stamina_Stack",
  "BaseStatusEffect.ReflexRecorderCooldown",
  "BaseStatusEffect.ReflexRecorderCooldownEffector",
  "BaseStatusEffect.ReflexRecorderCooldownNotification",
  "BaseStatusEffect.ReflexRecorderEffector",
  "BaseStatusEffect.ReflexRecorderIconicPlayerBuffEpic",
  "BaseStatusEffect.ReflexRecorderIconicPlayerBuffEpicPlus",
  "BaseStatusEffect.ReflexRecorderIconicPlayerBuffLegendary",
  "BaseStatusEffect.ReflexRecorderIconicPlayerBuffLegendaryPlus",
  "BaseStatusEffect.ReflexRecorderIconicPlayerBuffRare",
  "BaseStatusEffect.ReflexRecorderIconicPlayerBuffRarePlus",
  "BaseStatusEffect.ReflexRecorderPlayerBuffCommon",
  "BaseStatusEffect.ReflexRecorderPlayerBuffCommonPlus",
  "BaseStatusEffect.ReflexRecorderPlayerBuffEpic",
  "BaseStatusEffect.ReflexRecorderPlayerBuffEpicPlus",
  "BaseStatusEffect.ReflexRecorderPlayerBuffLegendary",
  "BaseStatusEffect.ReflexRecorderPlayerBuffLegendaryPlus",
  "BaseStatusEffect.ReflexRecorderPlayerBuffRare",
  "BaseStatusEffect.ReflexRecorderPlayerBuffRarePlus",
  "BaseStatusEffect.ReflexRecorderPlayerBuffUncommon",
  "BaseStatusEffect.ReflexRecorderPlayerBuffUncommonPlus",
  "BaseStatusEffect.RelaxedCoolPerkSE",
  "BaseStatusEffect.RemoteBreachCooldown",
  "BaseStatusEffect.RemoveAllQuickHackCooldownsEffector",
  "BaseStatusEffect.ResistanceFromDamage",
  "BaseStatusEffect.RevealInterrupted",
  "BaseStatusEffect.ReversePoisonNewPerkRegeneration",
  "BaseStatusEffect.RoyceForceStagger",
  "BaseStatusEffect.Saburo_Healing",
  "BaseStatusEffect.Saburo_Hemorrhage",
  "BaseStatusEffect.Sandevistan",
  "BaseStatusEffect.SandevistanBuff",
  "BaseStatusEffect.SandevistanBuffHumanoidRanged",
  "BaseStatusEffect.SandevistanCooldown",
  "BaseStatusEffect.SandevistanPlayerBuff",
  "BaseStatusEffect.SandevistanVersusSandevistanDelayBase",
  "BaseStatusEffect.SandevistanVersusSandevistanDelayEasy",
  "BaseStatusEffect.SandevistanVersusSandevistanDelayHard",
  "BaseStatusEffect.SandevistanVersusSandevistanDelayHelper",
  "BaseStatusEffect.SandevistanVersusSandevistanDelayNormal",
  "BaseStatusEffect.SandevistanVersusSandevistanDelayVeryHard",
  "BaseStatusEffect.Sandstorm",
  "BaseStatusEffect.SandstormAbstract",
  "BaseStatusEffect.SandstormSFXEffector",
  "BaseStatusEffect.SasquatchGrabAttackDamage",
  "BaseStatusEffect.SasquatchGrabAttackEffect",
  "BaseStatusEffect.SasquatchSuicideWithGrenade",
  "BaseStatusEffect.Sated",
  "BaseStatusEffect.SE_Q302_ChimeraProvoke",
  "BaseStatusEffect.SE_Q302_ChimeraTerrorize",
  "BaseStatusEffect.SE_Q305_ForceTerror",
  "BaseStatusEffect.SecondaryKnockdown",
  "BaseStatusEffect.SecondChancePerkBuffEffector",
  "BaseStatusEffect.SecondChancePerkCooldown",
  "BaseStatusEffect.SecondChancePerkCooldownEffector",
  "BaseStatusEffect.SecondChancePerkEffector",
  "BaseStatusEffect.SecondChancePerkTDBuff",
  "BaseStatusEffect.SecondChancePerkTimeDilation",
  "BaseStatusEffect.SecondHeart",
  "BaseStatusEffect.SecondHeartCooldown",
  "BaseStatusEffect.SecurityTurretTurnedOff",
  "BaseStatusEffect.SeeThroughWalls",
  "BaseStatusEffect.SetFriendly",
  "BaseStatusEffect.SeverelyHearingImpaired",
  "BaseStatusEffect.SFXEffector",
  "BaseStatusEffect.ShortBlind",
  "BaseStatusEffect.ShotgunMod1_Buff",
  "BaseStatusEffect.ShotgunMod2_LeftLeg",
  "BaseStatusEffect.ShotgunMod2_RightLeg",
  "BaseStatusEffect.Sleep",
  "BaseStatusEffect.SmartStorageCooldown",
  "BaseStatusEffect.SmartStorageRevengeTarget",
  "BaseStatusEffect.SmasherICE_Damage_Base",
  "BaseStatusEffect.SmasherICE_Damage_Easy",
  "BaseStatusEffect.SmasherICE_Damage_Hard",
  "BaseStatusEffect.SmasherICE_Damage_Story",
  "BaseStatusEffect.SmasherICE_Damage_VeryHard",
  "BaseStatusEffect.SmasherICE_DisableCyberdeck",
  "BaseStatusEffect.SmasherStatusCleanse",
  "BaseStatusEffect.SmokeBomb",
  "BaseStatusEffect.SmokeScreen",
  "BaseStatusEffect.SmokeScreenUI",
  "BaseStatusEffect.SoftKill",
  "BaseStatusEffect.SoMi_Q306_BlackwallHackQuestForceKill",
  "BaseStatusEffect.SoMi_Q306_BlackwallHackUpload",
  "BaseStatusEffect.SoMi_Q306_BlackwallMark",
  "BaseStatusEffect.Sovereign_Reload_Buff",
  "BaseStatusEffect.Sovereign_Speed_Buff",
  "BaseStatusEffect.SpreadFear",
  "BaseStatusEffect.StaminaBooster",
  "BaseStatusEffect.StaminaRatioCalculator",
  "BaseStatusEffect.StaminaResetTutorial",
  "BaseStatusEffect.Stat_Buff",
  "BaseStatusEffect.Stat_Debuff",
  "BaseStatusEffect.Stealth_Area_03_Perk_3_Buff_Level_1",
  "BaseStatusEffect.Stealth_Area_08_Perk_2_Buff_Level_1",
  "BaseStatusEffect.Stealth_Area_09_Perk_2_Buff_Level_1",
  "BaseStatusEffect.StealthArea09Perk2Cooldown",
  "BaseStatusEffect.StealthEnteringCritUpgrade",
  "BaseStatusEffect.StealthEnteringCritUpgradeLevel2",
  "BaseStatusEffect.StealthFood",
  "BaseStatusEffect.StealthKillMovementSpeedStackSE",
  "BaseStatusEffect.StealthPerkAntidoteSE",
  "BaseStatusEffect.StealthThrowingMeleeDamageIncrease",
  "BaseStatusEffect.StealthThrowingMeleeDamageIncreaseUI",
  "BaseStatusEffect.Strong_Arms_Buff",
  "BaseStatusEffect.StrongArmsActive",
  "BaseStatusEffect.StrongArmsChemicalActive",
  "BaseStatusEffect.StrongArmsElecricActive",
  "BaseStatusEffect.StrongArmsPhysicalActive",
  "BaseStatusEffect.StrongArmsThermalActive",
  "BaseStatusEffect.StrongerLongLastingPoisonDebuff",
  "BaseStatusEffect.StrongLongLastingPoisonDebuff",
  "BaseStatusEffect.Stun",
  "BaseStatusEffect.StunImmunity",
  "BaseStatusEffect.StunReed",
  "BaseStatusEffect.SuccessfullICEBreakerTutorial",
  "BaseStatusEffect.SuddenAidBuff",
  "BaseStatusEffect.SuddenAidCooldown",
  "BaseStatusEffect.SuicideCooldown",
  "BaseStatusEffect.SuicideHackMemoryCostReduction",
  "BaseStatusEffect.SuicideWithGrenade",
  "BaseStatusEffect.SuicideWithGrenadeDummy",
  "BaseStatusEffect.SuicideWithWeapon",
  "BaseStatusEffect.SuppressNoise",
  "BaseStatusEffect.SuppressVisibility",
  "BaseStatusEffect.SupressPresence",
  "BaseStatusEffect.SwordWitcherCooldown",
  "BaseStatusEffect.SwordWitcherCooldownEffector",
  "BaseStatusEffect.SwordWitcherTDBuff",
  "BaseStatusEffect.SwordWitcherTDEffector",
  "BaseStatusEffect.SynapticAcceleratorCooldown",
  "BaseStatusEffect.SynapticAcceleratorCooldownEffector",
  "BaseStatusEffect.SynapticAcceleratorCooldownNotification",
  "BaseStatusEffect.SynapticAcceleratorEffector",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffCommon",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffEpic",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffEpicPlus",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffLegendary",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffLegendaryPlus",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffLegendaryPlusPlus",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffRare",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffRarePlus",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffUncommon",
  "BaseStatusEffect.SynapticAcceleratorPlayerBuffUncommonPlus",
  "BaseStatusEffect.SystemCollapse",
  "BaseStatusEffect.SystemCollapseCooldown",
  "BaseStatusEffect.SystemCollapseMemoryCostReduction",
  "BaseStatusEffect.TakedownsUnequipWeapons",
  "BaseStatusEffect.Takemura_Katana_Optical_Camo_Buff",
  "BaseStatusEffect.TalkCooldown",
  "BaseStatusEffect.Tanto_Saburo_Bleeding",
  "BaseStatusEffect.TargetOfGrenadeDetonationTutorial",
  "BaseStatusEffect.TargetOfICEBreakerTutorial",
  "BaseStatusEffect.TE2",
  "BaseStatusEffect.Tech_Left_Milestone_3_Buff",
  "BaseStatusEffect.Tech_Master_Perk_2_Buff",
  "BaseStatusEffect.Tech_Master_Perk_2_Explosion",
  "BaseStatusEffect.Tech_Master_Perk_3_Buff",
  "BaseStatusEffect.Tech_Master_Perk_3_VFX",
  "BaseStatusEffect.Tech_Master_Perk_5_Buff_Chain_Lightning",
  "BaseStatusEffect.Tech_Right_Milestone_3_Block",
  "BaseStatusEffect.Tech_Right_Milestone_3_Buff",
  "BaseStatusEffect.Tech_Right_Perk_3_4_Buff",
  "BaseStatusEffect.TechAbility_60_EMP_Blast",
  "BaseStatusEffect.TechWeaponChargedBurst_Effect",
  "BaseStatusEffect.TechWeaponChargedBurst_Trigger",
  "BaseStatusEffect.TechWeaponChargedFullAuto_Effect",
  "BaseStatusEffect.TemporarilyBlockMovement",
  "BaseStatusEffect.TerminateAfterFriendly",
  "BaseStatusEffect.TestEffect",
  "BaseStatusEffect.Testera_Nicolas_SelfBurning",
  "BaseStatusEffect.Testera_Runner_Buff",
  "BaseStatusEffect.ThermalResistanceFromThermalDamage",
  "BaseStatusEffect.ThreeOrMoreProgramsCooldownRedPerk",
  "BaseStatusEffect.ThreeOrMoreProgramsMemoryRegPerk1",
  "BaseStatusEffect.ThreeOrMoreProgramsMemoryRegPerk2",
  "BaseStatusEffect.ThrowMod1_RemoveCooldownsSE",
  "BaseStatusEffect.ThrowMod3_ThrowPeneration",
  "BaseStatusEffect.ThrownNPC",
  "BaseStatusEffect.Ticon_Projectile_Pattern_Change_Ability",
  "BaseStatusEffect.Ticon_Reeds_Buff",
  "BaseStatusEffect.Ticon_Stealth_Multiplier_Helper",
  "BaseStatusEffect.TimeDilationStatusEffect",
  "BaseStatusEffect.TimedImmunity",
  "BaseStatusEffect.TogglePlayerFlashlight",
  "BaseStatusEffect.TrainingBuff",
  "BaseStatusEffect.TranquilizerUnconscious",
  "BaseStatusEffect.TroubleFinderCooldown",
  "BaseStatusEffect.TroubleFinderPlayerBuffCommon",
  "BaseStatusEffect.TroubleFinderPlayerBuffCommonPlus",
  "BaseStatusEffect.TroubleFinderPlayerBuffEpic",
  "BaseStatusEffect.TroubleFinderPlayerBuffEpicPlus",
  "BaseStatusEffect.TroubleFinderPlayerBuffLegendary",
  "BaseStatusEffect.TroubleFinderPlayerBuffLegendaryPlus",
  "BaseStatusEffect.TroubleFinderPlayerBuffLegendaryPlusPlus",
  "BaseStatusEffect.TroubleFinderPlayerBuffRare",
  "BaseStatusEffect.TroubleFinderPlayerBuffRarePlus",
  "BaseStatusEffect.TroubleFinderPlayerBuffUncommon",
  "BaseStatusEffect.TroubleFinderPlayerBuffUncommonPlus",
  "BaseStatusEffect.TyrosineInjectorBuff",
  "BaseStatusEffect.UltimateQuickHackStatusEffect",
  "BaseStatusEffect.UncommonBurnGrenade",
  "BaseStatusEffect.UncommonEmpGrenade",
  "BaseStatusEffect.UncommonFlashGrenade",
  "BaseStatusEffect.UncommonFragGrenadeExplosion",
  "BaseStatusEffect.UncommonLastingEffectBlind",
  "BaseStatusEffect.UncommonPlusBurnGrenade",
  "BaseStatusEffect.UncommonPlusFlashGrenade",
  "BaseStatusEffect.Unconscious",
  "BaseStatusEffect.UncontrolledMovement_Base",
  "BaseStatusEffect.UncontrolledMovement_Default",
  "BaseStatusEffect.UncontrolledMovement_RagdollOffLedge",
  "BaseStatusEffect.Uninterested",
  "BaseStatusEffect.UnstoppableBennett",
  "BaseStatusEffect.UploadingBossHack",
  "BaseStatusEffect.UsedHealingItemOrCyberwareStatusEffect",
  "BaseStatusEffect.UtilityGrenadeRewardHarvested",
  "BaseStatusEffect.VBAxeCooldownStatusEffect",
  "BaseStatusEffect.VBAxeEMPAttackStatusEffect",
  "BaseStatusEffect.VehicleBaseDamageOverTimeEffect",
  "BaseStatusEffect.VehicleExitKnockdownProtection",
  "BaseStatusEffect.VehicleHighDamageOverTimeEffect",
  "BaseStatusEffect.VehicleKnockdown",
  "BaseStatusEffect.VehicleTrunkBodyPickup",
  "BaseStatusEffect.VisionDebuff",
  "BaseStatusEffect.VisionDebuffUI",
  "BaseStatusEffect.Vulnerable",
  "BaseStatusEffect.VulnerableStatusEffect",
  "BaseStatusEffect.Wakako_Tiger_Buff",
  "BaseStatusEffect.Warden_Effect",
  "BaseStatusEffect.Warden_Stealth_Multiplier_Helper",
  "BaseStatusEffect.WasQuickHacked",
  "BaseStatusEffect.WaterCollision",
  "BaseStatusEffect.Weak",
  "BaseStatusEffect.WeakExplosionStun",
  "BaseStatusEffect.WeakspotDestructionStatusEffect",
  "BaseStatusEffect.WeaponChargeRatioCalculator",
  "BaseStatusEffect.WeaponGlitchLvl4Buff",
  "BaseStatusEffect.WeaponGlitchLvl4PlusPlusBuff",
  "BaseStatusEffect.WeaponMalfunction",
  "BaseStatusEffect.WeaponMalfunctionLvl2",
  "BaseStatusEffect.WeaponMalfunctionLvl3",
  "BaseStatusEffect.WeaponMalfunctionLvl4",
  "BaseStatusEffect.WeaponMalfunctionLvl4PlusPlus",
  "BaseStatusEffect.WeaponMalfunctionReactionBlocker",
  "BaseStatusEffect.WeaponMalfunctionReapply",
  "BaseStatusEffect.WeaponMalfunctionRepeat",
  "BaseStatusEffect.WeaponMalfunctionSmartLock",
  "BaseStatusEffect.WellFed",
  "BaseStatusEffect.WhistleCooldown",
  "BaseStatusEffect.WhistleLvl0",
  "BaseStatusEffect.WhistleLvl1",
  "BaseStatusEffect.WhistleLvl2",
  "BaseStatusEffect.WhistleLvl3",
  "BaseStatusEffect.WhistleLvl4",
  "BaseStatusEffect.WhistleLvl4_TurnAway",
  "BaseStatusEffect.WildBoar_Buff",
  "BaseStatusEffect.Witcher_Multikill_Buff",
  "BaseStatusEffect.Witcher_Wounded_Buff",
  "BaseStatusEffect.Wounded",
  "BaseStatusEffect.YashaBioGrenade",
  "Effectors.ADSSpeedPercentBonusEffector",
  "Effectors.AllIconic_OW_CW_Purchased_TreasureChest_Failsafe_Effector",
  "Effectors.Android_ExplodeOnElectricDeathEffector",
  "Effectors.Android_ExplodeOnElectricDeathEffectorVFX",
  "Effectors.ApplyAccumulatedDoTEffector",
  "Effectors.ApplyDisableCWOnCyberwareMalfunctionEffector",
  "Effectors.ApplyDoTOnCyberwareMalfunctionEffector",
  "Effectors.ApplyQuickhackEffector",
  "Effectors.ApplyShaderEffector",
  "Effectors.AttachCloakVisionBlocker",
  "Effectors.AttachCloakVisionBlockerEpic",
  "Effectors.AttachCloakVisionBlockerLegendary",
  "Effectors.AttachCloakVisionBlockerRare",
  "Effectors.AttachCloakVisionBlockerUncommon",
  "Effectors.AttachPerfectCloakVisionBlocker",
  "Effectors.BladeMod1_CritEffector",
  "Effectors.BladeWeaponHitEffector",
  "Effectors.BleedingImmunityEffector",
  "Effectors.BlindImmunityEffector",
  "Effectors.BloodlustHealingEffector",
  "Effectors.BluntMod1_KnockdownEffector",
  "Effectors.BluntMod3_DamageEffector",
  "Effectors.BossBlackWallAttack",
  "Effectors.BossForceSuicideGunWeapon",
  "Effectors.BurningImmunityEffector",
  "Effectors.BuyAttributeEffector",
  "Effectors.CerberusAttackDamage",
  "Effectors.CerberusFinalKillAttackDamage",
  "Effectors.ChangeAppearanceEffector",
  "Effectors.ChaosWeaponCritChanceCustomEffector",
  "Effectors.ChaosWeaponCustomEffectorBase",
  "Effectors.ChaosWeaponDebuffApplicationCustomEffector",
  "Effectors.ChaosWeaponElementalDamageCustomEffector",
  "Effectors.ChimeraMeleeMod_BladeDismemberEffector",
  "Effectors.ChimeraMeleeMod_BluntDismemberEffector",
  "Effectors.ChimeraMod_OnExplosiveWeapon_Effector",
  "Effectors.ChimeraSelfDestructPhase1",
  "Effectors.ChimeraSelfDestructPhase2",
  "Effectors.ChimeraSelfDestructPhase3",
  "Effectors.ChimeraSmartMods_QuickHackEffector",
  "Effectors.ClearQuickhackQueueEffector",
  "Effectors.ColdBlood_Area_01_Perk_1_Effector",
  "Effectors.ConvertDamageToDoTEffector",
  "Effectors.Crack",
  "Effectors.CritChanceVsElectrocutedEnemiesEffector",
  "Effectors.CriticalHealthTBH",
  "Effectors.CriticalHealthTBHIncrease",
  "Effectors.CrouchTBHIncrease",
  "Effectors.CyberwareMalfunctionAttackEffector",
  "Effectors.CyberwareMalfuntionDismembermentRigthLeg",
  "Effectors.DismemberEffector",
  "Effectors.DismemberHeadEffector",
  "Effectors.DivingTBHIncrease",
  "Effectors.DodgingTBHIncrease",
  "Effectors.ElectrocuteImmunityEffector",
  "Effectors.EMPImmunityEffector",
  "Effectors.EvaluateEncumbranceEffector",
  "Effectors.FinisherEffector",
  "Effectors.ForceSuicideGunWeapon",
  "Effectors.ForceSuicideMeleeWeapon",
  "Effectors.GrabAttack",
  "Effectors.GrabAttack01",
  "Effectors.GrabAttack02",
  "Effectors.GrabAttack03",
  "Effectors.GrabAttackEffector01",
  "Effectors.GrabAttackEffector02",
  "Effectors.GrabAttackEffector03",
  "Effectors.HardToKillDamageModificationEffector",
  "Effectors.HauntedCyberdeckEquippedEffector",
  "Effectors.HealOnKillingBleedingTargetEffector",
  "Effectors.HealthtregenEffector",
  "Effectors.HGMod1_AccuracyEffector",
  "Effectors.HighlightEffector",
  "Effectors.HitReactionTBHCooldown",
  "Effectors.HitReactionTBHIncrease",
  "Effectors.ICECounterHackEffector",
  "Effectors.InactiveChimeraCoreEffector",
  "Effectors.InitiateCyberwareExplosionEffector",
  "Effectors.IntrinsicModsEffector",
  "Effectors.InVehicleDamageReductionEffector",
  "Effectors.JuggernautEffector",
  "Effectors.JugglerPerkRemoveKnifeCooldowns",
  "Effectors.KiroshiHighlightEffector",
  "Effectors.KnockdownImmunityEffector",
  "Effectors.LimfaticNanoChargeSystemEffector",
  "Effectors.LootHighlightEffector",
  "Effectors.LowHealthTBH",
  "Effectors.LowHealthTBHIncrease",
  "Effectors.MainBossEffector",
  "Effectors.MetelKurtMod_DismemberEffector",
  "Effectors.ModifyCyberwareCooldownDurationEffector",
  "Effectors.ModifyDamageEffector",
  "Effectors.ModifyDamagePerHackEffector",
  "Effectors.ModifyDamageWithCyberwareCountEffector",
  "Effectors.ModifyStatPoolValuePerHitEffector",
  "Effectors.ModifyStatPoolValueQuickhackCostEffector",
  "Effectors.ModifyStatusEffectDurationEffector",
  "Effectors.ModifyStatusEffectDurationOnAttackEffector",
  "Effectors.MonoWireQuickHackApplyEffector",
  "Effectors.NanoTechPlatesEffector",
  "Effectors.NoICECooldown",
  "Effectors.NotifyPoliceEffector",
  "Effectors.NPCMeleeWeaponHitEffector",
  "Effectors.NPCStealthTakedown",
  "Effectors.OnEnemyKilledStatpoolModifierEffector",
  "Effectors.Phase1",
  "Effectors.Phase2",
  "Effectors.Phase3_VFX",
  "Effectors.PlayerApplyInvulnerable",
  "Effectors.PlayerAxeFinisher",
  "Effectors.PlayerBatonFinisher",
  "Effectors.PlayerChainswordFinisherHead",
  "Effectors.PlayerChainswordFinisherLeg",
  "Effectors.PlayerDildoFinisher",
  "Effectors.PlayerEnteredCombat",
  "Effectors.PlayerFinisher",
  "Effectors.PlayerFistsFinisher",
  "Effectors.PlayerHammerFinisher",
  "Effectors.PlayerKatanaFinisher",
  "Effectors.PlayerKatanaFinisherNoDismemberment",
  "Effectors.PlayerKatanaFinisherNoneLethal",
  "Effectors.PlayerKnifeFinisher",
  "Effectors.PlayerLethalTakedown",
  "Effectors.PlayerMantisBladesFinisher",
  "Effectors.PlayerMonoWireFinisherHead",
  "Effectors.PlayerMonowireFinisherLeftArm",
  "Effectors.PlayerNonLethalAerialTakedown",
  "Effectors.PlayerNonLethalNetworkBreachTakedown",
  "Effectors.PlayerNonLethalTakedown",
  "Effectors.PlayerNonLethalTakedownMassiveTarget",
  "Effectors.PlayerOdaTakedown",
  "Effectors.PlayerOdaTakedownPhase2",
  "Effectors.PlayerOneHandedBladeFinisher",
  "Effectors.PlayerOneHandedBluntFinisher",
  "Effectors.PlayerRoyceTakedown",
  "Effectors.PlayerRoyceTakedownPhase2",
  "Effectors.PlayerSasquatchTakedown",
  "Effectors.PlayerSasquatchTakedownPhase2",
  "Effectors.PlayerSmasherTakedown",
  "Effectors.PlayerSmasherTakedownPhase2",
  "Effectors.PlayerSmasherTakedownPhase3",
  "Effectors.PlayerStrongArms01Finisher",
  "Effectors.PlayerStrongArms02Finisher",
  "Effectors.PlayerTwoHandedBluntFinisher",
  "Effectors.PlaySFXEffector",
  "Effectors.PlayVFXEffector",
  "Effectors.PlayVFXOnHitPositionEffector",
  "Effectors.PoisonImmunityEffector",
  "Effectors.PostLexWilsonBuyPriceSwitch",
  "Effectors.PowerUpCyberwareEffector",
  "Effectors.PRSRMod2_PopupEffector",
  "Effectors.QuickHackImmunityEffector",
  "Effectors.RamOnKillEffector",
  "Effectors.RangedMod1_CritEffector",
  "Effectors.RecoilPercentBonusEffector",
  "Effectors.RefreshQhWithTagInAreaEffector",
  "Effectors.ReloadSpeedPercentBonusEffector",
  "Effectors.RemoveAllStatusEffectsEffector",
  "Effectors.RemoveReduceNextUltimateHackCostReductionSE",
  "Effectors.RemoveStatusEffectOnAttackEffector",
  "Effectors.RemoveStatusEffectsEffector",
  "Effectors.ResetDevelopmentPointsEffector",
  "Effectors.RewardPlayerWithCrimeScoreEffector",
  "Effectors.RipAndTearEffector",
  "Effectors.SadismEffector",
  "Effectors.SampleMulti",
  "Effectors.SasquatchGrabDamage01",
  "Effectors.SasquatchGrabDamage02",
  "Effectors.SasquatchGrabDamage03",
  "Effectors.ScaleOvershieldDecayOverTimeEffector",
  "Effectors.SelfDestructEffect",
  "Effectors.SetFactBasedOnClearAreaEffector",
  "Effectors.SetFactEffector",
  "Effectors.ShotgunDamageController",
  "Effectors.ShotgunMod1_DamageEffector",
  "Effectors.ShotgunMod2_DismemberEffector",
  "Effectors.SimpleTriggerAttackEffect",
  "Effectors.SlidingTBHIncrease",
  "Effectors.SprintTBHIncrease",
  "Effectors.StaminaRatioCalculatorEffector",
  "Effectors.StatPoolBasedTimeBankEffector",
  "Effectors.StatusEffectBasedTimeBankEffector",
  "Effectors.StopAndPlaySFXEffector",
  "Effectors.StopAndPlayVFXEffector",
  "Effectors.StopSelfDestructEffect",
  "Effectors.StopSFXEffector",
  "Effectors.StopVFXEffector",
  "Effectors.StuckInEffector",
  "Effectors.StunImmunityEffector",
  "Effectors.SystemCollapseImmunityEffector",
  "Effectors.TDD_Source",
  "Effectors.TDD_Target",
  "Effectors.TDD_World",
  "Effectors.TechMod1_EMPEffector",
  "Effectors.TEST",
  "Effectors.TEST2",
  "Effectors.TEST3",
  "Effectors.TEST4",
  "Effectors.TEST5",
  "Effectors.TEST6",
  "Effectors.TESTW",
  "Effectors.ThrowMod1_ReturnEffector",
  "Effectors.ToggleFactEffector",
  "Effectors.TogglePlayerFlashlight",
  "Effectors.TriggerAttackByChanceEffector",
  "Effectors.TriggerAttackOnAttackEffect",
  "Effectors.TriggerAttackOnEffectBase",
  "Effectors.TriggerAttackOnNearbyEnemiesEffector",
  "Effectors.TriggerAttackOnOwnerEffect",
  "Effectors.TriggerAttackOnTargetEffect",
  "Effectors.TutorialCyberwarePriceSwitch",
  "Effectors.UnconsciousImmunityEffector",
  "Effectors.UnderwaterExtinguish",
  "Effectors.UnstoppableEffector",
  "Effectors.UsedHealingItemOrCyberwareEffector",
  "Effectors.VaultingTBHIncrease",
  "Effectors.VehicleCombatRangeBoost",
  "Effectors.VehicleTBHIncrease",
  "Effectors.WeakspotOnDestroy",
  "Effectors.WeaponChargeRatioCalculatorEffector",
  "Effectors.WeaponMalfunctionBlowUpWeapon",
  "Effectors.WeaponMalfunctionBlowUpWeaponManMassive",
  "GameplayRestriction.AllowFastForwardInVehicle",
  "GameplayRestriction.AllowTracingInTier2",
  "GameplayRestriction.AllowTracingInTier3",
  "GameplayRestriction.AllowTracingInTier4",
  "GameplayRestriction.AllowTracingInTier5",
  "GameplayRestriction.BinocularView",
  "GameplayRestriction.BlockAllHubMenu",
  "GameplayRestriction.BlockDeviceInteractions",
  "GameplayRestriction.BlockFastTravel",
  "GameplayRestriction.BlockSmartWeapons",
  "GameplayRestriction.BlockTrafficInteractions",
  "GameplayRestriction.BodyCarryingActionRestriction",
  "GameplayRestriction.BodyCarryingBodyMasterPerk5",
  "GameplayRestriction.BodyCarryingCanSprint",
  "GameplayRestriction.BodyCarryingForceDrop",
  "GameplayRestriction.BodyCarryingFriendly",
  "GameplayRestriction.BodyCarryingGeneric",
  "GameplayRestriction.BodyCarryingNoDrop",
  "GameplayRestriction.BodyCarryingWoundedSoldier",
  "GameplayRestriction.Braindance",
  "GameplayRestriction.CerberusNoSandevistan",
  "GameplayRestriction.CustomVehicleSummon",
  "GameplayRestriction.Cyberspace",
  "GameplayRestriction.DeviceControlZoomLock",
  "GameplayRestriction.DriverCombatBikeWeapons",
  "GameplayRestriction.DriverCombatFirearms",
  "GameplayRestriction.FastForward",
  "GameplayRestriction.FastForwardCrouchLock",
  "GameplayRestriction.FastForwardHintActive",
  "GameplayRestriction.Firearms",
  "GameplayRestriction.FirearmsNoUnequipNoSwitch",
  "GameplayRestriction.FistFight",
  "GameplayRestriction.FocusModeLocomotion",
  "GameplayRestriction.ForceAim",
  "GameplayRestriction.ForceCrouch",
  "GameplayRestriction.ForceCrouchNoMovementOnlyFirearms",
  "GameplayRestriction.ForceStand",
  "GameplayRestriction.ForceStandKeepState",
  "GameplayRestriction.ForceStandWithDodge",
  "GameplayRestriction.GrappleNoBreakFree",
  "GameplayRestriction.InDaClub",
  "GameplayRestriction.InfiniteAmmo",
  "GameplayRestriction.LockInHubMenu",
  "GameplayRestriction.Melee",
  "GameplayRestriction.MetroRide",
  "GameplayRestriction.NoCameraControl",
  "GameplayRestriction.NoCombat",
  "GameplayRestriction.NoCrafting",
  "GameplayRestriction.NoCyberware",
  "GameplayRestriction.NoDangerousCyberware",
  "GameplayRestriction.NoDangerousPerks",
  "GameplayRestriction.NoDriving",
  "GameplayRestriction.NoEncumbrance",
  "GameplayRestriction.NoGrenadeOrGadget",
  "GameplayRestriction.NoHealing",
  "GameplayRestriction.NoJump",
  "GameplayRestriction.NoMovement",
  "GameplayRestriction.NoPhone",
  "GameplayRestriction.NoPhotoMode",
  "GameplayRestriction.NoQuickMelee",
  "GameplayRestriction.NoRadialMenus",
  "GameplayRestriction.NoScanning",
  "GameplayRestriction.NoSecondHeart",
  "GameplayRestriction.NoSprint",
  "GameplayRestriction.NoTimeDisplay",
  "GameplayRestriction.NoTimeSkip",
  "GameplayRestriction.NoWeapons",
  "GameplayRestriction.NoWorldInteractions",
  "GameplayRestriction.NoZooming",
  "GameplayRestriction.OneHandedFirearms",
  "GameplayRestriction.OnlyOpenDoor",
  "GameplayRestriction.PhoneCall",
  "GameplayRestriction.PhoneCallDeviceActionRestrictions",
  "GameplayRestriction.PhoneInterrupted",
  "GameplayRestriction.PhoneNoCalling",
  "GameplayRestriction.PhoneNoTexting",
  "GameplayRestriction.PreventLowHealthOverlay",
  "GameplayRestriction.SandstormLocomotion",
  "GameplayRestriction.SecurityLocker",
  "GameplayRestriction.ShootingRangeCompetition",
  "GameplayRestriction.SpaceShuttleInterior",
  "GameplayRestriction.Tier2Locomotion",
  "GameplayRestriction.Tier2LocomotionFast",
  "GameplayRestriction.Tier2LocomotionSlow",
  "GameplayRestriction.VehicleBlockExit",
  "GameplayRestriction.VehicleBlockRadioInput",
  "GameplayRestriction.VehicleCombat",
  "GameplayRestriction.VehicleCombatBlockExit",
  "GameplayRestriction.VehicleCombatNoInterruptions",
  "GameplayRestriction.VehicleFPP",
  "GameplayRestriction.VehicleNoInteraction",
  "GameplayRestriction.VehicleNoSummoning",
  "GameplayRestriction.VehicleOnlyForward",
  "GameplayRestriction.VehicleScene",
  "GameplayRestriction.VehicleSceneFpp",
  "GameplayRestriction.VehicleSceneFppOnlyForward",
  "GameplayRestriction.VehicleSummoning",
  "MinigameAction.AccessPoint",
  "MinigameAction.BasicAccess",
  "MinigameAction.Both",
  "MinigameAction.BuffDamageReductionMinigame",
  "MinigameAction.BuffSturdinessMinigame",
  "MinigameAction.CameraAccess",
  "MinigameAction.CyberwareAccess",
  "MinigameAction.CyberwareMalfunctionMinigame",
  "MinigameAction.DamageReductionTrap",
  "MinigameAction.DataAccess",
  "MinigameAction.DefenseSystemAccess",
  "MinigameAction.Device",
  "MinigameAction.DeviceMinigameAction",
  "MinigameAction.GainAccessProgram",
  "MinigameAction.ICEBrokenMinigameMajor",
  "MinigameAction.ICEBrokenMinigameMedium",
  "MinigameAction.ICEBrokenMinigameMinor",
  "MinigameAction.ICEBrokenMinigamePlacide",
  "MinigameAction.JamWeaponMinigame",
  "MinigameAction.NetworkAntivirus",
  "MinigameAction.NetworkAutoBlindHack",
  "MinigameAction.NetworkAutoJamHack",
  "MinigameAction.NetworkAutoLocomotionHack",
  "MinigameAction.NetworkCameraFriendly",
  "MinigameAction.NetworkCameraMalfunction",
  "MinigameAction.NetworkCameraShutdown",
  "MinigameAction.NetworkCameraTagSeenEnemies",
  "MinigameAction.NetworkCyberwareMalfunctionHack",
  "MinigameAction.NetworkDataMineLootAll",
  "MinigameAction.NetworkDataMineLootAllAdvanced",
  "MinigameAction.NetworkDataMineLootAllAdvanced2",
  "MinigameAction.NetworkDataMineLootAllMaster",
  "MinigameAction.NetworkDoorAuthorization",
  "MinigameAction.NetworkJamWeaponHack",
  "MinigameAction.NetworkLootMaterials",
  "MinigameAction.NetworkLootMoney",
  "MinigameAction.NetworkLootMoneyVRTutorial",
  "MinigameAction.NetworkLootMQ015",
  "MinigameAction.NetworkLootMQ015Recipe",
  "MinigameAction.NetworkLootMQ024",
  "MinigameAction.NetworkLootQ003",
  "MinigameAction.NetworkLootShard",
  "MinigameAction.NetworkLowerICEMajor",
  "MinigameAction.NetworkLowerICEMedium",
  "MinigameAction.NetworkLowerICEMinorFirst",
  "MinigameAction.NetworkLowerICEMinorSecond",
  "MinigameAction.NetworkLowerICEMinorThird",
  "MinigameAction.NetworkLowerICEPlacide",
  "MinigameAction.NetworkLowerICETutorial",
  "MinigameAction.NetworkMadnessHack",
  "MinigameAction.NetworkPingHack",
  "MinigameAction.NetworkSuicideForceShoot",
  "MinigameAction.NetworkSuicideHack",
  "MinigameAction.NetworkSuicideMotion",
  "MinigameAction.NetworkTurretFriendly",
  "MinigameAction.NetworkTurretMalfunction",
  "MinigameAction.NetworkTurretShutdown",
  "MinigameAction.NetworkVulnerableNPCs",
  "MinigameAction.NetworkWeakNPCs",
  "MinigameAction.NetworkWeaponMalfunctionHack",
  "MinigameAction.NeuralAccess",
  "MinigameAction.NPC",
  "MinigameAction.PuppetMinigameAction",
  "MinigameAction.Q305_decrypt_part_1",
  "MinigameAction.Q305_decrypt_part_2",
  "MinigameAction.Q305_decrypt_part_3",
  "MinigameAction.q306_oa_credentials_program",
  "MinigameAction.SecurityAccess",
  "MinigameAction.SturdinessTrap",
  "MinigameAction.SuicideMotion",
  "MinigameAction.Trojan",
  "MinigameAction.TurretAccess",
  "MinigameAction.UnlockSecurityProgram",
  "MinigameAction.UnlockSecurityProgramQ003",
  "MinigameAction.VulnerabilityMinigame",
  "MinigameAction.WeaknessMinigame",
  "MinigameAction.WeaponAccess",
  "MinigameAction.WeaponMalfunctionMinigame",
  "Minotaur.DefeatedMinotaur",
  "Minotaur.LeftArmDestroyed",
  "Minotaur.LeftExplosion",
  "Minotaur.Minotaur",
  "Minotaur.OverloadWeakspot",
  "Minotaur.OverloadWeakspotEffector",
  "Minotaur.RemoveOverloadWeakspotEffectEffector",
  "Minotaur.RightArmDestroyed",
  "Minotaur.RightExplosion",
  "Oda.BlindedBySmokeGrenade",
  "Oda.BlockStaggerOda",
  "Oda.Cemented",
  "Oda.DeactivateMaskedStatusEffects",
  "Oda.Emergency",
  "Oda.ForceStaggerGrenade",
  "Oda.ForceStaggerOda",
  "Oda.HealEffector",
  "Oda.Healing",
  "Oda.Hurt",
  "Oda.Invulnerable",
  "Oda.Main_boss_oda_allow_knockdown",
  "Oda.Masked",
  "Oda.MaskExplosionEffector",
  "Oda.NoSandevistanMode",
  "Oda.OdaHackCyberware",
  "Oda.OdaHackDeath",
  "Oda.OdaHackingCooldown",
  "Oda.OdaHackLocomotion",
  "Oda.OdaHackOverheat",
  "Oda.OdaHackWeapon",
  "Oda.OdaLeapBlocker",
  "Oda.OdaMantisPhase",
  "Oda.OdaNoDodge",
  "Oda.OdaOverload",
  "Oda.OdaRoamingPhase",
  "Oda.OdaSMGPhase",
  "Oda.OdaStatus",
  "Oda.OverHeatVFX",
  "Oda.OverheatWeakspotEffector",
  "Oda.OverloadWeakspot",
  "Oda.OverloadWeakspotEffector",
  "Oda.Phase1",
  "Oda.Phase2",
  "Oda.Revealed",
  "Oda.Shooting",
  "Oda.SmokeBombExplosionEffector",
  "Oda.StealthMode",
  "Oda.Stunned",
  "Oda.WagnerHealEffector",
  "Oda.WagnerHealingSE",
  "Royce.Broken",
  "Royce.HeadExploded",
  "Royce.HeadExplodedEffector",
  "Royce.InvulnerableLimited",
  "Royce.Jackie_Royce_Dps_Modifier",
  "Royce.MaelstromVsMilitech_Stat_mult",
  "Royce.OverloadWeakspotEffector",
  "Royce.Phase1",
  "Royce.Phase2",
  "Royce.RoyceExplodeExplosive",
  "Royce.WeakSpotDestroyed",
  "Sasquatch.Broken",
  "Sasquatch.BurningGrenade",
  "Sasquatch.Dodge",
  "Sasquatch.ForceStaggerSuicide",
  "Sasquatch.Loop1",
  "Sasquatch.Loop2",
  "Sasquatch.Loop3",
  "Sasquatch.NoTakedown",
  "Sasquatch.OverloadWeakspotEffector",
  "Sasquatch.Phase1",
  "Sasquatch.Phase2",
  "Sasquatch.Regenerate",
  "Sasquatch.RegenerateEffector",
  "Sasquatch.SasquatchOverload",
  "Sasquatch.SasquatchStatus",
  "Sasquatch.WeakSpotDestroyed",
  "Weakspots.Arm_Nachtigall_Weakspot",
  "Weakspots.Arm_Simple_Weakspot",
  "Weakspots.Base_Weakspot",
  "Weakspots.Chimera_Weakspot_Back_01",
  "Weakspots.Chimera_Weakspot_Back_02",
  "Weakspots.Chimera_Weakspot_Base",
  "Weakspots.Chimera_Weakspot_Base_Stats",
  "Weakspots.Chimera_Weakspot_Front_01",
  "Weakspots.Chimera_Weakspot_Front_02",
  "Weakspots.Chimera_Weakspot_Front_03",
  "Weakspots.Chimera_Weakspot_Front_04",
  "Weakspots.Chimera_Weakspot_Front_05",
  "Weakspots.Chimera_Weakspot_Left_01",
  "Weakspots.Chimera_Weakspot_Left_02",
  "Weakspots.Chimera_Weakspot_Left_03",
  "Weakspots.Chimera_Weakspot_Left_04",
  "Weakspots.Chimera_Weakspot_Leg_Bl_01",
  "Weakspots.Chimera_Weakspot_Leg_Bl_02",
  "Weakspots.Chimera_Weakspot_Leg_Br_01",
  "Weakspots.Chimera_Weakspot_Leg_Br_02",
  "Weakspots.Chimera_Weakspot_Leg_Fl_01",
  "Weakspots.Chimera_Weakspot_Leg_Fl_02",
  "Weakspots.Chimera_Weakspot_Leg_Fr_01",
  "Weakspots.Chimera_Weakspot_Leg_Fr_02",
  "Weakspots.Chimera_Weakspot_Leg_Ml_01",
  "Weakspots.Chimera_Weakspot_Leg_Ml_02",
  "Weakspots.Chimera_Weakspot_Leg_Mr_01",
  "Weakspots.Chimera_Weakspot_Leg_Mr_02",
  "Weakspots.Chimera_Weakspot_Metalstorm_01",
  "Weakspots.Chimera_Weakspot_Right_01",
  "Weakspots.Chimera_Weakspot_Right_02",
  "Weakspots.Chimera_Weakspot_Right_03",
  "Weakspots.Chimera_Weakspot_Right_04",
  "Weakspots.Chimera_Weakspot_Turret_back_01",
  "Weakspots.Chimera_Weakspot_Turret_back_02",
  "Weakspots.Engine_Zetatech_Av_Weakspot_01",
  "Weakspots.Engine_Zetatech_Av_Weakspot_02",
  "Weakspots.Engine_Zetatech_Av_Weakspot_03",
  "Weakspots.Engine_Zetatech_Av_Weakspot_04",
  "Weakspots.Engine_Zetatech_Av_Weakspot_Base",
  "Weakspots.Exo_CPO_Weakspot",
  "Weakspots.Exo_Weakspot",
  "Weakspots.Exo_Weakspot_Stats",
  "Weakspots.Explosive_Tank_Weakspot",
  "Weakspots.Head_Cyberware_Weakspot",
  "Weakspots.Head_Helmet_Armor",
  "Weakspots.Head_Nachtigall_Weakspot",
  "Weakspots.Juice_Dispenser_Back_Weakspot",
  "Weakspots.JuiceDispenserStats",
  "Weakspots.Leg_Bandage_Weakspot",
  "Weakspots.Mech_Weapon_Left_Weakspot",
  "Weakspots.Mech_Weapon_Right_Weakspot",
  "Weakspots.Mech_Weapon_Weakspot",
  "Weakspots.Mech_Weapon_Weakspot_Stats",
  "Weakspots.Oda_Mask_Weakspot",
  "Weakspots.OdaMaskStats",
  "Weakspots.Ozob_Nose_Stats",
  "Weakspots.Ozob_Nose_Weakspot",
  "Weakspots.Smasher_Generator_Stats",
  "Weakspots.Smasher_Generator_Weakspot",
  "Weakspots.Smasher_Plate_Weakspot",
  "Weakspots.Smasher_Plate_Weakspot_back_l",
  "Weakspots.Smasher_Plate_Weakspot_back_r",
  "Weakspots.Smasher_Plate_Weakspot_chest_l",
  "Weakspots.Smasher_Plate_Weakspot_chest_r",
  "Weakspots.Smasher_Plate_Weakspot_collar",
  "Weakspots.Smasher_Plate_Weakspot_pipe_l",
  "Weakspots.Smasher_Plate_Weakspot_pipe_r",
  "Weakspots.Smasher_Plate_Weakspot_shoulder_l",
  "Weakspots.Smasher_Plate_Weakspot_shoulder_r",
  "Weakspots.Smasher_Plate_Weakspot_Stats",
  "Weakspots.Smasher_Plate_Weakspot_stomach_low",
  "Weakspots.Smasher_Plate_Weakspot_stomach_mid_l",
  "Weakspots.Smasher_Plate_Weakspot_stomach_mid_r",
  "Weakspots.Smasher_Plate_Weakspot_stomach_up_l",
  "Weakspots.Smasher_Plate_Weakspot_stomach_up_r",
  "Weakspots.Test_CPO_Weakspot1",
  "Weakspots.Test_CPO_Weakspot2",
  "Weakspots.Test_CPO_Weakspot3",
  "Weakspots.Test_Weakspot",
  "Weakspots.Weakspot_Base_Stat_ModGroup",
  "WorkspotStatus.Braindance",
  "WorkspotStatus.Busy",
  "WorkspotStatus.Deaf",
  "WorkspotStatus.Death",
  "WorkspotStatus.Drunk",
  "WorkspotStatus.Immune",
  "WorkspotStatus.JohnnySceneWorkspot",
  "WorkspotStatus.LoreAnim",
  "WorkspotStatus.NoSenses",
  "WorkspotStatus.Sleep",
  "WorkspotStatus.SwimTube",
  "WorkspotStatus.SyncAnimation",
  "WorkspotStatus.Unconscious"
		
	}
	reactionlist = { 
		{name = "Neutral", idle = 2, category = 2},
        {name = "Joy", idle = 5, category = 3},
        {name = "Smile", idle = 6, category = 3},
        {name = "Sad", idle = 3, category = 3},
        {name = "Surprise", idle = 8, category = 3},
        {name = "Aggressive", idle = 2, category = 3},
        {name = "Anger", idle = 1, category = 3},
        {name = "Interested", idle = 3, category = 1},
        {name = "Disinterested", idle = 6, category = 1},        
        {name = "Disappointed", idle = 4, category = 3},
        {name = "Disgust", idle = 7, category = 3},
        {name = "Exertion", idle = 1, category = 1},
        {name = "Nervous", idle = 10, category = 3},
        {name = "Fear", idle = 11, category = 3},
        {name = "Terrified", idle = 9, category = 3},
        {name = "Pain", idle = 2, category = 1},
        {name = "Sleepy", idle = 5, category = 1},
        {name = "Unconscious", idle = 4, category = 1},
        {name = "Dead", idle = 1, category = 2}
	}
	reactionNameList = {"Neutral","Joy","Smile","Sad","Surprise","Aggressive","Anger","Interested","Disinterested","Disappointed","Disgust","Exertion","Nervous","Fear","Terrified","Pain","Sleepy","Unconscious","Dead"}
	--Thanks AMM
	
	editor_check_trigger_test = false
	editor_check_action_test = false
	editor_check_trigger_test_visble = false
	
	editor_json = ""
	editor_json_tag = ""
	editor_json_view = false
	editor_json_malformatted = false
	editor_json_malformatted_error = ""
	editor_json_obj = nil
	editor_json_obj_name = ""
	
	possiblecategory = {}
	corpoNews = {}
	
	
	arrayDatapack3 = {}
	arrayMyDatapack = {}
	
	arrayMission = {}
	arrayMymissions = {}
	editorPathTarget = nil
	arrayMarket = {}
	recordRotation = false
	recordRotationOnly = false
	recordRelative = false
	recordInitialPosition = {}
	arrayMarketItem = {}
	lookatEntity = nil
	currentpack = ""
	
	CurrentServerModVersion = {}
	CurrentServerModVersion.version = cyberscript.version
	
	NetServiceOn = true
	MultiplayerOn = false
	
	
	canSpawn = true
	selectedInstance = 1
	selectedInstancePassword = "none"
	
	myTag = ""
	currentSave.myAvatar = "Character.Judy"
	
	Avatarindex = 1
	tweakdbtable = {}
	
	myFriendTag = ""
	myPassword = ""
	
	tokenisvalid = false
	myFaction ="Arasaka"
	previousConnectedPlayersList = {}
	ActualPlayersList = {}
	
	multiWindowsOpen = false
	errormessage = ""
	AlreadyLogin = false
	friendIsSpaned = false
	friendIsReady = false
	friendMove = false
	
	to_spawn = {}
	
	KillStats = {
		totalKills = 0,
		totalKillsByGroup = {},
		lastKillLocation = nil,
		lastKillTimestamp = nil,
	}
	
	
	seats = {"seat_front_left","seat_front_right","seat_back_right","seat_back_left"}
	
	
	
	-- 
	calledfromgarage = true
	
	
	channel = 1
	
	currentMultiHouse = {}
	ItemOfHouseMultiSpawned = false
	isInMultiHouse = false
	selectedItemMulti = nil
	selectedItemMultiBackup = nil
	
	
	currentHouse = {}
	isInHouse = false
	ItemOfHouseSpawned = false
	worldprocessing = false
	messageprocessing = false
	selectedItem = nil
	SalaryIsPossible = true
	--enum type house 
	
	
	potentialQuest = {}
	possibleQuest = {}
	takenQuest = {}
	openQuestWindows = false
	currentQuest = nil
	AIhandler = {}
	currentQuestStarted = false
	currentQuestFailed = false
	
	
	cancheckmission = false
	currentQuestFinished = false
	
	
	canDoTriggerAction = false
	canDoStartAction = false
	canDoEndAction = false
	canDoFailAction = false
	
	canDoResetAction = false
	
	DoedTriggerAction = false
	DoedStartAction = false
	DoedEndAction = false
	DoedFailAction = false
	AIconversation = {}
	DoedResetAction = false
	
	actionistaken = false
	worker = false
	currentActionIndex=0
	
	currentActionList = nil
	currentActionVerb = nil
	currentwaitTimer = nil
	currentTimer = nil
	
	displayRemaningTimer = false
	displayConsumingTimer = false
	displayTimerMessage = ""
	
	enabledTrack = {}
	
	
	currentTarget={}
	currentTargetIsFromNPC = false
	currentTargetIsFromFriend = false
	
	
	selectedEntity = false
	
	enableEntitySelection = false
	entitySelectionIsVehicule = false
	
	
	openQuestDialogWindow = false
	openPhoneDialogWindow = false
	openSpeakDialogWindow = false
	openEventDialogWindow = false 
	openPhone = false
	startSpeak = false
	currentPhoneDialog = nil
	currentPhoneDialogPopup = nil
	Phoned = nil
	phoneAnim = false
	phoneAnimFixer = false
	
	autoplayRadio = false
	autoplayincar = false
	shuffleall = false
	currentRadio = {}
	currentRadioVolume = 100
	pausemusic = false
	
	
	
	possibleInteract = {}
	possibleInteractDisplay = {}
	
	currentInteractGroupIndex = 1
	currentInteractGroup = {}
	
	
	
	workerTable={}
	workerTableKey={}
	directWorkerTable = {}
	directActionsWorkerTable = {}
	toremove = {}
	selectTarget = nil
	autoScript = true
	
	goIndex = 0
	
	cachedActionResult = false
	
	mappinManager = {}
	currentDistricts2 = {
		visible = true,
		districtId = nil,
		districtLabels = nil,
		districtCaption = nil,
		factionLabels = nil,
		customdistrict = nil
	}
	
	
	
	AVinput = {
		isMoving = false,
		lastInput = "",
		keyPressed = false,
		currentDirections = {
			forward = false,
			backwards = false,
			right = false,
			left = false,
			up = false,
			down = false,
			rollleft = false,
			rollright = false,
		},
	}
	
	
	ScannerInfoManager = {}
	
	VendorsStockManager = {}
	VendorsStockManager["lookatnpc"] = {}
	VendorsStockManager["lookatnpc"].items = {}
	
	
	local itemtable = {}
	local myitems = {}
	myitems.quantity = math.random(1,10)
	myitems.tweak = "Items.Preset_Chao_Neon"
	myitems.powerLevel = math.random(1,10)
	table.insert(itemtable,myitems)
	
	local myitems = {}
	myitems.quantity = math.random(1,10)
	myitems.tweak = "Items.Helmet_03_old_01"
	myitems.powerLevel = math.random(1,10)
	table.insert(itemtable,myitems)
	
	local myitems = {}
	myitems.quantity = math.random(1,10)
	myitems.tweak = "Items.Jacket_02_old_03"
	myitems.powerLevel = math.random(1,10)
	table.insert(itemtable,myitems)
	
	local myitems = {}
	myitems.quantity = math.random(1,10)
	myitems.tweak = "Items.GenericJunkItem14"
	myitems.powerLevel = math.random(1,10)
	table.insert(itemtable,myitems)
	
	local myitems = {}
	myitems.quantity = math.random(1,10)
	myitems.tweak = "Items.SexToyJunkItem4"
	myitems.powerLevel = math.random(1,10)
	table.insert(itemtable,myitems)
	
	VendorsStockManager["lookatnpc"].items = itemtable
	VendorsStockManager["lookatnpc"].name = "Donk's Dealer"
	-- ScannerInfoManager["judy01"] = {}
	-- ScannerInfoManager["judy01"].name = "Donk's Love"
	-- ScannerInfoManager["judy01"].secondaryname = "Cookie eaters"
	-- ScannerInfoManager["judy01"].level = 5
	-- ScannerInfoManager["judy01"].rarity = 0
	-- ScannerInfoManager["judy01"].faction = "faction_mox"
	-- ScannerInfoManager["judy01"].attitude = 0
	-- ScannerInfoManager["judy01"].networkstate = 5
	-- ScannerInfoManager["judy01"].text = "Go Buy it for me !"
	-- ScannerInfoManager["judy01"].bounty = {}
	-- ScannerInfoManager["judy01"].bounty.transgressions= {}
	-- ScannerInfoManager["judy01"].bounty.customtransgressions= {"cookier eaters", "donk sucker"}
	-- table.insert( ScannerInfoManager["judy01"].bounty.transgressions,"UnpaidDebt")
	-- ScannerInfoManager["judy01"].bounty.reward = 130891
	-- ScannerInfoManager["judy01"].bounty.streetreward = 69
	-- ScannerInfoManager["judy01"].bounty.issuedby = "donk"
	-- ScannerInfoManager["judy01"].bounty.danger = 5
	
	AVList = {"","",}
	
	AVspeed = 0.3
	AVVelocity = 0.005
	CurrentAVEntity = nil
	AVisIn = false
	AVseat = nil
	AVyaw = 0
	AVroll = 0
	AVrollCam = 0
	AVPitch = 0
	
	
	
	
	--Var and Init 
	
	
	enummt = {
		__index = function(table, key) 
			if rawget(table.enums, key) then 
				return key
			end
		end
	}
	
	
	
	
	openColorPicker = false
	
	openEditor = false
	openEditTrigger = false
	openEditActionTrigger = false
	openNewTrigger = false
	
	openTriggerItem = false
	
	openNewAction = false
	openEditAction = false
	toti = ""
	totitem = ""
	searchitem=""
	
	
	camstep = 0.1
	posstep = 0.1
	rotstep = 0.1
	
	openNewRoom = false
	openEditRoom = false
	
	
	
	loadQuest = {}
	loadInteract = {}
	loadPlace = {}
	loadDialog = {}
	loadEvent = {}
	loadFunction = {}
	loadCustomNPC = {}
	loadFixer = {}
	loadFaction = {}
	loadRadio = {}
	loadNode = {}
	loadCircuit = {}
	loadPath = {}
	loadLang = {}
	LoadInterface = {}
	loadHelp ={}
	loadPOI = {}
	loadShard = {}
	loadPhoneDialog = {}
	loadScene = {}
	loadHousing = {}
	
	loadQuesttag = ""
	loadInteracttag = ""
	loadPlacetag = ""
	loadDialogtag = ""
	loadEventtag = ""
	loadFunctiontag = ""
	loadCustomNPCtag = ""
	loadFixertag = ""
	loadFactiontag = ""
	loadRadiotag = ""
	loadNodetag = ""
	loadCircuittag = ""
	loadPathtag = ""
	loadLangtag = ""
	LoadInterfacetag = ""
	LoadPOItag = ""
	loadHelptag =""
	loadShardtag = ""
	loadPhoneDialogtag = ""
	loadScenetag = ""
	loadHousingtag = ""
	currentSelectLocation = {}
	
	editLocation = false
	placetype = "House"
	newRequirementItem = ""
	selectedTrigger2 = ""
	currentSelectTrigger = {}
	currentSelectAction = {}
	currentSelectRoom = {}
	currentSelectOptions = {}
	currentSelectObjective = {}
	currentSelectConversation = {}
	currentSelectMessage = {}
	currentSelectChoice = {}
	currentSelectSceneStep = {}
	currentEditorTrigger = nil
	currentEditorItems = nil
	currentEditorAction = nil
	currentEditorOptions = nil
	currentEditorControls = nil
	currentcolor = ""
	currentcolorTable = {}
	questTrigger = true
	questStart = true
	questEnd = true
	questFail = true
	currentEditorSubTrigger = {}
	editLocation=false
	EditorAddColor=false
	colorPickerModeRGB = false
	genericItem = {}
	genericItem.name = ""
	genericItem.file = ""
	
	genericLocation = {}
	genericLocation.x = 0
	genericLocation.y = 0
	genericLocation.z = 0
	genericLocation.district = "Watson"
	genericLocation.subdistrict = "ArasakaWaterfront"
	genericLocation.inVehicule = false
	genericLocation.Tag = ""
	
	genericVIP = {}
	genericVIP.name = ""
	genericVIP.score = 0
	
	EgameMessageSender =  
	{
		NPC = 0,
		Player = 1
	}
	
	defaulftGameMessageSender = "NPC"
	defaulttag = "mytag"
	dicKey = ""
	dicValue = ""
	dicInt = 0
	selectedTrigger = "auto"
	selectedTrigger2 = "auto"
	npcchara = "Judy"
	defaultQuestType = "Contract"
	npcFixer = "Wakako Okada"
	defaultfaction = "Mox"
	defaultDistrict = "Watson"
	defaultEnumDistrict = "Watson"
	defaultJournalEntryState = "Active"
	waydialog = "phone"
	selectedAction = "notify"
	selectedSubAction = "notify"
	selectedControlType = "button"
	selectedControlvalue = "text"
	selectedThemeKey = ""
	selectedThemeValue = {}
	selectedThemeText = ""
	selectedTriggerTable = {}
	selectedActionTable = {}
	newtrigger = {}
	
	
	selecAction = ""
	
	currentParentItem = {}
	
	activeEditedQuest = {} -- 0
	questgraph = {}
	choicegraph = {}
	activeEditedInteract = {} --1 
	activeEditedDialog = {}--2
	activeEditedFixer = {} --3
	activeEditedPlace = {} --4
	activeEditedFunction = {} --5
	activeEditedFaction = {} --5
	activeEditedRadio = {} --5
	activeEditedNode = {} --5loadPlacetag
	activeEditedCircuit = {} --5
	activeEditedPath = {} --5
	activeEditedPOI = {} --5
	activeEditedEvent = {} --5
	activeEditedLang = {} --5
	activeEditHelp = {} --5
	activeEditedTheme = {} --5
	activeEditedInterfaces = {} --5
	activeEditedCustomNPC = {} --5
	activeEditedShard = {} --5
	activeEditedPhoneDialog = {} --5
	activeEditedScene = {} --4
	activeEditedHousing = {} 
	
	
	
	local f = assert(io.open("mod/data/anims/CharacterEntryLibrary.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	f:close()
	entityListJson = trydecodeJSOn(encdo, f ,"mod/data/anims/CharacterEntryLibrary.json")
	
	
	entityListJsonfinal = {}
	controltypelist = {"button","label","area","scrollarea","vertical_area","image"}
	controltypevaluelist = {"text","number","score","variable"}
	
	
	-- animslibrary = {}
	
	-- local reader = dir("mod/data/anims")
	-- if(reader ~= nil) then
	-- for i,v in ipairs(reader) do 
	-- animslibrary[reader[i].name] = dofile(v)
	-- end
	
	-- end
	
	wantcorrectpoi = false
	poicorrectready = false
	currentpoicorrectindex = 1
	
	
	local f = assert(io.open("mod/external/amm_entities.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	amm_entities = {}
	
	local test = trydecodeJSOn(encdo, f ,"mod/external/amm_entities.json")
	
	for i,v in ipairs(test) do
		
		amm_entities[v.entity_id] = v
		
		
		
	end
	
	
	
	
	local f = assert(io.open("mod/external/amm_component.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	amm_component = {}
	
	local test =  trydecodeJSOn(encdo, f ,"mod/external/amm_component.json")
	
	for i,v in ipairs(test) do
		
		amm_component[v.cname] = v
		
		
	end
	
	
	
	
	arrayDBitems = {}
	arrayDBitemsfilter = {}
	
	local f = assert(io.open("mod/data/getItems.json"))
	
	lines = f:read("*a")
	
	encdo = lines
	
	
	
	
	arrayDBitems = trydecodeJSOn(encdo, f,"mod/data/getItems.json")
	
	
	f:close()
	
	
	
	
	
	if AMM ~= nil then
		
		local ammprops = AMM.API.GetAMMProps()
		
		for i,v in ipairs(ammprops) do
			
			local obj = {}
			obj.Id = #arrayDBitems + i
			obj.Path = v.path
			obj.Tag= string.lower(v.name:gsub( " ", "_"))
			obj.Title = "(AMM) "..v.name
			obj.Statut = 1
			obj.Quantity = 99999999999
			obj.Price = math.random(1,5000)
			obj.Inflate = 0
			obj.DefaultStatut = 0
			obj.parentCategory = "amm"
			obj.childCategory = "amm"
			obj.flag = "amm;"
			table.insert(arrayDBitems,obj)
		end
		
	end
	
	
	
	
	componentCname = {"amm_prop_slot1", "amm_prop_slot2", "amm_prop_slot3", "amm_prop_slot4", "body_01", "trunk_a", "cockpit", "trunk_b", "canopy_right_screen_frame_b", "canopy_right_screen_middle_b", "canopy_right_screen_right_b", "canopy_right_screen_left_b", "canopy_right_screen_frame_a", "canopy_right_screen_middle_a", "canopy_right_screen_right_a", "canopy_right_screen_left_a", "canopy_left_screen_middle_b", "canopy_left_screen_frame_b", "canopy_left_screen_right_b", "canopy_left_screen_left_b", "canopy_left_mainscreen_b", "canopy_left_mainscreen_a", "canopy_left_screen_left_a", "canopy_left_screen_right_a", "canopy_left_screen_middle_a", "canopy_left_screen_frame_a", "canopy_right_screen_a", "av_militech_basilisk__ext01_body_shadow", "av_militech_basilisk__ext01_trunk_b_shadow", "av_militech_basilisk__ext01_trunk_a_shadow", "av_militech_basilisk__ext01_hinges_shadow", "basilisk_vfx_cutout", "elevator_door_large_a", "Mesh8033", "neon", "neon_unlit", "neon_light_a", "mch_003__minotaur_arm_l_01", "mch_003__minotaur_body_01", "mch_003__minotaur_decals", "mch_003__minotaur_lights_glass", "mch_003__minotaur_arm_r_01", "mch_003__minotaur_bags_01", "mch_003__minotaur_hands_01", "mch_003__minotaur_weapons_01", "mch_003__minotaur_legs_01", "mch_003__minotaur_arm_l_4776", "mch_003__minotaur_arm_l_1320", "vs_apartment_table_default", "smoke_machine_a", "Mesh8265", "q110_black_box", "int_accessories_001__johnnysguitar"}
	
	lightComponents = {
	"Light0275",
 "Light7460",
 "Light5050",
 "Light1783",
 "Light5638",
 "amm_light",
 "Light5520",
 "Light7161",
 "Light0034",
 "Light2702",
 "Light1460",
 "Light6337",
 "Light2103",
 "Light6270",
 "Light5424",
 "Light7002",
 "L_Main",
 "Light6234",
 "LT_Point",
 "LT_Spot",
 "Light6765",
 "Light4716",
 "Light_Main8854",
 "Light_Main",
 "Light",
 "Light_Glow",
 "head_light_left_01",
 "head_light_right_01"
}
	
	haschanged = false
	scaleChanged = false
	proportionalMode = true
	proportionalModeChanged = true
	
	
	
	
	
	
	arrayListCharacter = {}
	arrayPNJ = {}
	
	
	
	for i = 1, 100 do
		
		selectedTriggerTable[i] = ""
		selectedActionTable[i] = ""
	end
	
	
	myDatapack = {}
	myDatapack.name = ""
	myDatapack.desc = ""
	myDatapack.author = ""
	myDatapack.file = ""
	myDatapack.tag = ""
	myDatapack.version = "0.0.0"
	myDatapack.flags ={}
	
	myDatapackQuest = {}
	myDatapackInteract = {}
	myDatapackDialog = {}
	myDatapackFixer = {}
	myDatapackPlace = {}
	myDatapackFunction = {}
	myDatapackFaction = {}
	myDatapackRadio = {}
	myDatapackNode = {}
	myDatapackCircuit = {}
	myDatapackPath = {}
	myDatapackPOI = {}
	myDatapackLanguage = {}
	myDatapackEvent = {}
	myDatapackHousing = {}
	myDatapackHousingTemplate = {}
	myDatapackHelp = {}
	myDatapackTheme = {}
	myDatapackInterfaces = {}
	myDatapackCustomNPC = {}
	myDatapackShard = {}
	myDatapackPhoneDialog = {}
	myDatapackScene = {}
	
	inCrewManager =  false
	selectedCompanion = nil
	
	savelocation = {}
	tempLocation = {}
	savelocation.locations = {}
	savelocation.desc = "location_"..math.random(0,59656518543133)
	savelocation.isFor = ""
	savelocation.tag = "location_"..math.random(0,59656518543133)
	
	saveLocationRotation = false
	
	playtick=1
	uimargintop = 50
	uifont = 35
	pathtick = 0
	
	currentSelectedGameNode = nil
	inTaxiWindows = false
	inAVTaxiWindows = false
	lastcurpos = nil
	AVdestination = nil
	isHeigh = false
	isDown = false
	isAVinService = false
	xreach = false
	yreach = false
	zreach = false
	isTaxiAVcall = false
	
	currentItemSpawned = {}
	currentItemMultiSpawned = {}
	currentPlayerNode = nil
	inEditMode = false
	
	---@type ShardReadPopupData
	notificationData = {}
	
	---@type inkGameNotificationToken
	notificationToken = {}
	
	---@type sampleStyleManagerGameController
	eventCatcher = {}
	
	---@type table
	buttonsData = {}
	
	currentShardNotificationController = nil
	
	currentPhoneConversation = nil
	currentController = "gamepad"
	currentChattersGameController = nil
	currentSubtitlesGameController = nil
	
	popupManager = nil
	popupActive = false
	
	AffinityPopupisShow = false
	
	
	WebModule = {}
	contactList = {}
	
	mappedFastTravelPoint = {}
	mappedFastTravelPointJSON = {}
	
	MessengerGameController = nil
	
	KeystoneDownloader = {}
	Keystone_currentSelectedItemCategory = nil
	Keystone_currentSelectedItem = nil
	KeystoneDownloader.displayName = "Cyberpunk Mulitverse"
	KeystoneDownloader.widgetName = "CM"
	
	inputcount = 0
	
	table.insert(WebModule,KeystoneDownloader)
	
	
	MetroCurrentTime = 0
	NewMetroTime = 0
	JournalNotificationQueue = nil
	
	
	
	GameIsLoaded = false
	
	
	
	MasterVolume = 0
	
	
	SfxVolume = 0
	
	
	DialogueVolume = 0
	
	
	MusicVolume =0
	
	
	CarRadioVolume = 0
	
	
	SoundManager = {}
	
	SoundManager.Version = 6
	
	SoundManager.MasterVolume = -1
	SoundManager.SfxVolume = -1
	SoundManager.DialogueVolume = -1
	SoundManager.MusicVolume = -1
	SoundManager.CarRadioVolume = -1
	
	locationWidgetLeft = 15
	
	locationWidgetPosX_top = 400
	
	
	processingmessage = false
	
	CurrentOnlineMessage = {}
	
	LinkController = nil
	
	locationWidgetPosX_top = 400
	
	locationWidgetDisctrict_top = 450
	
	locationWidgetSubDisctrict_top = 500
	
	locationWidgetFactionDisctrict_top = 550
	
	
	
	
	locationWidgetPlace_top = 800
	locationWidgetRoom_top = 900
	
	posWdiget = nil
	districtWidget = nil
	subdistrictWidget = nil
	subdistrictWidget = nil
	factionwidget = nil
	placewidget = nil
	roomwidget = nil
	placemultiwidget = nil
	multistatewidget = nil
	factiontitle = nil
	timerwidget = nil
	avspeedwidget = nil
	
	openEditSceneStep = false
	
	openNewSceneStep = false
	
	enableLocation = true
	showcyberscriptfixeronmap = true
	showFactionAffinityHud = true
	
	
	if(file_exists("net/userLogin.txt"))then
		
		local f = io.open("net/userLogin.txt")
		local lines = f:read("*a")
		
		if(lines ~= "" ) then
			pcall(function ()
				local obj = trydecodeJSOn(lines,f,"net/userLogin.txt")
				
				myTag = obj.login
				myPassword = obj.password
			end)
		end
		
		f:close()
		
		RememberMe = true
		
		
	end
	--logme(10,"CyberScript: variable module loaded")
	--logme(2,"Variables init finish")
	
	
	
end
