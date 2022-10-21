

local currentObjectiveId = 0

local QuestTrackerUI = {}


function QuestTrackerUI.Reset()
	currentObjectiveId = 0
end
	

function QuestTrackerUI.Initialize()
	---@param self QuestTrackerGameController
	Observe('QuestTrackerGameController', 'OnTrackedEntryChanges', function(self)
		QuestManager.UntrackObjective()
		currentObjectiveId = 0
		
	end)
	
	Observe('QuestTrackerGameController', 'UpdateTrackerData', function(self)
		
		QuestTrackerGameController = self
	
	end)

	---@param self QuestTrackerGameController
	ObserveAfter('QuestTrackerGameController', 'OnMenuUpdate', function(self, value)
		
			QuestTrackerGameController = self
		TrackObjective()
	end)
end



function TrackObjective()
	
	if QuestManager.IsTrackingObjective() then
		
			--print('QuestTrackerGameController', 'CustomTrack')
			-- print('QuestTrackerGameController')
			
		--	if not QuestManager.IsTrackedObjective(currentObjectiveId) then
				
				local trackedQuestId = QuestManager.GetTrackedQuestId()
				local trackedQuestDef = QuestManager.GetQuest(trackedQuestId)
				local trackedObjectiveId = QuestManager.GetTrackedObjectiveId()
			
				QuestTrackerGameController.root:SetVisible(true)

				inkTextRef.SetText(QuestTrackerGameController.QuestTitle, trackedQuestDef.title)
				inkCompoundRef.RemoveAllChildren(QuestTrackerGameController.ObjectiveContainer)

				for _, objectiveDef in ipairs(trackedQuestDef.objectives) do
					local objectiveState = QuestManager.GetObjectiveState(objectiveDef.id)
						
					if not objectiveState.isComplete and (objectiveState.state == gameJournalEntryState.Active or objectiveState.state == gameJournalEntryState.Failed)then
						local objectiveEntry = QuestManager.GetObjectiveEntry(objectiveDef.id)
						local objectiveWidget = QuestTrackerGameController:SpawnFromLocal(inkWidgetRef.Get(QuestTrackerGameController.ObjectiveContainer), "Objective")

						---@type QuestTrackerObjectiveLogicController
						local objectiveController = objectiveWidget:GetController()
						objectiveController:SetData(objectiveDef.title, objectiveDef.id == trackedObjectiveId, objectiveDef.isOptional, 0, 0, objectiveEntry,true)
						local quest = getQuestByTag(trackedQuestId)
					
						
						if(quest ~= nil and (getScoreKey(quest.tag,"Score") == nil or getScoreKey(quest.tag,"Score") <= 3) and currentQuest == nil ) then
							
							--untrackQuest()
							
							startQuest(quest)
						
						end
					end
				end

				currentObjectiveId = trackedObjectiveId
				
			
			
		elseif currentObjectiveId ~= 0 then
				QuestTrackerGameController.root:SetVisible(false)
				currentObjectiveId = 0
				
		else
			QuestTrackerGameController:UpdateTrackerData()
			
		end
	
end

return QuestTrackerUI