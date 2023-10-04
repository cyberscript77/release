logme(1,"CyberScript Core Quest Manager module loaded")
local questDefs = {}
local questDefMap = {}
local objectiveDefMap = {}
local objectiveToQuestDefMap = {}

local questEntryMap = {}
local objectiveEntryMap = {}



local trackedQuestId = 0
local trackedObjectiveId = 0
local lastTrackedObjective = 0


EgameJournalQuestType =  
{
	MainQuest = 0,
  SideQuest = 1,
  Gig = 2,
  Cyberpsycho = 3,
  NCPDQuest = 4,
  Apartment = 5,
  Courier = 6,
  Finished = 7,
  Count = 8,
  All = 9,
  Invalid = -1,
}


EgameJournalEntryState = 
{
   Undefined = 0,
   Inactive = 1,
   Active = 2,
   Succeeded = 3,
   Failed = 4
}

EgameJournalEntryStateRename = 
{
   Undefined = 0,
   Locked = 1,
   Unlocked = 2,
   Succeeded = 3,
   Failed = 4
}

EgamedataDistrict = 
{
    ArasakaWaterfront = 0,
  ArasakaWaterfront_AbandonedWarehouse = 1,
  ArasakaWaterfront_KonpekiPlaza = 2,
  Arroyo = 3,
  Arroyo_Arasaka_Warehouse = 4,
  Arroyo_ClairesGarage = 5,
  Arroyo_CytechFactory = 6,
  Arroyo_Kendachi = 7,
  Arroyo_KenmoreCafe = 8,
  Arroyo_LasPalapas = 9,
  Arroyo_Red_Dirt = 10,
  Arroyo_TireEmpire = 11,
  Badlands = 12,
  Badlands_BiotechnicaFlats = 13,
  Badlands_DryCreek = 14,
  Badlands_JacksonPlains = 15,
  Badlands_LagunaBend = 16,
  Badlands_LasPalapas = 17,
  Badlands_NorthSunriseOilField = 18,
  Badlands_RattlesnakeCreek = 19,
  Badlands_RedPeaks = 20,
  Badlands_RockyRidge = 21,
  Badlands_SantaClara = 22,
  Badlands_SierraSonora = 23,
  Badlands_SoCalBorderCrossing = 24,
  Badlands_Spaceport = 25,
  Badlands_VasquezPass = 26,
  Badlands_Yucca = 27,
  Badlands_YuccaGarage = 28,
  Badlands_YuccaRadioTower = 29,
  CharterHill = 30,
  CharterHill_AuCabanon = 31,
  CharterHill_PowerPlant = 32,
  CityCenter = 33,
  Coastview = 34,
  Coastview_BattysHotel = 35,
  Coastview_ButcherShop = 36,
  Coastview_GrandImperialMall = 37,
  Coastview_RundownApartment = 38,
  Coastview_VDBChapel = 39,
  Coastview_VDBMaglev = 40,
  Coastview_q110Cyberspace = 41,
  CorpoPlaza = 42,
  CorpoPlaza_Apartment = 43,
  CorpoPlaza_ArasakaTowerAtrium = 44,
  CorpoPlaza_ArasakaTowerCEOFloor = 45,
  CorpoPlaza_ArasakaTowerJenkins = 46,
  CorpoPlaza_ArasakaTowerJungle = 47,
  CorpoPlaza_ArasakaTowerLobby = 48,
  CorpoPlaza_ArasakaTowerNest = 49,
  CorpoPlaza_ArasakaTowerSaburoOffice = 50,
  CorpoPlaza_ArasakaTowerUnlistedFloors = 51,
  CorpoPlaza_ArasakaTowerUpperAtrium = 52,
  CorpoPlaza_q201Cyberspace = 53,
  Dogtown = 54,
  Dogtown_Akebono = 55,
  Dogtown_Brooklyn = 56,
  Dogtown_CapitanCaliente = 57,
  Dogtown_Cynosure = 58,
  Dogtown_Expo = 59,
  Dogtown_Hideout = 60,
  Dogtown_Worldmap_Sub = 61,
  Downtown = 62,
  Downtown_Jinguji = 63,
  Downtown_TheHammer = 64,
  Glen = 65,
  Glen_Apartment = 66,
  Glen_Embers = 67,
  Glen_MusicStore = 68,
  Glen_NCPDLab = 69,
  Glen_WichedTires = 70,
  Heywood = 71,
  JapanTown = 72,
  JapanTown_Apartment = 73,
  JapanTown_Clouds = 74,
  JapanTown_DarkMatter = 75,
  JapanTown_Fingers = 76,
  JapanTown_FourthWallBdStudio = 77,
  JapanTown_HiromisApartment = 78,
  JapanTown_MegabuildingH8 = 79,
  JapanTown_VR_Tutorial = 80,
  JapanTown_Wakakos_Pachinko_Parlor = 81,
  Kabuki = 82,
  Kabuki_JudysApartment = 83,
  Kabuki_LizziesBar = 84,
  Kabuki_NoTellMotel = 85,
  LagunaBend_LakeHut = 86,
  Langley_Clinic = 87,
  LittleChina = 88,
  LittleChina_Afterlife = 89,
  LittleChina_MistysShop = 90,
  LittleChina_Q101Cyberspace = 91,
  LittleChina_RiotClub = 92,
  LittleChina_TomsDiner = 93,
  LittleChina_VApartment = 94,
  LittleChina_VictorsClinic = 95,
  MorroRock = 96,
  MorroRock_NCX = 97,
  NorthBadlands = 98,
  NorthOaks = 99,
  NorthOaks_Arasaka_Estate = 100,
  NorthOaks_Columbarium = 101,
  NorthOaks_Denny_Estate = 102,
  NorthOaks_Kerry_Estate = 103,
  Northside = 104,
  Northside_All_Foods = 105,
  Northside_Apartment = 106,
  Northside_CleanCut = 107,
  Northside_Totentaz = 108,
  Northside_WNS = 109,
  Pacifica = 110,
  RanchoCoronado = 111,
  RanchoCoronado_Caliente = 112,
  RanchoCoronado_GunORama = 113,
  RanchoCoronado_Piez = 114,
  RanchoCoronado_Softsys = 115,
  RanchoCoronado_Stylishly = 116,
  SantoDomingo = 117,
  SouthBadlands = 118,
  SouthBadlands_EdgewoodFarm = 119,
  SouthBadlands_PoppyFarm = 120,
  SouthBadlands_TrailerPark = 121,
  SouthBadlands_q201SpaceStation = 122,
  VistaDelRey = 123,
  Vista_del_Rey_Delamain = 124,
  Vista_del_Rey_LaCatrina = 125,
  Vista_del_rey_Abandoned_Apartment_Building = 126,
  Vista_del_rey_ElCoyoteCojo = 127,
  Watson = 128,
  Wellsprings = 129,
  WestWindEstate = 130,
  Westbrook = 131,
  Count = 132,
  Invalid = 133
}



local function getSavedState(entryId)
	if not currentSave.savedStates[entryId] then
		currentSave.savedStates[entryId] = {
			state = 2
		}
	end

	return currentSave.savedStates[entryId]
end

local function makeJournalQuestEntry(questId)
	if not questEntryMap[questId] then
		local questEntry = JournalQuest.new()
		questEntry.id = questId

		questEntryMap[questId] = questEntry
	end

	return questEntryMap[questId]
end

local function makeJournalObjectiveEntry(objectiveId)
	if not objectiveEntryMap[objectiveId] then
		local objectiveEntry = JournalQuestObjective.new()
		objectiveEntry.id = objectiveId

		objectiveEntryMap[objectiveId] = objectiveEntry
	end

	return objectiveEntryMap[objectiveId]
end

local function resetJournalManager()
	local journal = JournalEntry.new()
	JournalEntry.id = "test"
	--Game.GetJournalManager():TrackEntry(journal)
end

local function signalQuestTracker()
	local blackboardDefs = Game.GetAllBlackboardDefs()
	Game.GetBlackboardSystem():Get(blackboardDefs.UI_System):SignalBool(blackboardDefs.UI_System.IsInMenu)
end






local QuestManager = {}




function QuestManager.getDistrictName(enum)
	
	for k,v in pairs(EgamedataDistrict) do
	
		if(v == enum) then
		
			return k
		
		end
	
	end
	
end


function  QuestManager.getEntryState(enum)
	
	for k,v in pairs(EgamedataDistrict) do
	
		if(v == enum) then
		
			return k
		
		end
	
	end
	
end


function  QuestManager.getgameJournalEntryState(enum)
	
	if(enum == 0)then
		return gameJournalEntryState.Undefined
	end
	
	if(enum == 1)then
		return gameJournalEntryState.Inactive
	end
	
	if(enum == 2)then
		return gameJournalEntryState.Active
	end
	
	if(enum == 3)then
		return gameJournalEntryState.Succeeded
	end
	
	if(enum == 4)then
		return gameJournalEntryState.Failed
	end
	
end


function  QuestManager.getgameJournalQuestType(enum)
	
	if(enum == 0)then
		return gameJournalQuestType.MainQuest
	end
	
	if(enum == 1)then
		return gameJournalQuestType.SideQuest
	end
	
	if(enum == 2)then
		return gameJournalQuestType.MinorQuest
	end
	
	if(enum == 3)then
		return gameJournalQuestType.StreetStory
	end
	if(enum == 4)then
		return gameJournalQuestType.CyberPsycho
	end
	
	if(enum == 5)then
		return gameJournalQuestType.Contract
	end
	if(enum == 6)then
		return gameJournalQuestType.VehicleQuest
	end
	
	if(enum == 7)then
		return gameJournalQuestType.ApartmentQuest
	end
	
end




function QuestManager.LoadData(data)
	questDefs = data

	questDefMap = {}
	objectiveDefMap = {}
	objectiveToQuestDefMap = {}

	for _, questDef in ipairs(questDefs) do
		questDefMap[questDef.id] = questDef

		for _, objectiveDef in ipairs(questDef.objectives) do
			objectiveDefMap[objectiveDef.id] = objectiveDef
			objectiveToQuestDefMap[objectiveDef.id] = questDef
		end
	end
end

function QuestManager.LoadState(state)
	currentSave.savedStates = state
end



function QuestManager.AddQuest(data)
	
	if(questDefMap[data.id] == nil) then
	
		table.insert(questDefs,data)


		questDefMap[data.id] = data
		questDefMap[data.id].isVisited = false
			for _, objectiveDef in ipairs(data.objectives) do
				objectiveDefMap[objectiveDef.id] = objectiveDef
				objectiveToQuestDefMap[objectiveDef.id] = data
			end
			
		
	end
	
end

function QuestManager.RemoveQuest(id)
	
	local index = nil
	local data = nil 
	
	for i = 1,#questDef do
	
		if(questDef[i].id == id) then
			index = i
			data = questDef[i]
		end
	
	end
	
	if(index ~= nil and data ~= nil) then
		
		questDefMap[id] = nil
		for _, objectiveDef in ipairs(data.objectives) do
			objectiveDefMap[objectiveDef.id] = nil
			objectiveToQuestDefMap[objectiveDef.id] = nil
		end
		questDef[i] = nil
		
	end
	
end




function QuestManager.resetQuestfromJson(questId)
	
	local questos = cyberscript.cache["mission"][questId].data
	
	local data = {}
	checkContext(questos)		
	
	data.id = questos.tag
	data.title = getLang(questos.title)
	data.description = getLang(questos.content)
	data.extra = questos.extra
	data.metadata = {}
	data.metadata.level = questos.recommandedlevel
	data.metadata.questType = questos.questtype
	data.metadata.district =  questos.district
	
	data.objectives = {}
	
	
	for i=1,#questos.objectives do 
	
	local irpobj = questos.objectives[i]
	checkContext(irpobj)
	local obj = irpobj
	
	obj.id = irpobj.tag
	obj.title = getLang(irpobj.title)
	obj.isOptional = irpobj.isoptionnal
	obj.state = irpobj.state
	
	table.insert(data.objectives,obj)
	
	end
	
	questDefMap[data.id] = data
	
	for _, objectiveDef in ipairs(data.objectives) do
		objectiveDefMap[objectiveDef.id] = objectiveDef
		objectiveToQuestDefMap[objectiveDef.id] = data
		QuestManager.MarkObjectiveAs(objectiveDef.id, objectiveDef.state)
	end
	
	QuestManager.MarkQuestAsInactive(questos.tag)
	
	
end





function QuestManager.GetQuests()
	
	return questDefMap
end


function QuestManager.IsKnownQuest(questId)
	return questDefMap[questId] ~= nil
end

function QuestManager.IsKnownObjective(objectiveId)
	return objectiveDefMap[objectiveId] ~= nil
end



function QuestManager.GetQuest(questId)
	return questDefMap[questId]
end

function QuestManager.GetQuestEntry(questId)
	return makeJournalQuestEntry(questId)
end

function QuestManager.GetObjective(objectiveId)
	return objectiveDefMap[objectiveId]
end



function QuestManager.GetObjectiveDefByQuest(questId)
	
	local objectives = {}
	
	for i=1,#questDefMap[questId].objectives do
		local obje = questDefMap[questId].objectives[i]
		
		table.insert(objectives, objectiveDefMap[obje.id])
	
	end
	
	
	return objectives
	
end


function QuestManager.GetObjectiveEntry(objectiveId)
	return makeJournalObjectiveEntry(objectiveId)
end

function QuestManager.GetQuestForObjective(objectiveId)
	return objectiveToQuestDefMap[objectiveId]
end

function QuestManager.GetQuestEntryForObjective(objectiveId)
	return makeJournalQuestEntry(QuestManager.GetQuestForObjective(objectiveId).id)
end

function QuestManager.GetFirstObjective(questId)
	local questDef = QuestManager.GetQuest(questId)

	if questDef then
		for _, objectiveDef in ipairs(questDef.objectives) do
			local objectiveState = QuestManager.GetObjectiveState(objectiveDef.id)

			if not objectiveState.isComplete then
				return objectiveDef
			end
		end
	end

	return nil
end

function QuestManager.GetFirstObjectiveEntry(questId)
	return makeJournalObjectiveEntry(QuestManager.GetFirstObjective(questId).id)
end

function QuestManager.GetQuestState(questId)
	local savedState = getSavedState(questId)

	local finalState = {}
	finalState.state =  QuestManager.getgameJournalEntryState(savedState.state)
	finalState.isVisited = (checkQuestStatutByTag(questId, nil) == false and checkQuestStatutByTag(questId, -1) == false)
	finalState.isComplete = QuestManager.getgameJournalEntryState(savedState.state)== gameJournalEntryState.Succeeded or QuestManager.getgameJournalEntryState(savedState.state) == gameJournalEntryState.Failed
	finalState.isTracked = QuestManager.IsTrackedQuest(questId)
	
	finalState.isActive = QuestManager.getgameJournalEntryState(savedState.state) == gameJournalEntryState.Active
	
	return finalState
end

function QuestManager.GetObjectiveState(objectiveId)
	local savedState = getSavedState(objectiveId)

	local finalState = {}
	finalState.hidden = savedState.hidden
	finalState.state = QuestManager.getgameJournalEntryState(savedState.state)
	finalState.isComplete = QuestManager.getgameJournalEntryState(savedState.state) == gameJournalEntryState.Succeeded or QuestManager.getgameJournalEntryState(savedState.state) == gameJournalEntryState.Failed
	finalState.isTracked = QuestManager.IsTrackedObjective(objectiveId)
	finalState.isActive = QuestManager.getgameJournalEntryState(savedState.state) == gameJournalEntryState.Active
	return finalState
end




function QuestManager.IsQuestComplete(entryId)
	return QuestManager.GetQuestState(entryId).isComplete
end

function QuestManager.IsQuestActive(entryId)
	return QuestManager.GetQuestState(entryId).isActive
end

function QuestManager.isVisited(entryId)
	return QuestManager.GetQuestState(entryId).isVisited
end

function QuestManager.IsObjectiveComplete(objectiveId)
	return QuestManager.GetObjectiveState(objectiveId).isComplete
end





function QuestManager.MarkQuestAsVisited(entryId)

		
		currentSave.savedStates[entryId] = {
			state = 2,
			
		}
		questDefMap[entryId].isVisited = true
		if(getScoreKey(entryId,"Score") == nil or getScoreKey(entryId,"Score") == -1) then
		
		setScore(entryId,"Score",0)
		
		end
	
end


function QuestManager.MarkQuestAsUnVisited(entryId)

		
	
		questDefMap[entryId].isVisited = false
		
	
end

function QuestManager.MarkQuestAsUndefined(entryId)
	
	currentSave.savedStates[entryId] = {
		state = 0
		}
	
end

function QuestManager.MarkQuestAsInactive(entryId)
	
	currentSave.savedStates[entryId] = {
			state =1
		}
		
	
end

function QuestManager.MarkQuestAsActive(entryId)
	
	currentSave.savedStates[entryId] = {
			state = 2
		}
	
end

function QuestManager.MarkQuestASucceeded(entryId)
	print("ddd)")
	if(entryId ~= nil) then
	currentSave.savedStates[entryId] = {
			state =3
		}
	
		if(questDefMap[entryId] ~= nil and questDefMap[entryId].objectives ~= nil) then
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsComplete(objectiveDef.id)
	end
		end
		
	end
end




function QuestManager.MarkQuestAsFailed(entryId)
	
	currentSave.savedStates[entryId] = {
			state =4
		}
	
end




function QuestManager.ChangeQuestTitle(entryId,desc)

		
		questDefMap[entryId].title = desc
	
end



function QuestManager.ChangeQuestContent(entryId,desc)

		
		questDefMap[entryId].description = desc
	
end

function QuestManager.ChangeObjectiveContent(objectiveId,desc)

	objectiveDefMap[objectiveId].title = desc
	
	
end


function QuestManager.AddObjective(entryId,objective)

		objectiveDefMap[objective.id] = objective
		objectiveToQuestDefMap[objective.id] = questDefMap[entryId]
		
	
end

function QuestManager.RemoveObjective(objective)

		objectiveDefMap[objective.id] = nil
		objectiveToQuestDefMap[objective.id] = nil
		
	
end



function QuestManager.MarkAllObjectiveOfQuestAs(entryId,statut)
	
	if(statut == 3) then
	
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsComplete(objectiveDef.id)
	end
	
	end
	
	if(statut == 0) then
	
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsUndefined(objectiveDef.id)
	end
	
	end
	
	if(statut == 1) then
	
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsInactive(objectiveDef.id)
	end
	
	end
	
	if(statut == 4) then
	
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsFailed(objectiveDef.id)
	end
	
	end
	
	if(statut == 2) then
	
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsActive(objectiveDef.id)
	end
	
	end
	
end

function QuestManager.MarkObjectiveAs(objectiveId,enum)
	
	
	
   -- Undefined = 0,
   -- Inactive = 1,
   -- Active = 2,
   -- Succeeded = 3,
   -- Failed = 4
	
	
		currentSave.savedStates[objectiveId] = {
			state = enum
		}
	
	

	

	
end


function QuestManager.MarkObjectiveAsComplete(objectiveId)

	
	currentSave.savedStates[objectiveId] = {
			state = 3
		}

	
end

function QuestManager.MarkObjectiveAsCompleteAndHidden(objectiveId)

	
	currentSave.savedStates[objectiveId] = {
			state = 3,
			hidden = true
		}

	
end


function QuestManager.MarkObjectiveAsUndefined(objectiveId)

	currentSave.savedStates[objectiveId] = {
			state = 0
		}

	
end

function QuestManager.MarkObjectiveAsInactive(objectiveId)

currentSave.savedStates[objectiveId] = {
			state =1
		}
	
end

function QuestManager.MarkObjectiveAsActive(objectiveId)

	
	currentSave.savedStates[objectiveId] = {
			state = 2
		}

	 
end

function QuestManager.MarkObjectiveAsFailed(objectiveId)
	

	currentSave.savedStates[objectiveId] = {
			state = 4
		}

end





function QuestManager.IsTrackingObjective()
	return trackedObjectiveId ~= 0
end

function QuestManager.IsTrackinQuest()
	return trackedQuestId ~= 0
end




function QuestManager.GetTrackedQuestId()
	return trackedQuestId
end

function QuestManager.GetTrackedObjectiveId()
	return trackedObjectiveId
end




function QuestManager.IsTrackedQuest(questId)
	return trackedQuestId == questId
end

function QuestManager.IsTrackedObjective(objectiveId)
	return trackedObjectiveId == objectiveId
end




function QuestManager.TrackObjective(objectiveId, bool)
	
	lastTrackedObjective = trackedObjectiveId
	trackedObjectiveId = objectiveId
	trackedQuestId = objectiveToQuestDefMap[objectiveId].id

	resetJournalManager()
	signalQuestTracker()
	
	if(bool ~= nil and bool == true) then
	
	GameController["QuestTrackerGameController"]:OnMenuUpdate(true)
	
	end
end

function QuestManager.UntrackObjective()
	trackedQuestId = 0
	trackedObjectiveId = 0

	signalQuestTracker()
end




return QuestManager