
function SimpleQuestListItemController_OnPress(this,data)
	if(observerthread1  == true or moddisabled == true)    then return end
	if(this.data.journalManager == nil) then
		myucurrentQuestData = this.data.questData.id
		
		
		else
		myucurrentQuestData = nil
		
	end
end

function SimpleQuestListItemController_OnDataChanged(this,data)
	if(observerthread1  == true or moddisabled == true)    then return end
	local quest = FromVariant(data)
	if(quest.journalManager == nil) then
		local mymission = cyberscript.cache["mission"][quest.questData.id].data
		local questType = QuestTypeIconUtils.GetIconState(mymission.questtype);
		
		
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
	if(observerthread1  == true or moddisabled == true)    then return end
	if getUserSetting("enableCustomQuest") == true then
		Cron.NextTick(function()
			
			getMissionByTrigger()
			
			local questToOpen
			local listData = self.listData
			
			
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
					
					
					local itemData = makeListItemData(questDef, questEntry, questState,99)
					itemData.playerLevel = self.playerLevel
					
					table.insert(listData, itemData)
					
					if questState.isTracked then
						questToOpen = questEntry
					end
					
					-- end
					
				end
				
				if(QuestManager.IsQuestComplete(questDef.id)) then 
					
					
					
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
			
			
			self.virtualListController:SetData(listData)
			
			
			
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
					
					
				end
			end
			
			
		end)
	end	
	
	
end


function questLogGameController_OnQuestListItemClicked(self,e)
	if(observerthread1  == true or moddisabled == true)    then return end
	Cron.NextTick(function()
		local questId = e.questData.id
		
		if QuestManager.IsKnownQuest(questId) then
			QuestManager.MarkQuestAsVisited(questId)
			
			
		end
		
	end)
	
end

function questLogGameController_OnRequestChangeTrackedObjective(self,e)
	if(observerthread1  == true or moddisabled == true)    then return end
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
			local itemData = nestedData
			
			if itemData:IsA('QuestListItemData') then
				itemData.isTrackedQuest = itemData.questData.id == e.quest.id
			end
		end
	end)
	
end

function QuestListItemController_UpdateDistance(self)
	if(observerthread1  == true or moddisabled == true)    then return end
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
	if(observerthread1  == true or moddisabled == true)    then return end
	Cron.NextTick(function()
		local questId = questData.id
		
		if QuestManager.IsKnownQuest(questId) and questsetup ~= true then
			questsetup = true
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
			else
			questsetup = false
			
		end
	end)
	
	
end

function QuestDetailsPanelController_OnUpdateTrackedObjectiveEvent(self, e)

	QuestManager.UntrackObjective()
	if(myucurrentQuestData ~= nil) then
	
		local questId = myucurrentQuestData
		
		if QuestManager.IsKnownQuest(questId) then
			print("QuestDetailsPanelController_OnUpdateTrackedObjectiveEvent")
			print(questId)
			
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
			local objtracked = QuestManager.GetFirstObjective(questId)
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
			
		
			
			QuestManager.TrackObjective(objtracked.id,true)
		
			
			
		
	else
			
		logme(1,"debugquest QuestDetailsPanelController_OnUpdateTrackedObjectiveEvent")
			untrackQuest()
			local state = self.journalManager:GetEntryState(e.quest)
			
			if state == gameJournalEntryState.Succeeded or state == gameJournalEntryState.Failed then
				return
			end
			
			self.journalManager:TrackEntry(e.objective)
			
		end
		
		
		
	else
			
			QuestManager.UntrackObjective()
			currentQuest = nil
		
	end	
	
end


function QuestListHeaderController_Setup(self, titleLocKey,questType,wrappedMethod)
	if(observerthread1  == true or moddisabled == true)    then return wrappedMethod(titleLocKey,questType) end
	if questType == 99 then
		
		self.questType = questType;
		inkTextRef.SetText(self.title, getLang("Cyberscript"))
		self.hovered = false
		self:UpdateState()
		else
		wrappedMethod(titleLocKey,questType)
	end
end


function QuestTrackerGameController_OnTrackedEntryChanges(self)
	if(observerthread1  == true or moddisabled == true)    then return end
	GameController["QuestTrackerGameController"] = self

	
end

function QuestTrackerGameController_UpdateTrackerData(self,wrappedmethod)
	
	
	GameController["QuestTrackerGameController"] = self
	if not QuestManager.IsTrackingObjective() then
		wrappedmethod()
		
		
		
	end
end

function QuestTrackerGameController_OnMenuUpdate(self, value)
	if(observerthread1  == true or moddisabled == true)    then return end
	GameController["QuestTrackerGameController"] = self
	
	TrackObjective()
end


function TrackQuestNotificationAction_TrackFirstObjective(thos,questEntry)
	if(observerthread4  == true or moddisabled == true)    then return end
	
	if(questEntry ~= nil)then
		
		local quest = getQuestByTag(questEntry.id)
		
		
		if(quest ~= nil and getScoreKey(quest.tag,"Score") <= 3) then
			
			

			
			
			
			
			
			
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


function QuestMappinLinkController_Setup(thos,mappinEntry,mappinHash,jumpTo,isTracked,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(mappinEntry,jumpTo) end
	if mappinEntry == nil and journalQuestMapPinBase ~= nil then
		
		local mappin = getMappinByTag(journalQuestMapPinBase)
		
		
		
		inkTextRef.SetText(thos.linkLabel, mappin.title)
		
		thos.jumpTo = Vector3.new( mappin.position.x, mappin.position.y, mappin.position.z)
		journalQuestMapPinBase = nil
		
		else
		
		wrappedMethod(mappinEntry,mappinHash,jumpTo,isTracked)
		
	end
	
end

function QuestCodexLinkController_SetupCodexLink(thos,codexEntry,wrappedMethod)
	if(observerthread5 == true or moddisabled  == true)  then return wrappedMethod(codexEntry) end
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


