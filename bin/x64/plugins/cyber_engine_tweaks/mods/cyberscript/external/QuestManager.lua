local questDefs = {}
local questDefMap = {}
local objectiveDefMap = {}
local objectiveToQuestDefMap = {}

local questEntryMap = {}
local objectiveEntryMap = {}



local trackedQuestId = 0
local trackedObjectiveId = 0



EgameJournalQuestType =  
{
   MainQuest = 0,
   SideQuest = 1,
   MinorQuest = 2,
   StreetStory = 3,
   CyberPsycho = 4,
   Contract = 5,
   VehicleQuest = 6,
   ApartmentQuest = 7
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
   Badlands_VasquezPass = 25,
   Badlands_Yucca = 26,
   Badlands_YuccaGarage = 27,
   Badlands_YuccaRadioTower = 28,
   CharterHill = 29,
   CharterHill_PowerPlant = 30,
   CityCenter = 31,
   Coastview = 32,
   Coastview_BattysHotel = 33,
   Coastview_ButcherShop = 34,
   Coastview_GrandImperialMall = 35,
   Coastview_RundownApartment = 36,
   Coastview_VDBChapel = 37,
   Coastview_VDBMaglev = 38,
   Coastview_q110Cyberspace = 39,
   CorpoPlaza = 40,
   CorpoPlaza_ArasakaTowerAtrium = 41,
   CorpoPlaza_ArasakaTowerCEOFloor = 42,
   CorpoPlaza_ArasakaTowerJenkins = 43,
   CorpoPlaza_ArasakaTowerJungle = 44,
   CorpoPlaza_ArasakaTowerLobby = 45,
   CorpoPlaza_ArasakaTowerNest = 46,
   CorpoPlaza_ArasakaTowerSaburoOffice = 47,
   CorpoPlaza_ArasakaTowerUnlistedFloors = 48,
   CorpoPlaza_ArasakaTowerUpperAtrium = 49,
   CorpoPlaza_q201Cyberspace = 50,
   Downtown = 51,
   Downtown_Jinguji = 52,
   Downtown_TheHammer = 53,
   Glen = 54,
   Glen_Embers = 55,
   Glen_MusicStore = 56,
   Glen_NCPDLab = 57,
   Glen_WichedTires = 58,
   Heywood = 59,
   JapanTown = 60,
   JapanTown_Clouds = 61,
   JapanTown_DarkMatter = 62,
   JapanTown_Fingers = 63,
   JapanTown_FourthWallBdStudio = 64,
   JapanTown_HiromisApartment = 65,
   JapanTown_MegabuildingH8 = 66,
   JapanTown_VR_Tutorial = 67,
   JapanTown_Wakakos_Pachinko_Parlor = 68,
   Kabuki = 69,
   Kabuki_JudysApartment = 70,
   Kabuki_LizziesBar = 71,
   Kabuki_NoTellMotel = 72,
   LagunaBend_LakeHut = 73,
   LittleChina = 74,
   LittleChina_Afterlife = 75,
   LittleChina_MistysShop = 76,
   LittleChina_Q101Cyberspace = 77,
   LittleChina_RiotClub = 78,
   LittleChina_TomsDiner = 79,
   LittleChina_VApartment = 80,
   LittleChina_VictorsClinic = 81,
   NorthBadlands = 82,
   NorthOaks = 83,
   NorthOaks_Arasaka_Estate = 84,
   NorthOaks_Columbarium = 85,
   NorthOaks_Denny_Estate = 86,
   NorthOaks_Kerry_Estate = 87,
   Northside = 88,
   Northside_All_Foods = 89,
   Northside_CleanCut = 90,
   Northside_Totentaz = 91,
   Northside_WNS = 92,
   Pacifica = 93,
   RanchoCoronado = 94,
   RanchoCoronado_Caliente = 95,
   RanchoCoronado_GunORama = 96,
   RanchoCoronado_Piez = 97,
   RanchoCoronado_Softsys = 98,
   RanchoCoronado_Stylishly = 99,
   SantoDomingo = 100,
   SouthBadlands = 101,
   SouthBadlands_EdgewoodFarm = 102,
   SouthBadlands_PoppyFarm = 103,
   SouthBadlands_TrailerPark = 104,
   SouthBadlands_q201SpaceStation = 105,
   VistaDelRey = 106,
   Vista_del_Rey_Delamain = 107,
   Vista_del_Rey_LaCatrina = 108,
   Vista_del_rey_Abandoned_Apartment_Building = 109,
   Vista_del_rey_ElCoyoteCojo = 110,
   Watson = 111,
   Wellsprings = 112,
   WestWindEstate = 113,
   Westbrook = 114,
   Count = 115,
   Invalid = 116
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
	Game.untrack()
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
	
	local questos = arrayQuest2[questId].quest
	
	local data = {}
	checkContext(questos)		
	
	data.id = questos.tag
	data.title = getLang(questos.title)
	data.description = getLang(questos.content)
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
	return questDefs
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
	
	currentSave.savedStates[entryId] = {
			state =3
		}
		
		
	for _, objectiveDef in ipairs(questDefMap[entryId].objectives) do

			QuestManager.MarkObjectiveAsComplete(objectiveDef.id)
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
	trackedObjectiveId = objectiveId
	trackedQuestId = objectiveToQuestDefMap[objectiveId].id

	resetJournalManager()
	signalQuestTracker()
	
	if(bool ~= nil and bool == true) then
	
	QuestTrackerGameController:OnMenuUpdate(true)
	
	end
end

function QuestManager.UntrackObjective()
	trackedQuestId = 0
	trackedObjectiveId = 0

	signalQuestTracker()
end




return QuestManager