logme(3,"CyberScript Studio : Variable module loaded")
editorversion = "1.2.2"



contexttype = {"text","number","boolean"}

objectiveextratype = {"","mappin","data","custom","update"}
missionextratype = {"","success","fail","new","mappin","data","custom"}
defaultextra = ""
defaultextramission = ""
mappinextra = "mappintag"

dataextratype = ""
dataextravalue = ""

customextratag = ""

animequipitem = {"Items.crowd_cigarette_i_stick", "Items.glass_f_whiskey", "Items.glass_e_champagne", "Items.crowd_glass_c_empty", "Items.crowd_glass_f_whiskey", "Items.crowd_glass_e_champagne", "Items.crowd_glass_f_whiskey_empty", "Items.bottle_e_beer", "Items.bottle_i_beer", "Items.bottle_i_beer_small", "Items.bottle_k_beer", "Items.bottle_m_whiskey_no_cap", "Items.crowd__bottle_k_beer", "Items.crowd_bottle_e_beer", "Items.crowd_bottle_i_beer", "Items.crowd_bottle_i_beer_small", "Items.crowd_bottle_m_whiskey_no_cap", "Items.bottle_e_beer", "Items.bottle_e_beer", "Items.bottle_e_beer", "Items.cellphone", "Items.cigar", "Items.cooking_pan_c", "Items.drug_inhaler", "Items.duffle_bag", "Items.electric_guitar_b", "Items.electric_guitar_d", "Items.end_of_world_sign_a_on_stick", "Items.flare", "Items.fries_cone", "Items.fryer", "Items.game_card_a", "Items.game_card_pack", "Items.grenade_launcher", "Items.guitar_pick", "Items.gym_weights_a_dumbbell_large", "Items.gym_weights_b_dumbbell_small", "Items.gym_weights_c_dumbbell_small", "Items.handcuffs_a", "Items.handcuffs_a_closed", "Items.handpan_drum", "Items.head_bucket", "Items.int_food_001__asian_street_food_f_a", "Items.int_food_001__mixed_fast_food_i_hotdog_half", "Items.personnal_link"
	}
equipeslot = {
	"ArmsCyberwareGeneralSlot", "Barrel", "BaseClothing", "Belly", "BerserkSlot1", "BerserkSlot2", "BerserkSlot3", "Blade", "BotChassisModule", "BotCpuSlot1", "BotCpuSlot2", "BotCpuSlot3", "BotMainModule", "BotSoftwareSlot1", "BotSoftwareSlot2", "BotSoftwareSlot3", "BotSoftwareSlot4", "BotSoftwareSlot5", "Chest", "ClothingSlots", "ClothingUpgrade1", "Consumable", "CyberdeckProgram1", "CyberdeckProgram2", "CyberdeckProgram3", "CyberdeckProgram4", "CyberdeckProgram5", "CyberdeckProgram6", "CyberdeckProgram7", "CyberdeckProgram8", "CyberwareRoot", "CyberwareSlots", "Engine1", "Engine2", "Engine3", "Engine4", "ExoWeakspot", "Eyes", "EyesCW", "FaceFabricEnhancer1", "FaceFabricEnhancer2", "FaceFabricEnhancer3", "FaceFabricEnhancer4", "Feet", "FootFabricEnhancer1", "FootFabricEnhancer2", "FootFabricEnhancer3", "FootFabricEnhancer4", "GenericItemRoot", "GenericWeaponMod1", "GenericWeaponMod2", "GenericWeaponMod3", "GenericWeaponMod4", "GrenadeCore", "GrenadeDelivery", "GrenadeLeft", "GrenadeRight", "GrenadesSlots", "Grip", "Hands", "Head", "HeadFabricEnhancer1", "HeadFabricEnhancer2", "HeadFabricEnhancer3", "HeadFabricEnhancer4", "IconicMeleeWeaponMod1", "IconicWeaponModLegendary", "InnerChestFabricEnhancer1", "InnerChestFabricEnhancer2", "InnerChestFabricEnhancer3", "InnerChestFabricEnhancer4", "ItemSlotGenericMelee", "ItemSlotGenericRanged", "ItemSlotHammer", "ItemSlotHandgunLeft", "ItemSlotHandgunLeftJackie", "ItemSlotHandgunRight", "ItemSlotHandgunRightJackie", "ItemSlotKatana", "ItemSlotKnifeLeft", "ItemSlotKnifeRight", "ItemSlots", "ItemSlotSMG", "ItemSlotSniperRifle", "ItemSlotTechRifle", "KERSSlot1", "KERSSlot2", "KERSSlot3", "KiroshiOpticsSlot1", "KiroshiOpticsSlot2", "KiroshiOpticsSlot3", "Laser_01", "Laser_02", "Laser_03", "Laser_04", "LeftArm", "LeftHand", "LeftShoulder", "LeftUpLeg", "Legs", "LegsFabricEnhancer1", "LegsFabricEnhancer2", "LegsFabricEnhancer3", "LegsFabricEnhancer4", "Magazine", "MagazineEmpty", "MantisBladesEdge", "MantisBladesRotor", "MeleeWeaponMod1", "MeleeWeaponMod2", "MeleeWeaponMod3", "Nameplate", "NanoWiresBattery", "NanoWiresCable", "Nose", "OffensiveAttachment", "OuterChestFabricEnhancer1", "OuterChestFabricEnhancer2", "OuterChestFabricEnhancer3", "OuterChestFabricEnhancer4", "Outfit", "OverheadMappin", "Ozob", "PanamVehicleTurret", "PanzerCannon", "PanzerCounterMeasuresLeft", "PanzerCounterMeasuresRight", "PanzerHomingMissiles", "PersonalLink", "PlayerTattoo", "PowerModule", "PowerWeaponModEpic", "PowerWeaponModLegendary", "PowerWeaponModRare", "ProjectileLauncherRound", "ProjectileLauncherWiring", "PuppetSlots", "Q101HelicopterTurret", "QuestDeviceMappin", "Receiver", "RightArm", "RightElbow", "RightHand", "RightShoulder", "RightUpLeg", "RightWrist", "RoleMappin", "SandevistanSlot1", "SandevistanSlot2", "SandevistanSlot3", "Scope", "ScopeRail", "SilverhandArm", "SmartWeaponModEpic", "SmartWeaponModLegendary", "SmartWeaponModRare", "Smasher_Plate_Weakspot_back_l", "Smasher_Plate_Weakspot_back_r", "Smasher_Plate_Weakspot_chest_l", "Smasher_Plate_Weakspot_chest_r", "Smasher_Plate_Weakspot_collar", "Smasher_Plate_Weakspot_pipe_l", "Smasher_Plate_Weakspot_pipe_r", "Smasher_Plate_Weakspot_shoulder_l", "Smasher_Plate_Weakspot_shoulder_r", "Smasher_Plate_Weakspot_stomach_low", "Smasher_Plate_Weakspot_stomach_mid_l", "Smasher_Plate_Weakspot_stomach_mid_r", "Smasher_Plate_Weakspot_stomach_up_l", "Smasher_Plate_Weakspot_stomach_up_r", "Splinter", "Stock", "StrongArmsBattery", "StrongArmsKnuckles", "SystemReplacementCW", "Targeting", "TechWeaponModEpic", "TechWeaponModLegendary", "TechWeaponModRare", "Torso", "TppHead", "UnderwearBottom", "UnderwearTop", "VehicleDoorBackLeft", "VehicleDoorBackRight", "VehicleDoorFrontLeft", "VehicleDoorFrontRight", "VehicleGenericMappin", "VehicleHood", "VehicleTrunk", "VehicleTurret", "WeakspotLeft", "WeakspotRight", "WeakspotSlot", "WeaponLeft", "WeaponRight", "WeaponSlots"
	}
	
	factsearch = ""
	factresult = ""
currentproject = nil
currentactionlist = {}
currentcolorRGB = {}
currentcolorRGB.red = 0
currentcolorRGB.green = 0
currentcolorRGB.blue = 0
currentScript = {}
itemsdirectmod = {}

itemsdirectmod.state = false
itemsdirectmod.target = nil

cameraManager = {}

mappineditorManager = {}

currentJson = {}

currentAction= {}

editortimedilatationignoreplayer = false

editortimedilatation = 0

editortimehour = 0

editortimeminute = 0

currentTrigger= {}

currentContextProp= {}

currentContext= {}

currentObjective= {}

currentDialogOptions= {}

currentContextPropValue =  {}

currentPhoneConversationeditor = {}

currentPhoneConversationMessage = {}

currentPhoneConversationMessageChoice = {}

currentInterfaceControl = {}

currentvertex = { x= 0, y=0 }


editorinterfacecontrolsearch = ""
currentPlacesRooms= {}
currentItems= {}

newscript = {}
newscript.type = ""
newscript.tag = ""

newtrack = {}
newtrack.name = ""
newtrack.file = ""

aiAnswer = ""
aiAsk = ""
aiContext =""


newhousestep = {}
newhousestep.title = ""
newhousestep.price = 0
newhousestep.desc = ""
newhousestep.template = ""
newhousestep.anchor = {}
newhousestep.anchor.x = 0
newhousestep.anchor.y = 0
newhousestep.anchor.z = 0

newscenestep = {}
newscenestep.tag = ""
newscenestep.action = {}

newentity = {}
newentity.tag = ""
newentity.tweak = "Character.Judy"
newentity.search = ""

entityinputappearance = ""

defaultdialogIcon = ""
defaultlanguage = "en-us"
editoriconsearch = ""
editorpnjsearch = ""

genericVIPname = ""
genericVIPscore = 0
helpsectionNode = ""
helpsectionNodeAction = {}
assetbrowsersearch = ""
editortext = ""
editoractionsearch = ""
editortriggersearch = ""
editorcontexttypesearch = ""
entityinspector = {}
entityinspectortag = ""
camerainspector = {}
camerainspectortag = ""
camerainspectorindex = 0

mappininspector = {}
mappininspectortag = ""
mappininspectorindex = 0
currentOutput = {}

clipboard = {}
editorvoice = {
		["Greet V"] ="greeting",
		["Fear Foll"] ="fear_foll",
		["Fear Toll"] ="fear_toll",
		["Fear Beg"] ="fear_beg",
		["Fear Run"] ="fear_run",
		["Stealth Search"] ="stlh_search",
		["Stealth Death"] ="stlh_death",
		["Stealth Restore"] ="stealth_restored",
		["Stealth End"] ="stealth_ended",
		["Curious Grunt"] ="stlh_curious_grunt",
		["Grapple Grunt"] ="grapple_grunt",
		["Bump"] ="bump",
		["Vehicle Bump"] ="vehicle_bump",
		["Turret Warning"] ="turret_warning",
		["Octant Warning"] ="octant_warning",
		["Drone Warning"] ="drones_warning",
		["Mech Warning"] ="mech_warning",
		["Elite Warning"] ="elite_warning",
		["Camera Warning"] ="camera_warning",
		["Enemy Warning"] ="enemy_warning",
		["Heavy Warning"] ="heavy_warning",
		["Sniper Warning"] ="sniper_warning",
		["Any Damage"] ="vo_any_damage_hit",
		["Danger"] ="danger",
		["Combat Start"] ="start_combat",
		["Combat End"] ="combat_ended",
		["Combat Target Hit"] ="combat_target_hit",
		["Pedestrian Hit"] ="pedestrian_hit",
		["Light Hit"] ="hit_reaction_light",
		["Curse"] ="battlecry_curse",
		["Irritated"] ="coop_irritation",
		["Grenade Throw"] ="grenade_throw",
		["Got a kill!"] ="coop_reports_kill",
}
defaultphonemsgmode = {"From Speaker", "From V"}
langcategory = {
"default",
"de-de",
"en-us",
"fr-fr",
"pl-pl",
"es-es",
"es-mx",
"it-it",
"kr-kr",
"zh-cn",
"zh-tw",
"ru-ru",
"jp-jp",
"ar-ar",
"cz-cz",
"hu-hu",
"tr-tr",
"pt-br"
	
	}
choiceIconList = {
	"",
	"AccessPointIcon",
  "AccessTokenIcon",
  "ActionIcon",
  "AimIcon",
  "AllowIcon",
  "ApartmentIcon",
  "AthleticsIcon",
  "BackOutIcon",
  "BarIcon",
  "BountyHuntIcon",
  "BraindanceIcon",
  "CarIcon",
  "CarToBuyIcon",
  "ChangeToFriendlyIcon",
  "ClientInDistressIcon",
  "ClothesIcon",
  "ClueIcon",
  "ControlPanelIcon",
  "ConvoyIcon",
  "CoolIcon",
  "CourierIcon",
  "CustomPositionIcon",
  "DistractIcon",
  "DrawWeaponIcon",
  "DrinkIcon",
  "DropboxIcon",
  "EngineeringIcon",
  "FastTravelIcon",
  "FixerIcon",
  "FlatheadIcon",
  "FoodVendorIcon",
  "GangWatchIcon",
  "GetInIcon",
  "GetUpIcon",
  "GiveTakeIcon",
  "GrappleIcon",
  "GrenadeExplodeIcon",
  "GrenadeIcon",
  "GunIcon",
  "GunSuicideIcon",
  "HackingIcon",
  "HandshakeIcon",
  "HiddenStashIcon",
  "HideWeaponIcon",
  "HitIcon",
  "HuntForPsychoIcon",
  "IllegalIcon",
  "InteractionDoorsIcon",
  "InteractionIcon",
  "InvalidIcon",
  "JackInIcon",
  "JamWeaponIcon",
  "JohnnyPillsIcon",
  "JunkShopIcon",
  "LifepathCorpoIcon",
  "LifepathNomadIcon",
  "LifepathStreetKidIcon",
  "LockedIcon",
  "LootIcon",
  "MapBountyIcon",
  "MedicineIcon",
  "MeleeIcon",
  "MinorActivityIcon",
  "MinorQuestIcon",
  "MirrorIcon",
  "MotorcycleIcon",
  "NetrunnerIcon",
  "NetServiceIcon",
  "NonLethalTakedownIcon",
  "NPCIcon",
  "OnOffIcon",
  "OpenVendorIcon",
  "OutpostIcon",
  "PayIcon",
  "PhoneCallIcon",
  "PlayGuitarIcon",
  "ProstituteIcon",
  "QuestGiverIcon",
  "QuestIcon",
  "RebuyIcon",
  "ReflexIcon",
  "ReinforcementIcon",
  "ResourceIcon",
  "RetrievingIcon",
  "RipperdocIcon",
  "SabotageIcon",
  "ScanIcon",
  "ShardIcon",
  "ShowerIcon",
  "SitIcon",
  "SkillcheckDeviceIcon",
  "SmugglersIcon",
  "TakeControlIcon",
  "TakeDownIcon",
  "TalkIcon",
  "TechIcon",
  "ThieveryIcon",
  "UndiscoveredIcon",
  "UseIcon",
  "VehicleIcon",
  "WaitIcon",
  "WanderingMerchantIcon"
}


questgraphzoomlevel = 150
graphError = ""

editorUIManager = 
{
	
}
datapackmsg = ""

editorUIManagerName = 
{
	["editorWindows"] = "Cyberscript Studio V."..editorversion,
	["newScriptSelector"] = "New script",
	["moddata"] = "Mod Data",
	["newSpawn"] = "Spawn entities",
	["entityInspector"] = "Entity Inspector",
	["seeView"] = "Script Execution Engine",
	["currentQuestView"] = "Current CS Quest Viewer",
	["currentBountyView"] = "Current Bounty Viewer",
	["devZone"] = "Dev Zone",
	["modLog"] = "Mod Log",
	["variableEditor"] = "Variable Editor",
	["cameraManager"] = "Camera Manager",
	["colorPicker"] = "Color Picker",
	["customsoundtester"] = "Custom Sound Tester",
	["customradiotester"] = "Custom Radio Tester",
	["loadScriptSelector"] = "Script Browser",
	["ammdecorconvert"] = "AMM Decor Template Converter",
	["windowsmanager"] = "Editor Windows Manager",
	["itemEditor"] = "Item Editor",
	["newCameraSpawn"] = "Spawn camera",
	["cameraInspector"] = "Camera Inspector",
	["playerposition"] = "Player Position and Camera",
	["datapackbuilding"] = "Datapack Building",
	["timecontrol"] = "Time Manager",
	["newSpawnVehicle"] = "Spawn vehicles",
	["newMappinSpawn"] = "Spawn mappin",
	["mappinInspector"] = "Mappin Inspector",
	["datapackmanager"] = "CS Mod Manager",
	["actionTester"] = "Action Tester",
	["triggerTester"] = "Trigger Tester",
	["datapackscriptmanager"] = "Project Windows",
	["loadProjectScriptSelector"] = "Project Browser",
	["factcheck"] = "Fact Check",
	["aiTester"] = "Ai Tester",
	["perfTester"] = "Performance Tester"
}

editorInterfaceDynamicType = {
	"default","text" ,"shape","color" ,"visible" ,"opacity","rotation","size","margin","translation","padding","pivot"
}
editorContextType = {
	"System","User","Assistant"
}
editorContextValue = ""
editorContextTypeDefault = "User"
editorInterfaceDynamicTypedefault = "default"
editorInterfaceGlobalItem = {
	type ="",
	
	parent   ="",
	margin  ={},
	padding  ={},
	dynamic  ={},
	size  ={},
	scale  ={},
	translation ={},
	transform={},
	textcolor={
		red = 255,
		blue = 255,
		green = 255,
		},
	
	fittocontent  =true,
	opacity  =1,
	rotation  =0,
	interactive  = false,
	event  ={},
	horizontalalign  =0,
	anchor  =0,
	verticalalign  =0,
	style  ={fontsize=30},
	context  ={},
	trigger  ={},
	requirement  ={},
	}
	newcontrolevent = ""
	editorInterfaceEventName= {
		"OnEnter","OnRelease","OnLeave"
		
	}
	editorInterfaceSpecialProps= {
	"text",
	"split" ,
	"scrollspeed",
	"scrolldelay" ,
	"autoscroll" ,
	"tweak",
	"texture",

	"title",
	"action",
	"onenter_action",
	"onleave_action",
	"bgcolor",
	"childmargin",
	"shapevariant",
	"linethickness",
	"endcapstyle",
	"vertex"
}

	editorInterfaceItemType = {
		label={
			text="",
			split=0,
			scrollspeed = 5 ,
			scrolldelay  = 5,
			autoscroll  = false
		},
		textinput={
			text="",
			split=0,
			scrollspeed = 5 ,
			scrolldelay  = 5,
			autoscroll  = false
		},
		image={
			tweak="",
			texture=""
		},
		button={
			interactive  = true,
			title="",
			action= {} ,
			onenter_action= {} ,
			onleave_action= {},
			bgcolor={
			red = 255,
			blue = 255,
			green = 255,
			},
		},
		scrollarea={
			
		},
		area={
			
		},
		vertical_area={
			childmargin  ={},
		},
		horizontal_area={
			
			childmargin  ={},
		},
		rectangle={
			
			
		},
		circle={
			
		},
		shape={
			
			shapevariant  =0,
			linethickness  =5,
			endcapstyle  =3,
			vertex  ={}
		}
	}