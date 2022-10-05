

local contractTypeLevel = 3 -- gameJournalQuestType.Contract
local maxNestedLevel = 7

local QuestJournalUI = {}
-- enum gameJournalQuestType
-- {
-- MainQuest = 0,
-- SideQuest = 1,
-- MinorQuest = 2,
-- StreetStory = 3,
-- Contract = 4,
-- VehicleQuest = 5
-- }




local function makeListItemData(questDef, questEntry, questState, questtype)
	local itemData = QuestListItemData.new()
	itemData.questType = questtype
	itemData.questData = questEntry
	itemData.recommendedLevel = questDef.metadata.level
	itemData.State = questState.state --gameJournalEntryState.Undefined
	itemData.isVisited = questState.isVisited
	itemData.isResolved = questState.isComplete
	itemData.isTrackedQuest = questState.isTracked
	
	local listItemData = VirutalNestedListData.new()
	listItemData.widgetType = 1
	listItemData.level = questtype
	listItemData.collapsable = true
	listItemData.data = itemData
	
	return listItemData
end




function QuestJournalUI.Initialize()
	---@param self questLogGameController
	ObserveAfter('questLogGameController', 'BuildQuestList', function(self)
	
	if getUserSetting("enableCustomQuest") == true then
		Cron.NextTick(function()
		
			getMissionByTrigger()
			
			local questToOpen
			local listData = self.listData
			
			
			
			local header = QuestListHeaderData.new()
			header.type = 99
			header.nameLocKey = CName("Available Quests")
			
			
			local listItemData = VirutalNestedListData.new()
			listItemData.widgetType = 0
			listItemData.level = 99
			listItemData.collapsable = false
			listItemData.isHeader = true
			listItemData.data = header
			table.insert(listData, listItemData)
			
			
			for _, questDef in ipairs(QuestManager.GetQuests()) do
				local questState = QuestManager.GetQuestState(questDef.id)
				local questEntry = QuestManager.GetQuestEntry(questDef.id)
				
				if(QuestManager.IsQuestActive(questDef.id) or QuestManager.IsQuestComplete(questDef.id)) then 
					
					if QuestManager.isVisited(questDef.id) then
						
						local itemData = makeListItemData(questDef, questEntry, questState, questDef.metadata.questType)
						itemData.data.playerLevel = self.playerLevel
						
						table.insert(listData, itemData)
						
						if questState.isTracked then
							questToOpen = questEntry
						end
						
						else
						
						local itemData = makeListItemData(questDef, questEntry, questState,99)
						itemData.data.playerLevel = self.playerLevel
						
						table.insert(listData, itemData)
						
						if questState.isTracked then
							questToOpen = questEntry
						end
						
					end
					
				end
			end
			
			self.listData = listData
			
			---@type QuestListVirtualNestedListController
			local listController = inkWidgetRef.GetController(self.virtualList)
			if(listController ~= nil) then
				if(#listData > 0) then
					listController:SetData(self.listData, true)
					
					if questToOpen then
						local evt = QuestlListItemClicked.new()
						evt.questData = questToOpen
						evt.skipAnimation = true
						
						self:QueueEvent(evt)
						
						listController.toggledLevels = {}
						for level = 0, maxNestedLevel do
							if level ~= contractTypeLevel then
								listController:ToggleLevel(level)
							end
						end
					end
				end
			end
		
		end)
	end	
	end)
	
	---@param e QuestlListItemClicked
	ObserveAfter('questLogGameController', 'OnQuestListItemClicked', function(self, e)
	Cron.NextTick(function()
		local questId = e.questData.id
		
		if QuestManager.IsKnownQuest(questId) then
			QuestManager.MarkQuestAsVisited(questId)
			
			
		end
		
	end)
		end)
	---@param self questLogGameController
	---@param e RequestChangeTrackedObjective
	ObserveAfter('questLogGameController', 'OnRequestChangeTrackedObjective', function(self, e)
		
		Cron.NextTick(function()
		
		if e.quest then
			if QuestManager.IsKnownQuest(e.quest.id) then
				e.objective = QuestManager.GetFirstObjectiveEntry(e.quest.id)
				else
				e.objective = self:GetFirstObjectiveFromQuest(e.quest)
			end
			elseif e.objective then
			if QuestManager.IsKnownObjective(e.objective.id) then
				e.quest = QuestManager.GetQuestEntryForObjective(e.objective.id)
				else
				e.quest = questLogGameController.GetTopQuestEntry(self.journalManager, e.objective)
			end
		end
		
		if QuestManager.IsKnownQuest(e.quest.id) then
			if QuestManager.IsQuestComplete(e.quest.id) then
				return
			end
			
			QuestManager.TrackObjective(e.objective.id)
			
			local obj = QuestManager.GetObjective(e.objective.id)
			
			
			else
			local state = self.journalManager:GetEntryState(e.quest)
			
			if state == gameJournalEntryState.Succeeded or state == gameJournalEntryState.Failed then
				return
			end
			
			self.journalManager:TrackEntry(e.objective)
		end
		
		
		
		self.trackedQuest = e.quest
		
		self:PlaySound('MapPin', 'OnCreate')
		
		local updateEvent = UpdateTrackedObjectiveEvent.new()
		updateEvent.trackedObjective = e.objective
		updateEvent.trackedQuest = e.quest
		
		self:QueueEvent(updateEvent)
		
		for _, nestedData in ipairs(self.listData) do
			local itemData = nestedData.data
			if itemData:IsA('QuestListItemData') then
				itemData.isTrackedQuest = itemData.questData.id == e.quest.id
			end
		end
		end)
	end)
	---@param self QuestListItemController
	ObserveAfter('QuestListItemController', 'UpdateDistance', function(self)
		Cron.NextTick(function()
		local questId = self.data.questData.id
		
		if QuestManager.IsKnownQuest(questId) then
			local questDef = QuestManager.GetQuest(questId)
			
			inkTextRef.SetText(self.title, getLang(questDef.title))
			if(questDef.metadata.district < 119) then
				local districtIconRecord = TweakDBInterface.GetUIIconRecord('UIIcon.' .. QuestManager.getDistrictName(questDef.metadata.district))
				inkImageRef.SetAtlasResource(self.districtIcon, districtIconRecord:AtlasResourcePath())
				inkImageRef.SetTexturePart(self.districtIcon, districtIconRecord:AtlasPartName())
			else
				local districtIconRecord = TweakDBInterface.GetUIIconRecord('UIIcon.program_generic')
				inkImageRef.SetAtlasResource(self.districtIcon, districtIconRecord:AtlasResourcePath())
				inkImageRef.SetTexturePart(self.districtIcon, districtIconRecord:AtlasPartName())
			end
		end
	end)
	end)
	---@param self QuestDetailsPanelController
	---@param questData JournalQuest
	ObserveAfter('QuestDetailsPanelController', 'Setup', function(self, questData)
	Cron.NextTick(function()
		local questId = questData.id
		
		if QuestManager.IsKnownQuest(questId) then
		
				local questDef = QuestManager.GetQuest(questId)
				
				if( arrayQuest2[questId].quest.recurrent ~= nil and arrayQuest2[questId].quest.recurrent == true) then
					
					inkTextRef.SetText(self.questTitle, "(Recurrent)"..getLang(questDef.title))
					
					else
					inkTextRef.SetText(self.questTitle, getLang(questDef.title))
					
				end
				inkTextRef.SetText(self.questDescription, getLang(questDef.description))
				for _, objectiveDef in ipairs(QuestManager.GetObjectiveDefByQuest(questDef.id)) do
					local objectiveState = QuestManager.GetObjectiveState(objectiveDef.id)
				
					if not objectiveState.isComplete and objectiveState.isActive then
						local objectiveWidget = self:SpawnFromLocal(inkWidgetRef.Get(self.activeObjectives), 'questObjective')
						objectiveWidget:SetHAlign(inkEHorizontalAlign.Left)
						objectiveWidget:SetVAlign(inkEVerticalAlign.Top)
						
						---@type QuestDetailsObjectiveController
						local objectiveController = objectiveWidget:GetController()
						objectiveController.objective = QuestManager.GetObjectiveEntry(objectiveDef.id)
						spdlog.error(dump(objectiveDef))
						local objectiveTitle = getLang(objectiveDef.title)
						if objectiveDef.isOptional then
							objectiveTitle = objectiveTitle .. ' [' .. GetLocalizedText('UI-ScriptExports-Optional0') .. ']'
						end
						--local widget = self.SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkMappin")
						--  local controller = widget:GetController()
						
						if objectiveState.isTracked then
						
						
						local obj = QuestManager.GetObjective(objectiveDef.id)
						spdlog.error(dump(obj))
						if obj.extra ~= nil then
							
							
							
							
							
							
							if obj.extra.mappin ~= nil then
								
								local mappin = getMappinByTag(obj.extra.mappin)
								
								if(mappin ~= nil) then
									
									local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkMappin")
									local controller =  widget:GetController()
									
									
									local jumpto = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
									
									
									
									journalQuestMapPinBase =  obj.extra.mappin
									
									controller:Setup(nil, jumpto)
									
									
								end
							end
							
							
							if obj.extra.data ~= nil then
								for i,data in ipairs(obj.extra.data) do
									
									local entry = Game.GetJournalManager():GetEntryByString(data.value,data.type)
									
									if(entry ~= nil) then
										
										local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkCodex")
										local controller =  widget:GetController()
										controller:Setup(entry)
										
										
									end
									
								end
							end
							
							if obj.extra.custom ~= nil then
								for i,data in ipairs(obj.extra.custom) do
									
									
									
									local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkCodex")
									local controller =  widget:GetController()
									
									
									
									codexEntryTag = data.tag
									
									
									controller:SetupCodexLink(nil)
									
									
									
									
								end
							end
						end
						
								
						end
						
						inkTextRef.SetText(objectiveController.objectiveName, objectiveTitle)
						inkWidgetRef.SetState(objectiveController.trackingMarker, objectiveState.isTracked and 'Tracked' or 'Default')
					end
				end
			
		end
	end)
	end)
	
	Override('QuestListHeaderController', 'Setup', function(self, titleLocKey,questType,wrappedMethod)
		
		
		if questType == 99 then
			
			self.questType = questType;
			inkTextRef.SetText(self.title, getLang("AvailablesQuest"))
			self.hovered = false
			self:UpdateState()
			else
			wrappedMethod(titleLocKey,questType)
		end
		
		
	end)
	
end

return QuestJournalUI
