logme(10,"CyberScript: observer function module loaded")
cyberscript.module = cyberscript.module +1
----print("hot reload test")
---Observer and Overrider---

local myucurrentQuestData = nil
--SetObserver()

--QuestJournalUI
function GenericNotificationController_SetNotificationData(self, notificationData)
	
	print("toto"..GameDump(notificationData))
	
end

function SimpleQuestListItemController_OnPress(this,data)
	
	if(this.data.journalManager == nil) then
		myucurrentQuestData = this.data.questData.id
		
		
		else
		myucurrentQuestData = nil
		
	end
end

function SimpleQuestListItemController_OnDataChanged(this,data)
	print("tracked")
	local quest = FromVariant(data)
	if(quest.journalManager == nil) then
		local mymission = cyberscript.cache["mission"][quest.questData.id].data
		local questType = QuestTypeIconUtils.GetIconState(mymission.questtype);
		
		print(tostring(QuestManager.IsTrackedQuest(quest.questData.id)))
		if  QuestManager.IsTrackedQuest(quest.questData.id)  then
			this.tracked = true;
			this:PlayDistanceMarkerAnimation(this.distanceAnim_toTracked, true);
			this:PlayToggleIconAnimation(true, true);
			
			else
			if QuestManager.IsTrackedQuest(quest.questData.id) == false and this.tracked then
				this.tracked = false;
				local marker = false
				if this.hovered then marker = this.distanceAnim_toHover else marker =  this.distanceAnim_toDefault end
				this:PlayDistanceMarkerAnimation(marker, true);
				this:PlayToggleIconAnimation(false, true);
			end
		end
		
		inkTextRef.SetText(this.title, mymission.title)
		inkTextRef.SetText(this.description, mymission.content)
		inkWidgetRef.SetVisible(this.description, true);
		inkWidgetRef.SetVisible(this.ep1Icon, false)
		inkImageRef.SetTexturePart(this.typeIcon, QuestTypeIconUtils.GetIcon(mymission.questtype))
		inkWidgetRef.SetState(this.typeIcon, questType);
		
		
		inkWidgetRef.SetState(this.questItemBg, questType);
		inkWidgetRef.SetState(this.hoverIndicator, questType);
		inkWidgetRef.SetState(this.questItemFrame, questType);
		
		inkWidgetRef.SetVisible(this.difficultIcon, mymission.recommandedlevel <= -6);
		inkWidgetRef.SetState(this.title, "Default");
		inkWidgetRef.SetState(this.description, "Default");
		
		inkTextRef.SetText(this.defaultDistance, "55m");
		inkTextRef.SetText(this.trackedDistance, "55m");
	end
	
	
end 

function questLogGameController_BuildQuestList(self)
	logme(1,"test"..GameDump(self.questList))
	
	if getUserSetting("enableCustomQuest") == true then
		Cron.NextTick(function()
			
			getMissionByTrigger()
			
			local questToOpen
			local listData = self.listData
			print("test"..#listData)
			
			
			-- local header = QuestListHeaderData.new()
			-- header.type = 99
			-- header.nameLocKey = CName("Cyberscript")
			
			
			-- local listItemData = VirutalNestedListData.new()
			-- listItemData.widgetType = 0
			-- listItemData.level = 99
			-- listItemData.collapsable = false
			-- listItemData.isHeader = true
			-- listItemData.data = header
			-- table.insert(listData, listItemData)
			
			
			for k, questDef in pairs(QuestManager.GetQuests()) do
				
				local questState = QuestManager.GetQuestState(questDef.id)
				local questEntry = QuestManager.GetQuestEntry(questDef.id)
				
				if(QuestManager.IsQuestActive(questDef.id)) then 
					print("hllo")
					-- if QuestManager.isVisited(questDef.id) then
					
					-- local itemData = makeListItemData(questDef, questEntry, questState, questDef.metadata.questType)
					-- itemData.data.playerLevel = self.playerLevel
					
					-- table.insert(listData, itemData)
					
					-- if questState.isTracked then
					-- questToOpen = questEntry
					-- end
					
					-- else
					
					local itemData = makeListItemData(questDef, questEntry, questState,99)
					itemData.playerLevel = self.playerLevel
					
					table.insert(listData, itemData)
					
					if questState.isTracked then
						questToOpen = questEntry
					end
					
					-- end
					
				end
				
				if(QuestManager.IsQuestComplete(questDef.id)) then 
					
					-- if QuestManager.isVisited(questDef.id) then
					
					-- local itemData = makeListItemData(questDef, questEntry, questState, questDef.metadata.questType)
					-- itemData.data.playerLevel = self.playerLevel
					
					-- table.insert(listData, itemData)
					
					-- if questState.isTracked then
					-- questToOpen = questEntry
					-- end
					
					-- else
					
					local itemData = makeListItemData(questDef, questEntry, questState,99)
					
					
					table.insert(listData, itemData)
					
					
					
					-- end
					
				end
			end
			
			
			local questData = QuestDataWrapper.new()
			questData.isNew = true
			
			questData.title = "Test"
			questData.description = "Test"
			questData.questStatus = gameJournalEntryState.Active
			questData.isTracked = true
			questData.isChildTracked = false
			questData.recommendedLevel = 13
			
			print("test"..#listData)
			self.virtualListController:SetData(listData)
			
			---@type QuestListVirtualNestedListController
			
			if(#listData > 0) then
				for k,v in ipairs(listData) do
					local questData = QuestDataWrapper.new()
					questData.isNew = true
					
					questData.title = "Test"
					questData.description = "Test"
					questData.questStatus = gameJournalEntryState.Active
					questData.isTracked = true
					questData.isChildTracked = false
					questData.recommendedLevel = 13
					
					
					-- self.QuestLists[0]:AddQuest(questData, false)
					-- if questToOpen then
					-- local evt = QuestlListItemClicked.new()
					-- evt.questData = questToOpen
					-- evt.skipAnimation = true
					
					-- self:QueueEvent(evt)
					
					-- listController.toggledLevels = {}
					-- for level = 0, maxNestedLevel do
					
					-- listController:ToggleLevel(level)
					
					-- end
					-- end
				end
			end
			
			
		end)
	end	
	
	
end


function questLogGameController_OnQuestListItemClicked(self,e)
	
	Cron.NextTick(function()
		local questId = e.questData.id
		
		if QuestManager.IsKnownQuest(questId) then
			QuestManager.MarkQuestAsVisited(questId)
			
			
		end
		
	end)
	
end

function questLogGameController_OnRequestChangeTrackedObjective(self,e)
	print("questLogGameController_OnRequestChangeTrackedObjective"..GameDump(self))
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
		
		for k,v in ipairs(self.listData) do
			print("currentmark"..GameDump(v))
		end
		for _, nestedData in ipairs(self.listData) do
			local itemData = nestedData
			
			if itemData:IsA('QuestListItemData') then
				itemData.isTrackedQuest = itemData.questData.id == e.quest.id
			end
		end
	end)
	
end

function QuestListItemController_UpdateDistance(self)
	
	Cron.NextTick(function()
		
		if(self.data ~= nil) then
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
		end
	end)
	
end


function QuestDetailsPanelController_Setup(self, questData)
	
	Cron.NextTick(function()
		local questId = questData.id
		
		if QuestManager.IsKnownQuest(questId) then
			
			local questDef = QuestManager.GetQuest(questId)
			
			if( cyberscript.cache["mission"][questId].data.recurrent ~= nil and cyberscript.cache["mission"][questId].data.recurrent == true) then
				
				inkTextRef.SetText(self.questTitle, "(Recurrent)"..getLang(questDef.title))
				
				else
				inkTextRef.SetText(self.questTitle, getLang(questDef.title))
				
			end
			
			if questDef.extra ~= nil then
				
				
				inkCompoundRef.RemoveAllChildren(self.codexLinksContainer);
				inkCompoundRef.RemoveAllChildren(self.mapLinksContainer);
				if questDef.extra.mappin ~= nil then
					
					local mappin = getMappinByTag(questDef.extra.mappin)
					
					if(mappin ~= nil) then
						
						local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.mapLinksContainer), "linkMappin")
						local controller =  widget:GetController()
						
						
						local jumpto = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
						
						
						
						journalQuestMapPinBase =  questDef.extra.mappin
						print("tiotisd"..GameDump(controller))
						controller:Setup(nil,nil, jumpto,true)
						
						
					end
				end
				
				
				if questDef.extra.data ~= nil then
					for i,data in ipairs(questDef.extra.data) do
						
						local entry = Game.GetJournalManager():GetEntryByString(data.value,data.type)
						if(entry ~= nil) then
							
							local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkCodex")
							local controller =  widget:GetController()
							
							controller:SetupCodexLink(entry)
							controller.journalEntry = entry
							
							
						end
						
					end
				end
				
				if questDef.extra.custom ~= nil then
					for i,data in ipairs(questDef.extra.custom) do
						
						
						
						local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkCodex")
						local controller =  widget:GetController()
						
						
						
						codexEntryTag = data.tag
						
						
						controller:SetupCodexLink(nil)
						
						
						
						
					end
				end
			end
			
			inkTextRef.SetText(self.questDescription, getLang(questDef.description))
			for _, objectiveDef in ipairs(QuestManager.GetObjectiveDefByQuest(questDef.id)) do
				local objectiveState = QuestManager.GetObjectiveState(objectiveDef.id)
				
				if not objectiveState.isComplete and objectiveState.isActive and not objectiveDef.isOptional then
					
					local objectiveWidget = self:SpawnFromLocal(inkWidgetRef.Get(self.activeObjectives), 'questObjective')
					objectiveWidget:SetHAlign(inkEHorizontalAlign.Left)
					objectiveWidget:SetVAlign(inkEVerticalAlign.Top)
					
					---@type QuestDetailsObjectiveController
					local objectiveController = objectiveWidget:GetController()
					objectiveController.objective = QuestManager.GetObjectiveEntry(objectiveDef.id)
					
					local objectiveTitle = getLang(objectiveDef.title)
					
					
					if objectiveState.isTracked then
						
						inkCompoundRef.RemoveAllChildren(self.codexLinksContainer);
						inkCompoundRef.RemoveAllChildren(self.mapLinksContainer);
						local obj = QuestManager.GetObjective(objectiveDef.id)
						
						if obj.extra ~= nil then
							
							
							
							
							
							if obj.extra.mappin ~= nil then
								
								local mappin = getMappinByTag(obj.extra.mappin)
								
								if(mappin ~= nil) then
									
									local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkMappin")
									local controller =  widget:GetController()
									
									
									local jumpto = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
									
									
									
									journalQuestMapPinBase =  obj.extra.mappin
									
									controller:Setup(nil,nil, jumpto,true)
									
									
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
				
				if not objectiveState.isComplete and objectiveState.isActive and objectiveDef.isOptional then
					
					local objectiveWidget = self:SpawnFromLocal(inkWidgetRef.Get(self.optionalObjectives), 'questObjective')
					objectiveWidget:SetHAlign(inkEHorizontalAlign.Left)
					objectiveWidget:SetVAlign(inkEVerticalAlign.Top)
					
					---@type QuestDetailsObjectiveController
					local objectiveController = objectiveWidget:GetController()
					objectiveController.objective = QuestManager.GetObjectiveEntry(objectiveDef.id)
					
					local objectiveTitle = getLang(objectiveDef.title)
					
					objectiveTitle = objectiveTitle .. ' [' .. GetLocalizedText('UI-ScriptExports-Optional0') .. ']'
					
					
					
					if objectiveState.isTracked then
						inkCompoundRef.RemoveAllChildren(self.codexLinksContainer);
						inkCompoundRef.RemoveAllChildren(self.mapLinksContainer);
						
						local obj = QuestManager.GetObjective(objectiveDef.id)
						
						if obj.extra ~= nil then
							
							
							
							
							
							if obj.extra.mappin ~= nil then
								
								local mappin = getMappinByTag(obj.extra.mappin)
								
								if(mappin ~= nil) then
									
									local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkMappin")
									local controller =  widget:GetController()
									
									
									local jumpto = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
									
									
									
									journalQuestMapPinBase =  obj.extra.mappin
									
									controller:Setup(nil,nil, jumpto,true)
									
									
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
				
				if objectiveState.isComplete then
					
					local objectiveWidget = self:SpawnFromLocal(inkWidgetRef.Get(self.activeObjectives), 'questObjective')
					objectiveWidget:SetHAlign(inkEHorizontalAlign.Left)
					objectiveWidget:SetVAlign(inkEVerticalAlign.Top)
					
					
					local objectiveController = objectiveWidget:GetController()
					objectiveController.objective = QuestManager.GetObjectiveEntry(objectiveDef.id)
					
					local objectiveTitle = getLang(objectiveDef.title)
					if objectiveDef.isOptional then
						objectiveTitle = objectiveTitle .. ' [' .. GetLocalizedText('UI-ScriptExports-Optional0') .. ']'
					end
					
					
					inkTextRef.SetText(objectiveController.objectiveName, objectiveTitle)
					objectiveController.objectiveName.widget:SetTintColor(gamecolor(0,255,145,1))
					
					inkWidgetRef.SetState(objectiveController.trackingMarker, 'Default')
					objectiveController.trackingMarker.widget:SetTintColor(gamecolor(0,255,145,1))
				end
				
				
			end
			
		end
	end)
	
	
end

function QuestDetailsPanelController_OnUpdateTrackedObjectiveEvent(self, e)
	print(myucurrentQuestData)
	if(myucurrentQuestData ~= nil) then
		
		local questId = myucurrentQuestData
		print("questId"..questId)
		if QuestManager.IsKnownQuest(questId) then
			
			local questDef = QuestManager.GetQuest(questId)
			
			if( cyberscript.cache["mission"][questId].data.recurrent ~= nil and cyberscript.cache["mission"][questId].data.recurrent == true) then
				
				inkTextRef.SetText(self.questTitle, "(Recurrent)"..getLang(questDef.title))
				
				else
				inkTextRef.SetText(self.questTitle, getLang(questDef.title))
				
			end
			inkCompoundRef.RemoveAllChildren(self.codexLinksContainer);
			inkCompoundRef.RemoveAllChildren(self.mapLinksContainer);
			
			if questDef.extra ~= nil then
				
				
				
				
				
				if questDef.extra.mappin ~= nil then
					
					local mappin = getMappinByTag(questDef.extra.mappin)
					
					if(mappin ~= nil) then
						
						local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.mapLinksContainer), "linkMappin")
						local controller =  widget:GetController()
						
						
						local jumpto = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
						
						
						
						journalQuestMapPinBase =  questDef.extra.mappin
						controller:Setup(nil,nil, jumpto,true)
						
						
					end
				end
				
				
				if questDef.extra.data ~= nil then
					for i,data in ipairs(questDef.extra.data) do
						
						local entry = Game.GetJournalManager():GetEntryByString(data.value,data.type)
						
						if(entry ~= nil) then
							
							local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkCodex")
							local controller =  widget:GetController()
							controller:Setup(entry)
							
							
						end
						
					end
				end
				
				if questDef.extra.custom ~= nil then
					for i,data in ipairs(questDef.extra.custom) do
						
						
						
						local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.codexLinksContainer), "linkCodex")
						local controller =  widget:GetController()
						
						
						
						codexEntryTag = data.tag
						
						
						controller:SetupCodexLink(nil)
						
						
						
						
					end
				end
			end
			
			inkTextRef.SetText(self.questDescription, getLang(questDef.description))
			for _, objectiveDef in ipairs(QuestManager.GetObjectiveDefByQuest(questDef.id)) do
				local objectiveState = QuestManager.GetObjectiveState(objectiveDef.id)
				
				if not objectiveState.isComplete and objectiveState.isActive then
					
					
					
					if objectiveState.isTracked then
						
						
						local obj = QuestManager.GetObjective(objectiveDef.id)
						inkCompoundRef.RemoveAllChildren(self.codexLinksContainer);
						inkCompoundRef.RemoveAllChildren(self.mapLinksContainer);
						if obj.extra ~= nil then
							
							
							
							
							
							if obj.extra.mappin ~= nil then
								
								local mappin = getMappinByTag(obj.extra.mappin)
								
								if(mappin ~= nil) then
									
									local widget = self:SpawnFromLocal(inkWidgetRef.Get(self.mapLinksContainer), "linkMappin")
									local controller =  widget:GetController()
									
									
									local jumpto = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
									
									
									
									journalQuestMapPinBase =  obj.extra.mappin
									
									controller:Setup(nil,nil, jumpto,true)
									
									
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
					
					
				end
				
				
				
				
			end
			
			local objtracked = QuestManager.GetFirstObjective(questId)
			print(dump(objtracked))
			QuestManager.TrackObjective(objtracked.id)
			
			
			
			else
			local state = self.journalManager:GetEntryState(e.quest)
			
			if state == gameJournalEntryState.Succeeded or state == gameJournalEntryState.Failed then
				return
			end
			
			self.journalManager:TrackEntry(e.objective)
			
		end
		
		
		
		
		
	end	
	
end


function QuestListHeaderController_Setup(self, titleLocKey,questType,wrappedMethod)
	
	if questType == 99 then
		
		self.questType = questType;
		inkTextRef.SetText(self.title, getLang("Cyberscript"))
		self.hovered = false
		self:UpdateState()
		else
		wrappedMethod(titleLocKey,questType)
	end
end


--QuestJournalUI






--QuestTrackerUI
function QuestTrackerGameController_OnTrackedEntryChanges(self)
	GameController["QuestTrackerGameController"] = self
	QuestManager.UntrackObjective()
	
	currentObjectiveId = 0
end

function QuestTrackerGameController_UpdateTrackerData(self, wrappedmethod)
	GameController["QuestTrackerGameController"] = self
	if not QuestManager.IsTrackingObjective() then
		wrappedmethod()
		
		
		
	end
end

function QuestTrackerGameController_OnMenuUpdate(self, value)
	GameController["QuestTrackerGameController"] = self
	print("trrackme")
	TrackObjective()
end

--QuestTrackerUI


---part1
function ComputerMainLayoutWidgetController_OnScreenSaverSpawned(thos,widget,userData)
	if(observerthread  == true or moddisabled == true)    then return end
	local obj = widget:GetWidgetByIndex(2):GetWidgetByIndex(3):GetWidgetByIndex(1)
	logme(10,GameDump(obj))
	if(NetServiceOn == true and currentHouse ~= nil) then
		
		obj:SetText(myTag)
		obj:SetFontSize(45)
		--obj:SetMargin(inkMargin.new({top=0,left=10}))
	end
	
end
function ComputerMainLayoutWidgetController_OnMailsMenuSpawned(this,widget,userData)
	if(observerthread  == true or moddisabled == true)    then return end
	-- logme(10,GameDump(this.mailsMenu))
	-- ----print("mark1")
	-- this.mailsMenu:SetVisible(false)
	
end
function BaseMappinBaseController_UpdateRootState(this)
	if(observerthread  == true or moddisabled == true)    then return end
	local wordpos = this:GetMappin():GetWorldPosition()
	for k,v in pairs(mappinManager) do 
		local mappin = v
		if(mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
			
			if(mappin.range ~= 0 and mappin.range ~= nil) then 
				if( check3DPos(curPos, mappin.position.x,  mappin.position.y,  mappin.position.z, mappin.range) ) then
					this:SetRootVisible(true)
					else
					this:SetRootVisible(false)
				end
				
			end
			v.widget = this.iconWidget
			v.controller = this
			v.mappinEntity = this:GetMappin()
			v.distanceToPlayer = getDistance(Game.GetPlayer():GetWorldPosition(), v.position)
			
			if(v.tracked ~= nil) then
				if #this.taggedWidgets > 0 then
					
					
					if this:GetProfile():ShowTrackedIcon() then
						
						
						for i=0, #this.taggedWidgets do
							inkWidgetRef.SetVisible(this.taggedWidgets[i], v.tracked)
							
							
						end
						
						local animPlayer = this:GetAnimPlayer_Tracked()
						animPlayer:PlayOrPause(v.tracked)
					end
					
					
				end
			end
			
			if(mappin.style ~= nil) then
				
				if(mappin.style.icon ~= nil) then
					
					local record = TweakDBInterface.GetUIIconRecord("ChoiceIcons."..mappin.style.icon)
					v.widget:SetTexturePart(record:AtlasPartName())
					v.widget:SetAtlasResource(record:AtlasResourcePath())
					
					
				end
				
				if(mappin.style.color ~= nil) then
					
					this.iconWidget:SetTintColor(gamecolorStyle(mappin.style.color))
				end
			end
			
			break
		end
	end
end
function PerksMainGameController_SetupLayout(this,screenType)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(0):GetWidgetByIndex(0):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(0):GetWidgetByIndex(1):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(1):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(2):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(3):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(4):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(5):SetVisible(false)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(6):GetWidgetByIndex(2):SetVisible(false)
	
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(7):SetVisible(false)
	
	
	
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(0):AddChild(this.attributeSelectorsContainer.widget:GetWidgetByIndex(0):GetWidgetByIndex(1).widget)
	-- this.attributeSelectorsContainer.widget:GetWidgetByIndex(0):GetWidgetByIndex(1):SetRotation(90)
	
	
	local currentperkscreen = this.perksScreen.widget
	if(currentperkscreen.visible == true) then
		
		if NameToString(currentperkscreen.name) == "SkillPerksScreen8" then
			--printChild(this.perksScreen.widget)
			
			----print("yes")
			
		end
	end
	-- inkWidgetRef.SetVisible(this.attributeSelectorsContainer, false)
	-- inkWidgetRef.SetVisible(this.perksScreen, false)
	-- inkWidgetRef.SetVisible(this.johnnyConnectorRef, true)
	
end
function PerkScreenController_Setup(this,displayData, dataManager , startingIndex,wrappedMethod)
	
	local proficiencies = displayData.proficiencies
	
	local myproficiency = ProficiencyDisplayData.new()
	
	
	myproficiency.attributeId  = TweakDBID.new("Test")
	myproficiency.proficiency  = 10
	myproficiency.index   = #displayData.proficiencies+1
	myproficiency.areas   = {}
	
	local myarea = AreaDisplayData.new()
	myarea.attributeId  = TweakDBID.new("Test")
	myarea.perks = {}
	myarea.locked = false
	myarea.proficency  = 102	
	myarea.area   = 117
	
	local myperk = PerkDisplayData.new()
	myperk.attributeId= TweakDBID.new("Test")
	
	
	myperk.name =CName.new("myperk")
	myperk.localizedName  = "donk special move"
	myperk.localizedDescription   = "donk special move"
	myperk.iconID   = TweakDBID.new("Test")
	myperk.level   = 1
	myperk.maxLevel   = 13
	myperk.locked 	  = false
	myperk.proficiency   = 0
	
	myperk.area   = 102
	myperk.type =174
	table.insert(myarea.perks,myperk)
	table.insert(myproficiency.areas ,myarea)
	
	
	myproficiency.passiveBonusesData   = displayData.proficiencies[1].passiveBonusesData 
	myproficiency.traitData   = {}
	myproficiency.localizedName   = "donk no bonk"
	myproficiency.localizedDescription   = "See that comin ? ;)"
	myproficiency.level   = 13
	myproficiency.maxLevel    = 99
	myproficiency.expPoints     = 13	
	myproficiency.maxExpPoints      = 100	
	myproficiency.unlockedLevel      = 50	
	table.insert(proficiencies,myproficiency)
	
	displayData.proficiencies = proficiencies
	wrappedMethod(displayData, dataManager , startingIndex)
	for i,pro in ipairs(displayData.proficiencies) do
		
		------print(GameDump(pro))
		
	end
	-- local attributeData
    -- this.dataManager = dataManager
    -- this.displayData = displayData
	
	-- for i=0,#this.widgetMap do
	
	-- this.widgetMap[i]:SetData(nil,nil)
	
	-- end
	
    -- this:RegisterProficiencyButtons(displayData, startingIndex)
    -- attributeData = dataManager:GetAttribute(displayData.m_attributeId)
    -- inkTextRef.SetText(this.attributeNameText, attributeData.label)
	
	
    -- inkTextRef.SetText(this.attributeLevelText, IntToString(attributeData.value))
    
	-- inkImageRef.SetTexturePart(this.attributeIcon, this:GetIconAtlasPart(attributeData.id))
	
    -- this:RebuildPerks(startingIndex)
    -- this:PlayLibraryAnimation("start_perk_screen")
end
function PerkDisplayController_Setup(this,displayData, dataManager , startingIndex)
	
	------print(GameDump(displayData))
	
end
function ComputerInkGameController_ShowMails(this)
	if(observerthread  == true or moddisabled == true)    then return end
	-- ----print("mark3")
end
function ComputerMenuWidgetController_InitializeFiles(this,gameController,widgetsData)
	if(observerthread  == true or moddisabled == true)    then return end
	-- for i,v in ipairs(widgetsData) do
	
	-- logme(10,GameDump(v))
	
	-- end
	
end
function ComputerDocumentWidgetController_Initialize(this,gameController,widgetsData)
	if(observerthread  == true or moddisabled == true)    then return end
	-- ----print("mark4")
	
	-- this.titleWidget:SetText("Donk is bonl")
	
end
function ComputerMenuWidgetController_InitializeFilesThumbnails(this,gameController,widgetsData)
	if(observerthread  == true or moddisabled == true)    then return end
	-- this.thumbnailsListWidget:SetVisible(true)
	-- local mymail = SDocumentThumbnailWidgetPackage.new()
	-- mymail.displayName = "Donk no bonk"
	-- mymail.libraryID="mailThumbnail"
	
	-- mymail.widgetName = "cyberscript_01"
	-- mymail.placement = 0
	-- mymail.orientation= 0
	-- mymail.isWidgetInactive=false
	-- mymail.widgetState = 0
	-- mymail.iconID=nil
	-- mymail.documentType = 1
	-- mymail.wasRead = false
	-- mymail.isOpened = false
	-- mymail.folderName = "Q101 new email"
	
	-- local docaddress =  SDocumentAdress.new()
	-- docaddress.folderID=7
	-- docaddress.documentID=0 
	-- mymail.documentAdress  = docaddress
	
	
	
	-- local questinfo = gamedeviceQuestInfo.new()
	-- questinfo.isHighlighted = true
	-- questinfo.factName  = "donknobonk"
	-- mymail.questInfo = questinfo
	
	
	
	
	
	
	
    -- local screenDef = gameController:GetScreenDefinition()
    -- local spawnData = AsyncSpawnData.new()
    -- spawnData:Initialize(this, "OnDocumentThumbnailWidgetSpawned", widgetData, gameController)
    -- this:AddFileThumbnailWidgetData(widgetData, gameController)
	
	
	
	
end
function FullscreenVendorGameController_PopulateVendorInventory(thos)
	-- ----print("selll02")
	if(observerthread  == true or moddisabled == true)    then return end
end

function HUDProgressBarController_OnInitialize(thos)
	
	if(observerthread == true or moddisabled  == true)     then return end
	GameController["HUDProgressBarController"] = thos
end

function AnimationControllerComponent_ApplyFeature(thos,obj,inputName,value,delay)
	----print("ApplyFeature "..NameToString(inputName))
	----print("ApplyFeature "..GameDump(value))
	if(observerthread  == true or moddisabled == true)    then return end
end

function BackdoorInkGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["BackdoorInkGameController"] = thos
	
	--thos:GetRootWidget():SetVisible(true) E3 smart windows issue
	
end


function hudCorpoController_OnInitialize(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	
	GameController["hudCorpoController"] = thos
	hudCorpoControllerReady = true
	
	
	
end



function PanzerHUDGameController_OnInitialize(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	GameController["PanzerHUDGameController"] = thos
	PanzerHUDGameControllerReady = true
	logme(10,"PanzerHUDGameController")
	displayHUD["hud_panzer"] = GameController["PanzerHUDGameController"] :GetRootWidget()
	
end


function PanzerHUDGameController_OnUninitialize(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerOnUninitialize")
	
	
end

function PanzerHUDGameController_OnVehicleStateChanged(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerOnVehicleStateChanged")
	
	
end


function PanzerHUDGameController_OnPlayerVehicleStateChange(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerOnPlayerVehicleStateChange")
	
end

function PanzerHUDGameController_EvaluateUIState(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerEvaluateUIState")
	
end

function PanzerHUDGameController_OnForwardVehicleQuestEnableUIEvent(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerOnForwardVehicleQuestEnableUIEvent")
	
end

function PanzerHUDGameController_OnPlayerAttach(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerOnPlayerAttach")
	
end

function PanzerHUDGameController_OnPlayerDetach(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"PanzerHUDGameControllerOnPlayerDetach")
	
end

function vehicleUIGameController_OnVehiclePanzerBootupUIQuestEvent(thos)
	if(observerthread == true or moddisabled  == true)     then return end
	logme(10,"vehicleUIGameControllerOnVehiclePanzerBootupUIQuestEvent")
	
end



function ChatBoxGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["ChatBoxGameController"]  = thos
	inkWidgetRef.SetVisible(thos.chatBox, true)
	----print("YYYYYYYYYYYYYYYESSS")
end
function HudPhoneAvatarController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["HudPhoneAvatarController"]  = thos
end
function HudPhoneGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["HudPhoneGameController"]  = thos
end



function FlightController_Activate(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	JackFlight = true
	
end

function FlightController_Deactivate(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	JackFlight = false
	
end

function PlayerPuppet_ReactToHitProcess(thos,hitEvent)
	if(observerthread  == true or moddisabled == true)    then return end
	
	--targetGodMode = GetImmortality(hitEvent.target)
	if  hitEvent.target:IsPlayer() == true then
		--if (targetGodMode == gameGodModeType.Invulnerable or hitEvent.attackData:HasFlag(hitFlag.WasBlocked) or hitEvent.attackData:HasFlag(hitFlag.WasDeflected) or hitEvent.attackData:HasFlag(hitFlag.DealNoDamage) or hitEvent.attackData:HasFlag(hitFlag.DisableNPCHitReaction)) then
		if (hitEvent.attackData:HasFlag(hitFlag.WasBlocked) or hitEvent.attackData:HasFlag(hitFlag.WasDeflected) or hitEvent.attackData:HasFlag(hitFlag.DealNoDamage) or hitEvent.attackData:HasFlag(hitFlag.DisableNPCHitReaction)) then
			PlayerisHitten = false
			else
			PlayerisHitten = true
			
		end
	end
	
	
end



function PlayerPuppet_SetEntityNoticedPlayerBBValue(thos,b)
	if(observerthread  == true or moddisabled == true)    then return end
	playerNoticed = b
	--logme(10,"playerNoticed "..tostring(b))
end

function PlayerPuppet_OnBeingTarget(thos,evt)
	if(observerthread  == true or moddisabled == true)    then return end
	
	if(evt.noLongerTarget == true) then
		
		local indextoremove = 0
		for i,v in ipairs(entityTargetPlayer) do
			
			if(evt.objectThatTargets:IsA("entEntity") and evt.objectThatTargets:GetEntityID()==v:GetEntityID()) then
				
				indextoremove = i
				break
				
			end
			
		end
		if indextoremove > 0 then
			table.remove(entityTargetPlayer,indextoremove)
		end
		
		
		else
		
		local isalreadyinsert = true
		pcall(function()
			for i,v in ipairs(entityTargetPlayer) do
				
				
				if(evt.objectThatTargets:IsA("entEntity") and evt.objectThatTargets:GetEntityID()==v:GetEntityID())then
					isalreadyinsert = false
					break
				end
				
				
			end
		end)
		if isalreadyinsert == true then
			table.insert(entityTargetPlayer,evt.objectThatTargets)
		end
	end
	
	
	playerTargeted = #entityTargetPlayer>0
	--logme(10,"playerTargeted "..tostring(playerTargeted))
end 


function MinimapContainerController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["MinimapContainerController"]  = thos
	
	
end

function healthbarWidgetGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["healthbarWidgetGameController"]  = thos
	
	
end




function StaminabarWidgetGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["StaminabarWidgetGameController"]  = thos
	
	
end

function HotkeysWidgetController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["HotkeysWidgetController"]  = thos
	
	
end

function NPCPuppet_CompileScannerChunks(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	local vehicleSummonDef = Game.GetAllBlackboardDefs().UI_ScannerModules
	local scannerBlackboard = Game.GetBlackboardSystem():Get(vehicleSummonDef)
	
	
	local characterRecord  = TweakDBInterface.GetCharacterRecord(thos:GetRecordID())
	local scannerPreset = characterRecord:ScannerModulePreset()
	
	
	
	
	if (characterRecord ~= nil and scannerBlackboard ~= nil and scannerPreset ~= nil )then
		
		
		
		---get information
		local thosEntity = thos:GetRecordID()
		
		local ps = thos:GetPS()
		currentScannerItem = {}
		
		
		
		
		
		
		
		if ps:GetForcedScannerPreset() ~= nil then
			scannerPreset = TweakDBInterface.GetScannerModuleVisibilityPresetRecord(ps:GetForcedScannerPreset())
			else
			scannerPreset = characterRecord.ScannerModulePreset()
		end
		
		
		currentScannerItem.networkstate = tonumber(ScannerNetworkState.NOT_CONNECTED)
		
		local aps = ps:GetAccessPoint()
		
		if(aps ~= nil)then
			if aps:IsBreached() then
				
				currentScannerItem.networkstate = tonumber(ScannerNetworkState.BREACHED)
				else
				
				currentScannerItem.networkstate = tonumber(ScannerNetworkState.NOT_BREACHED)
			end
			
		end
		
		
		local archetype = characterRecord:ArchetypeData()
		local archetypename = nil
		if(archetype ~= nil) then
			
			archetypename = archetype:Type():LocalizedName()
			
		end
		
		
		
		
		
		
		
		if(archetypeName ~= nil and archetypeName ~= "") then
			
			--currentScannerItem.archetypename = archetypeName
			
		end
		
		
		
		-- local items = AIActionTransactionSystem.CalculateEquipmentItems(thos, thos:GetRecord():PrimaryEquipment(), -1)
		
		-- local primaryweapons = nil
		
		-- if(#items>0) then
		-- primaryweapons = items[1]:Item():DisplayName()
		-- end
		
		
		
		
		currentScannerItem.bounty = nil
		
		if thos.bounty ~= nil then
			
			local bountyChunk =ScannerBountySystem.new()
			local bountyUI = BountyUI.new() 
			local bounty =Bounty.new()
			local transgressions = {}
			
			
			if #thos.bounty.transgressions >0 then
				
				for i,trans in ipairs(thos.bounty.transgressions) do
					local transText = getTransgressionFromTweakId(trans)
					
					if(transText ~= nil) then
						table.insert(transgressions,transText)
						
					end
					
					
				end
				
				
				bounty = BountyManager.GenerateBounty(thos)
				else 
				bounty = thos.bounty
			end
			
			
			
			
			
			currentScannerItem.entityname = thos:ToString()
			currentScannerItem.entityname = thos:ToString()
			currentScannerItem.secondaryname = Game.NameToString(thos:GetCurrentAppearanceName())
			currentScannerItem.primaryname = LocKeyToString(thos:GetDisplayName())
			currentScannerItem.attitude = tonumber(thos:GetAttitudeTowards(Game.GetPlayer()))
			currentScannerItem.data = tostring(NameToString(characterRecord:Affiliation():EnumName()))
			currentScannerItem.rarity = tonumber(thos:GetNPCRarity())
			currentScannerItem.text = ""
			currentScannerItem.bounty = {}
			currentScannerItem.bounty.danger = bountyUI.level
			currentScannerItem.bounty.reward = bountyUI.moneyReward
			currentScannerItem.bounty.streetreward = bountyUI.streetCredReward
			currentScannerItem.bounty.transgressions = transgressions
			currentScannerItem.bounty.customtransgressions = {}
			currentScannerItem.bounty.issuedby = getAffiliationsFromTweakId(bounty.bountySetter)
			
			
			
		end
		
		
		
		
		
		
		
		
		
		-- --custom scanner
		local entid = thos:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) then
			
			
			if (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
				currentScannerItem = getScannerdataFromEntityOrGroupOfEntity(entity)
				currentScannerItem.entityname = thos:ToString()
				
			end
			
			
			
			
			
		end
		
		else
		
		
		currentScannerItem = nil
		
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
end

function VehiclesManagerListItemController_OnDataChanged(thos,value)
	if(observerthread  == true or moddisabled == true)    then return end
	
	if(tostring(thos.vehicleData.displayName) == "None")then
		inkTextRef.SetText(thos.label, tostring(NameToString(thos.vehicleData.data.name)));
	end
	
end

function VehiclesManagerListItemController_OnSelected(thos,itemController,discreteNav)
	if(observerthread  == true or moddisabled == true)    then return end
	
	if(tostring(thos.vehicleData.displayName) == "None")then
		inkTextRef.SetText(thos.label, tostring(NameToString(thos.vehicleData.data.name)));
	end
	
end

function IncomingCallGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	
	GameController["IncomingCallGameController"]  = thos
end

function IncomingCallGameController_GetIncomingContact(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["IncomingCallGameController"]  = thos
end

function IncomingCallGameController_OnPhoneCall(thos,value)
	if(observerthread  == true or moddisabled == true)    then return end
	print("call on me")
end



function  IncomingCallGameController_HandleCall(this)
	print("IncomingCallGameController_HandleCall")
end



function IncomingCallGameController_UpdateHoloAudioCall(this)
	print("IncomingCallGameController_UpdateHoloAudioCall")
end



function IncomingCallGameController_SetPhoneFunction(this,newFunction)
	print("IncomingCallGameController_SetPhoneFunction")
	print(newFunction)
end

function TutorialPopupGameController_OnInitialize(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["TutorialPopupGameController"]  = thos
end

function TutorialPopupGameController_OnPlayerAttach(thos,playerPuppet)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["TutorialPopupGameController"]  = thos
end

function WorldMapMenuGameController_GetDistrictAnimation(thos,view ,show)
	if(observerthread  == true or moddisabled == true)    then return end
	logme(2,tostring(view))
	
end

function WorldMapMenuGameController_OnInitialize(this)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["WorldMapMenuGameController"]  = deepcopy(this,nil)
	
end

function WorldMapMenuGameController_GetDistrictAnimation(thos,view ,show)
	if(observerthread  == true or moddisabled == true)    then return end
	if(show == true or view == gameuiEWorldMapDistrictView.None) then
		
		
		currentMapDistrictView = view
		
		
	end
	
	if(view == gameuiEWorldMapDistrictView.None) then
		
		inkWidgetRef.SetVisible(thos.gangsInfoContainer, false)
		
	end
	
	thos:ShowGangsInfo(mapDistrict)
end

function TrackQuestNotificationAction_TrackFirstObjective(thos,questEntry)
	if(observerthread  == true or moddisabled == true)    then return end
	
	if(questEntry ~= nil)then
		
		local quest = getQuestByTag(questEntry.id)
		
		
		if(quest ~= nil and getScoreKey(quest.tag,"Score") <= 3) then
			
			--untrackQuest()
			
			
			
			
			
			
			
			
			if QuestManager.IsKnownQuest(quest.tag) then
				if QuestManager.IsQuestComplete(quest.tag) then
					
					return
					
				end
				
				local objective = QuestManager.GetObjective(questEntry.districtID)
				
				QuestManager.MarkQuestAsVisited(quest.tag)
				QuestManager.MarkQuestAsActive(quest.tag)
				
				if objective == nil then objective = QuestManager.GetFirstObjective(quest.tag) end
				
				if(objective ~= nil) then
					
					
					QuestManager.MarkObjectiveAsActive(objective.id)
					
					QuestManager.TrackObjective(objective.id,true)
					
					if objective.extra ~= nil then
						
						
						
						
						
						if objective.extra.mappin ~= nil then
							
							local mappin = getMappinByTag(objective.extra.mappin)
							
							
							
							
							
							
							if(mappin and mappin.controller ~= nil)then
								
								local startHub = StartHubMenuEvent.new()
								
								local userData = MapMenuUserData.new()
								userData.moveTo = Vector3.new(mappin.position.x, mappin.position.y, mappin.position.z)					
								startHub:SetStartMenu("world_map",nil,userData)
								Game.GetUISystem():QueueEvent(startHub)
								
								Cron.After(0.1, function()
									
									GameController["WorldMapMenuGameController"]:TrackMappin(mappin.controller)
									local closeHub = ForceCloseHubMenuEvent.new()
									Game.GetUISystem():QueueEvent(closeHub)							
									
								end)
							end
							
							
							
							
						end
						
					end
					
					
					
					
				end
			end
		end
	end
	
end



function WorldMapMenuGameController_OnUpdateHoveredDistricts(thos,district,subdistrict)
	if(observerthread  == true or moddisabled == true)    then return end
	if(subdistrict ~= gamedataDistrict.Invalid) then
		mapSubDistrict = subdistrict
		else
		mapSubDistrict = nil
	end
	
	mapDistrict = district
	
	
	if(currentMapDistrictView == gameuiEWorldMapDistrictView.Districts or currentMapDistrictView == nil or subdistrict == gamedataDistrict.Invalid) then
		
		
		inkWidgetRef.SetVisible(thos.subdistrictNameText, false)
		
		else
		
		inkWidgetRef.SetVisible(thos.subdistrictNameText, true)
		
	end
	
end

function CodexGameController_PopulateData(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	if(thos.f_sortOrder ~= nil or thos.sortOrder ~= nil) then
		
		logme(10,"flib sort mod is enabled, custom codex is disabled")
		else
		
		
		local counter = 0
		local groupData
		local groupVirtualListData
		local i
		local items
		local level
		local success = false
		local newEntries
		local tagsFilter = {}
		local toti = {}
		local data = CodexUtils.GetCodexDataArray(thos.journalManager,thos.activeData)
		
		
		local totalcount = 0
		
		
		local datatemp = CodexUtils.GetCodexDataArray(thos.journalManager,thos.activeData)
		table.insert(tagsFilter, CName("HideInBackpackUI"))
		
		counter = 0
		level = #data+1
		
		i = 1
		
		
		local textAffinity = "Affinity"
		
		for k,v in pairs(cyberscript.entitieshash) do
			
			local score = getScoreKey("Affinity",v.entity_name) 
			if score ~= nil and score > 1 then
				textAffinity = textAffinity.."\n "..v.entity_name.." : "..score
			end
			
			
		end
		
		
		local test = data
		local shardData =  CodexEntryData.new()
		
		shardData.description = textAffinity
		shardData.title = "CS Affinity : NPC"
		shardData.activeDataSync = thos.activeData
		shardData.counter = counter
		shardData.category =4
		shardData.imageType = 0
		shardData.isNew = true
		shardData.hash = 8888888+math.random(1,9999999)
		shardData.activeDataSync = thos.activeData
		table.insert(shardData.newEntries, shardData.hash)
		
		local shardVirtualListData = VirutalNestedListData.new()
		shardVirtualListData.level = -1
		shardVirtualListData.widgetType = 0
		shardVirtualListData.isHeader = false
		shardVirtualListData.data = shardData
		table.insert(data, shardVirtualListData)
		totalcount = totalcount +1
		
		
		textAffinity = "Gang Affinity"
		for k,v in pairs(cyberscript.cache["faction"]) do
			local score =getScoreKey("Affinity",k)
			if score ~= nil then
				textAffinity = textAffinity.."\n "..cyberscript.cache["faction"][k].data.name.." : "..score
			end
		end
		
		test = data
		shardData =  CodexEntryData.new()
		
		shardData.description = textAffinity
		shardData.title = "CS Affinity : Gang"
		shardData.activeDataSync = thos.activeData
		shardData.counter = counter
		shardData.category =4
		shardData.imageType = 0
		shardData.isNew = true
		shardData.hash = 8888888+math.random(1,9999999)
		shardData.activeDataSync = thos.activeData
		table.insert(shardData.newEntries, shardData.hash)
		
		local shardVirtualListData = VirutalNestedListData.new()
		shardVirtualListData.level = -1
		shardVirtualListData.widgetType = 0
		shardVirtualListData.isHeader = false
		shardVirtualListData.data = shardData
		table.insert(data, shardVirtualListData)
		totalcount = totalcount +1
		
		
		for k,v in pairs(cyberscript.cache["help"]) do
			local codex = v.data
			local description = ""
			for i,section in ipairs(codex.section) do
				if(section.message ~= nil) then
					description = description..section.message.."\n\n\n"
					else
					description = description..section.."\n\n\n"
				end
			end
			
			local shardData =  CodexEntryData.new()
			shardData.title = "CS Wiki : "..codex.title
			shardData.description = description
			shardData.activeDataSync = thos.activeData
			shardData.counter = counter
			shardData.category =4
			shardData.imageType = 0
			shardData.isNew = true
			
			shardData.hash = 13081991+math.random(1,9999999)
			shardData.activeDataSync = thos.activeData
			
			table.insert(shardData.newEntries, shardData.hash)
			
			local shardVirtualListData = VirutalNestedListData.new()
			shardVirtualListData.level = -1
			shardVirtualListData.widgetType = 0
			shardVirtualListData.isHeader = false
			shardVirtualListData.data = shardData
			table.insert(data, shardVirtualListData)
			totalcount = totalcount +1
			
		end
		
		
		for k,v in pairs(cyberscript.cache["codex"]) do
			local codex = v.data
			if((getScoreKey(codex.tag,"Score") == nil and codex.locked == false) or getScoreKey(codex.tag,"Score") == 0) then
				
				local shardData =  CodexEntryData.new()
				shardData.title = "CS : "..codex.title
				shardData.description = codex.description
				shardData.activeDataSync = thos.activeData
				shardData.counter = counter
				shardData.category =4
				shardData.imageType = 0
				shardData.isNew = false
				
				shardData.hash = 13081992+math.random(1,9999999)
				shardData.activeDataSync = thos.activeData
				
				table.insert(shardData.newEntries, shardData.hash)
				
				local shardVirtualListData = VirutalNestedListData.new()
				shardVirtualListData.level = -1
				shardVirtualListData.widgetType = 0
				shardVirtualListData.isHeader = false
				shardVirtualListData.data = shardData
				table.insert(data, shardVirtualListData)
				totalcount = totalcount +1
			end
		end
		
		
		groupData = CodexEntryData.new()
		groupData.category =4
		groupData.imageType = 0
		groupData.title = "CyberScript"
		groupData.activeDataSync = thos.activeData
		groupData.counter = totalcount
		groupData.isNew =  false
		groupData.newEntries = {}
		
		groupVirtualListData = VirutalNestedListData.new()
		groupVirtualListData.level = -1
		groupVirtualListData.widgetType = 1
		groupVirtualListData.isHeader = true
		groupVirtualListData.data = groupData
		groupVirtualListData.forceToTopWithinLevel  = true
		table.insert(data, groupVirtualListData)
		
		
		if #data <= 0 then
			thos:ShowNodataWarning()
			else 
			thos:HideNodataWarning()
			thos.listController:SetData(data)
		end
	end
	
end

function ShardsVirtualNestedListController_SetData(this,data, keepToggledLevels, sortOnce)
	-- print("yo"..#data)
	-- for k,v in ipairs(data) do
	
	-- spdlog.error(GameDump(v.data))
	
	-- end
	
end

function ShardsMenuGameController_PopulateData(thos,data, keepToggledLevels, sortOnce)
	
	if(observerthread  == true or moddisabled == true)    then return end
	
	
	local count = 0
	
	local test = deepcopy(data,nil)
	
	
	for k,v in pairs(cyberscript.cache["shard"]) do
		
		local shard = v.data
		checkContext(shard)
		
		
		if((getScoreKey(shard.tag,"Score") == nil and shard.locked == false) or getScoreKey(shard.tag,"Score") == 0) then
			count = count + 1
			
			local shardData =  ShardEntryData.new()
			shardData.title = shard.title
			shardData.description = shard.description
			
			
			shardData.isNew = shard.new
			shardData.hash = (math.random(1,9999999)+1308202029)
			shardData.isCrypted = shard.crypted
			
			shardData.counter =  data[1].data.counter
			shardData.timeStamp  =  data[1].data.timeStamp 
			shardData.newEntries   = {}
			shardData.imageId = data[1].data.imageId
			shardData.activeDataSync = data[1].data.activeDataSync
			shardData.itemID = data[1].data.itemID
			table.insert(shardData.newEntries, shardData.hash)
			
			
			
			local shardVirtualListData = VirutalNestedListData.new()
			shardVirtualListData.level = 999999
			shardVirtualListData.collapsable = false
			shardVirtualListData.forceToTopWithinLevel = false
			shardVirtualListData.widgetType = 0
			shardVirtualListData.isHeader = false
			shardVirtualListData.data = shardData
			table.insert(test, shardVirtualListData)
			
		end
	end
	
	if(count > 0) then
		
		
		local groupData = ShardEntryData.new()
		groupData.title = "CyberScript"
		groupData.isNew = false
		groupData.hash = 1308202299
		groupData.isCrypted = false
		groupData.newEntries   = {}
		groupData.counter =  1
		
		
		groupData.timeStamp  =  data[1].data.timeStamp 
		
		groupData.imageId = data[15].data.imageId
		groupData.activeDataSync = data[15].data.activeDataSync
		groupData.itemID = data[15].data.itemID
		
		local groupVirtualListData = VirutalNestedListData.new()		
		
		groupVirtualListData.collapsable = false
		groupVirtualListData.isHeader = true
		groupVirtualListData.level = 999999
		groupVirtualListData.forceToTopWithinLevel = false
		groupVirtualListData.widgetType = 1
		groupVirtualListData.data = groupData
		table.insert(test, groupVirtualListData)
		data = test
		
		local castedData = test
		
		if not keepToggledLevels then
			thos.toggledLevels = {}
		end
		
		thos.dataSource:Reset(castedData)
		--thos.dataView:SetToggledLevels(thos.toggledLevels, thos.defaultCollapsed) this line break missingperson ?!
		thos:EnableSorting()
		
		if sortOnce then
			thos:DisableSorting()
		end
		
		
	end
	
	
	
	
	
	
	
end

function WorldMapMenuGameController_OnSelectedDistrictChanged(thos,oldDistrict,newDistrict)
	
	if(observerthread  == true or moddisabled == true)    then return end
	
	
	if(currentMapDistrictView == gameuiEWorldMapDistrictView.Districts or currentMapDistrictView == nil or newDistrict == gamedataDistrict.Invalid) then
		
		
		inkWidgetRef.SetVisible(thos.subdistrictNameText, false)
		
		else
		
		inkWidgetRef.SetVisible(thos.subdistrictNameText, true)
		
	end
	
	if(currentMapDistrictView == gameuiEWorldMapDistrictView.Districts or currentMapDistrictView == nil ) then
		
		
		mapSubDistrict = nil
		
		else
		
		mapSubDistrict = newDistrict
		thos:ShowGangsInfo(mapDistrict)
		
	end
	
	
end

function WorldMapMenuGameController_OnZoomLevelChanged(thos,oldLevel,newLevel)
	if(observerthread  == true or moddisabled == true)    then return end
	
	local zoomlevel = thos:GetCurrentZoom()
	
	
	if( zoomlevel < 7000) then
		
		inkWidgetRef.SetVisible(thos.gangsInfoContainer, false)
	end
	
end

function WorldMapMenuGameController_OnSetUserData(thos,userData)
	if(observerthread  == true or moddisabled == true)    then return end
	
	setNewFixersPoint()
	setCustomLocationPoint() 
	
end
function SettingsMainGameController_RequestClose (_, _, target) -- Check if activated button is the custom mods button
	if(observerthread  == true or moddisabled == true)    then return end
	
	local sessionFile = io.open("user/settings/cyberscript.json", 'w')
	sessionFile:write(JSON:encode_pretty(arrayUserSetting))
	sessionFile:close()
	
	cyberscript.language = Game.GetSettingsSystem():GetVar("/language", "OnScreen"):GetValue().value
	
	if(AutoRefreshDatapack == true) then
		LoadDataPackCache()
	end
end

function PlayerPuppet_OnGameAttached(thos)
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["PlayerPuppet"]  = thos
	startListeners(thos)
end

function JournalNotificationQueue_OnMenuUpdate(self)
	----logme(2,"obs2")
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["JournalNotificationQueue"]  = self
end

function JournalNotificationQueue_OnInitialize(self)
	----logme(2,"obs2")
	if(observerthread  == true or moddisabled == true)    then return end
	GameController["JournalNotificationQueue"]  = self
end

---part2

function BaseWorldMapMappinController_SelectMappin(self)
	
	if(observerthread == true or moddisabled  == true)   then return end
	
	GameController["BaseWorldMapMappinController"]  = self
	if(self.mappin ~= nil ) then
		
		if lastId ~= nil then Game.GetMappinSystem():SetMappinActive(lastId,true) end
		SelectedMappinMetro = nil
		SelectedScriptMappin = nil
		SelectedMappinHouse = nil
		ActivecustomMappin = nil
		local mappinType = self.mappin:GetVariant()
		local wordpos = self.mappin:GetWorldPosition()
		
		
		
		
		local obj = {}
		obj.id = 0
		obj.tag = "selected_mappin"
		obj.position = self.mappin:GetWorldPosition()
		obj.variant = tostring(mappinType)
		obj.wall =  true
		obj.range = 0
		obj.active =  true
		obj.title = ""
		obj.desc = ""
		obj.style = {}
		obj.style.color = nil
		obj.style.icon = nil
		
		
		print(dump( obj))
		mappinManager["selected_mappin"] = obj
		
		if mappinType == gamedataMappinVariant.CustomPositionVariant then
			
			ActivecustomMappin = self.mappin
			print(GameDump( self.mappin))
			local obj = {}
			obj.id = 0
			obj.tag = "selected_user_mappin"
			obj.position = self.mappin:GetWorldPosition()
			obj.variant = tostring(mappinType)
			obj.wall =  true
			obj.range = 0
			obj.active =  true
			obj.title = ""
			obj.desc = ""
			obj.style = {}
			obj.style.color = nil
			obj.style.icon = nil
			
			
			
			mappinManager["selected_user_mappin"] = obj
			
		end
		
		
		if mappinType == gamedataMappinVariant.FastTravelVariant then
			ActiveFastTravelMappin = {}
			
			ActiveFastTravelMappin.markerRef = self.mappin:GetPointData():GetMarkerRef()
			ActiveFastTravelMappin.position = self.mappin:GetWorldPosition()
			
			local obj = {}
			obj.id = 0
			obj.tag = "selected_fasttravel_mappin"
			obj.position = self.mappin:GetWorldPosition()
			obj.variant =  "FastTravelVariant"
			obj.wall =  true
			obj.range = 0
			obj.active =  true
			obj.title = ""
			obj.desc = ""
			obj.style = {}
			obj.style.color = nil
			obj.style.icon = nil
			
			mappinManager["selected_mappin"].id = nil
			mappinManager["selected_mappin"].position = nil
			
			mappinManager["selected_fasttravel_mappin"] = obj
			
		end
		if(
			mappinType == gamedataMappinVariant.ApartmentVariant or
			mappinType == gamedataMappinVariant.Zzz05_ApartmentToPurchaseVariant or
			mappinType == gamedataMappinVariant.ServicePointFoodVariant or
			mappinType == gamedataMappinVariant.ServicePointBarVariant or
		mappinType == gamedataMappinVariant.ServicePointJunkVariant) then
		local haveFounded = false
		-- local test = {}
		
		-- table.insert(test,cyberscript.cache["place"]["playerhouse01"])
		for _,v in pairs(cyberscript.cache["place"]) do 
			if(math.floor(v.data.x) == math.floor(wordpos.x) and math.floor(v.data.y) == math.floor(wordpos.y) and math.floor(v.data.z) == math.floor(wordpos.z)) then
				SelectedMappinHouse = v.data
				haveFounded = true
			end
		end
		else
		if(mappinType == gamedataMappinVariant.Zzz01_CarForPurchaseVariant) then
			--logme(2,"Metro ?")
			
			local haveFounded = false
			for k,v in pairs(cyberscript.cache["node"]) do 
				local mappin = v.data
				if(mappin.sort == "metro") then
					if(math.floor(mappin.GameplayX) == math.floor(wordpos.x) and math.floor(mappin.GameplayY) == math.floor(wordpos.y) and math.floor(mappin.GameplayZ) == math.floor(wordpos.z)) then
						SelectedMappinMetro = mappin
						haveFounded = true
						--logme(2,"Mine")
						break
					end
				end
			end
			else
			local haveFounded = false
			
			for k,v in pairs(mappinManager) do 
				local mappin = v
				
				if(k ~= "selected_mappin" and k ~= "selected_fasttravel_mappin" and mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
					
					
					SelectedScriptMappin = mappin
					break
				end
			end
		end
		end
	end
end


--region Browser
function PhotoModeGridButton_ButtonStateChanged(thos)
	if(observerthread == true or moddisabled  == true)   then return end
	--print(NameToString(thos.currentImagePart))
	
end
function BrowserController_OnInitialize(self,gameController)
	
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["BrowserController"]  = self
	GameController["BrowserGameController"]  = self
end




function DeviceMappinsContainer_EvaluatePositions(this)
	
	----print("DeviceMappinsContainer_EvaluatePositions")
	
end

function SmartWindowInkGameController_InitializeMainLayout(this)
	if(observerthread == true or moddisabled  == true)  then return  end
	Cron.After(1, function()
		
		
		for k,v in pairs(cyberscript.EntityManager) do
			
			if(v.id ~= nil) then
				
				if(v.id.hash== this:GetOwner():GetEntityID().hash) then
					
					v.widget = this.rootWidget
					
					
					-- if v.interface ~= nil then
					-- v.widget :RemoveAllChildren()
					-- makeCustomInterface(v.widget,cyberscript.cache["interfaces"][v.interface].data)
					
					-- end
					
					break
				end
			end
			
		end
	end)
end

function MappinBaseController_SetRootVisible(this,mappin, mappinVariant, customData)
	
	if(observerthread == true or moddisabled  == true)  then return  end
	local mappinType = mappin:GetVariant()
	local wordpos = mappin:GetWorldPosition()
	
	for _,v in pairs(mappinManager) do 
		local mappin = v
		if(mappin.position ~= nil and math.floor(mappin.position.x) == math.floor(wordpos.x) and math.floor(mappin.position.y) == math.floor(wordpos.y) and math.floor(mappin.position.z) == math.floor(wordpos.z)) then
			v.mappinobj = mappin
			break
		end
	end
	
	return result
	
end

function WebPage_OnInitialize(self)
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["WebPage"]  = self
end


function WebPage_FillPageFromJournal(self,page)
	if(observerthread == true or moddisabled  == true)   then return end
	print("ttot"..tostring(page.address))
	----print("ttot"..tostring(BrowserCustomPlace))
	defaultPage = page
	
	
	if(page.address == "NETdir://ncity.pub") then -- custompage
		
		
		
		LinkController = inkWidgetRef.GetController(self.imageList[1])
		local root = self:GetRootWidget()
		
		
		local page = root:GetWidgetByIndex(0)
		local linkpanel = page:GetWidgetByIndex(0)
		local panel =linkpanel:GetWidgetByIndex(0)
		
		
		local network = panel:GetWidgetByIndex(0)
		local networktext = network:GetWidgetByIndex(4)
		local linkbar01 = panel:GetWidgetByIndex(1)
		local linkbar02 = panel:GetWidgetByIndex(2)
		local link01 = linkbar01:GetWidgetByIndex(0)
		
		
		
		local link02 = linkbar01:GetWidgetByIndex(1)
		local link03 = linkbar01:GetWidgetByIndex(2)
		local link04 = linkbar01:GetWidgetByIndex(3)
		local link05 = linkbar01:GetWidgetByIndex(4)
		local link06 = linkbar02:GetWidgetByIndex(0)
		local link07 = linkbar02:GetWidgetByIndex(1)
		local link08 = linkbar02:GetWidgetByIndex(2)
		local link09 = linkbar02:GetWidgetByIndex(3)
		local link10 = linkbar02:GetWidgetByIndex(4)
		
		
		
		
		if(isEmpty(cyberscript.cache["webpage"]) == false) then
			
			local linknew = inkVerticalPanelWidget.new()
			linknew:SetName(StringToName("linknew"))
			linknew:SetChildMargin(inkMargin.new({ left = 50.0, top = 30.0, right = 50.0, bottom = 30.0 }))
			
			linknew:SetFitToContent(true)
			
			
			
			
			local imageprop = {}
			imageprop.tag = "link03_img"
			imageprop.tweak = "PhotoModeStickers.dcl_04"
			imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
			imageprop.size = {}
			imageprop.size.x = 200
			imageprop.size.y = 200
			imageprop.fittocontent = false
			imageprop.scale = {}
			imageprop.scale.x = 1.3
			imageprop.scale.y = 1.3
			
			local textprop = {}
			textprop.tag = "link03_text"
			textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
			textprop.size = {}
			textprop.size.x = 100
			textprop.size.y = 32
			textprop.text = "CyberScript Network"
			textprop.fontsize = 32
			textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
			textprop.scale = {}
			textprop.scale.x = 1.0
			textprop.scale.y = 1.0
			
			local link = linknew
			local actionlist = {}
			local action = {}
			
			action.name = "refreshBrowser" 
			action.page = page
			action.address = "CyberScriptWeb"
			action.subaddress = "home"
			table.insert(actionlist,action)
			
			
			
			buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
			linknew:Reparent(linkbar02, linkbar02:GetNumChildren()+1)
		end
		
		
		
		
		if(CurrentAddress == "CyberScript") then
			
			if(BrowserCybserscript == "loading") then
				
				linkpanel:RemoveAllChildren()
				
				makeCustomInterface(linkpanel,cyberscript.cache["interfaces"]["Keystone_Load"].data)
				
				
				
				
				elseif(BrowserCybserscript == "home") then
				
				
				
				
				
				LinkController = inkWidgetRef.GetController(self.textList[1])
				--header
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("CyberScript")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--link redef
				
				
				link01:RemoveAllChildren()
				
				
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "loading"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				
				if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069") then
					
					if(CurrentServerModVersion.version ~= "unknown" and CurrentServerModVersion.version ~= "0.16000069" and checkVersionNumber(cyberscript.version,CurrentServerModVersion.version))then
						
						
						local container = inkCanvas.new()
						container:SetName(CName.new("need_update_banner"))
						container:SetFitToContent(false)
						
						container:SetSize(Vector2.new({ X = 3150, Y = 200 }))
						container:SetScale(Vector2.new({ X = 1, Y = 1 }))
						container:SetInteractive(true)
						
						container:SetAnchor(15)
						container:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						container:SetOpacity(1)
						container:SetRotation(0)
						container:SetVisible(true)
						
						
						
						
						container:Reparent(panel, 0)
						
						local rectangletitle = inkRectangleWidget.new()
						rectangletitle:SetName(CName.new("need_update_rectangle"))
						rectangletitle:SetFitToContent(false)
						rectangletitle:SetMargin(inkMargin.new({ top = 100 }))
						rectangletitle:SetSize(Vector2.new({ X = 3150, Y = 150 }))
						rectangletitle:SetScale(Vector2.new({ X = 1, Y = 1 }))
						rectangletitle:SetInteractive(true)
						rectangletitle:SetTintColor(gamecolorStyle({red=255,blue=0,green=0}))
						rectangletitle:SetAnchor(0)
						rectangletitle:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						rectangletitle:SetOpacity(1)
						rectangletitle:SetRotation(0)
						rectangletitle:SetVisible(true)
						rectangletitle:Reparent(container, -1)
						
						local texttitle = inkText.new()
						texttitle:SetName(CName.new("need_update_title"))
						texttitle:SetFitToContent(false)
						texttitle:SetMargin(inkMargin.new({ top = 75 }))
						texttitle:SetSize(Vector2.new({ X = 100, Y = 200 }))
						texttitle:SetScale(Vector2.new({ X = 1, Y = 1 }))
						texttitle:SetInteractive(true)
						texttitle:SetText(getLang("ui_keystone_main_update_available"))
						texttitle:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						texttitle:SetFontStyle('Medium')
						texttitle:SetFontSize(50)
						texttitle:SetHorizontalAlignment(1)
						texttitle:SetVerticalAlignment(1)
						texttitle:SetTintColor(gamecolorStyle({red=255,blue=255,green=255}))
						texttitle:SetAnchor(1)
						texttitle:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						texttitle:SetOpacity(1)
						texttitle:SetRotation(0)
						texttitle:SetVisible(true)
						texttitle:Reparent(container, -1)
						
						
						local textversion = inkText.new()
						textversion:SetName(CName.new("need_update_title"))
						textversion:SetFitToContent(false)
						textversion:SetMargin(inkMargin.new({ top = -100 }))
						textversion:SetSize(Vector2.new({ X = 100, Y = 200 }))
						textversion:SetScale(Vector2.new({ X = 1, Y = 1 }))
						textversion:SetInteractive(true)
						textversion:SetText("CyberScript : local version :"..cyberscript.version.." Server version :"..CurrentServerModVersion.version)
						textversion:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textversion:SetFontStyle('Medium')
						textversion:SetFontSize(30)
						textversion:SetHorizontalAlignment(1)
						textversion:SetVerticalAlignment(1)
						textversion:SetTintColor(gamecolorStyle({red=255,blue=255,green=255}))
						textversion:SetAnchor(0)
						textversion:SetAnchorPoint(Vector2.new({ X = 0, Y = 0 }))
						textversion:SetOpacity(1)
						textversion:SetRotation(0)
						textversion:SetVisible(true)
						textversion:Reparent(panel, 4)
						
						EventProxy.RegisterCallback(container, "OnRelease", function(_, evt)
							
							
							if( workerTable["keystone_update_mod"] == nil) then
								
								local actionlist = {}
								
								local action = {}
								
								
								action.name = "refreshBrowser" 
								action.page = page
								action.address = "CyberScript"
								action.subaddress = "keystone_update"
								table.insert(actionlist,action)
								
								runActionList(actionlist, "keystone_update_mod", "interact",false,"nothing",true)
							end
							
							evt:Handle()
						end)
						
						
					end
					
					
				end
				
				
				
				local imageprop = {}
				imageprop.tag = "link01_img"
				imageprop.tweak = "PhotoModeStickers.dcl_02"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link01_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Datapack"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link01
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link02:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link02_img"
				imageprop.tweak = "PhotoModeStickers.dcl_05"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link02_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "My Datapacks"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				
				local link = link02
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "mydatapack"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				link03:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link03_img"
				imageprop.tweak = "PhotoModeStickers.bnd_032"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link03_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "CorpoNetwork"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link03
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_corpo_news"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link04:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link04_img"
				imageprop.tweak = "PhotoModeStickers.dcl_014"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link04_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Stock Market"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				
				local link = link04
				local actionlist = {}
				local action = {}
				action = {}
				action.name = "refresh_market"
				table.insert(actionlist,action)
				action = {}
				action.name = "wait_for_framework"
				table.insert(actionlist,action)
				action = {}
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_stock_market"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link05:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link05_img"
				imageprop.tweak = "PhotoModeStickers.dcl_016"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link05_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Items Market"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link05
				local actionlist = {}
				local action = {}
				
				action.name = "get_itemlist"
				table.insert(actionlist,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(actionlist,action)
				
				action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "item_category"
				table.insert(actionlist,action)
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link06:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link06_img"
				imageprop.tweak = "PhotoModeStickers.dcl_012"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link06_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "My Account"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link06
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_account"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				link07:RemoveAllChildren()
				
				local imageprop = {}
				imageprop.tag = "link07_img"
				imageprop.tweak = "PhotoModeStickers.dcl_06"
				imageprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				imageprop.size = {}
				imageprop.size.x = 200
				imageprop.size.y = 200
				imageprop.fittocontent = false
				imageprop.scale = {}
				imageprop.scale.x = 1.3
				imageprop.scale.y = 1.3
				
				local textprop = {}
				textprop.tag = "link07_text"
				textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 0.0 })
				textprop.size = {}
				textprop.size.x = 100
				textprop.size.y = 32
				textprop.text = "Changelog"
				textprop.fontsize = 32
				textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
				textprop.scale = {}
				textprop.scale.x = 1.0
				textprop.scale.y = 1.0
				
				local link = link07
				local actionlist = {}
				local action = {}
				
				action.name = "refreshBrowser" 
				action.page = page
				action.address = "CyberScript"
				action.subaddress = "keystone_changelog"
				table.insert(actionlist,action)
				
				
				
				buildWebPageBountonSquare(link,imageprop,textprop,page,actionlist)
				
				
				
				
				
				
				
				linkbar02:RemoveChildByIndex(2)
				linkbar02:RemoveChildByIndex(2)
				linkbar02:RemoveChildByIndex(2)
				
				
				
				
				
				elseif(BrowserCybserscript == "datapack") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Datapack")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--logme(2,"button")
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,v in ipairs(arrayDatapack3) do 
					
					
					table.insert(templist,v)
					
				end
				
				if(#arrayDatapack3 > 0) then
					for i = 1,#arrayDatapack3 do
						
						if(#obj < 4) then
							table.insert(obj,arrayDatapack3[i])
							if(arrayDatapack3[i+1] == nil) then
								table.insert(arrayList,obj)
							end
							else
							table.insert(arrayList,obj)
							obj = {}
							table.insert(obj,arrayDatapack3[i])
							if(arrayDatapack3[i+1] == nil) then
								table.insert(arrayList,obj)
							end
						end
						
						
						
						
					end
				end
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, 2)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.tag.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack.name
						if(isDatapackDownloaded(datapack.tag)) then
							
							textprop.text = "(Downloaded) "..datapack.name
							local localversion = CurrentDownloadedVersion(datapack.tag)
							if(localversion~=datapack.version and checkVersionNumber(localversion,datapack.version) == true) then
								
								textprop.text = "(Update) "..datapack.name
								
							end
						end
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_keystone_datapack" 
						action.value = datapack.tag
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "datapack_detail"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				
				
				
				
				elseif(BrowserCybserscript == "mydatapack") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Datapack")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "datapack"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,v in pairs(arrayDatapack) do 
					
					if(#obj < 4) then
						table.insert(obj,v.metadata)
						
						table.insert(arrayList,obj)
						
						else
						table.insert(arrayList,obj)
						obj = {}
						table.insert(obj,v.metadata)
						
						table.insert(arrayList,obj)
						
					end
					
					
				end
				
				
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, -1)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.tag.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack.name
						if(isDatapackDownloaded(datapack.tag)) then
							
							textprop.text = "(Downloaded) "..datapack.name
							local localversion = CurrentDownloadedVersion(datapack.tag)
							if(localversion~=datapack.version and checkVersionNumber(localversion,datapack.version) == true) then
								
								textprop.text = "(Update) "..datapack.name
								
							end
						end
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_keystone_datapack" 
						action.value = datapack.tag
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "datapack_detail"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				
				
				
				
				elseif(BrowserCybserscript == "datapack_detail" and Keystone_currentSelectedDatapack ~= nil) then
				
				local datapack = Keystone_currentSelectedDatapack
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"]["keystone_datapack_detail"].data)
				
				
				elseif(BrowserCybserscript == "item_category") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Item Category")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				local buttonData = {
					name = StringToName("back"),
					text = "Back",
					value = i,
					tag =  "back",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "home"
				table.insert(buttonData.action,action)
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 100,left= 2800},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(panel, 1)
				
				
				local buttonData = {
					name = StringToName("refresh"),
					text = "refresh",
					value = i,
					tag =  "refresh",
					action = {}
				}
				
				
				local action = {}
				
				action.name = "fetch_data"
				table.insert(buttonData.action,action)
				
				
				action = {}
				
				action.name = "wait_for_framework"
				table.insert(buttonData.action,action)
				
				
				
				
				action = {}
				
				action.name = "refreshBrowser"
				action.address = "CyberScript"
				action.subaddress = "item_category"
				table.insert(buttonData.action,action)
				
				
				
				
				
				local widget = UIButton.Create(buttonData.name, buttonData.text,uifont, 200, 100, {top= 0,left= 3050},HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }),HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				
				widget:RegisterCallback('OnRelease', function(button, evt)
					if evt:IsAction('click') then
						
						runActionList(buttonData.action, "back", "interact",false,"nothing",false)
						
						evt:Handle()
					end
				end)
				widget:Reparent(root, 1)
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				if(#possiblecategory > 0) then
					for i = 1,#possiblecategory do
						
						if(#obj < 4) then
							table.insert(obj,possiblecategory[i])
							if(possiblecategory[i+1] == nil) then
								table.insert(arrayList,obj)
							end
							else
							table.insert(arrayList,obj)
							obj = {}
							table.insert(obj,possiblecategory[i])
							if(possiblecategory[i+1] == nil) then
								table.insert(arrayList,obj)
							end
						end
						
						
						
						
					end
				end
				
				
				
				
				local scrollComponent = UIScroller.Create("datapack_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, -1)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("datapack__vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("datapack_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						local datapack = arrayList[i][y]
						
						
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(datapack.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						
						
						local imageprop = {}
						imageprop.tag = datapack.."_img"
						local random = math.random(1, 11)
						if(random == 37 or random == 25) then
							imageprop.tweak =  ('PhotoModeStickers.crc_%d'):format(random)
							else
							imageprop.tweak =  ('PhotoModeStickers.crc_0%d'):format(random)
						end
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = datapack.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = datapack
						
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "set_selected_item_category" 
						action.value = datapack
						table.insert(actionlist,action)
						action = {}
						action.name = "set_current_item_page" 
						action.value = 1
						table.insert(actionlist,action)
						action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScript"
						action.subaddress = "keystone_item_market"
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist)
					end
				end
				
				elseif(BrowserCybserscript == "keystone_item_market") then
				
				local interface = cyberscript.cache["interfaces"]["keystone_item_market"].data
				
				local copyinterface = deepcopy(interface, nil)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				table.remove(copyinterface.controls,17)
				
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				if CurrentItemPage == nil then CurrentItemPage = 1 setScore("Item_Market","CurrentItemPage",CurrentItemPage) end
				
				
				
				
				if arrayMarketItem ~= nil  then
					if CurrentItemPage > #arrayMarketItem[Keystone_currentSelectedItemCategory] then CurrentItemPage = 1 setScore("Item_Market","CurrentItemPage",CurrentItemPage)  end
					
					local items = arrayMarketItem[Keystone_currentSelectedItemCategory][CurrentItemPage]
					
					
					
					
					if(#items > 0) then
						for i = 1,#items do
							
							if(#obj < 5) then
								table.insert(obj,items[i])
								if(items[i+1] == nil) then
									table.insert(arrayList,obj)
								end
								else
								table.insert(arrayList,obj)
								obj = {}
								table.insert(obj,items[i])
								if(items[i+1] == nil) then
									table.insert(arrayList,obj)
								end
							end
							
							
							
							
						end
					end
					
					if(#arrayList >0) then
						for i=1,#arrayList do 
							local horizontalarea = deepcopy(GetInterfaceChildren(interface,"horizontal_area_01"), nil)
							horizontalarea.tag = "datapack_horizontal_"..i
							
							table.insert(copyinterface.controls,horizontalarea)
							for y=1,#arrayList[i] do
								local item = arrayList[i][y]
								
								local stock_vertical_item =  deepcopy(GetInterfaceChildren(interface,"stock_vertical_item_01"), nil)
								stock_vertical_item.parent = horizontalarea.tag
								stock_vertical_item.tag = "stock_vertical_item_"..i.."_"..y
								
								local bckg_01 =  deepcopy(GetInterfaceChildren(interface,"bckg_01"), nil)
								bckg_01.parent = stock_vertical_item.tag
								bckg_01.tag = "bckg_"..i.."_"..y
								
								local stock_vertical_item_container =  deepcopy(GetInterfaceChildren(interface,"stock_vertical_item_container_01"), nil)
								stock_vertical_item_container.parent = stock_vertical_item.tag
								stock_vertical_item_container.tag = "stock_vertical_item_container_"..i.."_"..y
								
								local lbl_name =  deepcopy(GetInterfaceChildren(interface,"lbl_name_01"), nil)
								lbl_name.parent = stock_vertical_item_container.tag
								lbl_name.tag = "lbl_name_"..i.."_"..y
								lbl_name.context = nil
								lbl_name.text = item.Title
								
								local lbl_price =  deepcopy(GetInterfaceChildren(interface,"lbl_price_1"), nil)
								lbl_price.parent = stock_vertical_item_container.tag
								lbl_price.tag = "lbl_price_"..i.."_"..y
								lbl_price.context = nil
								lbl_price.text = "Price : "..item.Price
								
								local owned =  deepcopy(GetInterfaceChildren(interface,"owned_01"), nil)
								owned.parent = stock_vertical_item_container.tag
								owned.tag = "owned"..i.."_"..y
								
								local playerItems = getPlayerItemsbyTag(item.Tag)
								
								if playerItems == nil then 
									
									setScore("owned_item",item.Tag,0)
									
									
								end
								
								owned.context[1].prop.text.values.loadingmsg.type = "score"
								owned.context[1].prop.text.values.loadingmsg.variable = "owned_item"
								owned.context[1].prop.text.values.loadingmsg.key = item.Tag
								owned.context[1].prop.text.values.loadingmsg.tag = nil
								
								
								local incart =  deepcopy(GetInterfaceChildren(interface,"incart_01"), nil)
								incart.parent = stock_vertical_item_container.tag
								incart.tag = "incart"..i.."_"..y
								incart.context[1].prop.text.values.loadingmsg.type = "score"
								incart.context[1].prop.text.values.loadingmsg.variable = "Item_MarketCart"
								incart.context[1].prop.text.values.loadingmsg.key = item.Tag
								incart.context[1].prop.text.values.loadingmsg.tag = nil
								
								
								local horizontal_area_btn =  deepcopy(GetInterfaceChildren(interface,"horizontal_area_btn_01"), nil)
								horizontal_area_btn.parent = stock_vertical_item_container.tag
								horizontal_area_btn.tag = "horizontal_area_btn_"..i.."_"..y
								
								local btn_buy =  deepcopy(GetInterfaceChildren(interface,"btn_buy_01"), nil)
								btn_buy.parent = horizontal_area_btn.tag
								btn_buy.tag = "btn_buy_"..i.."_"..y
								btn_buy.context[1].trigger.auto.target = item.Price
								btn_buy.action[1].tag = item.Tag
								
								local btn_sell =  deepcopy(GetInterfaceChildren(interface,"btn_sell_01"), nil)
								btn_sell.parent = horizontal_area_btn.tag
								btn_sell.tag = "btn_sell_"..i.."_"..y
								btn_sell.context[2].trigger.auto.context[1].prop.value.values.loadingmsg.key = item.Tag
								btn_sell.context[3].trigger.auto.context[1].prop.value.values.loadingmsg.key = item.Tag
								btn_sell.action[1].tag = item.Tag
								
								
								table.insert(copyinterface.controls,stock_vertical_item)
								table.insert(copyinterface.controls,bckg_01)
								table.insert(copyinterface.controls,stock_vertical_item_container)
								table.insert(copyinterface.controls,lbl_name)
								table.insert(copyinterface.controls,lbl_price)
								table.insert(copyinterface.controls,owned)
								table.insert(copyinterface.controls,incart)
								table.insert(copyinterface.controls,horizontal_area_btn)
								table.insert(copyinterface.controls,btn_buy)
								table.insert(copyinterface.controls,btn_sell)
								
								
								
							end
						end
						panel:RemoveAllChildren()
						--	logme(10,JSON:encode_pretty(copyinterface))
						makeCustomInterface(panel,copyinterface)
					end
					
					
				end
				elseif(BrowserCybserscript ~= "loading" and BrowserCybserscript ~= "home" and BrowserCybserscript ~= "datapack" and BrowserCybserscript ~= "mydatapack" and BrowserCybserscript ~= "datapack_detail" and BrowserCybserscript ~= "stock_market" and BrowserCybserscript ~= "item_category" and BrowserCybserscript ~= "item_market") then
				
				------print(BrowserCybserscript)
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"][BrowserCybserscript].data)
				
				
				
				
				
			end
		end
		if(CurrentAddress == "CyberScriptWeb") then
			if(BrowserCybserscript == nil) then BrowserCybserscript = "home" end
			if(BrowserCybserscript == "home") then
				
				local stickerRecord = TDB.GetPhotoModeStickerRecord("PhotoModeStickers.dcl_03")
				
				networktext:GetWidgetByIndex(0):SetAtlasResource(stickerRecord:AtlasName())
				networktext:GetWidgetByIndex(0):SetTexturePart(stickerRecord:ImagePartName())
				
				networktext:GetWidgetByIndex(1):SetText("Web")
				networktext:GetWidgetByIndex(1):SetTintColor(gamecolor(255,255,255,1))
				
				
				
				
				--logme(2,"button")
				
				--linkbar01:RemoveAllChildren()
				panel:RemoveChildByIndex(1)
				panel:RemoveChildByIndex(1)
				network:SetVisible(false)
				
				
				
				
				
				
				
				local arrayList = {}
				local obj = {}
				local templist = {}
				
				
				for k,wpage in pairs(cyberscript.cache["webpage"]) do 
					
					if(checkTriggerRequirement(wpage.data.requirement,wpage.data.trigger))then
						table.insert(templist,wpage)
					end
				end
				
				
				for i,wpage in ipairs(templist) do 
					
					
					if(#obj < 4) then
						
						
						table.insert(obj,wpage)
						
						if(templist[i+1] == nil) then
							table.insert(arrayList,obj)
						end
						
						
						else
						
						table.insert(arrayList,obj)
						
						
						obj = {}
						table.insert(obj,wpage)
						
						if(templist[i+1] == nil) then
							table.insert(arrayList,obj)
						end
						
					end
					
					
				end
				
				
				
				local scrollComponent = UIScroller.Create("webpage_scroll")
				local scrollPanel = scrollComponent:GetRootWidget()
				
				scrollPanel:SetAnchor(inkEAnchor.TopLeft)
				scrollPanel:SetMargin(inkMargin.new({ left = 40.0 ,top=60}))
				scrollPanel:SetSize(Vector2.new({ X = 1900, Y = 1200 }))
				scrollPanel:Reparent(panel, 2)
				local scrollContent = scrollComponent:GetContentWidget()
				Cron.NextTick(function()
					scrollComponent:UpdateContent(true)
				end)
				
				
				local vertical = inkVerticalPanelWidget.new()
				vertical:SetName(StringToName("webpage_vertical"))
				vertical:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
				vertical:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
				vertical:SetFitToContent(true)
				vertical:Reparent(scrollContent, -1)
				
				
				for i=1,#arrayList do 
					local horizontalarea2 = inkHorizontalPanelWidget.new()
					horizontalarea2:SetName(CName.new("webpage_horizontal_"..i))
					horizontalarea2:SetSize(Vector2.new({ X = 1900, Y = 500 }))
					horizontalarea2:SetChildMargin(inkMargin.new({left=100, top=30, right=100, bottom=0 }))
					--	horizontalarea2:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					horizontalarea2:Reparent(vertical)
					
					for y=1,#arrayList[i] do
						
						local webpage = arrayList[i][y].data
						------print(dump(webpage))
						local verticalarea = inkVerticalPanelWidget.new()
						verticalarea:SetName(StringToName(webpage.tag.."_vertical"))
						--buttonList:SetPadding(inkMargin.new({ left = 32.0, top = 20.0, right = 32.0 }))
						--buttonList:SetChildMargin(inkMargin.new({ top = 8.0, bottom = 8.0 }))
						verticalarea:SetFitToContent(false)
						verticalarea:SetSize(Vector2.new({ X = 500, Y = 500 }))
						verticalarea:Reparent(horizontalarea2, 1)
						local customimage = false
						
						local imageprop = {}
						imageprop.tag = webpage.tag.."_img"
						
						if(webpage.tweak ~= nil and webpage.texture ~= nil and webpage.tweak ~= "" and webpage.texture ~= "") then
							
							imageprop.tweak = webpage.tweak
							imageprop.texture = webpage.texture
							customimage = true
							else
							
							imageprop.tweak = ('PhotoModeStickers.dcl_016')
						end
						
						
						imageprop.margin = inkMargin.new({ left = 100.0, right = 100, bottom = 0, top = 0.0 })
						imageprop.size = {}
						imageprop.size.x = 200
						imageprop.size.y = 200
						imageprop.fittocontent = false
						imageprop.scale = {}
						imageprop.scale.x = 1.3
						imageprop.scale.y = 1.3
						
						local textprop = {}
						textprop.tag = webpage.tag.."_text"
						textprop.margin = inkMargin.new({ left = 0.0, right = 0, bottom = 0, top = 50.0 })
						textprop.size = {}
						textprop.size.x = 100
						textprop.size.y = 32
						textprop.text = webpage.name
						
						textprop.fontsize = 45
						
						textprop.textcolor =HDRColor.new({ Red = 0.321569, Green = 0.866667, Blue = 0.874510, Alpha = 1.0 })
						
						textprop.scale = {}
						textprop.scale.x = 1.0
						textprop.scale.y = 1.0
						
						
						
						local actionlist = {}
						local action = {}
						action.name = "refreshBrowser"
						action.address = "CyberScriptWeb"
						action.subaddress = webpage.target
						table.insert(actionlist,action)
						
						buildWebPageBountonSquare(verticalarea,imageprop,textprop,page,actionlist,customimage)
					end
				end
				
				
				
				else
				
				panel:RemoveAllChildren()
				
				makeCustomInterface(panel,cyberscript.cache["interfaces"][BrowserCybserscript].data)
				
				
			end
		end
		
		
	end
	if(CurrentAddress == "NETdir://ezestates.web/for_rent") then --place and housing
		
		
		local root = self:GetRootWidget()
		
		pcall(function()
			printChild(root)
		end)
		
		
		
		LinkController = inkWidgetRef.GetController(self.textList[1])
		local root = self.textList[1].widget.parentWidget.parentWidget
		logme(2,"obs6")
		
		root:SetVisible(true)
		local texts = page:GetTexts()
		logme(2,"obs6")
		local buttonData = {
			name = StringToName("testButton"),
			text = "CyberScript Estates",
			value = 1,
			tag =  "testButton"
		}
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local buttonComponent = UIButton.Create(buttonData.name, buttonData.text,50, self.textList[1].widget.parentWidget:GetSize().X,  self.textList[1].widget.parentWidget:GetSize().Y,{top=600,left=475},yellow,black)
		buttonComponent:Reparent(root, -1)
		buttonComponent:RegisterCallback('OnRelease', function(button, evt)
			if(self.textList ~= nil) then
				local linkController = LinkController
				if linkController ~= nil then
					linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
					self.lastClickedLinkAddress = linkController:GetLinkAddress()
					self:CallCustomCallback("OnLinkPressed")
					CurrentAddress = "NETdir://ezestates.web/makeovers"
					BrowserCustomPlace = "main"
					else 
					logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
				end
			end  
			evt:Handle()
		end)
		local root2 = self.imageList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
		
		root2:SetVisible(true)
		local nightcity01 = self.textList[11].widget
		nightcity01:SetVisible(false)
		local nightcity02 = self.textList[11].widget.parentWidget
		nightcity02:SetVisible(false)
	end
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace ~= nil) then
		LinkController = inkWidgetRef.GetController(self.textList[1])
		local root = self.textList[1].widget.parentWidget.parentWidget
		logme(2,tostring(GameDump(root)))
		local texts = page:GetTexts()
		logme(2,"obs6")
		local buttonData = {
			name = StringToName("testButton"),
			text = "CyberScript Estates",
			value = 1,
			tag =  "testButton"
		}
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local buttonComponent = UIButton.Create(buttonData.name, buttonData.text,50, self.textList[1].widget.parentWidget:GetSize().X,  self.textList[1].widget.parentWidget:GetSize().Y,{top=600,left=475},yellow,black)
		buttonComponent:Reparent(root, -1)
		buttonComponent:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				self:CallCustomCallback("OnLinkPressed")
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "main"
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local anquestion = self.textList[15].widget.parentWidget
		local anquestion_margin = anquestion:GetMargin()
		anquestion_margin.top = anquestion_margin.top+250
		anquestion:SetMargin(anquestion_margin)
		local anquestion_height = anquestion:GetHeight()
		anquestion_height = anquestion_height-150
		anquestion:SetHeight(anquestion_height)
		local texts = page:GetTexts()
		local textcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local bgcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		self.textList[2].widget:SetTintColor(bgcolor)
		self.textList[2].widget.parentWidget:SetTintColor(bgcolor)
		self.imageList[2].widget:SetTintColor(textcolor)
		local itemcontainer = self.textList[3].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[5].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[6].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[7].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local itemcontainer = self.textList[8].widget.parentWidget.parentWidget.parentWidget
		itemcontainer:SetVisible(false)
		local anquestionPics = self.textList[15].widget
		anquestionPics:SetText("An Bug ? An Suggestions ?")
		anquestionPics:SetFontSize(35)
		local contactUs = self.textList[16].widget
		contactUs:SetText("Go to CyberScript Discord for Help !")
		contactUs:SetFontSize(35)
	end
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace == "main") then
		----print("YOHOHOHO")
		local texts = page:GetTexts()
		logme(2,"obs6")
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local textList = #self.textList
		local root2 = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
		local heigh = 100
		local width = 2800
		local fontsize = uifont
		local black = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
		local yellow = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
		local leftm = 500
		local btn_house = UIButton.Create("btn_house", "Our Houses",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_house:Reparent(root2, 0)
		btn_house:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "house"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[3])) + "]")
			end
			evt:Handle()
		end)
		local btn_bar = UIButton.Create("btn_bar", "Our bars",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_bar:Reparent(root2, 0)
		btn_bar:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "bar"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local btn_nightclub = UIButton.Create("btn_nightclub", "Our nightclubs",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_nightclub:Reparent(root2, 1)
		btn_nightclub:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "nightclub"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local btn_shops = UIButton.Create("btn_shops", "Our Shops",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_shops:Reparent(root2, 2)
		btn_shops:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "shopping"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		local btn_restaurant = UIButton.Create("btn_restaurant", "Our restaurants",50, width, heigh ,{top=150,left=leftm},black,yellow)
		btn_restaurant:Reparent(root2, 3)
		btn_restaurant:RegisterCallback('OnRelease', function(button, evt)
			local linkController = LinkController
			if linkController ~= nil then
				linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
				self.lastClickedLinkAddress = linkController:GetLinkAddress()
				CurrentAddress = "NETdir://ezestates.web/makeovers"
				BrowserCustomPlace = "restaurant"
				self:CallCustomCallback("OnLinkPressed")
				else 
				logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
			end
			evt:Handle()
		end)
		
		
		
		if(currentHouse ~= nil) then
			local housestatut = getVariableKey(currentHouse.tag,"Statut")
			if(housestatut ~= nil and housestatut > 0) then
				
				local btn_template = UIButton.Create("btn_template", "Our Renovations",50, width, heigh ,{top=150,left=leftm},black,yellow)
				btn_template:Reparent(root2, 4)
				btn_template:RegisterCallback('OnRelease', function(button, evt)
					local linkController = LinkController
					if linkController ~= nil then
						linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
						self.lastClickedLinkAddress = linkController:GetLinkAddress()
						CurrentAddress = "NETdir://ezestates.web/makeovers"
						BrowserCustomPlace = "template"
						self:CallCustomCallback("OnLinkPressed")
						else 
						logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
					end
					evt:Handle()
				end)
				
				if(currentHouse.step ~= nil and #currentHouse.step > 0) then
					local housesttep = getVariableKeyWithDefault(currentHouse.tag,"step",0)
					
					
					
					local btn_upgrade = UIButton.Create("btn_upgrade", "Upgrade your home !",50, width, heigh ,{top=150,left=leftm},black,yellow)
					btn_upgrade:Reparent(root2, 5)
					btn_upgrade:RegisterCallback('OnRelease', function(button, evt)
						local linkController = LinkController
						if linkController ~= nil then
							linkController:SetLinkAddress("NETdir://ezestates.web/makeovers")
							self.lastClickedLinkAddress = linkController:GetLinkAddress()
							CurrentAddress = "NETdir://ezestates.web/makeovers"
							BrowserCustomPlace = "upgrade"
							self:CallCustomCallback("OnLinkPressed")
							else 
							logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
						end
						evt:Handle()
					end)
					
				end
				
			end
		end
		
	end
	
	
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace ~= "main") then
		-- local textList = #self.textList
		-- logme(2,"textList "..textList)
		--Hide current Items
		----print("YAHAHAHA")
		if (BrowserCustomPlace == "house" or BrowserCustomPlace == "bar" or BrowserCustomPlace == "nightclub" or BrowserCustomPlace == "restaurant" or BrowserCustomPlace == "shopping") then
			local textink = self.textList[4].widget
			local textcontainer = self.textList[4].widget.parentWidget
			local buttonink = self.textList[4].widget.parentWidget.parentWidget
			local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
			local rowcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
			local verticalarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
			local scrollarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
			local tempcount = 0
			local temparrayHouse = {}
			local obj = {}
			local templist = {}
			local housetype = 0
			if(BrowserCustomPlace == "house") then
				housetype = 0
			end
			if(BrowserCustomPlace == "bar") then
				housetype = 1
			end
			if(BrowserCustomPlace == "nightclub") then
				housetype = 2
			end
			if(BrowserCustomPlace == "restaurant") then
				housetype = 3
			end
			if(BrowserCustomPlace == "shopping") then
				housetype = 4
			end
			for k,v in pairs(cyberscript.cache["place"]) do 
				if(v.data.type == housetype) then
					table.insert(templist,v.data)
				end
			end
			logme(10,"House count :"..#templist)
			if(#templist > 0) then
				for i = 1,#templist do
					
					
					if(#obj < 2) then
						table.insert(obj,templist[i])
						if(templist[i+1] == nil) then
							table.insert(temparrayHouse,obj)
						end
						else
						table.insert(temparrayHouse,obj)
						obj = {}
						table.insert(obj,templist[i])
						if(templist[i+1] == nil) then
							table.insert(temparrayHouse,obj)
						end
					end
					
					
					
					
				end
			end
			logme(10,"House count :"..#temparrayHouse)
			local marginleft = 50
			local topleft = 0
			for i=1,#temparrayHouse do 
				local rowcontainerhouse = inkHorizontalPanelWidget.new()
				rowcontainerhouse:SetName(CName.new("rowcontainer_house_"..i))
				rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
				rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
				rowcontainerhouse:Reparent(verticalarea)
				-- local rowcontainerhouse = inkCanvasWidget.new()
				-- rowcontainerhouse:SetName(CName.new("rowcontainer_house_"..i))
				-- rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
				-- rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
				-- rowcontainerhouse:SetMargin(inkMargin.new({ bottom = 50 }))
				-- rowcontainerhouse:Reparent(verticalarea)
				for y=1,#temparrayHouse[i] do
					local house = temparrayHouse[i][y]
					local score = getHouseStatut(house.tag)
					
					local canvas = inkCanvasWidget.new()
					canvas:SetName(CName.new("canvas_house_"..house.tag))
					canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
					canvas:SetMargin(inkMargin.new({ bottom = 50 }))
					canvas:Reparent(rowcontainerhouse)
					local bg = inkImage.new()
					bg:SetName(CName.new("bg_house_"..house.tag))
					bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					bg:SetTexturePart('cell_bg')
					bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
					bg:SetOpacity(0.8)
					bg:SetAnchor(inkEAnchor.Fill)
					bg.useNineSliceScale = true
					bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					bg:SetInteractive(false)
					bg:Reparent(canvas, -1)
					local fill = inkImage.new()
					fill:SetName("fill_house_"..house.tag)
					fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					fill:SetTexturePart('cell_bg')
					fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
					fill:SetOpacity(0.0)
					fill:SetAnchor(inkEAnchor.Fill)
					fill.useNineSliceScale = true
					fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					fill:SetInteractive(false)
					fill:Reparent(canvas, -1)
					local frame = inkImage.new()
					frame:SetName("frame_house_"..house.tag)
					frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					frame:SetTexturePart('cell_fg')
					frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
					frame:SetOpacity(0.3)
					frame:SetAnchor(inkEAnchor.Fill)
					frame.useNineSliceScale = true
					frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					frame:SetInteractive(false)
					frame:Reparent(canvas, -1)
					local textinkhousename = inkText.new()
					textinkhousename:SetName(CName.new("text_house_"..house.tag.."_Name"))
					if (score == nil or score == 0) then
						textinkhousename:SetText("Name : "..house.name)
						else
						textinkhousename:SetText("(Owned) Name : "..house.name)
						textinkhousename:SetTintColor(gamecolor(0,255,0,1))
					end
					textinkhousename:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textinkhousename:SetFontStyle('Medium')
					textinkhousename:SetFontSize(35)
					textinkhousename:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textinkhousename:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textinkhousename:SetVerticalAlignment(textVerticalAlignment.Center)
					textinkhousename:SetMargin(inkMargin.new({ left = 50, top = 0 }))
					textinkhousename:Reparent(canvas,-1)
					local textinkhouseprice = inkText.new()
					textinkhouseprice:SetName(CName.new("text_house_"..house.tag.."_price"))
					textinkhouseprice:SetText("Price : "..house.price.." €$")
					textinkhouseprice:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textinkhouseprice:SetFontStyle('Medium')
					textinkhouseprice:SetFontSize(35)
					textinkhouseprice:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textinkhouseprice:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textinkhouseprice:SetVerticalAlignment(textVerticalAlignment.Center)
					textinkhouseprice:SetMargin(inkMargin.new({ left = 50, top = 50 }))
					textinkhouseprice:Reparent(canvas,-1)
					local textinkhousedesc = inkText.new()
					textinkhousedesc:SetName(CName.new("text_house_"..house.tag.."_desc"))
					if(house.desc == nil) then
						textinkhousedesc:SetText("No description about thos place. Come back later !")
						else
						local splitContentRequ = splitByChunk(house.desc,50)
						local result = splitContentRequ
						textinkhousedesc:SetText(result)
					end
					textinkhousedesc:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textinkhousedesc:SetFontStyle('Medium')
					textinkhousedesc:SetFontSize(35)
					textinkhousedesc:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textinkhousedesc:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textinkhousedesc:SetVerticalAlignment(textVerticalAlignment.Center)
					textinkhousedesc:SetMargin(inkMargin.new({ left = 50, top = 100 }))
					textinkhousedesc:Reparent(canvas,-1)
					if (house.isbuyable == true) then
						if ((score == nil or score == 0)) then
							local buttonData = {
								name = "text_house_"..house.tag.."_buy",
								text = "Buy",
								value = 1,
								tag =  "text_house_"..house.tag.."_buy"
							}
							local fontsize = uifont
							local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
							local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
							local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
							buy_btn:Reparent(canvas, -1)
							buy_btn:RegisterCallback('OnRelease', function(button, evt)
								local onenter_action = {}
								local action = {}
								action.name = "buyHouse"
								action.tag = house.tag
								table.insert(onenter_action,action)
								local action = {}
								action.name = "notify"
								action.value = "Place Buyed !"
								table.insert(onenter_action,action)
								local action = {}
								action.name = "set_mappin"
								action.position = "custom_place"
								action.position_tag = house.tag
								action.position_house_way = "default"
								action.tag =  house.tag
								action.typemap = "Zzz05_ApartmentToPurchaseVariant"
								action.wall =  true
								action.active =  false
								action.x = 0
								action.y = 0
								action.z = 0
								table.insert(onenter_action,action)
								runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
								local linkController = LinkController
								if linkController ~= nil then
									linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
									self.lastClickedLinkAddress = linkController:GetLinkAddress()
									CurrentAddress = "NETdir://ezestates.web/for_rent"
									BrowserCustomPlace = nil
									self:CallCustomCallback("OnLinkPressed")
									else 
									logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
								end
								evt:Handle()
							end)
							else
							local buttonData = {
								name = "text_house_"..house.tag.."_sell",
								text = "Sell",
								value = 1,
								tag =  "text_house_"..house.tag.."_sell"
							}
							local fontsize = uifont
							local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
							local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 16, Blue = 16, Alpha = 1.0 }))
							local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
							buy_btn:Reparent(canvas, -1)
							buy_btn:RegisterCallback('OnRelease', function(button, evt)
								local onenter_action = {}
								local action = {}
								action.name = "sellHouse"
								action.tag = house.tag
								table.insert(onenter_action,action)
								local action = {}
								action.name = "notify"
								action.value = "Place Selled !"
								table.insert(onenter_action,action)
								
								runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
								local linkController = LinkController
								if linkController ~= nil then
									linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
									self.lastClickedLinkAddress = linkController:GetLinkAddress()
									CurrentAddress = "NETdir://ezestates.web/for_rent"
									BrowserCustomPlace = nil
									self:CallCustomCallback("OnLinkPressed")
									else 
									logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
								end
								evt:Handle()
							end)
						end
					end
				end
			end
			
			
		end
		if(BrowserCustomPlace == "template") then
			if(currentHouse ~= nil) then
				
				local textink = self.textList[4].widget
				local textcontainer = self.textList[4].widget.parentWidget
				local buttonink = self.textList[4].widget.parentWidget.parentWidget
				local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
				local rowcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
				local verticalarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local scrollarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local tempcount = 0
				local temparrayHouse = {}
				local obj = {}
				local templist = {}
				
				local marginleft = 50
				local topleft = 0
				
				for k,v in pairs(cyberscript.cache["housing_template"]) do 
					
					if(v.data.target == currentHouse.tag) then
						table.insert(templist,v.data)
					end
				end
				
				if(#templist > 0) then
					for i = 1,#templist do
						
						if(#obj < 2) then
							table.insert(obj,templist[i])
							if(templist[i+1] == nil) then
								table.insert(temparrayHouse,obj)
							end
							else
							table.insert(temparrayHouse,obj)
							obj = {}
							table.insert(obj,templist[i])
							if(templist[i+1] == nil) then
								table.insert(temparrayHouse,obj)
							end
						end
						
						
						
						
					end
				end
				
				logme(10,dump(temparrayHouse))
				
				for i=1,#temparrayHouse do 
					local rowcontainerhouse = inkHorizontalPanelWidget.new()
					rowcontainerhouse:SetName(CName.new("rowcontainer_house_"..i))
					rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
					rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					rowcontainerhouse:Reparent(verticalarea)
					
					for y=1,#temparrayHouse[i] do
						local template = temparrayHouse[i][y]
						local currenttemplate = getVariableKey(currentHouse.tag,"current_template")
						
						local canvas = inkCanvasWidget.new()
						canvas:SetName(CName.new("canvas_house_"..template.tag))
						canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
						canvas:SetMargin(inkMargin.new({ bottom = 50 }))
						canvas:Reparent(rowcontainerhouse)
						local bg = inkImage.new()
						bg:SetName(CName.new("bg_house_"..template.tag))
						bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
						bg:SetTexturePart('cell_bg')
						bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
						bg:SetOpacity(0.8)
						bg:SetAnchor(inkEAnchor.Fill)
						bg.useNineSliceScale = true
						bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
						bg:SetInteractive(false)
						bg:Reparent(canvas, -1)
						local fill = inkImage.new()
						fill:SetName("fill_house_"..template.tag)
						fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
						fill:SetTexturePart('cell_bg')
						fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
						fill:SetOpacity(0.0)
						fill:SetAnchor(inkEAnchor.Fill)
						fill.useNineSliceScale = true
						fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
						fill:SetInteractive(false)
						fill:Reparent(canvas, -1)
						local frame = inkImage.new()
						frame:SetName("frame_house_"..template.tag)
						frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
						frame:SetTexturePart('cell_fg')
						frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
						frame:SetOpacity(0.3)
						frame:SetAnchor(inkEAnchor.Fill)
						frame.useNineSliceScale = true
						frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
						frame:SetInteractive(false)
						frame:Reparent(canvas, -1)
						local textinkhousename = inkText.new()
						textinkhousename:SetName(CName.new("text_house_"..template.tag.."_Name"))
						
						if(currenttemplate ~= nil and currenttemplate == template.tag) then
							textinkhousename:SetText("(Applied) Name : "..template.name)
							textinkhousename:SetTintColor(gamecolor(0,255,0,1))
							else
							textinkhousename:SetText("Name : "..template.name)
							textinkhousename:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
						end
						
						textinkhousename:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textinkhousename:SetFontStyle('Medium')
						textinkhousename:SetFontSize(35)
						
						textinkhousename:SetHorizontalAlignment(textHorizontalAlignment.Center)
						textinkhousename:SetVerticalAlignment(textVerticalAlignment.Center)
						textinkhousename:SetMargin(inkMargin.new({ left = 50, top = 0 }))
						textinkhousename:Reparent(canvas,-1)
						local textinkhouseprice = inkText.new()
						textinkhouseprice:SetName(CName.new("text_house_"..template.tag.."_price"))
						textinkhouseprice:SetText("Price : "..template.price.." €$")
						textinkhouseprice:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textinkhouseprice:SetFontStyle('Medium')
						textinkhouseprice:SetFontSize(35)
						textinkhouseprice:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
						textinkhouseprice:SetHorizontalAlignment(textHorizontalAlignment.Center)
						textinkhouseprice:SetVerticalAlignment(textVerticalAlignment.Center)
						textinkhouseprice:SetMargin(inkMargin.new({ left = 50, top = 50 }))
						textinkhouseprice:Reparent(canvas,-1)
						local textinkhousedesc = inkText.new()
						textinkhousedesc:SetName(CName.new("text_house_"..template.tag.."_desc"))
						if(template.desc == nil) then
							textinkhousedesc:SetText("No description about thos place. Come back later !")
							else
							local splitContentRequ = splitByChunk(template.desc,50)
							local result = splitContentRequ
							
							textinkhousedesc:SetText(result)
						end
						textinkhousedesc:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
						textinkhousedesc:SetFontStyle('Medium')
						textinkhousedesc:SetFontSize(35)
						textinkhousedesc:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
						textinkhousedesc:SetHorizontalAlignment(textHorizontalAlignment.Center)
						textinkhousedesc:SetVerticalAlignment(textVerticalAlignment.Center)
						textinkhousedesc:SetMargin(inkMargin.new({ left = 50, top = 100 }))
						textinkhousedesc:Reparent(canvas,-1)
						local buttonData = {
							name = "text_house_"..template.tag.."_buy",
							text = "Buy",
							value = 1,
							tag =  "text_house_"..template.tag.."_buy"
						}
						local fontsize = uifont
						local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
						local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
						local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
						buy_btn:Reparent(canvas, -1)
						buy_btn:RegisterCallback('OnRelease', function(button, evt)
							local onenter_action = {}
							local action = {}
							action.name = "remove_money"
							action.value = template.price
							table.insert(onenter_action,action)
							local action = {}
							action.name = "notify"
							action.value = "Renovation Buyed !"
							table.insert(onenter_action,action)
							local action = {}
							action.name = "current_place_clear_all_template"
							table.insert(onenter_action,action)
							local action = {}
							action.name = "set_variable"
							action.variable = currentHouse.tag
							action.key = "current_template"
							action.value = template.tag
							table.insert(onenter_action,action)
							local action = {}
							action.name = "current_place_apply_template"
							action.tag = template.tag
							action.x = 0
							action.y = 0
							action.z = 0
							table.insert(onenter_action,action)
							runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
							local linkController = LinkController
							if linkController ~= nil then
								linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
								self.lastClickedLinkAddress = linkController:GetLinkAddress()
								CurrentAddress = "NETdir://ezestates.web/for_rent"
								BrowserCustomPlace = nil
								self:CallCustomCallback("OnLinkPressed")
								else 
								logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
							end
							evt:Handle()
						end)
						
					end
				end
				
				local rowcontainerhouse = inkHorizontalPanelWidget.new()
				rowcontainerhouse:SetName(CName.new("rowcontainer_house_clear"))
				rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
				rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
				rowcontainerhouse:Reparent(verticalarea)
				
				local canvas = inkCanvasWidget.new()
				canvas:SetName(CName.new("canvas_house_clear"))
				canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
				canvas:SetMargin(inkMargin.new({ bottom = 50 }))
				canvas:Reparent(rowcontainerhouse)
				local bg = inkImage.new()
				bg:SetName(CName.new("bg_house_clear"))
				bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
				bg:SetTexturePart('cell_bg')
				bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
				bg:SetOpacity(0.8)
				bg:SetAnchor(inkEAnchor.Fill)
				bg.useNineSliceScale = true
				bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
				bg:SetInteractive(false)
				bg:Reparent(canvas, -1)
				local fill = inkImage.new()
				fill:SetName("fill_house_clear")
				fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
				fill:SetTexturePart('cell_bg')
				fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
				fill:SetOpacity(0.0)
				fill:SetAnchor(inkEAnchor.Fill)
				fill.useNineSliceScale = true
				fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
				fill:SetInteractive(false)
				fill:Reparent(canvas, -1)
				local frame = inkImage.new()
				frame:SetName("frame_house_clear")
				frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
				frame:SetTexturePart('cell_fg')
				frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
				frame:SetOpacity(0.3)
				frame:SetAnchor(inkEAnchor.Fill)
				frame.useNineSliceScale = true
				frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
				frame:SetInteractive(false)
				frame:Reparent(canvas, -1)
				local textinkhousename = inkText.new()
				textinkhousename:SetName(CName.new("text_house_clear_Name"))
				textinkhousename:SetText("Clear current renovations")
				textinkhousename:SetTintColor(gamecolor(255,0,0,1))
				textinkhousename:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
				textinkhousename:SetFontStyle('Medium')
				textinkhousename:SetFontSize(35)
				
				textinkhousename:SetHorizontalAlignment(textHorizontalAlignment.Center)
				textinkhousename:SetVerticalAlignment(textVerticalAlignment.Center)
				textinkhousename:SetMargin(inkMargin.new({ left = 50, top = 0 }))
				textinkhousename:Reparent(canvas,-1)
				local textinkhouseprice = inkText.new()
				textinkhouseprice:SetName(CName.new("text_house_clear_price"))
				textinkhouseprice:SetText("Price : 500 €$")
				textinkhouseprice:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
				textinkhouseprice:SetFontStyle('Medium')
				textinkhouseprice:SetFontSize(35)
				textinkhouseprice:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
				textinkhouseprice:SetHorizontalAlignment(textHorizontalAlignment.Center)
				textinkhouseprice:SetVerticalAlignment(textVerticalAlignment.Center)
				textinkhouseprice:SetMargin(inkMargin.new({ left = 50, top = 50 }))
				textinkhouseprice:Reparent(canvas,-1)
				local textinkhousedesc = inkText.new()
				textinkhousedesc:SetName(CName.new("text_house_clear_desc"))
				textinkhousedesc:SetText("It will clear the current renovation.")
				
				textinkhousedesc:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
				textinkhousedesc:SetFontStyle('Medium')
				textinkhousedesc:SetFontSize(35)
				textinkhousedesc:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
				textinkhousedesc:SetHorizontalAlignment(textHorizontalAlignment.Center)
				textinkhousedesc:SetVerticalAlignment(textVerticalAlignment.Center)
				textinkhousedesc:SetMargin(inkMargin.new({ left = 50, top = 100 }))
				textinkhousedesc:Reparent(canvas,-1)
				local buttonData = {
					name = "text_house_clear_buy",
					text = "Buy",
					value = 1,
					tag =  "text_house_clear_buy"
				}
				local fontsize = uifont
				local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
				local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
				local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
				buy_btn:Reparent(canvas, -1)
				buy_btn:RegisterCallback('OnRelease', function(button, evt)
					local onenter_action = {}
					local action = {}
					action.name = "remove_money"
					action.value = 500
					table.insert(onenter_action,action)
					local action = {}
					action.name = "notify"
					action.value = "Renovation Cleared !"
					table.insert(onenter_action,action)
					local action = {}
					action.name = "current_place_clear_all_template"
					table.insert(onenter_action,action)
					local action = {}
					action.name = "set_variable"
					action.variable = currentHouse.tag
					action.key = "current_template"
					action.value = ""
					table.insert(onenter_action,action)
					
					runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
					local linkController = LinkController
					if linkController ~= nil then
						linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
						self.lastClickedLinkAddress = linkController:GetLinkAddress()
						CurrentAddress = "NETdir://ezestates.web/for_rent"
						BrowserCustomPlace = nil
						self:CallCustomCallback("OnLinkPressed")
						else 
						logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
					end
					evt:Handle()
				end)
				
			end
			
			
		end
		
		
		if(BrowserCustomPlace == "upgrade") then
			if(currentHouse ~= nil) then
				
				local textink = self.textList[4].widget
				local textcontainer = self.textList[4].widget.parentWidget
				local buttonink = self.textList[4].widget.parentWidget.parentWidget
				local itemcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget
				local rowcontainer = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget
				local verticalarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local scrollarea = self.textList[4].widget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget.parentWidget
				local tempcount = 0
				local temparrayHouse = {}
				local obj = {}
				local templist = {}
				
				local marginleft = 50
				local topleft = 0
				
				
				local housesttep = getVariableKeyWithDefault(currentHouse.tag,"step",0)
				
				if (housesttep > 0) then
					
					local currentstep = currentHouse.step[housesttep]
					
					local rowcontainerhouse = inkHorizontalPanelWidget.new()
					rowcontainerhouse:SetName(CName.new("rowcontainer_house_clear"))
					rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
					rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					rowcontainerhouse:Reparent(verticalarea)
					
					local canvas = inkCanvasWidget.new()
					canvas:SetName(CName.new("canvas_house_clear"))
					canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
					canvas:SetMargin(inkMargin.new({ bottom = 50 }))
					canvas:Reparent(rowcontainerhouse)
					local bg = inkImage.new()
					bg:SetName(CName.new("bg_house_clear"))
					bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					bg:SetTexturePart('cell_bg')
					bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
					bg:SetOpacity(0.8)
					bg:SetAnchor(inkEAnchor.Fill)
					bg.useNineSliceScale = true
					bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					bg:SetInteractive(false)
					bg:Reparent(canvas, -1)
					local fill = inkImage.new()
					fill:SetName("fill_house_clear")
					fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					fill:SetTexturePart('cell_bg')
					fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
					fill:SetOpacity(0.0)
					fill:SetAnchor(inkEAnchor.Fill)
					fill.useNineSliceScale = true
					fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					fill:SetInteractive(false)
					fill:Reparent(canvas, -1)
					local frame = inkImage.new()
					frame:SetName("frame_house_clear")
					frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					frame:SetTexturePart('cell_fg')
					frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
					frame:SetOpacity(0.3)
					frame:SetAnchor(inkEAnchor.Fill)
					frame.useNineSliceScale = true
					frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					frame:SetInteractive(false)
					frame:Reparent(canvas, -1)
					
					
					
					local textc01 = inkText.new()
					textc01:SetName(CName.new("text_house_clear_title"))
					textc01:SetText("Current Upgrade : "..currentstep.title)
					textc01:SetTintColor(gamecolor(255,0,0,1))
					textc01:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textc01:SetFontStyle('Medium')
					textc01:SetFontSize(45)
					
					
					
					
					textc01:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textc01:SetVerticalAlignment(textVerticalAlignment.Center)
					textc01:SetMargin(inkMargin.new({ left = 50, top = 0 }))
					textc01:Reparent(canvas,-1)
					
					local textc02 = inkText.new()
					textc02:SetName(CName.new("text_house_clear_desc"))
					textc02:SetText(splitByChunk(currentstep.desc,50))
					
					textc02:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					textc02:SetFontStyle('Medium')
					textc02:SetFontSize(35)
					textc02:SetTintColor(HDRColor.new({ Red = 0.113725, Green = 0.929412, Blue = 0.513726, Alpha = 1.0 }))
					textc02:SetHorizontalAlignment(textHorizontalAlignment.Center)
					textc02:SetVerticalAlignment(textVerticalAlignment.Center)
					textc02:SetMargin(inkMargin.new({ left = 50, top = 100 }))
					textc02:Reparent(canvas,-1)
					
					local fontsize = uifont
					local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
					local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
					
				end
				
				local nextstep = currentHouse.step[housesttep+1]
				if(nextstep ~= nil) then
					
					local rowcontainerhouse = inkHorizontalPanelWidget.new()
					rowcontainerhouse:SetName(CName.new("rowcontainer_house_newstep"))
					rowcontainerhouse:SetSize(Vector2.new({ X = 2120, Y = 500 }))
					rowcontainerhouse:SetMargin(inkMargin.new({ top = 50, bottom = 50 }))
					rowcontainerhouse:Reparent(verticalarea)
					
					local canvas = inkCanvasWidget.new()
					canvas:SetName(CName.new("canvas_house_newstep"))
					canvas:SetSize(Vector2.new({ X = 874, Y = 491 }))
					canvas:SetMargin(inkMargin.new({ bottom = 50 }))
					canvas:Reparent(rowcontainerhouse)
					local bg = inkImage.new()
					bg:SetName(CName.new("bg_house_new"))
					bg:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					bg:SetTexturePart('cell_bg')
					bg:SetTintColor(HDRColor.new({ Red = 0.054902, Green = 0.054902, Blue = 0.090196, Alpha = 1.0 }))
					bg:SetOpacity(0.8)
					bg:SetAnchor(inkEAnchor.Fill)
					bg.useNineSliceScale = true
					bg.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					bg:SetInteractive(false)
					bg:Reparent(canvas, -1)
					local fill = inkImage.new()
					fill:SetName("fill_house_new")
					fill:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					fill:SetTexturePart('cell_bg')
					fill:SetTintColor(HDRColor.new({ Red = 1.1761, Green = 0.3809, Blue = 0.3476, Alpha = 1.0 }))
					fill:SetOpacity(0.0)
					fill:SetAnchor(inkEAnchor.Fill)
					fill.useNineSliceScale = true
					fill.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					fill:SetInteractive(false)
					fill:Reparent(canvas, -1)
					local frame = inkImage.new()
					frame:SetName("frame_house_new")
					frame:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas'))
					frame:SetTexturePart('cell_fg')
					frame:SetTintColor(HDRColor.new({ Red = 0.368627, Green = 0.964706, Blue = 1.0, Alpha = 1.0 }))
					frame:SetOpacity(0.3)
					frame:SetAnchor(inkEAnchor.Fill)
					frame.useNineSliceScale = true
					frame.nineSliceScale = inkMargin.new({ left = 0.0, top = 0.0, right = 10.0, bottom = 0.0 })
					frame:SetInteractive(false)
					frame:Reparent(canvas, -1)
					
					
					local text01 = inkText.new()
					text01:SetName(CName.new("text_house_new_Name"))
					text01:SetText(nextstep.title)
					
					text01:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					text01:SetFontStyle('Medium')
					text01:SetFontSize(45)
					
					text01:SetHorizontalAlignment(textHorizontalAlignment.Center)
					text01:SetVerticalAlignment(textVerticalAlignment.Center)
					text01:SetMargin(inkMargin.new({ left = 50, top = 0 }))
					text01:SetTintColor(gamecolor(255,169,0,1))
					text01:Reparent(canvas,-1)
					
					
					
					local text02 = inkText.new()
					text02:SetName(CName.new("text_house_new_price"))
					text02:SetText("Price : "..nextstep.price.."€$")
					text02:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					text02:SetFontStyle('Medium')
					text02:SetFontSize(35)
					text02:SetTintColor(gamecolor(255,255,255,1))
					text02:SetHorizontalAlignment(textHorizontalAlignment.Center)
					text02:SetVerticalAlignment(textVerticalAlignment.Center)
					text02:SetMargin(inkMargin.new({ left = 50, top = 100 }))
					text02:Reparent(canvas,-1)
					
					
					
					local text03 = inkText.new()
					text03:SetName(CName.new("text_house_new_desc"))
					text03:SetText(splitByChunk(nextstep.desc,50))
					
					text03:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
					text03:SetFontStyle('Medium')
					text03:SetFontSize(35)
					text03:SetTintColor(gamecolor(255,255,255,1))
					text03:SetHorizontalAlignment(textHorizontalAlignment.Center)
					text03:SetVerticalAlignment(textVerticalAlignment.Center)
					text03:SetMargin(inkMargin.new({ left = 50, top = 150 }))
					text03:Reparent(canvas,-1)
					
					
					
					
					local buttonData = {
						name = "text_house_new_buy",
						text = "Upgrade !",
						value = 1,
						tag =  "text_house_new_buy"
					}
					local fontsize = uifont
					local blackbgcolor = Color.ToHDRColorDirect(Color.new({ Red = 0, Green = 0, Blue = 0, Alpha = 1.0 }))
					local goldtextcolor = Color.ToHDRColorDirect(Color.new({ Red = 255, Green = 220, Blue = 16, Alpha = 1.0 }))
					local buy_btn= UIButton.Create(buttonData.name, buttonData.text,50, 300, 100,{top=420,left=650},blackbgcolor,goldtextcolor)
					buy_btn:Reparent(canvas, -1)
					buy_btn:RegisterCallback('OnRelease', function(button, evt)
						local onenter_action = {}
						local action = {}
						action.name = "remove_money"
						action.value = nextstep.price
						table.insert(onenter_action,action)
						local action = {}
						action.name = "notify"
						action.value = "Upgrade installed !"
						table.insert(onenter_action,action)
						local action = {}
						action.name = "current_place_clear_all_template"
						table.insert(onenter_action,action)
						local action = {}
						action.name = "set_variable"
						action.variable = currentHouse.tag
						action.key = "step"
						action.value = housesttep+1
						table.insert(onenter_action,action)
						local action = {}
						action.name = "current_place_apply_template"
						action.tag = nextstep.template
						action.x = nextstep.anchor.x
						action.y = nextstep.anchor.y
						action.z = nextstep.anchor.z
						table.insert(onenter_action,action)
						
						runActionList(onenter_action, "test_onenter", "interact",false,"nothing",false)
						local linkController = LinkController
						if linkController ~= nil then
							linkController:SetLinkAddress("NETdir://ezestates.web/for_rent")
							self.lastClickedLinkAddress = linkController:GetLinkAddress()
							CurrentAddress = "NETdir://ezestates.web/for_rent"
							BrowserCustomPlace = nil
							self:CallCustomCallback("OnLinkPressed")
							else 
							logme(2,"Missing LinkController for a widget [" + NameToString(inkWidgetRef.GetName(self.textList[1])) + "]")
						end
						evt:Handle()
					end)
				end
			end
			
			
		end
		
	end
end		

function PopupsManager_OnShardRead(self,evt)
	print("Yahoo")
end

function BrowserController_OnPageSpawned(thos, widget, userData)
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["BrowserController"]  = thos
	-- if(CurrentAddress == "CyberScript") then
	-- inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod");
	-- end
	
	-- if(CurrentAddress == "CyberScript" and BrowserCybserscript ~= nil) then
	-- inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/"..BrowserCybserscript);
	-- end
	
	if(CurrentAddress == "CyberScriptWeb") then
		inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/search");
	end
	
	if(CurrentAddress == "CyberScriptWeb" and BrowserCybserscript ~= nil) then
		inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/search/site/"..BrowserCybserscript);
	end
	if(CurrentAddress == "NETdir://ezestates.web/makeovers" and BrowserCustomPlace ~= nil) then
		if(BrowserCustomPlace == "template") then
			inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/makeovers")
			else
			inkTextRef.SetText(thos.addressText, "NETdir://cyberscript.mod/estates")
		end
		
	end
end
--endregion Browser
function WorldMapTooltipController_SetData(self,data,menu)
	
	if(observerthread == true or moddisabled  == true)   then return end
	local mappinVariant = nil
	
	if( data.mappin ~= nil) then
		
		mappinVariant = data.mappin:GetVariant()
		
	end
	
	if mappinVariant ~= nil and mappinVariant == gamedataMappinVariant.FixerVariant and fixeroldText == nil then fixeroldText = self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):GetText() end
	print(fixeroldText) 
	
	if(SelectedScriptMappin ~= nil) then
		
		if(mappinVariant ~= nil and mappinVariant == gamedataMappinVariant.FixerVariant and SelectedScriptMappin.tag ~= nil) then
			
			local fixer = getFixerByTag(SelectedScriptMappin.tag)
			if(fixer ~= nil) then
				-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetVisible(true)
				-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(1):SetVisible(true)
				
				-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(2):SetVisible(false)
				-- self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(3):SetVisible(false)
				
				self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetText("Cyberscript Fixer")
				
				inkTextRef.SetText(self.gigBarCompletedText, "100")
				inkTextRef.SetText(self.gigBarTotalText, "100")
				self.gigProgress = 1
				
				
				inkWidgetRef.SetVisible(self.fixerPanel, true)
				inkImageRef.SetVisible(self.icon, false)
				
				self.descText:SetText("")
				
                self:PlayAnim("OnTooltipIntro", "OnFixerProgressBarAnim");
				else
				
			end
			else
			inkImageRef.SetVisible(self.icon, true)
			self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetText(fixeroldText)print(fixeroldText)
			
		end
		else
		if(mappinVariant ~= nil and mappinVariant == gamedataMappinVariant.FixerVariant) then self.fixerPanel.widget:GetWidgetByIndex(1):GetWidgetByIndex(0):SetText(fixeroldText) end
		inkWidgetRef.SetVisible(self.icon, true)
	end
end

function WorldMapTooltipContainer_SetData(self,target,data,menu)
	if(observerthread == true or moddisabled  == true)   then return end
	local displayXYZ = getUserSetting("displayXYZ")
	local mappinVariant = nil
	
	if( data.mappin ~= nil) then
		
		mappinVariant = data.mappin:GetVariant()
		
	end
	
	if(SelectedMappinHouse ~= nil or SelectedMappinMetro ~= nil or SelectedScriptMappin ~= nil) then
		inkWidgetRef.SetVisible(self.defaultTooltipController.descText, true)
		if(SelectedMappinHouse ~= nil) then
			inkTextRef.SetText(self.defaultTooltipController.titleText, SelectedMappinHouse.name)
			local desc = getLang("bebought")..tostring(SelectedMappinHouse.isbuyable)
			desc = desc.."\n"..getLang("price")..tostring(SelectedMappinHouse.price)
			desc = desc.."\n"..getLang("canhavebusiness")..tostring(SelectedMappinHouse.isrentable)
			desc = desc.."\n"..getLang("defaultsalary")..tostring(SelectedMappinHouse.rent)
			desc = desc.."\n"..getLang("prestige")..tostring(SelectedMappinHouse.coef)
			local position = ActivecustomMappin:GetWorldPosition()
			local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
			if(displayXYZ ~= nil and displayXYZ == 1) then
				inkTextRef.SetText(self.defaultTooltipController.descText, desc..postext)
				else
				inkTextRef.SetText(self.defaultTooltipController.descText, desc)
			end
			SelectedMappinHouse = nil
			elseif(SelectedMappinMetro ~= nil) then
			inkTextRef.SetText(self.titleText, getLang("metro_station")..SelectedMappinMetro.name)
			local desc = getLang("metro_available")
			local position = ActivecustomMappin:GetWorldPosition()
			local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
			if(displayXYZ ~= nil and displayXYZ == 1) then
				inkTextRef.SetText(self.defaultTooltipController.descText, desc..postext)
				else
				inkTextRef.SetText(self.defaultTooltipController.descText, desc)
			end
			SelectedMappinMetro = nil
			elseif(SelectedScriptMappin ~= nil) then
			
			inkTextRef.SetText(self.defaultTooltipController.titleText, getLang(SelectedScriptMappin.title))
			if(ActivecustomMappin ~= nil) then
				if(displayXYZ ~= nil and displayXYZ == 1) then
					local position = ActivecustomMappin:GetWorldPosition()
					local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
					
					inkTextRef.SetText(self.defaultTooltipController.descText, getLang(SelectedScriptMappin.desc)..postext)
					else
					inkTextRef.SetText(self.defaultTooltipController.descText, getLang(SelectedScriptMappin.desc))
				end
			end
			SelectedScriptMappin = nil
		end
		else
		if(ActivecustomMappin ~= nil) then
			local position = ActivecustomMappin:GetWorldPosition()
			local postext = "\n X :"..math.floor(position.x).." \n Y: "..math.floor(position.y).." \n Z: "..math.floor(position.z)
			if(displayXYZ ~= nil and displayXYZ == 1) then
				inkWidgetRef.SetVisible(self.defaultTooltipController.descText, true)
				inkTextRef.SetText(self.defaultTooltipController.descText,  self.defaultTooltipController.descText:GetText()..postext)
			end
		end
	end
end

function WorldMapMenuGameController_UntrackCustomPositionMappin(self)
	if(observerthread == true or moddisabled  == true)   then return end
	ActivecustomMappin = nil
	--logme(2,"obs3")
end

function BraindanceGameController_OnInitialize(self)
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["BraindanceGameController"]  = self
	
	GameController["BraindanceGameControllerRoot"] = self:GetRootWidget().parentWidget
	
	
	
	
end

function QuestTrackerGameController_OnInitialize()
	
	if(observerthread == true or moddisabled  == true)   then return end
	
	
	
	if not isGameLoaded then
		--logme(2,'Game Session Started')
		isGameLoaded = true
		draw = true
	end
end

function QuestTrackerGameController_OnUninitialize()
	if(observerthread == true or moddisabled  == true)   then return end
	if Game.GetPlayer() == nil then
		--logme(2,'Game Session Ended')
		workerTable = {}
		despawnAll()
		isGameLoaded = false
		draw = false
	end
end

function interactionWidgetGameController_OnInitialize(self)
	if(observerthread == true or moddisabled  == true)   then return end
	Cron.NextTick(function()
		
		GameController["interactionWidgetGameController"]  = self
		--logme(2,"new interact hub")
	end)
end

function ChattersGameController_OnInitialize(self) 
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["ChattersGameController"]  = self
	
	--logme(2,"Chat Sub Controller Init")
	
end

function ChattersGameController_OnPlayerAttach(self,playerGameObject) 
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["ChattersGameController"]  = self
	
	--logme(2,"Chat Sub Controller Init")
end

function SubtitlesGameController_OnInitialize(self) 
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["SubtitlesGameController"]  = self
end


function interactionWidgetGameController_OnItemSpawned(self)
	if(observerthread == true or moddisabled  == true)   then return end
	if(GameController["interactionWidgetGameController"] == nil) then
		Cron.NextTick(function()
			
			GameController["interactionWidgetGameController"]  = self
			logme(2,"new interact hub")
		end)
	end
end

function ChattersGameController_SetupLine(self) 
	if(observerthread == true or moddisabled  == true)   then return end
	if(currentChattersGameController == nil) then
		--logme(2,"obs99")
		Cron.NextTick(function()
			
			GameController["ChattersGameController"]  = self
			logme(2,"Chat Sub Controller Init")
		end)
	end
end

function SubtitlesGameController_SetupLine(self) 
	if(observerthread == true or moddisabled  == true)   then return end
	if(currentSubtitlesGameController == nil) then
		Cron.NextTick(function()
			
			GameController["SubtitlesGameController"]  = self
			logme(2,"Sub Controller Init")
		end)
	end
end

function BaseSubtitlesGameController_OnUninitialize(self) 
	if(observerthread == true or moddisabled  == true)   then return end
	currentChattersGameController = nil
	currentSubtitlesGameController = nil
end


function NPCPuppet_SendAfterDeathOrDefeatEvent(target)
	if(observerthread == true or moddisabled  == true)   then return end
	-- ----print("target.shouldDie".." "..tostring(target.shouldDie))
	-- ----print("target.myKiller ~= nil".." "..tostring(target.myKiller ~= nil))
	-- ----print("target.myKiller:GetEntityID().hash == Game.GetPlayer():GetEntityID().hash".." "..tostring(target.myKiller:GetEntityID().hash == Game.GetPlayer():GetEntityID().hash))
	-- ----print("target.wasJustKilledOrDefeated".." "..tostring(target.wasJustKilledOrDefeated))
	
	local obj = getEntityFromManagerById(target:GetEntityID())
	if(obj.id ~= nil) then
		
		-- ----print("mykill "..obj.tag)
		
	end
	
	
	if target ~= nil and ((target.myKiller ~= nil and target.myKiller:GetEntityID().hash == Game.GetPlayer():GetEntityID().hash) or target.wasJustKilledOrDefeated) then
		
		if(obj.id ~= nil) then
			
			cyberscript.EntityManager["last_killed"].tweak =  obj.tweak
			else
			cyberscript.EntityManager["last_killed"].tweak = "none"
		end
		
		if cyberscript.EntityManager["last_killed"].isquest == nil then cyberscript.EntityManager["last_killed"].isquest = false end
		
		cyberscript.EntityManager["last_killed"].id = nil
		
		cyberscript.EntityManager["last_killed"].id = target:GetEntityID()
		
		target:MarkAsQuest(cyberscript.EntityManager["last_killed"].isquest)
		
		-- ----print("LAST KILLED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
		lastTargetKilled = target
		
	end
end




function MessengerGameController_OnInitialize(this) 
	
	GameController["MessengerGameController"] = this
end



function PhoneDialerGameController_PopulateData(thos,contactDataArray)
	
	if(observerthread == true or moddisabled  == true)   then return end
	
	
	
	
	
	if(#contactList > 0) then
		for i = 1, #contactList do
			local itemData = ContactData.new()
			itemData.id = contactList[i].id
			itemData.localizedName  = contactList[i].name
			itemData.avatarID = TweakDBID.new(contactList[i].avatarID)
			itemData.questRelated  =  false
			itemData.hasMessages   =  true
			itemData.isCallable = true
			itemData.unreadMessegeCount  = 0
			itemData.unreadMessages  = {}
			itemData.playerCanReply   =  false
			itemData.playerIsLastSender   =  false
			itemData.lastMesssagePreview  =  "CyberScript"
			itemData.threadsCount  = 0
			
			itemData.hash  = 0
			itemData.type = MessengerContactType.Contact
			
			
			
			table.insert(contactDataArray,itemData)
		end
	end
	
	
	if GetMod('corruptNCPD') then 
		
		local corruptNCPD= GetMod('corruptNCPD')			
		
		for name, data in pairs(corruptNCPD.messenger.contacts) do
			local c = ContactData.new()
			c.id = "trainer_fred"
			c.avatarID = TweakDBID.new("PhoneAvatars.Avatar_Unknown")
			c.localizedName = CorruptNCPDLang.getText(data.name)
			c.hash = data.hash
			c.timeStamp = Game.GetTimeSystem():GetGameTime()
			c.questRelated = EnumInt(Game.GetScriptableSystemsContainer():Get("PreventionSystem"):GetHeatStage()) ~= 0
			table.insert(contactDataArray, c)
		end
		
		
	end
	
	
	
	thos.dataView:EnableSorting();
	thos.dataSource:Reset(contactDataArray);
	thos.dataView:DisableSorting();
	thos.firstInit = true;
	thos.indexToSelect = 0 
	--	----printGameDump(_.dataView))
end

--for one selected contact
function NewHudPhoneGameController_ShowSelectedContactMessages(this,contactData) 
	print("NewHudPhoneGameController_ShowSelectedContactMessages")
	GameController["NewHudPhoneGameController"] = this
end

function NewHudPhoneGameController_GotoSmsMessenger(this,contactData) 
	print("NewHudPhoneGameController_GotoSmsMessenger")
	GameController["NewHudPhoneGameController"] = this
	
end

function NewHudPhoneGameController_RefreshSmsMessager(this,contactData) 
	print("NewHudPhoneGameController_RefreshSmsMessager")
	GameController["NewHudPhoneGameController"] = this
	local contact  = this.contactListLogicController:GetSelectedContactData()
	currentPhoneConversation = nil
	
	for k,v in pairs(cyberscript.cache["phone_dialog"]) do
		local phoneConversation = v.data
		for z=1,#phoneConversation.conversation do
			local conversation = phoneConversation.conversation[z]
			if(conversation.tag == contact.id)then
				currentPhoneConversation = phoneConversation.conversation[z]
				currentPhoneConversation.currentchoices = {}
				currentPhoneConversation.speaker = phoneConversation.speaker
				logme(10,conversation.tag)
				currentPhoneConversation.loaded = 0
				onlineReceiver = nil
				
			end
		end
	end
	
	
end

function NewHudPhoneGameController_FocusSmsMessenger(this) 
	print("NewHudPhoneGameController_FocusSmsMessenger")
	GameController["NewHudPhoneGameController"] = this
end

function NewHudPhoneGameController_OnSmsMessageGotFocus(this,evt)
	print("NewHudPhoneGameController_OnSmsMessageGotFocus")
	GameController["NewHudPhoneGameController"] = this
	-- local contact  = this.contactListLogicController:GetSelectedContactData()
	-- logme(10,GameDump(contact))
	-- currentPhoneConversation = nil
	
	-- for k,v in pairs(cyberscript.cache["phone_dialog"]) do
	-- local phoneConversation = v.data
	-- for z=1,#phoneConversation.conversation do
	-- local conversation = phoneConversation.conversation[z]
	-- if(conversation.tag == contact.id)then
	-- currentPhoneConversation = phoneConversation.conversation[z]
	-- currentPhoneConversation.currentchoices = {}
	-- logme(10,conversation.tag)
	-- currentPhoneConversation.loaded = 0
	-- onlineReceiver = nil
	
	-- end
	-- end
	-- end
	
	
end
function NewHudPhoneGameController_ExecuteAction(this,types) 
	print("NewHudPhoneGameController_ExecuteAction")
	GameController["NewHudPhoneGameController"] = this
end
function NewHudPhoneGameController_ToggleShowAllMessages(this,types) 
	print("NewHudPhoneGameController_ToggleShowAllMessages"..dump(types))
	GameController["NewHudPhoneGameController"] = this
	local dots = ContactData.new()
	local messages = {}
	this.screenType = types;
    
	if( this.screenType == PhoneScreenType.Unread) then
		messages = MessengerUtils.GetSimpleContactDataArray(this.journalMgr, true, true, this.isShowingAllMessages);
		dots = this:CreateFakeContactData(#messages)
		
		-- local itemData = ContactData.new()
		-- itemData.id = "cm_test"
		-- itemData.localizedName  = "Hello NightCity Thread !!!"
		-- itemData.localizedPreview  = "Hello NightCity 2 !!!"
		-- itemData.avatarID = TweakDBID.new("PhoneAvatars.Avatar_Unknown")
		-- itemData.questRelated  =  false
		-- itemData.hasQuestImportantReply  =  false
		-- itemData.hasMessages   =  true
		-- itemData.isCallable = true
		-- itemData.unreadMessegeCount  = 5
		-- itemData.unreadMessages  = {}
		-- itemData.playerCanReply   =  false
		-- itemData.playerIsLastSender   =  false
		-- itemData.lastMesssagePreview  =  "CyberScript"
		-- itemData.threadsCount  = 0
		-- itemData.conversationHash=0
		-- itemData.hash  = 0
		-- itemData.type = MessengerContactType.MultiThread
		
		-- table.insert(messages, itemData)
		
		for k,v in pairs(cyberscript.cache["phone_dialog"]) do
			local phoneConversation = v.data
			
			
			if(getScoreKey(phoneConversation.tag,"unlocked") == nil or getScoreKey(phoneConversation.tag,"unlocked") == 1) then
				
				if phoneConversation.hash == nil then
					cyberscript.cache["phone_dialog"][k].data.hash = 0 - tonumber("1308"..math.random(1,999))
					
					phoneConversation.hash = cyberscript.cache["phone_dialog"][k].data.hash
				end
				
				
				for z=1,#phoneConversation.conversation do
					unreadcount = 0
					local unreadMessages  = {}
					local playerCanReply  = false
					local conversation = phoneConversation.conversation[z]
					if(getScoreKey(conversation.tag,"unlocked") == nil or getScoreKey(conversation.tag,"unlocked") == 1) then
						if(conversation.message ~= nil and #conversation.message>0) then
							for y=1,#conversation.message do
								if(conversation.message[y].readed == false and (getScoreKey(conversation.message[y].tag,"unlocked") == nil or getScoreKey(conversation.message[y].tag,"unlocked") == 1)) then
									unreadcount = unreadcount + 1
									table.insert(unreadMessages ,unreadcount)
									playerCanReply   =  true
								end
							end
						end
						
						
						local itemData = ContactData.new()
						itemData.id = conversation.tag
						itemData.localizedName  =  getLang(phoneConversation.speaker)
						itemData.localizedPreview  =  conversation.name
						itemData.avatarID = TweakDBID.new("PhoneAvatars.Avatar_Unknown")
						itemData.questRelated  =  false
						itemData.hasQuestImportantReply  =  false
						itemData.hasMessages   =  true
						itemData.isCallable = false
						itemData.unreadMessegeCount  = unreadcount
						itemData.unreadMessages  = unreadMessages
						itemData.playerCanReply   =  playerCanReply
						itemData.playerIsLastSender   =  false
						itemData.lastMesssagePreview  =  conversation.name
						itemData.threadsCount  = 0
						cyberscript.cache["phone_dialog"][k].data.conversation[z].hash =0 - tonumber(tostring(phoneConversation.hash)..math.random(1,100))
						cyberscript.cache["phone_dialog"][k].data.conversation[z].conversationHash =0 - tonumber(tostring(phoneConversation.hash)..math.random(1,100))
						itemData.conversationHash=cyberscript.cache["phone_dialog"][k].data.conversation[z].conversationHash
						itemData.hash  =cyberscript.cache["phone_dialog"][k].data.conversation[z].hash
						itemData.type = MessengerContactType.MultiThread
						itemData.timeStamp = Game.GetTimeSystem():GetGameTime()
						table.insert(messages, itemData)
					end
				end
			end
		end
		
		table.insert(messages, dots)
		for k,v in ipairs(messages) do 
			
			logme(10,GameDump(v))
			
		end
		
		this.contactListLogicController:UpdateShowAllButton(this.isShowingAllMessages);
		this.contactListLogicController:SetSortMethod(ContactsSortMethod.ByTime);
		this.contactListLogicController:PopulateListData(messages, this.indexToSelect, this.messageToOpenHash);
		this.contactListLogicController:SwtichTabs(PhoneDialerTabs.Unread);
		this:HideThreads();
		
		
	end
	
    
	
end
function MessengerGameController_PopulateData(thos) 
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["MessengerGameController"] = thos
	if(thos.f_sortOrder ~= nil or thos.sortOrder ~= nil) then
		
		logme(4,"flib sort mod is enabled, custom message is disabled")
		else
		print("tsetdsgshshnj")
		local data = MessengerUtils.GetContactDataArray(thos.journalManager,true,true,thos.activeData)
		
		for k,v in pairs(cyberscript.cache["phone_dialog"]) do
			local phoneConversation = v.data
			
			
			if(getScoreKey(phoneConversation.tag,"unlocked") == nil or getScoreKey(phoneConversation.tag,"unlocked") == 1) then
				
				if phoneConversation.hash == nil then
					cyberscript.cache["phone_dialog"][k].data.hash = 0 - tonumber("1308"..math.random(1,999))
					
					phoneConversation.hash = cyberscript.cache["phone_dialog"][k].data.hash
				end
				local itemData = ContactData.new()
				itemData.id = phoneConversation.tag
				itemData.localizedName  = phoneConversation.speaker
				itemData.avatarID = TweakDBID.new("Character.Judy")
				itemData.questRelated  =  false
				local unreadcount = 0
				itemData.unreadMessages  = {}
				for z=1,#phoneConversation.conversation do
					if(phoneConversation.conversation[z].message ~= nil and #phoneConversation.conversation[z].message >0) then
						for y=1,#phoneConversation.conversation[z].message do
							if(phoneConversation.conversation[z].message[y].readed == false and (getScoreKey(phoneConversation.conversation[z].message[y].tag,"unlocked") == nil or getScoreKey(phoneConversation.conversation[z].message[y].tag,"unlocked") == 1)) then
								unreadcount = unreadcount + 1
								table.insert(itemData.unreadMessages ,unreadcount)
								itemData.playerCanReply   =  true
							end
						end
					end
				end
				itemData.hasMessages   =  true
				itemData.unreadMessegeCount  = unreadcount
				itemData.playerIsLastSender   =  false
				itemData.lastMesssagePreview  =  "Cyberpunk Multiverse"
				itemData.threadsCount  = #phoneConversation.conversation
				itemData.timeStamp = Game.GetTimeSystem():GetGameTime()
				itemData.hash = phoneConversation.hash
				local contactVirtualListData =  VirutalNestedListData.new()
				contactVirtualListData.level =  phoneConversation.hash
				contactVirtualListData.widgetType = 0
				contactVirtualListData.isHeader = true
				contactVirtualListData.data = itemData
				contactVirtualListData.collapsable = true
				table.insert(data,contactVirtualListData)
				for z=1,#phoneConversation.conversation do
					unreadcount = 0
					itemData.unreadMessages  = {}
					local conversation = phoneConversation.conversation[z]
					if(getScoreKey(conversation.tag,"unlocked") == nil or getScoreKey(conversation.tag,"unlocked") == 1) then
						if(conversation.message ~= nil and #conversation.message>0) then
							for y=1,#conversation.message do
								if(conversation.message[y].readed == false and (getScoreKey(conversation.message[y].tag,"unlocked") == nil or getScoreKey(conversation.message[y].tag,"unlocked") == 1)) then
									unreadcount = unreadcount + 1
									table.insert(itemData.unreadMessages ,unreadcount)
									itemData.playerCanReply   =  true
								end
							end
						end
						local itemData = ContactData.new()
						itemData.id = conversation.tag
						itemData.localizedName  = conversation.name
						itemData.avatarID = TweakDBID.new("Character.Judy")
						itemData.questRelated  =  false
						itemData.hasMessages   =  true
						itemData.unreadMessegeCount  = unreadcount
						itemData.playerIsLastSender   =  false
						itemData.lastMesssagePreview  =  "Cyberpunk Multiverse"
						cyberscript.cache["phone_dialog"][k].data.conversation[z].hash =0 - tonumber(tostring(phoneConversation.hash)..math.random(1,100))
						conversation.hash = cyberscript.cache["phone_dialog"][k].data.conversation[z].hash
						
						itemData.threadsCount  = 0
						itemData.timeStamp = Game.GetTimeSystem():GetGameTime()
						itemData.hash = conversation.hash
						local contactVirtualListData =  VirutalNestedListData.new()
						contactVirtualListData.level = phoneConversation.hash
						contactVirtualListData.widgetType = 1
						contactVirtualListData.isHeader = false
						contactVirtualListData.data = itemData
						contactVirtualListData.collapsable = false
						table.insert(data,contactVirtualListData)
					end
				end
			end
		end
		thos.listController:SetData(data, true)
	end
end

---part3
function MessengerGameController_OnContactActivated(self,evt) 
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["MessengerGameController"] = self
	logme(1,"MessengerGameController.OnContactActivated")
	
	--if(currentSubtController == nil) then
	currentPhoneConversation = nil
	if (messageprocessing == false) then
		messageprocessing = true
		logme(2,tostring(evt.type))
		if (string.find(tostring(evt.entryHash), "1308")and evt.type == MessengerContactType.Thread) then
			for k,v in pairs(cyberscript.cache["phone_dialog"]) do
				local phoneConversation = v.data
				for z=1,#phoneConversation.conversation do
					local conversation = phoneConversation.conversation[z]
					if(conversation.hash == evt.entryHash)then
						currentPhoneConversation = phoneConversation.conversation[z]
						currentPhoneConversation.currentchoices = {}
						currentPhoneConversation.speaker = phoneConversation.speaker
						logme(10,GameDump(evt))
						currentPhoneConversation.loaded = 0
						onlineReceiver = nil
						local test = gameJournalPhoneMessage.new()
						self.dialogController:ShowThread(test)
					end
				end
			end
			-- if(MultiplayerOn and OnlineConversation ~= nil) then
			-- for z=1,#OnlineConversation.conversation do
			-- local conversation = OnlineConversation.conversation[z]
			-- if(conversation.hash == evt.entryHash)then
			-- currentPhoneConversation = OnlineConversation.conversation[z]
			-- currentPhoneConversation.currentchoices = {}
			-- currentPhoneConversation.loaded = 0
			-- onlineReceiver = OnlineConversation.conversation[z].name
			-- local test = gameJournalPhoneMessage.new()
			-- self.dialogController:ShowThread(test)
			-- end
			-- end
			-- end
			else
			currentPhoneConversation = nil
			onlineReceiver = nil
		end
		messageprocessing = false
	end
end

function MessengerDialogViewController_SetVisited(thos, records) 
	if(observerthread == true or moddisabled  == true)   then return end
	print("MessengerDialogViewController_SetVisited"..dump(records))
	local messages = thos.messages
	local choices = thos.replyOptions
	
	
	GameController["MessengerDialogViewController"]  = thos
	if(currentPhoneConversation ~= nil) then
		
		if(currentPhoneConversation ~= nil ) then
			
			
			
			
			for i=1,#currentPhoneConversation.message do
				local msgexist = false
				local sms = currentPhoneConversation.message[i]
				if( getScoreKey(sms.tag,"unlocked") == 1) then
					if(sms.unlocknext ~= nil and sms.unlocknext ~= "") then
					--	setScore(sms.unlocknext,"unlocked",1)
					end
					local test = gameJournalPhoneMessage.new()
					test.sender = sms.sender
					test.text = getLang(sms.text)
					test.delay = -9999
					test.id = sms.tag
					for y=1,#messages do
						if(test.id == messages[y].id) then
							msgexist = true
						end
					end
					if(msgexist == false) then
						table.insert(messages,test)
					end
					if(#sms.choices > 0) then
						if(getScoreKey(sms.tag,"unlocked") == 1) then
							for z=1,#sms.choices do
								local reply = sms.choices[z]
								logme(2,reply.tag)
								if((getScoreKey(reply.tag,"unlocked") == 0 or getScoreKey(reply.tag,"unlocked") == nil ) and checkTriggerRequirement(reply.requirement,reply.trigger)) then
									local test2 = gameJournalPhoneMessage.new()
									test2.sender = 1
									test2.text = getLang(reply.text)
									test2.delay = -9999
									test2.id = reply.tag
									reply.parent = sms.tag
									table.insert(currentPhoneConversation.currentchoices,reply)
									table.insert(choices,test2)
								end
							end
						end
					end
					--	------print#thos.messages)
				end
			end
			thos.messages = messages
			thos.replyOptions = choices
		end
	end
end

function MessengerDialogViewController_AttachJournalManager(thos, journalManager) 
	
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["MessengerDialogViewController"]  = thos
	
end

function MessengerDialogViewController_OnInitialize(thos) 
	if(observerthread == true or moddisabled  == true)   then return end
	
	GameController["MessengerDialogViewController"]  = thos
	
end

function PhoneMessagePopupGameController_SetupData(this,wrappedMethod)
	if(observerthread == true or moddisabled  == true)   then return end
	
	GameController["PhoneMessagePopupGameController"] = this
	logme(1,"currentPhoneConversation"..tostring(currentPhoneConversation))
	if(currentPhoneConversation ~= nil and currentPhoneConversation ~= "cs_nothing" 
	and GameController["NewHudPhoneGameController"]:IsPhoneActive() == false) then
	
	logme(1,"Open phone")
	local test = gameJournalPhoneMessage.new()
	Cron.After(0.1,function()
		logme(1,"dddd")
		GameController["PhoneMessagePopupGameController"]:UnregisterFromGlobalInputCallback("OnPostOnRelease", GameController["PhoneMessagePopupGameController"], "OnHandleMenuInput");
		PopupStateUtils.SetBackgroundBlur(GameController["PhoneMessagePopupGameController"], false);
		GameController["PhoneMessagePopupGameController"].uiSystem:PopGameContext(UIGameContext.ModalPopup);
		GameController["PhoneMessagePopupGameController"].uiSystem:RestorePreviousVisualState("inkModalPopupState");
		GameController["PhoneMessagePopupGameController"]:SetTimeDilatation(false);
		GameController["PhoneMessagePopupGameController"]:RequestUnfocus()
		GameController["PhoneMessagePopupGameController"]:HandleCommonInputActions("cancel")
		GameController["PhoneMessagePopupGameController"]:ClosePopup()
		Cron.After(0.1,function()
			GameController["NewHudPhoneGameController"].PhoneSystem:QueueRequest( UsePhoneRequest.new());
			uiActionPerformed= DPADActionPerformed.new()
            uiActionPerformed.successful = true;
            uiActionPerformed.state = EUIActionState.COMPLETED;
            GameController["NewHudPhoneGameController"].buttonPressed = false;
            Game.GetUISystem():QueueEvent(uiActionPerformed);
			
		end)
	end)
	
	
	
	
	else
	
	if(currentPhoneConversation ~= nil and currentPhoneConversation == "cs_nothing") then
		logme(1,"not open phone")
		Cron.After(0.5,function()
			logme(1,"aaaa")
			GameController["PhoneMessagePopupGameController"]:UnregisterFromGlobalInputCallback("OnPostOnRelease", GameController["PhoneMessagePopupGameController"], "OnHandleMenuInput");
			PopupStateUtils.SetBackgroundBlur(GameController["PhoneMessagePopupGameController"], false);
			GameController["PhoneMessagePopupGameController"].uiSystem:PopGameContext(UIGameContext.ModalPopup);
			GameController["PhoneMessagePopupGameController"].uiSystem:RestorePreviousVisualState("inkModalPopupState");
			GameController["PhoneMessagePopupGameController"]:SetTimeDilatation(false);
			GameController["PhoneMessagePopupGameController"]:RequestUnfocus()
			GameController["PhoneMessagePopupGameController"]:HandleCommonInputActions("cancel")
			GameController["PhoneMessagePopupGameController"]:ClosePopup()
			
		end)
		
		else
		if(currentPhoneConversation ~= nil and currentPhoneConversation ~= "cs_nothing" and GameController["NewHudPhoneGameController"]:IsPhoneActive() == true
		)then
		logme(1,"load conv")
		
		local test = gameJournalPhoneMessage.new()
		this.dialogViewController:ShowThread(test)
		else
		logme(1,"wrappedMethod")
		wrappedMethod()
		end
		
	end
	end
	
end

function MessengerDialogViewController_ShowThread(self,thread)
	if(observerthread == true or moddisabled  == true)   then return end
	logme(1,"MessengerDialogViewController_ShowThread")
	if(currentPhoneConversation ~= nil) then
		if(thread == nil) then
			local message = {}
			logme(1,currentPhoneConversation)
			table.insert(message,currentPhoneConversation)
			self.messages = message
		end
	end
end

function MessengerDialogViewController_ShowDialog(self,contact)
	if(observerthread == true or moddisabled  == true)   then return end
	if(currentPhoneConversation ~= nil) then
		logme(10,"test2")
		if(contact == nil) then
			local message = {}
			logme(10,"test2")
			table.insert(message,currentPhoneConversation)
			self.messages = message
			
		end
	end
end

function MessengerDialogViewController_UpdateData(self,animateLastMessage,setVisited)
	logme(1,"MessengerDialogViewController_UpdateData")
	Cron.NextTick(function()
		
		if(observerthread == true or moddisabled  == true)   then return end
		logme(10,GameDump(self))
	
		if(currentPhoneConversation ~= nil) then
			if(contact == nil) then
				local message = {}
				logme(10,"test3")
				print("sss"..dump(currentPhoneConversation))
				table.insert(message,currentPhoneConversation)
				self.messages = message
				
				
			end
		end
		
		if waitingforanswer ~= nil then
		
		self.typingIndicatorController:SetName(currentPhoneConversation.speaker);
		 self.typingIndicatorController:SetPlayerTypingStyle(false);
		 self:PlayDotsAnimation();
		  for i = 1, #currentPhoneConversation.currentchoices do
			setScore(currentPhoneConversation.currentchoices[i].tag,"unlocked",2)
		end
		 for i=1,#currentPhoneConversation.message do
				local msgexist = false
				local sms = currentPhoneConversation.message[i]
				if( getScoreKey(sms.tag,"unlocked") == 1) then
					if(sms.unlocknext ~= nil and sms.unlocknext ~= "") then
						setScore(sms.unlocknext,"unlocked",1)
					end
					
					if(#sms.choices > 0) then
						if(getScoreKey(sms.tag,"unlocked") == 1) then
							for z=1,#sms.choices do
								local reply = sms.choices[z]
								logme(1,reply.tag)
								if((getScoreKey(reply.tag,"unlocked") == 0 or getScoreKey(reply.tag,"unlocked") == nil ) and checkTriggerRequirement(reply.requirement,reply.trigger)) then
									
									table.insert(currentPhoneConversation.currentchoices,reply)
									
								end
							end
						end
					end
					--	------print#thos.messages)
				end
			end
		
		 Cron.After(2, function()
		 
		
		if(waitingforanswer.unlocknext ~= nil and waitingforanswer.unlocknext ~= "") then
			setScore(waitingforanswer.unlocknext,"unlocked",1)
		end
				if(#waitingforanswer.action > 0) then
					runActionList(waitingforanswer.action, waitingforanswer.tag, "interact",false,"nothing",waitingforanswer.action_bypassmenu_execution)
				end
		 

		 waitingforanswer = nil
			self.choicesList:SetVisible(true)
		 self:StopDotsAnimation()
		GameController["MessengerDialogViewController"]:UpdateData()
			end)
		
		end
		
	end)
end

function MessangerItemRenderer_GetData(self)
	if(observerthread == true or moddisabled  == true)   then return end
	Cron.NextTick(function()
		local choicepress = false
		logme(1,"test4")
		if(currentPhoneConversation ~= nil) then
			for i = 1, #currentPhoneConversation.currentchoices do
				logme(10,currentPhoneConversation.currentchoices[i].text)
				logme(10,self.labelPathRef:GetText())
				
				
				if(tostring(getLang(currentPhoneConversation.currentchoices[i].text)) == tostring(self.labelPathRef:GetText())) then
						choicepress = true
					
					if choicepress == true then
						
						GameController["MessengerDialogViewController"]:UpdateData()
						
						break
					end
				end
			end
			
		end
	end)
end

function MessangerReplyItemRenderer_OnDataChanged(self,value)
	if(observerthread == true or moddisabled  == true)   then return end
end

function MessangerItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
	if(observerthread == true or moddisabled  == true)   then return end
	logme(10,"test5")
	logme(10,"MessangerItemRenderer_OnJournalEntryUpdated"..GameDump(entry))
	Cron.NextTick(function()
		local message = entry
		local txt = ""
		local typo =  1
		--	------print"test")
		--	----printmessage.id.."titi")
		if(message.delay == -9999) then
			for i=1,#currentPhoneConversation.message do
				local sms = currentPhoneConversation.message[i]
				
				
				
				if( getScoreKey(sms.tag,"unlocked") == 1) then
					
					if(sms.tag == message.id) then
						checkContext(sms)
						txt = getLang(sms.text)
						if(sms.sender == 0) then
							typo = MessageViewType.Received 
							else
							typo = MessageViewType.Sent
						end
						self:SetMessageView(txt, typo, "")
						if(sms.action ~= nil and #sms.action > 0) then
							runActionList(sms.action, sms.tag, "interact",false,"nothing",sms.action_bypassmenu_execution)
						end
					end
					if(#sms.choices > 0) then
						for z=1,#sms.choices do
							if((getScoreKey(sms.choices[z].tag,"unlocked") == 0 or getScoreKey(sms.choices[z].tag,"unlocked") == nil) and checkTriggerRequirement(sms.choices[z].requirement,sms.choices[z].trigger)) then
								logme(2,getScoreKey(sms.choices[z].tag,"unlocked"))
								logme(2,sms.choices[z].tag)
								
								
								if(sms.choices[z].tag == message.id) then
									checkContext(sms.choices[z].tag)
									
									
									
									txt = sms.choices[z].text
									txt = getLang(txt)
									
									self:SetMessageView(txt, typo, "")
									--	self:SetMessageView(sms.choices[z].text, typo, "")
									inkTextRef.SetText(self.fluffText, sms.choices[z].tag)
									inkTextRef.SetText(self.labelPathRef, txt)
									--				inkTextRef.SetText(thos.m_fluffText, "CHKSUM_" + IntToString(contact.hash));
								end
							end
						end
					end
				end
			end
		end
	end)
end


function MessangerReplyItemRenderer_OnJournalEntryUpdated(self,entry,extraData)
	if(observerthread == true or moddisabled  == true)   then return end
	logme(10,"test6")
	logme(10,"MessangerReplyItemRenderer_OnJournalEntryUpdated"..GameDump(entry))
	Cron.NextTick(function()
		local message = entry
		local txt = ""
		local typo =  1
		
		
		--	------print"test")
		--	----printmessage.id.."titi")
		if(message.delay == -9999) then
			for i=1,#currentPhoneConversation.message do
				local sms = currentPhoneConversation.message[i]
				
				
				
				if( getScoreKey(sms.tag,"unlocked") == 1) then
					if(sms.tag == message.id) then
						checkContext(sms)
						txt = getLang(sms.text)
						if(sms.sender == 0) then
							typo = MessageViewType.Received 
							else
							typo = MessageViewType.Sent
						end
						self:SetMessageView(txt, typo, "")
					end
					if(#sms.choices > 0) then
						for z=1,#sms.choices do
							if((getScoreKey(sms.choices[z].tag,"unlocked") == 0 or getScoreKey(sms.choices[z].tag,"unlocked") == nil) and checkTriggerRequirement(sms.choices[z].requirement,sms.choices[z].trigger)) then
								logme(2,getScoreKey(sms.choices[z].tag,"unlocked"))
								logme(2,sms.choices[z].tag)
								
								
								if(sms.choices[z].tag == message.id) then
									
									checkContext(sms.choices[z])
									
									
									txt = sms.choices[z].text
									txt = getLang(txt)
									
									
									
									inkTextRef.SetText(self.labelPathRef, txt)
									--				inkTextRef.SetText(thos.m_fluffText, "CHKSUM_" + IntToString(contact.hash));
								end
							end
						end
					end
				end
			end
		end
	end)
end



function MessengerDialogViewController_ActivateSelectedReplyOption(self)
	----print("MessengerDialogViewController_ActivateSelectedReplyOption")
end

function MessengerDialogViewController_ActivateReply(self,target)
	
	if(observerthread == true or moddisabled  == true)   then return end
	local choicepress = false
	if(currentPhoneConversation ~= nil) then
		for i = 1, #currentPhoneConversation.currentchoices do
		
			logme(10,currentPhoneConversation.currentchoices[i].text)
			
			
			
			if(tostring(getLang(currentPhoneConversation.currentchoices[i].text)) == tostring(target.labelPathRef:GetText())) then
				
				choicepress = true
				
				if choicepress == true then
				
					
					
					 
					 waitingforanswer = currentPhoneConversation.currentchoices[i]
					self.choicesList:SetVisible(false)
					 setScore(waitingforanswer.unlocknext,"unlocked",1)
					break
				end
			end
		end
		
	end
end

function MessengerDialogViewController_OnPlayerReplyActivated(self,index,target)
	----print("MessengerDialogViewController_OnPlayerReplyActivated")
end










function MenuScenario_HubMenu_OnSelectMenuItem(_, menuItemData)
	if(observerthread == true or moddisabled  == true)   then return end
	--------print"toto"..menuItemData.menuData.label)
	--logme(2,"obs17")
end

function PhoneDialerGameController_CallSelectedContact_Observer(thos,contactData)
	
	GameController["NewHudPhoneGameController"] = thos
	if(observerthread == true or moddisabled  == true)   then return end
	-- let item: ref<PhoneContactItemVirtualController> = thos.m_listController.GetSelectedItem() as PhoneContactItemVirtualController;
	-- let contactData: ref<ContactData> = item.GetContactData();
	-- if IsDefined(contactData) {
	-- callRequest = new questTriggerCallRequest();
	-- callRequest.addressee = StringToName(contactData.id);
	
	logme(10,"found "..contactData.id)
	if(#contactList > 0) then
		for i = 1, #contactList do
			----printcontactData.id)
			if(contactList[i].id == contactData.id) then
				if(contactList[i].phonetype == "NPC") then
					
					
					
					currentNPC = findPhonedNPCByName(contactList[i].truename)
					
					if(currentNPC ~= nil) then
						
						local actionlist = {}
						local action = {}
						action.title = {}
						
						
						local title = getLang("observer_callselectedcontact_msg01")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg02")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg03")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg04")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg05")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg06")
						
						table.insert(action.title,title)
						
						local title = getLang("observer_callselectedcontact_msg07")
						
						table.insert(action.title,title)
						
						action.name = "random_subtitle"
						action.speaker = contactList[i].truename
						
						action.type = 1
						action.target = "player"
						action.duration = 3
						
						table.insert(actionlist,action)
						
						
						
						action = {}
						
						
						
						action.title = getLang("observer_callselectedcontact_v_answer")
						
						
						action.name = "subtitle"
						action.speaker = contactList[i].truename
						
						action.type = 1
						action.target = "player"
						action.duration = 3
						
						table.insert(actionlist,action)
						
						
						action = {}
						
						action.name = "speak_npc"
						action.way = "phone"
						action.speaker = "current_phone_npc"
						
						
						table.insert(actionlist,action)
						
						
						
						runActionList(actionlist,"call_"..contactData.id,"phone",false,"player")
						
						else
						
						logme(10,"can't find currentNPC ".. contactList[i].truename)
						Game.GetPlayer():SetWarningMessage(getLang("observer_callselectedcontact_unknown"))
					end
					
				end
				if(contactList[i].phonetype == "Service") then
					local interact = cyberscript.cache["interact"][contactList[i].id].data
					runActionList(interact.action,interact.tag,"interact",false,"player")
				end
				if(contactList[i].phonetype == "Fixer") then
					local phoned = getFixerByTag(contactData.id)
					if(phoned ~= nil) then
						phonedFixer = true
						phoneAnimFixer = true
						currentfixer = phoned
						
						local actionlist = {}
						local action = {}
						
						action.name = "hacking_notification"
						action.title =  getLang("observer_callselectedcontact_v_answer")
						action.title = getLang("download_quest_from_01")..phoned.name..getLang("download_quest_from_02")
						action.duration = 3
						
						table.insert(actionlist,action)
						
						
						
					end
				end
			end
		end
	end
	
	thos:CloseContactList()
	
	
end

function PhoneSystem_OnTriggerCall(thos, request)
	if(observerthread == true or moddisabled  == true)   then return end
	logme(1,"called")
	logme(1,GameDump(request))
	
	local contactName = request.addressee
	logme(1,"IsNameValid "..tostring(IsNameValid(contactName)))
	if IsNameValid(contactName) == false then
		logme(1,"stopcall")
		
		thos.TriggerCall(questPhoneCallMode.Video, false, "CyberScript", false, questPhoneCallPhase.IncomingCall, false, true)
	end
	
end

function PhoneSystem_TriggerCall(this, callMode, isAudio, contactName, isPlayerCalling, callPhase, isPlayerTriggered, isRejectable, showAvatar, callVisuals) 
	logme(1,"called2")
end

function PhoneSystem_OnUsePhone(thos, request)
	if(observerthread == true or moddisabled  == true)   then return end
	
	
	
	
end

function PhoneDialerGameController_Show(thos)
	
	if(observerthread == true or moddisabled  == true)   then return end
	refreshContact()
	openPhone = true
end

function PhoneDialerGameController_Hide()
	if(observerthread == true or moddisabled  == true)   then return end
	openPhone = false
end

function VehicleRadioPopupGameController_VirtualListReady(self)
	if(observerthread == true or moddisabled  == true)   then return end
	----logme(2,#self.dataSource:GetArray())
	-- 1. Remove stations that are not supported by the radio device
	-- 2. Select currently playing station
	local radio = RadioListItemData.new()
	radio.record = gamedataRadioStation_Record.new()
	print(radio.record:Index())
	for k,v in pairs(cyberscript.cache["radio"]) do
		self.dataSource:AppendItem(radio)
	end
	----logme(2,#self.dataSource:GetArray())
	local stationIndexLimit = Game.EnumValueFromName('ERadioStationList', 'NONE')
	for _, stationItem in ipairs(self.dataSource:GetArray()) do
		---@type RadioStation_Record
		local stationRecord = stationItem.record
		local stationIndex = stationRecord:Index()
		
		if(stationRecord:DisplayName() == "") then
		end
		-- if(stationRecord.tag ~= nil) then
		-- --logme(2,stationRecord.tag)
		-- --logme(2,stationRecord.tag)
		-- end
	end
	self.dataSource:Reset(self.dataSource:GetArray())
end

function VehicleSummonWidgetGameController_OnVehicleSummonStateChanged(state,value ) 
	if(observerthread == true or moddisabled  == true)   then return end
	local vehicleSummonDef = Game.GetAllBlackboardDefs().VehicleSummonData
	local vehicleSummonBB = Game.GetBlackboardSystem():Get(vehicleSummonDef)
	vehicleEntId = vehicleSummonBB:GetEntityID(vehicleSummonDef.SummonedVehicleEntityID)
	----printGameDump(vehicleSummonBB))
	----printdump(vehicleSummonBB))
	local vehi = Game.FindEntityByID(vehicleEntId)
	--local vehicleRecordID = vehicleSummonBB:GetRecordID()
	
	if(calledfromgarage == true) then
		for i=1,#currentSave.garage do
			----printtostring(mygarage[i].asAV))
			
			if(TweakDBID.new(currentSave.garage[i].path).hash == vehi:GetRecordID().hash and currentSave.garage[i].asAV == true) then
				--logme(2,"garage")
				local obj = getEntityFromManager(currentSave.garage[i].tag)
				--	 despawnEntity(currentSave.garage[i].tag)
				-- obj = getEntityFromManager(currentSave.garage[i].tag)
				if(obj.id == nil) then
					--logme(2,"spaaaaaaaace")
					local entity = {}
					entity.id = vehicleEntId
					entity.tag = currentSave.garage[i].tag
					entity.tweak = currentSave.garage[i].path
					entity.takenSeat = {}
					entity.isAV = currentSave.garage[i].asAV
					local veh = Game.FindEntityByID(vehicleEntId)
					entity.availableSeat = GetSeats(veh)
					--entity.availableSeat = {}
					entity.driver = {}
					cyberscript.EntityManager[entity.tag] = entity
					
					
					if(entity.isAV == true) then
						local group =getGroupfromManager("AV")
						if(group.entities == nil) then
							group.entities = {}
						end
						logme(2,"addedAV"..entity.tag)
						table.insert(group.entities,entity.tag)
						
						if(currentSave.garage[i].fakeAV ~= nil and currentSave.garage[i].fakeAV == true) then
							
							local parentpos = vehi:GetWorldPosition()
							spawnVehicleV2("Vehicle.v_sportbike1_yaiba_kusanagi","","fake_av", parentpos.x, parentpos.y ,parentpos.z,99,3,true,false,false,false, 0)
							table.insert(group.entities,"fake_av")
						end
						
						
						local script = {}
						local action = {}
						
						if(currentSave.garage[i].fakeAV ~= nil and currentSave.garage[i].fakeAV == true) then
							action = {}
							action.name = "wait_second"
							action.value = 3
							table.insert(script,action)
							
							action = {}
							action.name = "entity_set_seat"
							action.tag = "player"
							action.vehicle = "fake_av"
							action.seat = "seat_front_left"
							table.insert(script,action)
							
							action = {}
							action.name = "change_custom_condition"
							action.value = "av_cockpit"
							action.score = 0
							
							action = {}
							action.name = "change_camera_position"
							action.x = 0
							action.y = -15
							action.z = 2
							
							
							table.insert(script,action)
							
							else
							action = {}
							action.name = "vehicle_change_doors"
							action.value = "open"
							action.tag = entity.tag
							table.insert(script,action)
							
						end
						
						
						runActionList(script, entity.tag, "interact",false,"engine",false)
					end
					else
					obj.id = vehicleEntId
				end
			end
		end
	end
end

function PopupsManager_OnPlayerAttach(self)
	if(observerthread == true or moddisabled  == true)   then return end
	
	GameController["PopupsManager"]  = self
end

function PopupsManager_OnPlayerDetach()
	if(observerthread == true or moddisabled  == true)   then return end
	radiopopup = nil
end

function RadioStationListItemController_OnDataChanged(self,value)
	if(observerthread == true or moddisabled  == true)   then return end
	-- --logme(2,"thos is it 2")
	-- -- --logme(2,GameDump(self.label))
	-- if(self.stationData.record == nil) then
	-- --logme(2,"mark2")
	-- Cron.NextTick(function()
	-- local radioToPut = nil
	-- for i=1,#testRadio do
	-- if(testRadio[i].enabled == false) then
	-- radioToPut = testRadio[i]
	-- break
	-- end
	-- end
	-- inkTextRef.SetText(self.label, radioToPut.name)
	-- --logme(2,"test")
	-- end)
	-- end
	----logme(2,Dump(value))
end

function VehicleRadioPopupGameController_Activate(self)
	if(observerthread == true or moddisabled  == true)   then return end
	------print("test")
	
	
	if(self.selectedItem.stationData.record == nil or self.selectedItem.stationData.record:DisplayName() == nil or self.selectedItem.stationData.record:DisplayName() == "") then
		
		local radioToPut = nil
		for k,v in pairs(cyberscript.cache["radio"]) do
			
			if(self.selectedItem.label:GetText() == nil or self.selectedItem.label:GetText() == "") then
				if(cyberscript.cache["radio"][k].enabled == false ) then
					currentRadio = cyberscript.cache["radio"][k]
					--		------print(k)
					if(selectedradioIndex ~= nil) then
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, selectedradioIndex)
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, 0)
						else
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, -1)
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, 0)
					end
					
					break
				end
				else
				if(cyberscript.cache["radio"][k].data.name == self.selectedItem.label:GetText() ) then
					currentRadio = cyberscript.cache["radio"][k]
					--	------print(k)
					if(selectedradioIndex ~= nil) then
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, selectedradioIndex)
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, 0)
						else
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, -1)
						GetPlayer():GetQuickSlotsManager():SendRadioEvent(false, false, 0)
					end
					break
				end
			end
		end
		
		else
		selectedradioIndex = self.selectedItem.stationData.record:Index()
		------print("selectedradioIndex"..selectedradioIndex)
		if(currentRadio ~= nil and currentRadio.playedmusic ~= nil) then Stop(currentRadio.playedmusic) end
		currentRadio = nil
		
		
	end
	-- --logme(2,"thos is it 2")
	-- -- --logme(2,GameDump(self.label))
	-- if(self.stationData.record == nil) then
	-- --logme(2,"mark2")
	-- Cron.NextTick(function()
	-- local radioToPut = nil
	-- for i=1,#testRadio do
	-- if(testRadio[i].enabled == false) then
	-- radioToPut = testRadio[i]
	-- break
	-- end
	-- end
	-- inkTextRef.SetText(self.label, radioToPut.name)
	-- --logme(2,"test")
	-- end)
	-- end
	----logme(2,Dump(value))
end

function VehicleRadioPopupGameController_OnScrollChanged(self)
	if(observerthread == true or moddisabled  == true)   then return end
	
	for k,v in pairs(cyberscript.cache["radio"]) do
		cyberscript.cache["radio"][k].enabled = false
	end
	
end

function RadioStationListItemController_OnSelected(self,itemController,discreteNav)
	if(observerthread == true or moddisabled  == true)   then return end
	if(self.stationData.record == nil or self.stationData.record:DisplayName() == nil or self.stationData.record:DisplayName() == "") then
		
		local radioToPut = nil
		for k,v in pairs(cyberscript.cache["radio"]) do
			
			if(self.label:GetText() == nil or self.label:GetText() == "") then
				if(cyberscript.cache["radio"][k].enabled == false ) then
					--	currentRadio = cyberscript.cache["radio"][k]
					--	------print(k)
					--	self.quickSlotsManager:SendRadioEvent(false, false, -1)
					inkTextRef.SetText(self.label, cyberscript.cache["radio"][k].data.name)
					cyberscript.cache["radio"][k].enabled = true
					break
				end
				else
				if(cyberscript.cache["radio"][k].data.name == self.label:GetText() ) then
					--currentRadio = cyberscript.cache["radio"][k]
					
					--	self.quickSlotsManager:SendRadioEvent(false, false, -1)
					break
				end
			end
		end
		
		else
		if(currentRadio ~= nil and currentRadio.playedmusic ~= nil) then Stop(currentRadio.playedmusic) end
		currentRadio = nil
		
		
	end
end

function VehicleRadioPopupGameController_OnClose()
	if(observerthread == true or moddisabled  == true)   then return end
	for k,v in pairs(cyberscript.cache["radio"]) do
		cyberscript.cache["radio"][k].enabled = false
	end
	popupActive = false
end



function PlayerPuppet_OnDeath()
	if(observerthread == true or moddisabled  == true)   then return end
	isdead = true
end


function interactionItemLogicController_SetData(self,data,skillcheck)
	if(observerthread == true or moddisabled  == true)  then return  end
	if(cyberscript.cache["interact"][data.localizedName] ~= nil) then
		local interact = cyberscript.cache["interact"][data.localizedName].data
		
		
		self.label:SetText(getLang(interact.name))
		
		
		if(interact	 ~= nil) then
			
			
			if(	interact.style ~= nil) then
				local fontcolor = interact.style.textcolor
				
				if(fontcolor ~= nil) then
					self.label.widget:SetTintColor(gamecolorStyle(fontcolor))
				end
				
				local bgcolor = interact.style.bgcolor
				
				if(bgcolor ~= nil) then
					
					self.QuickHackHolder.widget:GetWidgetByIndex(0):GetWidgetByIndex(1):SetTintColor(gamecolorStyle(bgcolor))
					
				end
				
				local iconcolor = interact.style.iconcolor
				if(iconcolor ~= nil) then
					self.QuickHackIcon:SetTintColor(gamecolorStyle(iconcolor))
				end
				
			end
			
		end
		
	end
end

function DialogChoiceLogicController_UpdateView(self,wrappedMethod)
	
	if(observerthread == true or moddisabled  == true)   then return end
	if(currentDialogHub ~= nil and self.ActiveTextRef ~= nil) then
		
		local isphoneDialog = true
		
		local dialogoption = currentDialogHub.dial.options[interactionUI.selectedIndex+1]
		
		if(dialogoption ~= nil and 
			(getLang(dialogoption.description) ==  "["..self.tagWrapper.widget:GetWidgetByIndex(0):GetText().."]" 
			or getLang(dialogoption.description) ==  self.ActiveTextRef.widget:GetText())) then
			
			
			self.ActiveTextRef.widget:SetTintColor(gamecolor(0, 0, 0,1))
			self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolor(0, 0, 0,1))
			
			if (dialogoption.requirement ~= nil and checkTriggerRequirement(dialogoption.requirement,dialogoption.trigger) == false) then
				self.ActiveTextRef.widget:SetTintColor(gamecolor(237, 124, 109,1))
				self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolor(237, 124, 109,1))
				
				self.SelectedBg:SetTintColor(gamecolor(255, 86, 64,0))
				else
				
				if not (dialogoption.style == nil or dialogoption.style.color == nil  or dialogoption.style.color.red == nil or dialogoption.style.color.green == nil or dialogoption.style.color.blue == nil) then
					
					
					local fontcolor = dialogoption.style.color
					
					self.SelectedBg:SetTintColor(gamecolorStyle(fontcolor))
					
					
					
				end
			end
			
			
			
			
			
			
		end
		
		local dialogoption_unselect = nil
		
		
		for i,v in ipairs(currentDialogHub.dial.options) do
			
			if((getLang(v.description) ==  "["..self.tagWrapper.widget:GetWidgetByIndex(0):GetText().."]" or getLang(v.description) ==  self.ActiveTextRef.widget:GetText()) and getLang(v.description) ~=  getLang(currentDialogHub.dial.options[interactionUI.selectedIndex+1].description)) then
				
				dialogoption_unselect = v
				
				
				if (dialogoption_unselect ~= nil and dialogoption_unselect.requirement ~= nil and checkTriggerRequirement(dialogoption_unselect.requirement,dialogoption_unselect.trigger) == false)then
					
					
					pcall(function()
						
						self.ActiveTextRef.widget:SetTintColor(gamecolor(237, 124, 109,1))
						self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolor(237, 124, 109,1))
						
						
					end)
					else
					
					if (dialogoption_unselect ~= nil and dialogoption_unselect.style ~= nil and dialogoption_unselect.style.color ~= nil  and dialogoption_unselect.style.color.red ~= nil and dialogoption_unselect.style.color.green ~= nil and dialogoption_unselect.style.color.blue ~= nil) then
						
						local fontcolor = dialogoption_unselect.style.color
						
						self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(gamecolorStyle(fontcolor))
						self.ActiveTextRef.widget:SetTintColor(gamecolorStyle(fontcolor))
						
						else
						
						self.tagWrapper.widget:GetWidgetByIndex(0):SetTintColor(HDRColor.new({ Red=0.368627, Green=0.964706, Blue=1.000000, Alpha=1.000000 }))
						
						
						self.ActiveTextRef.widget:SetTintColor(HDRColor.new({ Red=0.368627, Green=0.964706, Blue=1.000000, Alpha=1.000000 }))
						
					end
					
					
				end
				
			end
			
			
		end
		
		
		
		
		
		
		
		
		
		
		
		
		else
		print("gameover")
		return wrappedMethod()
	end
end




---part4





function printChild(widget)
	if(observerthread == true or moddisabled  == true)   then return end
	if(widget ~= nil) then
		logme(1,tostring(NameToString(widget.name)).." "..GameDump(widget))
		local result = pcall(function() widget:GetNumChildren() end)
		
		if(result) then
			if(widget:GetNumChildren() > 0) then
				for i=0,widget:GetNumChildren() do
					logme(1,tostring(NameToString(widget.name)).." ["..tostring(i).."]")
					printChild(widget:GetWidgetByIndex(i))
					
				end
				
			end
		end
	end
end


function ComputerMainLayoutWidgetController_InitializeMenuButtons(thos, gameController, widgetsData,wrappedMethod)
	if(observerthread == true or moddisabled  == true)   then return wrappedMethod(gameController,widgetsData)  end
	
	wrappedMethod(gameController,widgetsData)
	
	
	
	-- if(isEmpty(cyberscript.cache["webpage"]) == false) then
	-- local test = thos
	-- local gameCon = gameController
	-- ----print("inirt"..widgetsData[2].widgetName)
	
	-- local widget = deepcopy(widgetsData[2],nil)
	
	-- widget.displayName = "CyberScript Web"
	-- widget.widgetName = "CyberScriptWeb"
	-- local widgeto = thos:CreateMenuButtonWidget(gameController, inkWidgetRef.Get(thos.menuButtonList), widget);
	-- thos:AddMenuButtonWidget(widgeto, widget, gameController)
	-- thos:InitializeMenuButtonWidget(gameController, widgeto, widget)
	
	
	-- end
	
end

function ComputerMainLayoutWidgetController_ShowInternet(thos, startingPage,wrappedMethod)
	if(observerthread == true or moddisabled  == true)   then return wrappedMethod(startingPage) end
	-- if(startingPage == "CyberScript") then
	-- -- thos:GetWindowContainer():SetVisible(false)
	-- -- Keystone_Load()
	-- -- if(currentInterface ~= nil and (currentInterface.type == "web")) then
	
	
	
	-- -- makeCustomInterface(thos:GetRootWidget())
	
	-- -- if(displayHUD["keystone_test"] == nil) then
	
	
	-- -- -- displayHUD["keystone_container"] = inkCanvas.new()
	-- -- -- displayHUD["keystone_container"]:SetName(CName.new("keystone_container"))
	-- -- -- displayHUD["keystone_container"]:SetAnchor(inkEAnchor.Fill)
	-- -- -- displayHUD["keystone_container"]:Reparent(thos:GetWindowContainer(), -1)
	
	
	-- -- displayHUD["keystone_test"] = inkText.new()
	-- -- displayHUD["keystone_test"]:SetName(CName.new("test"))
	-- -- displayHUD["keystone_test"]:SetText("TEST")
	-- -- displayHUD["keystone_test"]:SetFontFamily('base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily')
	-- -- displayHUD["keystone_test"]:SetFontStyle('Medium')
	-- -- displayHUD["keystone_test"]:SetFontSize(54)
	-- -- displayHUD["keystone_test"]:SetHorizontalAlignment(textHorizontalAlignment.Center)
	-- -- displayHUD["keystone_test"]:SetVerticalAlignment(textVerticalAlignment.Center)
	-- -- displayHUD["keystone_test"]:Reparent(thos:GetRootWidget(), -1)
	
	
	-- -- end
	
	-- -- displayHUD["keystone_test"]:SetVisible(true)
	
	-- -- end
	
	-- -- else
	-- -- if(displayHUD["keystone_test"] ~= nil) then
	-- -- displayHUD["keystone_test"]:SetVisible(false)
	-- -- end
	-- wrappedMethod(startingPage)
	
	-- end
	
	wrappedMethod(startingPage)
end

function ComputerInkGameController_ResolveBreadcrumbLevel(thos,  wrappedMethod) 
	if(observerthread == true or moddisabled  == true)   then return wrappedMethod() end
	----print("test")
	wrappedMethod()
end

function ComputerInkGameController_ShowMenuByName(thos, elementName, wrappedMethod)
	
	if(observerthread == true or moddisabled  == true)   then return wrappedMethod(elementName) end
	-- if(elementName == "CyberScript") then
	-- local internetData = (thos:GetOwner():GetDevicePS()):GetInternetData()
	-- thos:GetMainLayoutController():ShowInternet("CyberScript")
	
	-- thos:RequestMainMenuButtonWidgetsUpdate()
	-- CurrentAddress = "CyberScript"
	-- BrowserCybserscript = "loading"
	-- else
	-- wrappedMethod(elementName)
	-- end
	----print("ShowMenuByName "..elementName)
	if(elementName == "CyberScriptWeb") then
		----print("ShowMenuByName2 "..elementName)
		local internetData = (thos:GetOwner():GetDevicePS()):GetInternetData()
		thos:GetMainLayoutController():ShowInternet("CyberScriptWeb")
		thos:RequestMainMenuButtonWidgetsUpdate()
		CurrentAddress = "CyberScriptWeb"
		BrowserCybserscript = "home"
		else
		wrappedMethod(elementName)
	end
end

-- function BrowserController_TryGetWebsiteData(thos, address, wrappedMethod)

-- BrowserController = thos

-- ----print("02 - TryGetWebsiteData "..address)
-- if(address == "CyberScript" or address == "CyberScriptWeb") then


-- return wrappedMethod("NETdir://ncity.pub")




-- else
-- return wrappedMethod(address)
-- end
-- end


function BrowserController_LoadWebPage(self,address,wrappedMethod)
	--	CurrentAddress = address
	if(observerthread == true or moddisabled  == true)   then return wrappedMethod(address) end
	----print("LoadWebPage : "..address)
	if(address == "CyberScript" or address == "CyberScriptWeb" or  address == "NETdir://ezestates.web/makeovers" or  address == "NETdir://ezestates.web/for_rent") then
		if(BrowserController == nil) then BrowserController = self end
		
		
		if(address == "CyberScript" or address == "CyberScriptWeb" or  address == "NETdir://ezestates.web/makeovers" or  address == "NETdir://ezestates.web/for_rent") then
			
			CurrentAddress = address
			
			else
			CurrentAddress = nil
			
			
		end
		
		if(CurrentAddress == nil) then
			
			BrowserCybserscript = nil
			BrowserCustomPlace = nil
			
		end
		
		if(CurrentAddress == "CyberScript" and BrowserCybserscript == nil) then
			BrowserCybserscript = "loading"
			BrowserCustomPlace = nil
		end
		
		if(CurrentAddress == "CyberScriptWeb" and BrowserCybserscript == nil) then
			BrowserCybserscript = "home"
			BrowserCustomPlace = nil
		end
		
		-- Cron.NextTick(function()
		if(CurrentAddress ~= "NETdir://ezestates.web/makeovers") then
			BrowserCustomPlace = nil
			
		end
		
		
		if(address == "CyberScript" or address == "CyberScriptWeb" ) then
			----print("testlogic0")
			return wrappedMethod("NETdir://ncity.pub")
			
			else
			----print("testlogic1")
			return wrappedMethod(address)
			
		end
		
		else
		CurrentAddress = nil
		BrowserCybserscript = nil
		BrowserCustomPlace = nil
		
		return wrappedMethod(address)
		
	end
	
end






function CaptionImageIconsLogicController_OnInitialize(self,backgroundColor,iconColor)
	if(observerthread == true or moddisabled  == true)   then return end
	
end


function ShardNotificationController_OnInitialize(self)
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["ShardNotificationController"]  = self
end

function ShardNotificationController_OnPlayerAttach(self,playerPuppet)
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["ShardNotificationController"]  = self
end

function ShardNotificationController_SetButtonHints(self)
	if(observerthread == true or moddisabled  == true)   then return end
	if not UIPopupsManager.IsOwnPopup(self) then
		return
	end
	
	GameController["ShardNotificationController"]  = self
	if(currentInterface ~= nil and (currentInterface.type == nil or currentInterface.type == "popup")) then
		
		
		local titleIcon = self:GetRootWidget():GetWidgetByPathName(StringToName('container/Panel/vertical_organizer/topBar/icon'))
		
		titleIcon:SetAtlasResource(ResRef.FromName('base\\gameplay\\gui\\fullscreen\\hub_menu\\hub_atlas.inkatlas'))
		titleIcon:SetTexturePart('ico_journal')
		inkTextRef.SetText(self.titleRef, getLang(currentInterface.title))
		titleIcon:SetTintColor(inkWidgetRef.GetTintColor(self.titleRef))
		local contentArea = self:GetRootWidget():GetWidgetByPathName(StringToName('container/Panel/vertical_organizer/contentArea'))
		
		makeCustomInterface(contentArea,currentInterface)
	end
	
	
end

function ShardNotificationController_Close(self)
	if(observerthread == true or moddisabled  == true)   then return end
	buttonsData = {}
	if UIPopupsManager.IsOwnPopup(self) then
		UIPopupsManager.ClosePopup()
	end
end

function gameuiInGameMenuGameController_OnHandleMenuInput(self)
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["gameuiInGameMenuGameController"]  = self
end

function gameuiInGameMenuGameController_SpawnMenuInstanceEvent(self) -- Get Controller to spawn popup
	if(observerthread == true or moddisabled  == true)   then return end
	GameController["gameuiInGameMenuGameController"]  = self
end

function PopupsManager_ShowPhoneMessage(self)
	if(observerthread == true or moddisabled  == true)   then return end
	
	if self.phoneMessageData ~= nil and self.phoneMessageData.journalEntry == nil then
		
		else
		if self.phoneMessageData ~= nil and self.phoneMessageData.journalEntry ~= nil then
			logme(10,GameDump(self.phoneMessageData))
		end
	end
	
	
end

function PopupsManager_OnMessagePopupUseCloseRequest(self)
	if(observerthread == true or moddisabled  == true)   then return end
	if(currentPhoneConversation ~= nil) then
		currentPhoneConversation = nil
	end
	
	
end

function QuestCodexLinkController_Setup(self)
	if(observerthread == true or moddisabled  == true)   then return end
	----print("test")
	
end







-- function DeathLandEvents", "OnEnter(thos,stateContext, scriptInterface,wrappedMethod)
-- logme(10,"tombé1")
-- thos:PlayHardLandingEffects(stateContext, scriptInterface)
-- thos:BroadcastLandingStim(stateContext, scriptInterface, gamedataStimType.LandingHard)
-- thos:OnForcedExit(stateContext, scriptInterface)
-- thos:SetDetailedState(scriptInterface, gamePSMDetailedLocomotionStates.HardLand);
-- thos:SetBlackboardIntVariable(scriptInterface, GetAllBlackboardDefs().PlayerStateMachine.Landing, EnumInt(gamePSMLandingState.HardLand))

-- end)
function PreventionSpawnSystem_SpawnCallback(thos,requestResult,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(spawnedObject) end
	
	local contain = false
	if(cachedespawn[requestResult.requestID] ~= nil and requestResult.success == true) then
		print(GameDump(requestResult))
		
		cachedespawn[requestResult.requestID].NPC = requestResult.spawnedObjects
		cachedespawn[requestResult.requestID].result = true
		contain = true
		
	end
	
	-- local tweak = TweakDBID.new(k)
	
	-- if(tweak == spawnedObject:GetRecordID()) then
	
	-- local obj = getEntityFromManagerById(spawnedObject:GetEntityID())
	
	-- if((v.id == nil or v.id.hash ~= spawnedObject:GetEntityID().hash) and getEntityFromManagerById(spawnedObject:GetEntityID())~= nil) then
	
	-- local entity = getEntityFromManagerById(spawnedObject:GetEntityID())
	
	-- if (v.count == nil) then
	-- v.count = 0
	-- end
	-- ----print("Kill the NPC "..tostring(spawnedObject:GetEntityID().hash))
	-- --Game.GetPreventionSpawnSystem():RequestDespawn(spawnedObject:GetEntityID())
	
	
	-- spawnedObject:Dispose()
	
	-- --cachedespawn[i] = nil
	-- if(entity.fromgarage ~= nil ) then
	
	-- if (v.count == 0) then
	-- cachedespawn[k] = nil
	-- end
	
	-- else
	-- v.count = v.count +1
	-- if (v.count == 2) then
	-- cachedespawn[k] = nil
	-- end
	-- end
	-- end
	
	
	
	-- end
	
	-- end
	
	
	
	if(contain == false) then
		
		
		
		wrappedMethod(spawnedObject)
		
		
		
		
	end
	
end

function QuestMappinLinkController_Setup(thos,mappinEntry,mappinHash,jumpTo,isTracked,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(mappinEntry,jumpTo) end
	if mappinEntry == nil and journalQuestMapPinBase ~= nil then
		
		local mappin = getMappinByTag(journalQuestMapPinBase)
		
		logme(10,"Setup "..journalQuestMapPinBase)
		
		
		inkTextRef.SetText(thos.linkLabel, mappin.title)
		
		thos.jumpTo = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
		journalQuestMapPinBase = nil
		
		else
		
		wrappedMethod(mappinEntry,mappinHash,jumpTo,isTracked)
		
	end
	
end

function QuestCodexLinkController_SetupCodexLink(thos,codexEntry,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(codexEntry) end
	if codexEntry == nil and codexEntryTag ~= nil then
		
		
		
		local entry =  JournalCodexEntry.new()
		entry.id =  "CS_customcodex:"..codexEntryTag
		
		
		thos.journalEntry = entry
		
		
		local codexObj = cyberscript.cache["codex"][codexEntryTag].data
		
		inkTextRef.SetText(thos.linkLabel, codexObj.title)
		
		
		codexEntryTag = nil
		
		thos.isInteractive = true
		inkWidgetRef.SetVisible(thos.linkLabelContainer, true)
		thos:GetRootWidget():SetInteractive(true);
		
		else
		
		codexEntryTag = nil
		wrappedMethod(codexEntry)
		
		
		
		
	end
	
end




function CodexPopupGameController_SetupData(thos,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod() end
	thos.data = thos:GetRootWidget():GetUserData("CodexPopupData")
	print(GameDump(thos:GetRootWidget()))
	if string.match(thos.data.entry.id,"CS_customcodex:") then
		
		local splittext = split(thos.data.entry.id,':')
		
		
		local codex = cyberscript.cache["codex"][splittext[2]].data
		
		
		
		local codexEntryData = GenericCodexEntryData.new()
		codexEntryData.title = codex.tag
		codexEntryData.description = codex.description
		codexEntryData.hash = 13081991
		
		
		
		
		thos.entryViewController:ShowEntry(codexEntryData)
		inkWidgetRef.SetVisible(thos.entryViewRef, true)
		inkWidgetRef.SetVisible(thos.characterEntryViewRef, false)
		inkWidgetRef.SetVisible(thos.imageViewRef, false)
		
		
		else
		
		wrappedMethod()
		
		
	end
	
end


function CodexEntryViewController_ShowEntry(thos,data, inputDevice, inputScheme,wrappedMethod)
	
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod() end
	if data.hash == 13081991 then
		
		local codex = cyberscript.cache["codex"][data.title].data
		
		checkContext(codex)
		
		
		thos.scroll = inkWidgetRef.GetControllerByType(thos.scrollWidget, "inkScrollController")
		thos.scroll:SetScrollPosition(0.00);
		inkTextRef.SetText(thos.descriptionText, codex.description)
		inkTextRef.SetText(thos.titleText, codex.title)
		inkWidgetRef.SetVisible(thos.imageWidget, false)
		inkWidgetRef.SetVisible(thos.imageWidgetWrapper, false)
		inkWidgetRef.SetVisible(thos.noEntrySelectedWidget, false)
		inkWidgetRef.SetVisible(thos.contentWrapper, true)
		
		else
		
		wrappedMethod(data, inputDevice, inputScheme)
		
		
	end
	
end


function PlayerPuppet_OnLookAtObjectChangedEvent(thos)
	if(observerthread == true or moddisabled  == true)  then return end
	thos.isAimingAtFriendly = false
	thos.isAimingAtChild = false
end

function NcartTimetableControllerPS_UpdateCurrentTimeToDepart(self,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod() end
	if(activeMetroDisplay == true) then
		self.currentTimeToDepart = MetroCurrentTime
		--NewMetroTime = 0
		--logme(2,MetroCurrentTime)
		else
		wrappedMethod()
	end
end

function PhoneDialerGameController_CallSelectedContact(thos, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod() end
	local callRequest = nil
	local item = thos.listController:GetSelectedItem()
	local contactData = item:GetContactData()
	
	if IsDefined(contactData) and contactData.lastMesssagePreview ~= "CyberScript" then
		
		return wrappedMethod()
		
	end
end


function DoubleJumpDecisions_EnterCondition(thos,stateContext,scriptInterface, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(stateContext,scriptInterface) end
	if(getUserSetting('InfiniteDoubleJump') == true) then
		
		
		local currentNumberOfJumps = 0
		local jumpPressedFlag = stateContext:GetConditionBool("JumpPressed");
		
		if not jumpPressedFlag and not thos.jumpPressed then
			return false
		end
		
		
		if not scriptInterface:HasStatFlag(gamedataStatType.HasDoubleJump) then
			return false
		end
		if scriptInterface:HasStatFlag(gamedataStatType.HasChargeJump) or scriptInterface:HasStatFlag(gamedataStatType.HasAirHover) then
			return false
		end
		
		if scriptInterface.localBlackboard:GetBool(GetAllBlackboardDefs().PlayerStateMachine.IsPlayerInsideMovingElevator) then
			return false
		end
		
		currentNumberOfJumps = stateContext:GetIntParameter("currentNumberOfJumps", true)
		
		if(getUserSetting('numberOfMultiJumps') ~= 100) then
			if (currentNumberOfJumps >= getUserSetting('numberOfMultiJumps') ) then
				return false
			end
		end
		
		if jumpPressedFlag or scriptInterface:IsActionJustPressed("Jump") then
			
			return true
			
		end
		
		
		return false
		
		
		else
		
		if not jumpPressedFlag and not thos.jumpPressed then
			thos:EnableOnEnterCondition(false)
		end
		
		
		if not scriptInterface:HasStatFlag(gamedataStatType.HasDoubleJump) then
			return false
		end
		if scriptInterface:HasStatFlag(gamedataStatType.HasChargeJump) or scriptInterface:HasStatFlag(gamedataStatType.HasAirHover) then
			return false
		end
		
		if scriptInterface.localBlackboard:GetBool(GetAllBlackboardDefs().PlayerStateMachine.IsPlayerInsideMovingElevator) then
			return false
		end
		
		currentNumberOfJumps = stateContext:GetIntParameter("currentNumberOfJumps", true)
		
		if currentNumberOfJumps >= thos:GetStaticIntParameterDefault("numberOfMultiJumps", 1) then
			return false
		end
		
		if jumpPressedFlag or scriptInterface:IsActionJustPressed("Jump") then
			
			return true
			
		end
		
		
		return false
	end
end

function LocomotionAirEvents_OnUpdate(thos,timeDelta, stateContext, scriptInterface, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(stateContext,scriptInterface) end
	if(getUserSetting('DisableFallDamage') == true) then
		
		
		return 
		
		-- local deathLandingFallingSpeed
		-- local hardLandingFallingSpeed
		-- local horizontalSpeed
		-- local isInSuperheroFall
		-- local landingAnimFeature
		-- local landingType
		-- local maxAllowedDistanceToGround;
		-- local playerVelocity
		-- local regularLandingFallingSpeed
		-- local safeLandingFallingSpeed
		-- local verticalSpeed
		-- local veryHardLandingFallingSpeed
		
		-- wrappedMethod(timeDelta,stateContext, scriptInterface)
		
		-- if thos:IsTouchingGround(scriptInterface) then
		-- thos:ResetFallingParameters(stateContext)
		-- return
		-- end
		-- verticalSpeed = thos:GetVerticalSpeed(scriptInterface)
		-- if thos.updateInputToggles and verticalSpeed < thos:GetFallingSpeedBasedOnHeight(scriptInterface, thos:GetStaticFloatParameterDefault("minFallHeightToConsiderInputToggles", 0)) then
		-- thos:UpdateInputToggles(stateContext, scriptInterface)
		-- end
		-- if scriptInterface:IsActionJustPressed("Jump") then
		-- stateContext:SetConditionBoolParameter("CrouchToggled", false, true)
		-- return
		-- end
		-- if StatusEffectSystem:ObjectHasStatusEffect(scriptInterface.executionOwner, "BaseStatusEffect.BerserkPlayerBuff") and verticalSpeed < thos:GetFallingSpeedBasedOnHeight(scriptInterface, thos:GetStaticFloatParameterDefault("minFallHeightToEnterSuperheroFall", 0)) then
		-- stateContext:SetTemporaryBoolParameter("requestSuperheroLandActivatio", true, true)
		-- end
		-- regularLandingFallingSpeed = stateContext:GetFloatParameter("RegularLandingFallingSpeed", true)
		-- safeLandingFallingSpeed = stateContext:GetFloatParameter("SafeLandingFallingSpeed", true)
		-- hardLandingFallingSpeed = stateContext:GetFloatParameter("HardLandingFallingSpeed", true)
		-- veryHardLandingFallingSpeed = stateContext:GetFloatParameter("VeryHardLandingFallingSpeed", true)
		-- deathLandingFallingSpeed = stateContext:GetFloatParameter("DeathLandingFallingSpeed", true)
		-- isInSuperheroFall = stateContext:IsStateActive("Locomotio", "superheroFall")
		-- maxAllowedDistanceToGround = thos:GetStaticFloatParameterDefault("maxDistToGroundFromSuperheroFall", 20.00)
		-- if isInSuperheroFall and not thos.maxSuperheroFallHeight then
		-- thos:StartEffect(scriptInterface, "falling")
		-- thos:PlaySound("lcfalling_wind_loop", scriptInterface)
		-- if DefaultTransition:GetDistanceToGround(scriptInterface) >= maxAllowedDistanceToGround then
		-- thos.maxSuperheroFallHeight = true
		-- return
		-- end
		-- landingType = LandingType.Superhero
		
		-- else 
		-- if verticalSpeed <= safeLandingFallingSpeed then
		-- landingType = LandingType.Regular
		-- thos:SetBlackboardIntVariable(scriptInterface, GetAllBlackboardDefs().PlayerStateMachine.Fall, EnumInt(gamePSMFallStates.RegularFall))
		-- playerVelocity = DefaultTransition.GetLinearVelocity(scriptInterface)
		-- horizontalSpeed = Vector4.Length2D(playerVelocity)
		-- if horizontalSpeed <= thos:GetStaticFloatParameterDefault("maxHorizontalSpeedToAerialTakedow", 0) then
		-- thos:SetBlackboardIntVariable(scriptInterface, GetAllBlackboardDefs().PlayerStateMachine.Fall, EnumInt(gamePSMFallStates.SafeFall))
		-- end
		
		-- else 
		-- if verticalSpeed <= regularLandingFallingSpeed then
		-- if thos:GetLandingType(stateContext) ~= EnumInt(LandingType.Regular) then
		-- thos.PlaySound("lcfalling_wind_loop", scriptInterface)
		-- end
		-- landingType = LandingType.Regular
		-- else 
		-- landingType = LandingType.Off
		-- end
		-- end
		-- end
		-- stateContext:SetPermanentIntParameter("LandingType", EnumInt(landingType), true)
		-- stateContext:SetPermanentFloatParameter("ImpactSpeed", verticalSpeed, true)
		-- stateContext:SetPermanentFloatParameter("InAirDuratio", thos.GetInStateTime(), true)
		-- landingAnimFeature =  AnimFeature_Landing.new()
		-- landingAnimFeature.impactSpeed = verticalSpeed
		-- landingAnimFeature.type = EnumInt(landingType)
		-- scriptInterface:SetAnimationParameterFeature("Landing", landingAnimFeature)
		-- thos:SetAudioParameter("RTPC_Vertical_Velocity", verticalSpeed, scriptInterface)
		-- thos:SetAudioParameter("RTPC_Landing_Type", EnumInt(landingType), scriptInterface)
		
		else
		
		wrappedMethod(timeDelta,stateContext, scriptInterface)
	end
end


function WorldMapMenuGameController_OnGangListItemSpawned(self,gangWidget,userData) 
	if(observerthread == true or moddisabled  == true)  then return  end
end

function WorldMapMenuGameController_OnSelectedDistrictChanged(self,oldDistrict,newDistrict) 
	if(observerthread == true or moddisabled  == true)  then return  end
	self:ShowGangsInfo(newDistrict)
end

function WorldMapGangItemController_SetData(self,affiliationRecord) 
	if(observerthread == true or moddisabled  == true)  then return  end
	
	if(CurrentGang ~= nil) then
		
		
		inkTextRef.SetText(self.factionNameText, CurrentGang)
		inkImageRef.SetTexturePart(self.factionIconImage, CName(CurrentGangLogo))
		
	end
end

---part5



function RipperdocIdPanel_SetName(thos,vendorName,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(vendorName)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and VendorsStockManager[entity.tag] ~= nil then
			
			inkTextRef.SetText(thos.nameLabel, VendorsStockManager[entity.tag].name)
			----print("markname")
			else
			
			
			wrappedMethod(vendorName)
		end
		else
		
		
		wrappedMethod(vendorName)
	end
end

function VendorHubMenuGameController_SetupTopBar(thos,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod()  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and VendorsStockManager[entity.tag] ~= nil then
			----print("markname2")
			------print(VendorsStockManager[entity.tag].name)
			inkTextRef.SetText(thos.vendorShopLabel, VendorsStockManager[entity.tag].name)
			else
			
			
			wrappedMethod()
		end
		else
		
		
		wrappedMethod()
	end
end

function FullscreenVendorGameController_PopulateVendorInventory(thos,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod() end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and VendorsStockManager[entity.tag] ~= nil then
			
			local itemtable = VendorsStockManager[entity.tag].items
			
			logme(10,"table count"..#itemtable)
			
			
			local data = {}
			
			for k,v in ipairs(itemtable) do
				local test = SItemStack.new()
				test.quantity =  v.quantity
				test.powerLevel  = v.powerLevel
				test.vendorItemID = thos.VendorID
				test.isAvailable = true
				test.requirement = {}
				test.dynamicTags = {}
				
				test.itemID = ItemID.CreateQuery(TweakDBID.new(v.tweak))
				
				local ts = Game.GetTransactionSystem()
				
				
				if ts:GetItemQuantity(thos.VendorObject, test.itemID) == 0 then
					local result = ts:GiveItem(thos.VendorObject, test.itemID , v.quantity)
				end
				
				
				local item = VendorGameItemData.new()
				
				item.itemStack = test
				
				item.gameItemData  =  ts:GetItemData(thos.VendorObject, test.itemID)
				
				
				
				
				table.insert(data,item)
				
			end 
			
			
			----print("markk2")
			for k,v in ipairs(data) do
				logme(10,GameDump(v))
			end
			return data
			
			
			else
			
			
			wrappedMethod()
		end
		
		else
		
		wrappedMethod()
	end
end


---Scanner
function ScannervehicleGameController_OnVehicleInfoChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].primaryname ~= nil) then
				local vehicleInfoData = ScannerVehicleInfo.new()
				vehicleInfoData = FromVariant(value)
				
				if vehicleInfoData ~= nil then
					local text = ""..ScannerInfoManager[entity.tag].text
					
					if string.match(text,"cyberscript_scanner_") then
						text = text:gsub("cyberscript_scanner_", " ") 
						inkTextRef.SetText(thos.vehicleInfoText, text)
						
						thos.isValidVehicleInfo = true
						
						
						
						else
						if(Game.GetLocalizedText(vehicleInfoData:GetVehicleInfo()) ~= nil) then 
							
							inkTextRef:SetLocalizedTextScript(thos.vehicleInfoText, vehicleInfoData:GetVehicleInfo())
							
						end
						thos.isValidVehicleInfo = true
						
						
					end
					thos:UpdateGlobalVisibility()
					
					else
					
					wrappedMethod(value)
				end
				else
				
				wrappedMethod(value)
			end
			
			else
			
			wrappedMethod(value)
			
		end
	end
end


function ScannerNPCHeaderGameController_OnNameChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].primaryname ~= nil) then
				
				local testshow = ScannerInfoManager[entity.tag].primaryname
				
				if(ScannerInfoManager[entity.tag].secondaryname ~= nil and ScannerInfoManager[entity.tag].secondaryname ~= "") then
					
					testshow = testshow.." "..ScannerInfoManager[entity.tag].secondaryname
					
				end
				
				inkTextRef.SetText(thos.nameText, testshow)
				thos.isValidName = true
				thos:UpdateGlobalVisibility()
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
	
end

function ScannerNPCHeaderGameController_OnLevelChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].level ~= nil) then
				
				inkWidgetRef.SetVisible(thos.skullIndicator, (Game.GetStatsSystem():GetStatValue(Game.GetPlayer():GetEntityID(), 605) < ScannerInfoManager[entity.tag].level))
				
				
				thos:UpdateGlobalVisibility()
				
				else
				wrappedMethod()
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end

function ScannerNPCHeaderGameController_OnAttitudeChange(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].attitude ~= nil) then
				
				if(ScannerInfoManager[entity.tag].attitude == 0) then
					inkWidgetRef.SetState(thos.nameText, "Friendly")
				end
				
				if(ScannerInfoManager[entity.tag].attitude == 1) then
					inkWidgetRef.SetState(thos.nameText, "Neutral")
				end
				
				if(ScannerInfoManager[entity.tag].attitude == 2) then
					inkWidgetRef.SetState(thos.nameText, "Hostile")
				end
				
				
				
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
	
end

function ScannerNPCBodyGameController_OnFactionChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].data ~= nil) then
				local gang = getFactionByTag(ScannerInfoManager[entity.tag].data)
				inkTextRef.SetText(thos.dataText, "CS faction "..gang.Name)
				thos.isValidFaction = true;
				
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end


function ScannerNPCBodyGameController_OnRarityChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			--thos.asyncSpawnRequest:Cancel()
			if(ScannerInfoManager[entity.tag].rarity ~= nil) then
				if(ScannerInfoManager[entity.tag].iscivilian == nil) then
					ScannerInfoManager[entity.tag].iscivilian = true
				end
				if (ScannerInfoManager[entity.tag].iscivilian == true and thos.asyncSpawnRequest ~= nil) then
					thos.asyncSpawnRequest = thos:AsyncSpawnFromLocal(inkWidgetRef.Get(thos.dataBaseWidgetHolder), "ScannerCitizenDB", thos, "OnCitizenDBSpawned")
				end
				
				else
				wrappedMethod(value)
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end

function QuickHackDescriptionGameController_OnQuickHackDataChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	
	local vehicleInfoData = QuickhackData.new()
	vehicleInfoData = FromVariant(value)
	logme(10,GameDump(vehicleInfoData))
	wrappedMethod(value)
	
end

function ScannerBountySystemGameController_OnBountySystemChanged(thos, value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		if(entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			
			if(ScannerInfoManager[entity.tag].bounty ~= nil) then
				
				thos.isValidBounty = true
				
				
				
				if #ScannerInfoManager[entity.tag].bounty.transgressions >0 or #ScannerInfoManager[entity.tag].bounty.customtransgressions > 0 then
					local transgressionsText = ""
					inkWidgetRef.SetVisible(thos.rewardPanel, true)
					
					inkWidgetRef.SetVisible(thos.streetCredRewardRow, true);
					inkTextRef.SetText(thos.streetCredReward, IntToString(ScannerInfoManager[entity.tag].bounty.streetreward))
					
					inkWidgetRef.SetVisible(thos.moneyRewardRow, true);
					
					inkTextRef.SetText(thos.moneyReward, IntToString(ScannerInfoManager[entity.tag].bounty.reward))
					
					if(ScannerInfoManager[entity.tag].bounty.danger > 5) then
						
						ScannerInfoManager[entity.tag].bounty.danger = 5
						
					end
					
					if(ScannerInfoManager[entity.tag].bounty.danger < 0) then
						
						ScannerInfoManager[entity.tag].bounty.danger = 0
						
					end
					
					if(ScannerInfoManager[entity.tag].bounty.danger > 0) then
						for i = 1, ScannerInfoManager[entity.tag].bounty.danger do
							if i <= ScannerInfoManager[entity.tag].bounty.danger then
								inkWidgetRef.SetVisible(thos.starsWidget[i], true)
								else
								inkWidgetRef.SetVisible(thos.starsWidget[i], false)
							end
						end
						else
						inkWidgetRef.SetVisible(thos.starsWidget[1], false)
						inkWidgetRef.SetVisible(thos.starsWidget[2], false)
						inkWidgetRef.SetVisible(thos.starsWidget[3], false)
						inkWidgetRef.SetVisible(thos.starsWidget[4], false)
						inkWidgetRef.SetVisible(thos.starsWidget[5], false)
						
					end
					
					if(#ScannerInfoManager[entity.tag].bounty.transgressions > 0) then
						local transgressionslist = {}
						
						for i,trans in ipairs(ScannerInfoManager[entity.tag].bounty.transgressions) do
							
							local tweak = TweakDBID.new("Transgression."..trans)
							table.insert(transgressionslist,tweak)
							
							
						end
						
						if(#transgressionslist > 0) then	
							
							
							for i = 1, #transgressionslist do
								local record = TweakDBInterface.GetTransgressionRecord(transgressionslist[i])
								local trantext = ""
								if(record ~= nil) then
									
									trantext = record:LocalizedDescription()
									logme(10,trantext)
								end
								
								transgressionsText = transgressionsText..GetLocalizedText(trantext)
								if i < #transgressionslist then
									transgressionsText = transgressionsText.." ; "
								end
							end
							inkTextRef.SetText(thos.transgressions, transgressionsText)
							
							inkWidgetRef.SetVisible(thos.transgressionsWidget, true)
						end
						
					end
					
					if(#ScannerInfoManager[entity.tag].bounty.customtransgressions > 0) then
						transgressionsText = transgressionsText.." ; "
						
						
						for i = 1, #ScannerInfoManager[entity.tag].bounty.customtransgressions do
							transgressionsText = transgressionsText..ScannerInfoManager[entity.tag].bounty.customtransgressions[i]
							
							if i < #ScannerInfoManager[entity.tag].bounty.customtransgressions then
								transgressionsText = transgressionsText.." ; "
							end
							
						end
						
						inkTextRef.SetText(thos.transgressions, transgressionsText)
						
						inkWidgetRef.SetVisible(thos.transgressionsWidget, true)
					end
					
					inkWidgetRef.SetVisible(thos.wanted, true)
					inkTextRef.SetText(thos.wanted, "By : "..ScannerInfoManager[entity.tag].bounty.issuedby)
					
					else
					
					inkWidgetRef.SetVisible(thos.transgressionsWidget, false)
					inkWidgetRef.SetVisible(thos.rewardPanel, false)
					inkWidgetRef.SetVisible(thos.notFound, true)
					inkTextRef.SetLocalizedTextScript(thos.notFound, "LocKey#40655")
					inkWidgetRef.SetVisible(thos.mugShot, false)
					inkWidgetRef.SetVisible(thos.wanted, false)
				end
				
				
				thos:UpdateGlobalVisibility()
				
				
				else
				wrappedMethod(value)
				
			end
			else
			
			wrappedMethod(value)
			
		end
		
		else
		
		wrappedMethod(value)
		
	end
end

function scannerDetailsGameController_RefreshLayout(thos,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod()  end
	if(objLook ~= nil) then
		local entid = objLook:GetEntityID()
		local entity = getEntityFromManagerById(entid)
		
		if (entity.id ~= nil) and (getScannerdataFromEntityOrGroupOfEntity(entity) ~= nil) then
			thos:BreakAniamtions()
			
			if HUDManager.GetActiveMode() ~= ActiveMode.FOCUS then
				thos:PlayCloseScannerAnimation();
			end
			
			if thos.scanningState == gameScanningState.Complete or thos.scanningState == gameScanningState.ShallowComplete or thos.scanningState ==  gameScanningState.Started then
				
				for i,value in ipairs(thos.asyncSpawnRequests) do
					
					value:Cancel()
					
					
				end
				
				thos.asyncSpawnRequests = {}
				
				inkCompoundRef.RemoveAllChildren(thos.scannerCountainer)
				inkCompoundRef.RemoveAllChildren(thos.quickhackContainer)
				inkWidgetRef.SetVisible(thos.bg, true)
				thos:GetRootWidget():SetVisible(false)
				table.insert(thos.asyncSpawnRequests,thos:AsyncSpawnFromLocal(inkWidgetRef.Get(thos.quickhackContainer), "QuickHackDescription"))
				
				--	------print(tostring(thos.scannedObjectType))
				if(thos.scannedObjectType == ScannerObjectType.PUPPET) then
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerNPCHeaderWidget")
					thos:AsyncSpawnScannerModule("ScannerNPCBodyWidget")
					thos:AsyncSpawnScannerModule("ScannerBountySystemWidget")
					thos:AsyncSpawnScannerModule("ScannerRequirementsWidget")
					thos:AsyncSpawnScannerModule("ScannerAbilitiesWidget")
					thos:AsyncSpawnScannerModule("ScannerResistancesWidget")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					thos:AsyncSpawnScannerModule("ScannerVehicleBody")
					
					
					elseif(thos.scannedObjectType == ScannerObjectType.DEVICE) then
					
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerDeviceHeaderWidget")
					thos:AsyncSpawnScannerModule("ScannerVulnerabilitiesWidget")
					thos:AsyncSpawnScannerModule("ScannerRequirementsWidget")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					
					
					elseif(thos.scannedObjectType == ScannerObjectType.VEHICLE) then
					
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerVehicleBody")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					
					elseif(thos.scannedObjectType == ScannerObjectType.GENERIC) then
					thos:GetRootWidget():SetVisible(true)
					thos:AsyncSpawnScannerModule("ScannerDeviceHeaderWidget")
					thos:AsyncSpawnScannerModule("ScannerDeviceDescriptionWidget")
					
					inkWidgetRef:SetVisible(thos.toggleDescirptionHackPart, false)
					
				end
				
				
				thos.showScanAnimProxy = thos:PlayLibraryAnimation("intro")
				thos.showScanAnimProxy:RegisterToCallback(inkanimEventType.OnFinish, thos, "OnScannerDetailsShown")
			end
			
			
			if thos.scanningState == gameScanningState.Stopped or thos.scanningState ==  gameScanningState.Default then 
				thos:PlayCloseScannerAnimation()
			end
			
			else
			
			wrappedMethod()
			----print("tossss")
			
		end
		
		else
		
		wrappedMethod()
		----print("tossss")
	end
	
end

function QuickhacksListGameController_PopulateData(this,data,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(data)  end
	----print("step 00")
	wrappedMethod(data)
	
	for k,v in pairs(cyberscript.cache["quickhack"]) do
		
		if(checkTriggerRequirement(v.data.requirement,v.data.trigger))then
			
			
			CName.add("cyberscript_hack:"..v.data.tag)
			
			CName.add("cyberscript_hack_category")
			
			local mydata = QuickhackData.new()
			
			mydata.actionOwner = Game.GetPlayer()
			mydata.actionOwnerName = CName("cyberscript_hack:"..v.data.tag)
			mydata.icon = TweakDBID.new(v.data.icon)
			mydata.iconCategory = CName("cyberscript_hack_category")
			mydata.title = v.data.title
			mydata.titleAlternative = v.data.titlealternative
			mydata.description = v.data.description
			mydata.inactiveReason = v.data.inactivereason
			mydata.isLocked = checkTriggerRequirement(v.data.unlockrequirement,v.data.unlocktrigger) == false
			mydata.type = v.data.actiontype
			mydata.cost = v.data.cost
			mydata.costRaw = v.data.cost
			mydata.uploadTime = v.data.uploadtime
			mydata.duration =  v.data.duration
			mydata.ICELevelVisible = v.data.icelevelvisible
			mydata.ICELevel =  v.data.iceLevel
			mydata.vulnerabilities = nil
			mydata.quality =  v.data.quality
			mydata.isInstant =  v.data.isinstant
			mydata.cooldown  = v.data.cooldown
			mydata.cooldownTweak  = nil
			mydata.actionMatchesTarget  = false
			mydata.maxListSize  =  13
			mydata.category  =  nil
			mydata.actionCompletionEffects  = nil
			mydata.networkBreached  =  v.data.networkbreached
			
			this.listController:PushData(mydata, false)
			
		end
		
		
		
		
	end
	
	this.listController:Refresh()
	
end

function QuickhacksListItemController_UpdateState(this,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod()  end
	wrappedMethod()
	
	
end

function QuickhacksListGameController_OnAction(this,action,consumer,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(action,consumer)  end
	wrappedMethod(action,consumer)
	
	
end

function QuickhacksListGameController_ApplyQuickHack(this,shouldUseUI,wrappedMethod)
	print("step 02")
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(shouldUseUI)  end
	this.lastMaxCells = 999
	local value = wrappedMethod(shouldUseUI)
	if string.match(NameToString(this.selectedData.actionOwnerName),"cyberscript_hack:") then
		
		local splittext = split(NameToString(this.selectedData.actionOwnerName),':')
		
		if(checkTriggerRequirement(cyberscript.cache["quickhack"][splittext[2]].data.requirement,cyberscript.cache["quickhack"][splittext[2]].data.trigger))then
			
			usedCells = this.selectedData.cost
			maxCells =  this.lastMaxCells
			
			
			local availablecell = maxCells-usedCells
			
			local percent = math.floor((availablecell*100)/maxCells)
			
			local fillCells =  math.floor(maxCells * percent *0.01)
			
			if this:GetRootWidget():IsVisible() == false or (this.lastFillCells == fillCells and this.lastUsedCells == usedCells and this.lastMaxCells == maxCells) then
				
				else
				this.lastUsedCells = usedCells
				this.lastMaxCells = maxCells
				this.lastFillCells = fillCells
				this:UpdateMemoryBar()
			end
			
			
			
			
		end
		
		
		
		
	end
	
	
end

function QuickhacksListGameController_OnQuickhackStarted(this,value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	wrappedMethod(value)
	print(GameDump(this.selectedData))
	if string.match(NameToString(this.selectedData.actionOwnerName),"cyberscript_hack:") then
		
		local splittext = split(NameToString(this.selectedData.actionOwnerName),':')
		
		if(checkTriggerRequirement(cyberscript.cache["quickhack"][splittext[2]].data.requirement,cyberscript.cache["quickhack"][splittext[2]].data.trigger))then
			
			local availablecell = maxCells-usedCells
			
			local percent = math.floor((availablecell*100)/maxCells)
			
			local fillCells =  math.floor(maxCells * percent *0.01)
			
			if(fillCells > -1) then
				runActionList(cyberscript.cache["quickhack"][splittext[2]].data.action,cyberscript.cache["quickhack"][splittext[2]].data.tag,"interact",false,"player")
			end
			
		end
		
		
		
	end
	
end

function QuickhacksListGameController_SetVisibility(this,value,wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	wrappedMethod(value)
	
	
	
	
	
	
	
end

function QuickhacksListItemController_OnMemoryPercentUpdate(this,value, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(value)  end
	wrappedMethod(value)
	
	
	
	
end

function QuickhacksListItemController_UpdateQuickhacksMemoryBarSize(this,size, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod(size)  end
	wrappedMethod(size)
	
	
	
end

























function QuickhacksListItemController_PlayChoiceAcceptedAnimation(this,wrappedMethod)
	
	
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod()  end
	wrappedMethod()
	if this.isSelected then
		
		
		
		
		
		
		
	end
	
	
	
end
---Scanner
function VehiclesManagerPopupGameController_SetupData(this, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod()  end
	
	local currnetData 
	
	local result = {}
	
	local vehicleRecord
	local vehiclesList
	vehiclesList = Game.GetVehicleSystem():GetPlayerUnlockedVehicles()
	
	
	for i,vehicle in ipairs(vehiclesList) do
		
		if TDBID.IsValid(vehicle.recordID) then
			vehicleRecord = TweakDBInterface.GetVehicleRecord(vehicle.recordID)
			currnetData =  VehicleListItemData.new()
			currnetData.displayName = vehicleRecord:DisplayName()
			currnetData.icon = vehicleRecord:Icon()
			currnetData.data = vehicle
			table.insert(result, currnetData)
		end
		
	end
	
	
	for k,data in pairs(cyberscript.cache["garage"]) do
		
		local vehicle = data.data
		
		currnetData =  VehicleListItemData.new()
		currnetData.displayName = vehicle.name
		if(vehicle.icon ~= nil) then
			currnetData.icon = TweakDBInterface.GetUIIconRecord("UIIcon."..vehicle.icon)
			else
			currnetData.icon = TweakDBInterface.GetUIIconRecord("UIIcon.".."ItemIcon")
		end
		local vehiclePlayerVehicle = vehiclePlayerVehicle.new()
		CName.add(vehicle.tag)
		
		
		vehiclePlayerVehicle.name = CName.new(vehicle.tag)
		vehiclePlayerVehicle.recordID = TweakDBID.new(vehicle.tweak)
		vehiclePlayerVehicle.vehicleType = vehicle.type
		vehiclePlayerVehicle.isUnlocked  = checkTriggerRequirement(vehicle.requirement,vehicle.trigger)
		
		currnetData.data = vehiclePlayerVehicle
		------print(dump(vehicle))
		------print(dump(vehiclePlayerVehicle))
		if(vehiclePlayerVehicle.isUnlocked) then
			
			table.insert(result, currnetData)
		end
	end
	
	
	------print(dump(result))
	for i,v in ipairs(result) do
		
		------print(GameDump(v))
		
	end
	
	
	this.dataView:EnableSorting()
	this.dataSource:Reset(result)
	
	
	
	
	
	
end


function VehiclesManagerListItemController_OnDataChanged(this,value, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return  end
	this.vehicleData = FromVariant(value)
	if(cyberscript.cache["garage"][NameToString(this.vehicleData.data.name)] ~= nil) then
		
		local myvehicle = cyberscript.cache["garage"][NameToString(this.vehicleData.data.name)].data
		------print(dump(myvehicle))
		
		inkTextRef.SetText(this.label, myvehicle.name)
		
		else
		
		
		inkTextRef.SetLocalizedTextScript(this.label, this.vehicleData.displayName)
		
		
	end
	
	
	if this.vehicleData.data.vehicleType == gamedataVehicleType.Bike then
		inkImageRef.SetTexturePart(this.typeIcon, "motorcycle")
		else 
		inkImageRef.SetTexturePart(this.typeIcon, "car")
	end
end

function VehiclesManagerPopupGameController_Activate(this, wrappedMethod)
	if(observerthread == true or moddisabled  == true)  then return wrappedMethod()  end
	
	
	local selectedItem = this.listController:GetSelectedItem()
	
	local vehicleData = selectedItem:GetVehicleData()
	------print(GameDump(vehicleData))
	------print(GameDump(vehicleData.data))
	if(cyberscript.cache["garage"][NameToString(vehicleData.data.name)] ~= nil) then
		
		local myvehicle = cyberscript.cache["garage"][NameToString(vehicleData.data.name)].data
		------print(dump(myvehicle))
		runActionList(myvehicle.action,myvehicle.tag,"interact",false,"player")
		this:Close()
		else
		
		wrappedMethod()
		
	end
	
	
	
end

function WorldMapMenuGameController_ShowGangsInfo(self,district)
	if(observerthread == true or moddisabled  == true)  then return  end
	local zoomlevel = self:GetCurrentZoom()
	logme(2,zoomlevel)
	
	if(currentMapDistrictView ~= gameuiEWorldMapDistrictView.None or zoomlevel > 7000) then
		
		local districtRecord = nil
		
		if(currentMapDistrictView == gameuiEWorldMapDistrictView.Districts or currentMapDistrictView == nil or mapSubDistrict == nil) then
			
			districtRecord =  MappinUtils.GetDistrictRecord(district)
			inkWidgetRef.SetVisible(self.subdistrictNameText, false)
			
			else
			districtRecord =  MappinUtils.GetDistrictRecord(mapSubDistrict)
			inkWidgetRef.SetVisible(self.subdistrictNameText, true)
			
		end
		
		local enum = "Badlands"
		
		if(districtRecord ~= nil and districtRecord:EnumName() ~= nil and districtRecord:EnumName() ~= "" and districtRecord:EnumName() ~= "Null") then
			enum = districtRecord:EnumName()
		end
		
		
		
		inkCompoundRef.RemoveAllChildren(self.gangsList)
		
		inkWidgetRef.SetVisible(self.gangsInfoContainer, true)
		
		local mydistrict = nil
		
		
		if(currentMapDistrictView == gameuiEWorldMapDistrictView.Districts or currentMapDistrictView == nil or enum == "Badlands") then
			
			local dis =getDistrictfromEnum(enum)
			if(dis == nil) then
				mydistrict = enum
				else
				mydistrict = dis.Tag
			end
			
			else
			mydistrict = enum
		end
		
		
		
		if(mydistrict ~= nil) then
			if(MultiplayerOn and ActualPlayerMultiData.guildscores ~= nil) then
				local guilds = getGuildfromDistrict(mydistrict,-5)
				if(#guilds > 0) then
					for i=1,#guilds do 
						
						local gangWidget = self:SpawnFromLocal(inkWidgetRef.Get(self.gangsList), CName("GangListItem"))
						local gangController = gangWidget:GetController()
						
						CurrentGang =  guilds[i].tag.." ("..guilds[i].score..")"
						CurrentGangLogo = "logo_netwatch"
						
						
						gangController:SetData(gamedataAffiliation_Record.new())
					end
				end
				
				else
				
				
				
				local gangs = {}
				gangs = getGangfromDistrict(mydistrict,20)
				if(#gangs > 0) then
					for i=1,#gangs do 
						
						local gangWidget = self:SpawnFromLocal(inkWidgetRef.Get(self.gangsList), CName("GangListItem"))
						local gangController = gangWidget:GetController()
						local gang = getFactionByTag(gangs[i].tag)
						
						if(gang ~= nil) then
							CurrentGang = gang.name.." ("..gangs[i].score..")"
							CurrentGangLogo = gang.logo
							
							
							gangController:SetData(gamedataAffiliation_Record.new())
							else
							logme(10,"can't get gang for tag "..gangs[i].tag.." for district "..mydistrict)
						end
					end
				end
				
				
			end
		end
		
		else
		
		inkWidgetRef.SetVisible(self.gangsInfoContainer, false)
		
		
	end
end


---Observer and Overrider---

---Misc Function---
function startListeners(player)
	if(observerthread == true or moddisabled  == true)  then return  end
	player:UnregisterInputListener(player, 'QuickMelee')
	player:UnregisterInputListener(player, 'CameraAim')
	player:UnregisterInputListener(player, 'DeviceAttack')
	player:RegisterInputListener(player, 'QuickMelee')
	player:RegisterInputListener(player, 'CameraAim')
	player:RegisterInputListener(player, 'DeviceAttack')
end
---Misc Function---
function PhoneMessagePopupGameController_OnShow(self,evt)
	logme(1,"PhoneMessagePopupGameController_OnShowcurrentPhoneConversation"..dump(currentPhoneConversation))
end
function PhoneMessagePopupGameController_OnHide(self,evt)
	
	if(currentPhoneConversation ~= nil and currentPhoneConversation == "cs_nothing") then
		self.isInteractive = false;
		self.blockAction = true
		currentPhoneConversation = nil
		print("blocked popup because unknow journal")
		else
		if(currentPhoneConversation ~= nil) then
		
		 local request = UINotificationRemoveEvent.new()
     
		GameController["NewHudPhoneGameController"]:RemoveNotification(request);
			Cron.After(1,function()
				logme(1,"dddd")
				GameController["PhoneMessagePopupGameController"]:UnregisterFromGlobalInputCallback("OnPostOnRelease", GameController["PhoneMessagePopupGameController"], "OnHandleMenuInput");
				PopupStateUtils.SetBackgroundBlur(GameController["PhoneMessagePopupGameController"], false);
				GameController["PhoneMessagePopupGameController"].uiSystem:PopGameContext(UIGameContext.ModalPopup);
				GameController["PhoneMessagePopupGameController"].uiSystem:RestorePreviousVisualState("inkModalPopupState");
				GameController["PhoneMessagePopupGameController"]:SetTimeDilatation(false);
				GameController["PhoneMessagePopupGameController"]:RequestUnfocus()
				GameController["PhoneMessagePopupGameController"]:HandleCommonInputActions("cancel")
				GameController["PhoneMessagePopupGameController"]:ClosePopup()
				Cron.After(0.5,function()
					GameController["NewHudPhoneGameController"].PhoneSystem:QueueRequest( UsePhoneRequest.new());
					uiActionPerformed= DPADActionPerformed.new()
					uiActionPerformed.successful = true;
					uiActionPerformed.state = EUIActionState.COMPLETED;
					GameController["NewHudPhoneGameController"].buttonPressed = false;
					Game.GetUISystem():QueueEvent(uiActionPerformed);
					PopupStateUtils.SetBackgroundBlur(self, false);
					self.uiSystem:PopGameContext(UIGameContext.ModalPopup);
					self.uiSystem:RestorePreviousVisualState("inkModalPopupState");
					self.isInteractive = false;
		self.blockAction = true
				end)
			end)
		end
	end
end

function listenPlayerInput(action)
	if(observerthread == true or moddisabled  == true)  then return  end
	actionName = Game.NameToString(action:GetName(action))
	actionType = action:GetType(action).value
	actionValue = action:GetValue(action)
	-- if((actionType == "BUTTON_RELEASED" or actionType == "BUTTON_PRESSED") and (string.find(tostring(actionName), "hoiceScrollUp") or string.find(tostring(actionName), "hoiceScrollDown") or string.find(tostring(actionName), "up_button") or string.find(tostring(actionName), "down_button") or string.find(tostring(actionName), "hoice1") or string.find(tostring(actionName), "hoice2") or string.find(tostring(actionName), "hoice3") or string.find(tostring(actionName), "hoice4")))then 
	
	
	-- end
	-- logme(10,currentController)
	--logme(1,actionName)
	--logme(1,"currentPhoneConversation"..dump(currentPhoneConversation))
	-- logme(1,actionType)
	
	local PhoneMessagePopupGameControllerExisit = false
	local inkSystem = Game.GetInkSystem();
	local layers = inkSystem:GetLayers();
	
	for i,layer in ipairs(layers) do
		for j,controller in ipairs(layer:GetGameControllers()) do
			local name = NameToString(controller:GetClassName())
			
			if(name == "PhoneMessagePopupGameController") then PhoneMessagePopupGameControllerExisit = true end
		end
	end
	
	
	--	print("PhoneMessagePopupGameControllerExisit"..tostring(PhoneMessagePopupGameControllerExisit))
	
	-- if actionName == "NotificationOpen" and PhoneMessagePopupGameControllerExisit==true  and currentPhoneConversation ~= nil  then 				 
	-- Cron.After(0.5,function()
	-- logme(1,"dddd")
	-- GameController["PhoneMessagePopupGameController"]:UnregisterFromGlobalInputCallback("OnPostOnRelease", GameController["PhoneMessagePopupGameController"], "OnHandleMenuInput");
	-- PopupStateUtils.SetBackgroundBlur(GameController["PhoneMessagePopupGameController"], false);
	-- GameController["PhoneMessagePopupGameController"].uiSystem:PopGameContext(UIGameContext.ModalPopup);
	-- GameController["PhoneMessagePopupGameController"].uiSystem:RestorePreviousVisualState("inkModalPopupState");
	-- GameController["PhoneMessagePopupGameController"]:SetTimeDilatation(false);
	-- GameController["PhoneMessagePopupGameController"]:RequestUnfocus()
	-- GameController["PhoneMessagePopupGameController"]:HandleCommonInputActions("cancel")
	-- GameController["PhoneMessagePopupGameController"]:ClosePopup()
	-- Cron.After(0.5,function()
	-- GameController["NewHudPhoneGameController"].PhoneSystem:QueueRequest( UsePhoneRequest.new());
	-- uiActionPerformed= DPADActionPerformed.new()
	-- uiActionPerformed.successful = true;
	-- uiActionPerformed.state = EUIActionState.COMPLETED;
	-- GameController["NewHudPhoneGameController"].buttonPressed = false;
	-- Game.GetUISystem():QueueEvent(uiActionPerformed);
	-- end)
	-- end)
	
	-- end
	local phoneAction = false 
	
	if actionName == "PhoneReject" and actionType == "BUTTON_HOLD_COMPLETE" and currentPhoneCall ~= nil   then 
		StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.FistFight")
		phoneAction = true 
		local audioEvent = SoundStopEvent.new()
		audioEvent.soundName = "ui_phone_incoming_call"
		Game.GetPlayer():QueueEvent(audioEvent)
		
		runActionList(currentPhoneCall.rejected_action,"phone_call","interact",false,"player")
		incomingCallGameController:OnInitialize()
		currentPhoneCall = nil
		
		phoneAction = false 
		else
		if actionName == "PhoneInteract" and phoneAction == false and actionType == "BUTTON_RELEASED" and currentPhoneCall ~= nil   then 
			logme(1,"dddssssd")
			StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.FistFight")
			
			local audioEvent = SoundStopEvent.new()
			audioEvent.soundName = "ui_phone_incoming_call"
			Game.GetPlayer():QueueEvent(audioEvent)
			
			runActionList(currentPhoneCall.answer_action,"phone_call","interact",false,"player")
			incomingCallGameController:OnInitialize()
			currentPhoneCall = nil
			StatusEffectHelper.RemoveStatusEffect(Game.GetPlayer(), "GameplayRestriction.FistFight")
			
		end
	end
	
	
	if actionName == "popup_moveLeft" and actionType == "REPEAT" and currentController == "gamepad"   then 
		--hideInteract()
		logme(10,"tosto")
	end
	if actionName == "dpad_left" and actionType == "BUTTON_PRESSED"  and currentController == "gamepad" and currentHelp == nil  then 
		
		cycleInteract()
		
	end
	
	if currentHelp ~= nil and currentHelpIndex ~= nil and (actionName == "cancel" and actionType == "BUTTON_RELEASED" and currentController == "gamepad") or ((actionName == "activate_secondary" or actionName == "proceed_popup") and actionType == "BUTTON_RELEASED" and currentController ~= "gamepad")then
		
		local actionlisth = {}
		local actionh = {}
		if(currentHelpIndex-1 < #currentHelp.section)then
			UIPopupsManager.ClosePopup()
			currentHelp = nil
			currentHelpIndex = 1
			else
			actionh.name = "previous_help"
			table.insert(actionlisth,actionh)
			
			actionh = {}
			actionh =currentHelp.action
			actionh.name = "open_help"
			actionh.tag = currentHelp.tag
			table.insert(actionlisth,actionh)
			
			runActionList(actionlisth,currentHelp.tag,"interact",true,"player")
		end		
	end
	
	if currentHelp ~= nil and (actionName == "close_tutorial" and actionType == "BUTTON_RELEASED" and currentController == "gamepad") or ((actionName == "activate" or actionName == "close_tutorial") and actionType == "BUTTON_RELEASED" and currentController ~= "gamepad") then
		
		local actionlisth = {}
		local actionh = {}
		pcall(function()
			
			if(currentHelpIndex+1 > #currentHelp.section)then
				UIPopupsManager.ClosePopup()
				currentHelp = nil
				currentHelpIndex = 1
				else
				actionh.name = "next_help"
				table.insert(actionlisth,actionh)
				actionh = {}
				actionh =currentHelp.action
				actionh.name = "open_help"
				actionh.tag = currentHelp.tag
				table.insert(actionlisth,actionh)
				
				runActionList(actionlisth,currentHelp.tag,"interact",true,"player")
			end	
		end)
	end
	
	
	if((actionType == "BUTTON_RELEASED" or actionType == "BUTTON_PRESSED") and (string.find(tostring(actionName), "hoiceScrollUp") or string.find(tostring(actionName), "hoiceScrollDown") or string.find(tostring(actionName), "up_button") or string.find(tostring(actionName), "down_button") or string.find(tostring(actionName), "hoice1") or string.find(tostring(actionName), "hoice2") or string.find(tostring(actionName), "hoice3") or string.find(tostring(actionName), "hoice4")))then 
		
		local inputHitted = false
		
		if(isdialogactivehub == false and candisplayInteract == true) then
			--		------print"event detexted")
			local inputIndex = 0
			if(actionName == "Choice1") then
				inputIndex = 1
			end
			if(actionName == "Choice2") then
				inputIndex = 2
			end
			if(actionName == "Choice3") then
				inputIndex = 3
			end
			if(actionName == "Choice4") then
				inputIndex = 4
			end
			
			
			if(#loadInteract > 0) then
				local interact = cyberscript.cache["interact"][loadInteract[inputIndex]].data
				runActionList(interact.action,interact.tag,"interact",false,"player")
				
				else
				
				
				if(possibleInteractDisplay[currentPossibleInteractChunkIndex] ~= nil) then
					for i = 1, #possibleInteractDisplay[currentPossibleInteractChunkIndex] do
						--	------print"expected input for "..possibleInteractDisplay[currentPossibleInteractChunkIndex][i].name.." : "..possibleInteractDisplay[currentPossibleInteractChunkIndex][i].input)
						if(inputIndex == i) then
							runActionList(possibleInteractDisplay[currentPossibleInteractChunkIndex][i].action,possibleInteractDisplay[currentPossibleInteractChunkIndex][i].tag,"interact",false,"player")
							if(currentHouse == nil or (currentHouse ~= nil and interactautohide == true)) then
								currentPossibleInteractChunkIndex = 0
								
								createInteraction(false)
								candisplayInteract = false
							end
						end
					end
				end
				
				
			end
		end
	end
	
	
	
	if #currentInputHintList > 0 then
		for i = 1, #currentInputHintList do
			
			if(currentInputHintList[i] ~= nil and currentInputHintList[i].key == actionName and actionType == "BUTTON_RELEASED") then
				local inter = cyberscript.cache["interact"][currentInputHintList[i].tag].data
				runActionList(inter.action,inter.tag,"interact",false,"player")
			end
		end
	end
	
	inputAV(action)
end


